<?php
// 应用公共文件
use think\facade\Db;
use app\common\lib\Qiniu;


function ip2address($ip)
{
    // $ip = '具体的IP地址';
    $a = 'http://restapi.amap.com/v3/ip?ip='.$ip.'&output=json&key=2c017fc4c0b5629c24d5167a291cd1d3';
    $opts = array(
        'http'=>array(
            'method'=>"GET",
            'header'=>
                "Accept-language: zh-cn\r\n" .
                "User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; 4399Box.560; .NET4.0C; .NET4.0E)" .
                "Accept: *//*"
        )
    );
    $x = file_get_contents($a);
    return $x;
}

function checkCloseSpeck($id)
{
    $status = Db::name('user')->where('id',$id)->value('status');
    if ($status == 1) {
        return error([],'您已被禁言');
    }
    return true;
}

function get_tag_data($html,$tag){

    
    $regex = "/<$tag>(.*?)<\/$tag>/is";
    preg_match_all($regex,$html,$matches,PREG_PATTERN_ORDER);
    return $matches[1];//返回值为数组 ,查找到的标签内的内容
}



function success($data = [],$msg = 'ok',$code = 200)
{
    return  error($data,$msg,$code);
}

function error($data = [],$msg = '失败',$code = 0)
{
    return json([
        'code' => $code,
        'msg'  => $msg,
        'time' => time(),
        'data' => $data ?: []
    ]);
}
function sendSms($phone,$code)
{
    require __DIR__ . '/api/controller/alisms/autoload.php';
    $site = xn_cfg('base');
    $appid = $site['sms_aliid'];
    $key = $site['sms_alikey'];
    $temp_id = $site['sms_alimobanid'];
    $singName = $site['sms_signname'];
    AlibabaCloud\Client\AlibabaCloud::accessKeyClient($appid, $key)
        ->regionId('cn-hangzhou') // replace regionId as you need
        ->asDefaultClient();
        try {
            $result = AlibabaCloud\Client\AlibabaCloud::rpc()
            ->product('Dysmsapi')
            // ->scheme('https') // https | http
            ->version('2017-05-25')
            ->action('SendSms')
            ->method('POST')
            ->options([
                    'query' => [
                      'TemplateCode' => $temp_id,
                      'PhoneNumbers' => $phone,
                      'SignName' => $singName,
                      'TemplateParam' => "{'code':'".$code."'}",
                    ],
                ])
            ->request();
            $res = $result->toArray();
             
            // var_dump($res,$code);
            if($res['Message'] == 'OK'){
                return true;
            }
             
        } catch (AlibabaCloud\Client\Exception\ClientException $e) {
            return ['','发送失败!', $e->getErrorMessage() . PHP_EOL];
        } catch (AlibabaCloud\Client\Exception\ServerException $e) {
            return ['','发送失败!', $e->getErrorMessage() . PHP_EOL];
        }
}
/**
 * 检查手机或邮箱是否还可以发送验证码,并返回生成的验证码
 * @param string  $account 手机或邮箱
 * @param integer $length  验证码位数,支持4,6,8
 * @return string 数字验证码
 * @throws \think\db\exception\DataNotFoundException
 * @throws \think\db\exception\ModelNotFoundException
 * @throws \think\exception\DbException
 */
function cmf_get_verification_code($account, $length = 6)
{
    if (empty($account)) return false;
    $verificationCodeQuery = Db::name('verification_code');
    $currentTime           = time();
    $maxCount              = 5;
    $findVerificationCode  = $verificationCodeQuery->where('account', $account)->find();
    $result                = false;
    if (empty($findVerificationCode)) {
        $result = true;
    } else {
        $sendTime       = $findVerificationCode['send_time'];
        $todayStartTime = strtotime(date('Y-m-d', $currentTime));
        if ($sendTime < $todayStartTime) {
            $result = true;
        } else if ($findVerificationCode['count'] < $maxCount) {
            $result = true;
        }
    }

    if ($result) {
        switch ($length) {
            case 4:
                $result = rand(1000, 9999);
                break;
            case 6:
                $result = rand(100000, 999999);
                break;
            case 8:
                $result = rand(10000000, 99999999);
                break;
            default:
                $result = rand(100000, 999999);
        }
    }

    return $result;
}

/**
 * 更新手机或邮箱验证码发送日志
 * @param string $account    手机或邮箱
 * @param string $code       验证码
 * @param int    $expireTime 过期时间
 * @return int|string
 * @throws \think\Exception
 * @throws \think\db\exception\DataNotFoundException
 * @throws \think\db\exception\ModelNotFoundException
 * @throws \think\exception\DbException
 * @throws \think\exception\PDOException
 */
function cmf_verification_code_log($account, $code, $expireTime = 0)
{
    $currentTime = time();
    $expireTime  = $expireTime > $currentTime ? $expireTime : $currentTime + 30 * 60;

    $findVerificationCode = Db::name('verification_code')->where('account', $account)->find();

    if ($findVerificationCode) {
        $todayStartTime = strtotime(date("Y-m-d"));//当天0点
        if ($findVerificationCode['send_time'] <= $todayStartTime) {
            $count = 1;
        } else {
            $count = Db::raw('count+1');
        }
        $result = Db::name('verification_code')
            ->where('account', $account)
            ->update([
                'send_time'   => $currentTime,
                'expire_time' => $expireTime,
                'code'        => $code,
                'count'       => $count
            ]);
    } else {
        $result = Db::name('verification_code')
            ->insert([
                'account'     => $account,
                'send_time'   => $currentTime,
                'code'        => $code,
                'count'       => 1,
                'expire_time' => $expireTime
            ]);
    }

    return $result;
}

/**
 * 手机或邮箱验证码检查，验证完后销毁验证码增加安全性,返回true验证码正确，false验证码错误
 * @param string  $account 手机或邮箱
 * @param string  $code    验证码
 * @param boolean $clear   是否验证后销毁验证码
 * @return string  错误消息,空字符串代码验证码正确
 * @return string
 * @throws \think\Exception
 * @throws \think\db\exception\DataNotFoundException
 * @throws \think\db\exception\ModelNotFoundException
 * @throws \think\exception\DbException
 * @throws \think\exception\PDOException
 */
function cmf_check_verification_code($account, $code, $clear = false)
{

    $findVerificationCode = Db::name('verification_code')->where('account', $account)->find();
    if ($findVerificationCode) {
        if ($findVerificationCode['expire_time'] > time()) {

            if ($code == $findVerificationCode['code']) {
                if ($clear) {
                    Db::name('verification_code')->where('account', $account)->update(['code' => '']);
                }
            } else {
                return "验证码不正确!";
            }
        } else {
            return "验证码已经过期,请先获取验证码!";
        }

    } else {
        return "请先获取验证码!";
    }

    return "";
}

/**
 * 清除某个手机或邮箱的数字验证码,一般在验证码验证正确完成后
 * @param string $account 手机或邮箱
 * @return boolean true：手机验证码正确，false：手机验证码错误
 * @throws \think\Exception
 * @throws \think\exception\PDOException
 */
function cmf_clear_verification_code($account)
{
    $verificationCodeQuery = Db::name('verification_code');
    $result                = $verificationCodeQuery->where('account', $account)->update(['code' => '']);
    return $result;
}
//勋章类型
function getMedalType(){
    return [
        '帖子数量',
        '评论数量',
        '点赞数量'
    ];
}

//随机颜色
function getRandColor()
{
    $color = [   
        'purple',   
        'purplered',   
        'bluepurple',   
        'red',
        'aquablue',
        'orangered',
        'blue',   
        'orange',   
        'orangeyellow',
        'indigo',
        'cyan',
        'yellow',   
        'teal',   
        'lime',
        'green',
        'yellowgreen'  
    ];
    return $color[rand(0,15)];
}

//删除用户后，删除帖子，评论 ，点赞，评论点赞，关注，被关注
function deleteUserAfter($id){
    Db::startTrans();
    try {
        //删除帖子

        //删除评论
        //删除点赞
        //删除评论点赞
        //取消关注
        //取消别人的关注
        
        // 提交事务
        return true;
        Db::commit();
    } catch (\Exception $e) {
        // 回滚事务
        Db::rollback();
        return false;
    }
}

//帖子用户后，删除帖子，评论 ，点赞，评论点赞
function deleteGoodsAfter($info){
    Db::startTrans();
    try {
        //删除评论
        Db::name('goods_comment')->where('goods_id',$info['id'])->delete();
        //删除点赞
        Db::name('goods_like')->where('goods_id',$info['id'])->delete();
        //删除评论点赞
        Db::name('goods_comment')->where('goods_id',$info['id'])->delete();
        // 提交事务
        return true;
        Db::commit();
    } catch (\Exception $e) {
        // 回滚事务
        Db::rollback();
        return false;
    }
}

//等级处理
function addAfterLevel($userInfo,$type)
{
    $site = xn_cfg('base');
    $score = 10;
    $upScore = $site['user_leve_once'];
    if ($type == 'goods') {
        //lv_score
        $score = $site['add_goods_score'];
    }

    if ($type == 'active') {
        $score = $site['add_active_score'];
    }

    if ($type == 'category') {
        $score = $site['add_category_score'];
    }
    $nowScore = $userInfo['lv_score'] + $score;
    $lv = floor($nowScore / $upScore) + 1;
    Db::name('user')->where('id',$userInfo['id'])->update([
        'lv' => $lv,
        'lv_score' => $nowScore
    ]);
    return true;
}

//勋章处理
function addAfterMedal($userInfo,$type)
{
    $number = 9;
    if ($type == 'goods') {
        $number = 0;
    }
    if ($type == 'comment') {
        $number  = 1;
    }
    if ($type == 'like') {
        $number  = 2;
    }
    if ($number < 9) {
        $medal = Db::name('medal')->where('type',$number)->select();
        foreach ($medal as $once) {
            $has = Db::name('medal_list')->where(['user_id'=>$userInfo['id'],'medal_id'=>$once['id']])->find();
            switch ($number) {
                case '0':
                    $count = Db::name('goods')->where('user_id',$userInfo['id'])->count();
                    break;
                case '1':
                    $count = Db::name('goods_comment')->where('user_id',$userInfo['id'])->count();
                    break;
                case '2':
                    $count = Db::name('goods_like')->where('user_id',$userInfo['id'])->count();
                    break;
            }
            if ($count >= $once['meet_num'] && !$has) {
                Db::name('medal_list')->insert([
                    'medal_id' => $once['id'],
                    'user_id'  => $userInfo['id'],
                    'create_time' => time()
                ]);
            }
        }
    }
    return true;

}


//生成海报
/**
 * 总生成图片方法
 * @param $data        商品数据
 * @param $codeImg     二维码
 * @return new      返回图片image资源
 */

function createImg_biz($codeImg,$new,$title){
    $backImg = "static/common/images/biz.png"; 
    addPic($backImg,$codeImg,530,530,120,180,$new);   
    addWord($title,80,80,22,'black',$new);
    //addWord('特价fasdfasdfasdfasdfasdfadsf',0,0,10,'red',$new);
    return $new;
}


function createImg($codeImg,$new){
    $backImg = "static/common/images/mendian.png";
    // $new =  $codeImg;
    // $codeImg = 'static/common/images/905321646818132.png';
    // 添加二维码
    // var_dump($new);exit;
    addPic($backImg,$codeImg,230,230,260,920,$new);
    // // 添加产品
    // addPic($new,$goods_img,600,400,80,300,$new);

    // // 添加产品描述，对描述进行分行
    // $theTitle = cn_row_substr($data['title'],2,18);
    // addWord($theTitle[1],100,750,22,'black',$new);
    // addWord($theTitle[2],100,780,22,'black',$new);

    // // 添加价格1
    // addWord('特价'.$data['price_market'],100,900,30,'red',$new);
    // // 添加价格2
    // addWord('原价'.$data['price_member'],100,930,18,'black',$new);

    return $new;
}
/**
 * 添加图片
 * @param $path_base    原图
 * @param $path_logo     添加图
 * @param $imgWidth     添加图宽
 * @param $imgHeight     添加图高
 * @param $dst_x         在原图宽x处添加
 * @param $dst_y         在原图高y处添加
 * @param $new             生成图
 * @return resource    返回图片image资源
 */
function addPic($path_base,$path_logo,$imgWidth,$imgHeight,$dst_x,$dst_y,$new){

    $image_base = ImgInfo($path_base);
    $image_logo = ImgInfo($path_logo);
    // var_dump($image_base, $image_logo, $dst_x, $dst_y, 0, 0,$imgWidth,$imgHeight,imagesx($image_logo), imagesy($image_logo));exit;
    $res = imagecopyresampled($image_base, $image_logo, $dst_x, $dst_y, 0, 0,$imgWidth,$imgHeight,imagesx($image_logo), imagesy($image_logo));
    // 生成一个合并后的新图
    imagejpeg($image_base,$new);
    // 载入新图像资源
    $new_pic = imagecreatefromjpeg($new);
    // 生成写入文字的的新图
    imagejpeg($new_pic,$new);

}

/**
 * 添加文字
 * @param $str        要添加的文字
 * @param $posX     在宽x处添加
 * @param $poxY     在高y处添加
 * @param $font     字体大小
 * @param $color     字体颜色
 * @param $new         生成图
 * @return resource    返回图片image资源
 */
function addWord($str,$posX,$poxY,$font,$color,$new)
{
    $ori_img = $new;    //原图
    $new_img = $new;    //生成水印后的图片
    
    $s_original = ImgInfo($ori_img);
    $tilt = 0;    //文字的倾斜度
    $ImgColor = [                    //为一幅图像分配颜色 
        'black' => imagecolorallocate($s_original,0,0,0),
        'red' => imagecolorallocate($s_original,255,0,0),
        ] ;
    
    $res = imagettftext($s_original, $font, $tilt, $posX, $poxY, $ImgColor[$color], 'D:\wwwroot\shop.xcx.51duoke.cn\public\pingfang.ttf', $str);    
    $loop = imagejpeg($s_original, $new_img);    //生成新的图片(jpg格式)
}
/**
 * 从图片文件创建Image资源
 * @param $file 图片文件，支持url
 * @return bool|resource    成功返回图片image资源，失败返回false
 */
function ImgInfo($img){
    if(preg_match('/http(s)?:\/\//',$img)){
        $fileSuffix = getNetworkImgType($img);
    }else{
        $fileSuffix = pathinfo($img, PATHINFO_EXTENSION);
    }

    if(!$fileSuffix) return false;

    switch ($fileSuffix){
        case 'jpeg':
            $theImage = @imagecreatefromjpeg($img);
            break;
        case 'jpg':
            $theImage = @imagecreatefromjpeg($img);
            break;
        case 'png':
            $theImage = @imagecreatefrompng($img);
            break;
        case 'gif':
            $theImage = @imagecreatefromgif($img);
            break;
        default:
            $theImage = @imagecreatefromstring(file_get_contents($img));
            break;
    }
 
    return $theImage;
}

/**
 * 获取网络图片类型
 * @param $url  网络图片url,支持不带后缀名url
 * @return bool
 */
function getNetworkImgType($url){
    $ch = curl_init(); //初始化curl
    curl_setopt($ch, CURLOPT_URL, $url); //设置需要获取的URL
    curl_setopt($ch, CURLOPT_NOBODY, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 3);//设置超时
    curl_setopt($ch, CURLOPT_TIMEOUT, 3);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); //支持https
    curl_exec($ch);//执行curl会话
    $http_code = curl_getinfo($ch);//获取curl连接资源句柄信息
    curl_close($ch);//关闭资源连接
 
    if ($http_code['http_code'] == 200) {
        $theImgType = explode('/',$http_code['content_type']);
 
        if($theImgType[0] == 'image'){
            return $theImgType[1];
        }else{
            return false;
        }
    }else{
        return false;
    }
}

/**
 * 分行连续截取字符串
 * @param $str  需要截取的字符串,UTF-8
 * @param int $row  截取的行数
 * @param int $number   每行截取的字数，中文长度
 * @param bool $suffix  最后行是否添加‘...’后缀
 * @return array    返回数组共$row个元素，下标1到$row
 */
function cn_row_substr($str,$row = 1,$number = 10,$suffix = true){
    $result = array();
    for ($r=1;$r<=$row;$r++){
        $result[$r] = '';
    }
 
    $str = trim($str);
    if(!$str) return $result;
 
    $theStrlen = strlen($str);
 
    //每行实际字节长度
    $oneRowNum = $number * 3;
    for($r=1;$r<=$row;$r++){
        if($r == $row and $theStrlen > $r * $oneRowNum and $suffix){
            $result[$r] = mg_cn_substr($str,$oneRowNum-6,($r-1)* $oneRowNum).'...';
        }else{
            $result[$r] = mg_cn_substr($str,$oneRowNum,($r-1)* $oneRowNum);
        }
        if($theStrlen < $r * $oneRowNum) break;
    }
 
    return $result;
}

/**
 * 按字节截取utf-8字符串
 * 识别汉字全角符号，全角中文3个字节，半角英文1个字节
 * @param $str  需要切取的字符串
 * @param $len  截取长度[字节]
 * @param int $start    截取开始位置，默认0
 * @return string
 */
function mg_cn_substr($str,$len,$start = 0){
    $q_str = '';
    $q_strlen = ($start + $len)>strlen($str) ? strlen($str) : ($start + $len);
 
    //如果start不为起始位置，若起始位置为乱码就按照UTF-8编码获取新start
    if($start and json_encode(substr($str,$start,1)) === false){
        for($a=0;$a<3;$a++){
            $new_start = $start + $a;
            $m_str = substr($str,$new_start,3);
            if(json_encode($m_str) !== false) {
                $start = $new_start;
                break;
            }
        }
    }
 
    //切取内容
    for($i=$start;$i<$q_strlen;$i++){
        //ord()函数取得substr()的第一个字符的ASCII码，如果大于0xa0的话则是中文字符
        if(ord(substr($str,$i,1))>0xa0){
            $q_str .= substr($str,$i,3);
            $i+=2;
        }else{
            $q_str .= substr($str,$i,1);
        }
    }
    return $q_str;
}


function get_web_info($id)
{
    return Db::name('admin')->where('id',$id)->find();
}
function get_adinfo_type()
{
    return [
        '1'  => '首页幻灯',
        '2'  => '活动幻灯',
      
    ];
}
function getAgeByID($id){ 
        
    if(empty($id)) return ''; 
    $date=strtotime(substr($id,6,8));
    $today=strtotime('today');
    $diff=floor(($today-$date)/86400/365);
    $age=strtotime(substr($id,6,8).' +'.$diff.'years')>$today?($diff+1):$diff; 
    return $age; 
}

function cardHide($id)
{
    if(empty($id)) return '';
    return substr($id,0,4).'********'.substr($id, 12,18); 
}
function getImageUrl($url)
{
    if(strpos($url,'http') !== false){ 
        return $url;
    }else{
        return input('server.REQUEST_SCHEME') . '://' . input('server.SERVER_NAME').$url;
    }
}

function getImageUrlArr($url,$type='image')
{
    if (is_array($url)) {
        if (count($url) == 1 && $url[0] == '') {
            return [];
        }
        $newArr = [];
        foreach ($url as $key => $v) {
            $v = getImageUrl($v);
            array_push($newArr,$v);
        }
        return $newArr;
    }

    if(strpos($url,'http') !== false){ 
        return $url;
    }else{
        if ($type == 'avatar' && $url == '') {
            return input('server.REQUEST_SCHEME') . '://' . input('server.SERVER_NAME').$url.'/uploads/head.jpg';
        }else{
            return input('server.REQUEST_SCHEME') . '://' . input('server.SERVER_NAME').$url;
        }
        
    }
}
/**
 * 公共返回数据
 * @author  Devil
 * @blog    http://gong.gg/
 * @version 1.0.0
 * @date    2021-07-16
 * @desc    description
 * @param   [string]       $msg  [提示信息]
 * @param   [int]          $code [状态码]
 * @param   [mixed]        $data [数据]
 * @return  [json]               [json数据]
 */
function DataReturn($msg = '', $code = 0, $data = '')
{
    // 默认情况下，手动调用当前方法
    $result = ['msg'=>$msg, 'code'=>$code, 'data'=>$data];

    // 错误情况下，防止提示信息为空
    if($result['code'] != 0 && empty($result['msg']))
    {
        $result['msg'] = '操作失败';
    }

    return $result;
}

function PriceBeautify($price = 0, $default = null)
{
    if(empty($price))
    {
        return $default;
    }

    $price = str_replace('.00', '', $price);
    if(strpos($price, '.') !== false)
    {
        if(substr($price, -1) == 0)
        {
            $price = substr($price, 0, -1);
        }
        if(substr($price, -1) == '.')
        {
            $price = substr($price, 0, -1);
        }
    }
    return $price;
}
function xn_httpGet($url) {
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_TIMEOUT, 500);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($curl, CURLOPT_URL, $url);
    $res = curl_exec($curl);
    curl_close($curl);
    return $res;
}
/**
 * Db新增数据
 * @param string $table 表名
 * @param array $data 数据
 * @return string
 */
function xn_db_insert($table,array $data){
    return Db::name($table)->insert($data);
}

/**
 * Db根据主键删除数据
 * @param int $size
 * @return string
 */
function xn_db_delete_by_pk($table,int $id,string $pk = 'id'){
    return Db::name($table)->where($pk,$id)->delete();
}

/**
 * Db根据条件删除数据
 * @param int $size
 * @return string
 */
function xn_db_delete_by_where($table,array $where){
    return Db::name($table)->where($where)->delete();
}

/**
 * 自动判断是否假删除
 * @param int $size
 * @return string
 */
function xn_destroy($table,$id,$pk = 'id'){
    $has = Db::name($table)->where($pk,$id)->find();
    if($has && isset($has['delete_time'])){
        //假删除
        return Db::name($table)->where($pk,$id)->update([
            'delete_time' => time()
        ]);
    }else{
        return Db::name($table)->where($pk,$id)->delete();
    }
}

/**
 * 字节数Byte转换为KB、MB、GB、TB
 * @param int $size
 * @return string
 */
function xn_file_size($size){
    $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
    for ($i = 0; $size >= 1024 && $i < 5; $i++) $size /= 1024;
    return round($size, 2) . $units[$i];
}

/**
 * 驼峰命名转下划线命名
 * @param $camelCaps
 * @param string $separator
 * @return string
 */
function xn_uncamelize($camelCaps,$separator='_')
{
    return strtolower(preg_replace('/([a-z])([A-Z])/', "$1" . $separator . "$2", $camelCaps));
}

/**
 * 密码加密函数
 * @param $password
 * @return string
 */
function xn_encrypt($password)
{
    $salt = 'xiaoniu_admin';
    return md5(md5($password.$salt));
}

/**
 * 管理员操作日志
 * @param $remark
 */
function xn_add_admin_log($remark)
{
    $data = [
        'admin_id' => session('admin_auth.id'),
        'url' => request()->url(true),
        'ip' => request()->ip(),
        'remark' => $remark,
        'method' =>request()->method(),
        'param' => json_encode(request()->param()),
        'create_time' => time()
    ];
    if(session('admin_auth.id') == 1){
        \app\common\model\AdminLog::insert($data);
    }
}

/**
 * 获取自定义config/cfg目录下的配置
 * 用法： xn_cfg('base') 或 xn_cfg('base.website') 不支持无限极
 * @param string|null $name
 * @param string|null $default
 * @param string|null $path
 * @return array|string
 */
function xn_cfg($name, $default='', $path='cfg')
{
    if (false === strpos($name, '.')) {
        $name = strtolower($name);
        $config  = \think\facade\Config::load($path.'/'.$name, $name);
        return $config ?? [];
    }
    $name_arr    = explode('.', $name);
    $name_arr[0] = strtolower($name_arr[0]);
    $filename = $name_arr[0];
    $config  = \think\facade\Config::load($path.'/'.$filename, $filename);
    return $config[$name_arr[1]] ?? $default;
}

/**
 * 根目录物理路径
 * @return string
 */
function xn_root()
{
    return app()->getRootPath() . 'public';
}
//////////////默认的分类选择
function xn_upload_moren($value,$file_name,$water=null,$thumb=null,$select=1)
{

$html=<<<php
    <div class="xn-upload-box">
        <div class="t layui-col-md12 layui-col-space10">
            <input type="hidden" name="{$file_name}" class="layui-input xn-images" value="{$value}">
            <div class="layui-col-md4">
                <div type="button" class="layui-btn webuploader-container" id="{$file_name}" data-water="{$water}" data-thumb="{$thumb}" style="width: 113px;"><i class="layui-icon layui-icon-picture"></i>上传图片</div>
            <div type="button" class="layui-btn chooseImage" data-num="1"><i class="layui-icon layui-icon-table"></i>官方图库</div>
            </div>
        </div>
        <ul class="upload-ul clearfix">
            <span class="imagelist"></span>
        </ul>
        <script>$('#{$file_name}').uploadOne();</script>
    </div>
php;
    return $html;
}
/**
 * 构建图片上传HTML 单图
 * @param string $value
 * @param string $file_name
 * @param null $water 是否添加水印 null-系统配置设定 1-添加水印 0-不添加水印
 * @param null $thumb 生成缩略图，传入宽高，用英文逗号隔开，如：200,200（仅对本地存储方式生效，七牛、oss存储方式建议使用服务商提供的图片接口）
 * @return string
 */
function xn_upload_one($value,$file_name,$water=null,$thumb=null,$select=1)
{

$html=<<<php
    <div class="xn-upload-box">
        <div class="t layui-col-md12 layui-col-space10">
            <input type="hidden" name="{$file_name}" class="layui-input xn-images" value="{$value}">
            <div class="layui-col-md4">
                <div type="button" class="layui-btn webuploader-container" id="{$file_name}" data-water="{$water}" data-thumb="{$thumb}" style="width: 113px;"><i class="layui-icon layui-icon-picture"></i>上传图片</div>
                <div type="button" class="layui-btn chooseImageOne" data-num="1"><i class="layui-icon layui-icon-table"></i>选择图片</div>
            </div>
        </div>
        <ul class="upload-ul clearfix">
            <span class="imagelist"></span>
        </ul>
        <script>$('#{$file_name}').uploadOne();</script>
    </div>
php;
    return $html;
}
function xn_upload_one_unselect($value,$file_name,$water=null,$thumb=null,$select=1)
{

$html=<<<php
    <div class="xn-upload-box">
        <div class="t layui-col-md12 layui-col-space10">
            <input type="hidden" name="{$file_name}" class="layui-input xn-images" value="{$value}">
            <div class="layui-col-md4">
                <div type="button" class="layui-btn webuploader-container" id="{$file_name}" data-water="{$water}" data-thumb="{$thumb}" style="width: 113px;"><i class="layui-icon layui-icon-picture"></i>上传图片</div>
            </div>
        </div>
        <ul class="upload-ul clearfix">
            <span class="imagelist"></span>
        </ul>
        <script>$('#{$file_name}').uploadOne();</script>
    </div>
php;
    return $html;
}
function xn_upload_video($value,$file_name,$water=null,$thumb=null,$select=1)
{

$html=<<<php
    <div class="xn-upload-box">
        <div class="t layui-col-md12 layui-col-space10">
            <div class="layui-col-md8">
                <input type="text" name="{$file_name}" class="layui-input xn-images" value="{$value}">
            </div>
            <div class="layui-col-md4">
                <div type="button" class="layui-btn webuploader-container" id="{$file_name}" data-water="0" data-thumb="" style="width: 113px;">
                    <div class="webuploader-pick"><i class="layui-icon layui-icon-picture"></i>上传视频</div>
                </div>
            </div>
        </div>
        <ul class="upload-ul clearfix">
            <span class="imagelist"></span>
        </ul>
        <script>$('#{$file_name}').uploadVideo();</script>
    </div>

php;
    return $html;
}

/**
 * 构建图片上传HTML 多图
 * @param string $value
 * @param string $file_name
 * @param null $water 是否添加水印 null-系统配置设定 1-添加水印 0-不添加水印
 * @param null $thumb 生成缩略图，传入宽高，用英文逗号隔开，如：200,200（仅对本地存储方式生效，七牛、oss存储方式建议使用服务商提供的图片接口）
 * @return string
 */
function xn_upload_multi($value,$file_name,$water=null,$thumb=null)
{
    $html=<<<php
    <div class="xn-upload-box">
        <div class="t layui-col-md12 layui-col-space10">
            <div class="layui-col-md8">
                <input type="text" name="{$file_name}" class="layui-input xn-images" value="{$value}">
            </div>
            <div class="layui-col-md4">
                <div type="button" class="layui-btn webuploader-container" id="{$file_name}" data-water="{$water}" data-thumb="{$thumb}" style="width: 113px;"><i class="layui-icon layui-icon-picture"></i>上传图片</div>
                <div type="button" class="layui-btn chooseImage"><i class="layui-icon layui-icon-table"></i>选择图片</div>
            </div>
        </div>
        <ul class="upload-ul clearfix">
            <span class="imagelist"></span>
        </ul>
        <script>$('#{$file_name}').upload();</script>
    </div>
php;
    return $html;
}

/**
 * 格式化标签，将空格、中文逗号替换成英文半角分号
 * @param $tags
 * @return string
 */
function xn_format_tags($tags)
{
    $tags = trim($tags);
    $tags = str_replace(' ',',',str_replace('，',',',$tags));
    $arr = explode(',',$tags);
    $data = [];
    foreach ($arr as $v) {
        if( $v!='' ) {
            $data[] = $v;
        }
    }
    return implode(',',$data);
}

/**
 * 生成全局唯一标识符
 * @param bool $trim
 * @return string
 */
function xn_create_guid()
{
    $charid = strtoupper(md5(uniqid(mt_rand(), true)));
    $hyphen = chr(45);// "-"
    $uuid = chr(123)// "{"
        .substr($charid, 0, 8).$hyphen
        .substr($charid, 8, 4).$hyphen
        .substr($charid,12, 4).$hyphen
        .substr($charid,16, 4).$hyphen
        .substr($charid,20,12)
        .chr(125);// "}"
    return $uuid;
}

//生成订单号
function xn_create_order_no() {
    $yCode = array('A', 'T', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J');
    $orderSn = substr(time(), -5) . substr(microtime(), 2, 3) . sprintf('%02d', rand(0, 99));
    return $orderSn;
}

/**
 * @param $search 查找字符串
 * @param $replace 替换字符串
 * @param $subject 原始字符串
 * @return mixed
 */
function xn_str_lreplace($search, $replace, $subject)
{
    $pos = strrpos($subject, $search);

    if($pos !== false)
    {
        $subject = substr_replace($subject, $replace, $pos, strlen($search));
    }

    return $subject;
}


function changeOrderStatus($orderId,$param)
{
    $res = Db::name('order')->where('id',$orderId)->update($param);
    return $res;
}

function changeScore($userId, $changeNum, $description, $otherId = 0, $type = 0)
{
    //0签到
    $score = abs($changeNum);
    //查询用户
    $userInfo = Db::name('user')->where('id',$userId)->find();
    
    $res = Db::name("user_score_log")->insert([
        'user_id'     => $userId,
        'create_time' => time(),
        'description' => $description,
        'score'       => $changeNum,
        'other_id'    => $otherId,
        'type'        => $type,
       
    ]);

    if ($changeNum > 0) {
        $b = Db::name("user")
            ->where('id', $userId)
            ->inc('score', $score)
            ->update();
    } else {
        $b = Db::name("user")
            ->where('id', $userId)
            ->dec('score', $score)
            ->update();
    }
    if ($res && $b) {
        return true;
    } else {
        return false;
    }
}

 //处理用户余额
function changeMoney($userId, $changeNum, $description, $otherId = 0, $type = 0)
{
    //0签到
    $score = abs($changeNum);
    $user = Db::name("user")->where('id',$userId)->find();
    $res = Db::name("user_money_log")->insert([
        'user_id'     => $userId,
        'create_time' => time(),
        'description' => $description,
        'money'       => $changeNum,
        'other_id'    => $otherId,         
        'money_yue'   => $user['money']+$changeNum,

    ]);

    if ($changeNum > 0) {
        $b = Db::name("user")
            ->where('id', $userId)
            ->inc('money', $score)
            ->update();
    } else {
        $b = Db::name("user")
            ->where('id', $userId)
            ->dec('money', $score)
            ->update();
    }
    if ($res && $b) {
        return true;
    } else {
        return false;
    }
}

    
function _Postrequest($url, $data, $ssl = true)
{   
    $headers = [
        "Content-type: application/json;charset='utf-8'"
    ];
    //curl完成
    $curl = curl_init();
    //设置curl选项
    curl_setopt($curl, CURLOPT_URL, $url);//URL
    $user_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0 FirePHP/0.7.4';
    curl_setopt($curl, CURLOPT_USERAGENT, $user_agent);//user_agent，请求代理信息
    curl_setopt($curl, CURLOPT_AUTOREFERER, true);//referer头，请求来源
    curl_setopt($curl, CURLOPT_TIMEOUT, 30);//设置超时时间
    //SSL相关
    if ($ssl) {
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);//禁用后cURL将终止从服务端进行验证
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);//检查服务器SSL证书中是否存在一个公用名(common name)。
    }
    // 处理post相关选项
    curl_setopt($curl, CURLOPT_POST, true);// 是否为POST请求
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);// 处理请求数据
    // 处理响应结果
    curl_setopt($curl, CURLOPT_HEADER, false);//是否处理响应头
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);//curl_exec()是否返回响应结果
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers); 
    // 发出请求
    $response = curl_exec($curl);
    if (false === $response) {
        echo '<br>', curl_error($curl), '<br>';
        return false;
    }
    curl_close($curl);
    return $response;
}

function checkTextByQiniu($text)
{
    $qiniu = new Qiniu();
    $noPass = ['politics','terrorism','abuse','porn'];
    $res = $qiniu->textCheck($text);
    if ($res['suggestion'] == 'pass') {
        return [
            'code' => 1,
            'msg'  => '通过'
        ];
    }else{
        if (isset($res['scenes']['antispam']['details'][0]['label'])) {
            $type = $res['scenes']['antispam']['details'][0]['label'];
            // var_dump(getCheckTextType()[$type]);exit;
            if (isset(getCheckTextType()[$type]) && in_array($type, $noPass)) {
                return [
                    'code' => 0,
                    'msg'  => '非法字符'.getCheckTextType()[$type]
                ];
            }else{
                return [
                    'code' => 1,
                    'msg'  => '通过'
                ];
            }

        }
        
    }
    return [
        'code' => 0,
        'msg'  => '未知的非法字符'
    ];
}

function getCheckTextType()
{
    return [
        'normal' => '正常文本',
        'spam' => '含垃圾信息',
        'ad' => '广告',
        'politics' => '涉政',
        'terrorism' => '暴恐',
        'abuse' => '辱骂',
        'porn' => '色情',
        'flood' => '灌水',
        'contraband' => '违禁',
        'meaningless' => '无意义'
    ];
}

