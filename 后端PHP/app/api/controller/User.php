<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\api\controller;

use think\facade\Session;
use think\Exception;
use server\jwt\Jwt;
use think\facade\Config;
use think\Request;
use wechat\xcx\WXBizDataCrypt;
use think\facade\Db;
use think\db\Query;
use app\common\model\UploadFiles as UploadFilesModel;

class User extends Base
{
    // public function __construct(Request $request)
    // {
    //     //如果有JWT则自动获取用户id
    //     $jwt = $request->header('token');
    //     if (!$jwt) {
    //         $jwt = $request->param['token'];
    //     }
    //     if ($jwt) {
    //         $jwtDecode         = Jwt::decode($jwt, Config::get('jwt.key'), ['HS256']);
    //         $request->userInfo = Db::name('user')->where('id', $jwtDecode->uid)->find();
    //         if (!empty($request->userInfo)) {
    //             $request->loginInfo = $request->userInfo;
    //             $request->userId    = $jwtDecode->uid;
    //         }
    //     }
    // }

    //发布帖子
    public function addNewGoods(Request $request)
    {
        $param = $request->param();
        checkCloseSpeck($request->loginInfo['id']);
        //images tags_ids cate_id content 
        $res = checkTextByQiniu($param['content']);
        if ($res['code'] == 0) {
            return error(false,$res['msg']);
        }
        $site = xn_cfg('base');
        if (isset($site['add_goods_sh']) && $site['add_goods_sh'] == 1) {
            $param['is_sh'] = 1;
             $msg="发布成功";
        }else{
            $param['is_sh'] = 0;
                 $msg="发布成功，请等待审核";

        }
        
        $param['create_time'] = time();
        $param['tags_ids'] = ','.$param['tags_ids'].',';
        $param['user_id'] = $request->loginInfo['id'];
        // unset($param['token']);
        $res = Db::name('goods')->strict(false)->insertGetId($param);
        if ($res) {
            Db::name('category')->where('id',$param['cate_id'])->inc('goods_num')->update();
            Db::name('active')->where('id',$param['tags_ids'])->inc('goods_num')->update();

            addAfterLevel($request->loginInfo,'goods');//处理等级
            addAfterMedal($request->loginInfo,'goods');//处理勋章
            return success($res,$msg);
        }
        return error($res,'发布失败');
    }

    //修改基本信息
    public function set(Request $request)
    {
        $param = $request->param();
        $id = $request->loginInfo['id'];
        $upd = Db::name('user')->where('id',$id)->update([
            'nickname' => $param['nickname'],
            'avatar'   => $param['avatar'],
            'dec'      => $param['dec']
        ]);
        return success($upd,'修改成功');
    }
    //发布活动
    public function addActive(Request $request)
    {
        $param = $request->param();

        //title detail images address  lat  lng  times
        checkCloseSpeck($request->loginInfo['id']);
        $res = checkTextByQiniu($param['title'].''.$param['detail']);
        if ($res['code'] == 0) {
            return error(false,$res['msg']);
        }

        $site = xn_cfg('base');
        if (isset($site['add_active_sh']) && $site['add_active_sh'] == 1) {
            $param['is_sh'] = 1;
                 $msg="发布成功";
        }else{
            $param['is_sh'] = 0;
                 $msg="发布成功，请等待审核";
        }
        $param['create_time'] = time();
        $param['user_id'] = $request->loginInfo['id'];
        // unset($param['token']);
        $res = Db::name('active')->strict(false)->insertGetId($param);
        if ($res) {
            addAfterLevel($request->loginInfo,'active');
            return success($res,$msg);
        }
        return error($res,'发布失败');
    }


    //创建圈子
    public function addcategory(Request $request)
    {
        $param = $request->param();


        checkCloseSpeck($request->loginInfo['id']);
        $res = checkTextByQiniu($param['title'].''.$param['title_sub']);
        if ($res['code'] == 0) {
            return error(false,$res['msg']);
        }

        $site = xn_cfg('base');
        if (isset($site['add_category_sh']) && $site['add_category_sh'] == 1) {
            $param['is_sh'] = 1;
            $msg="创建成功";
        }else{
            $param['is_sh'] = 0;
            $msg="创建成功，请等待审核";

        }
        $param['create_time'] = time();
        $param['user_id'] = $request->loginInfo['id'];
        // unset($param['token']);
        $res = Db::name('category')->strict(false)->insertGetId($param);
        if ($res) {

            $insert = Db::name('category_follow')
            ->insert([
                'create_time' => time(),
                'user_id'   => $myId,
                'cate_id' => $res,
                'is_manage' =>1

            ]);
            Db::name('category')->where('id',$res)->inc('follow_num')->update();

            addAfterLevel($request->loginInfo,'category');
            return success($res,$msg);
        }
        return error($res,'发布失败');
    }



    public function PageData(Request $request)
    {
        $res = [];
        return success($res);
    }
    //获取用户基本信息
    public function index(Request $request)
    {

      
        $userInfo = $request->loginInfo;
       

        $res = [
            "userinfo" => [
                "avatar" =>getImageUrlArr($userInfo['avatar'],'avatar'),
                "nickname" => $userInfo['nickname'],
                "lv" => 0,
                "money" =>0,
                "coupon" => 0,
                "mc" => "0",
                "integral" => $userInfo['score'],
                "mobile" => $userInfo['mobile'],
                "encrypt" => $userInfo['id']
            ],
            "userVip" => [
                "is_vip" =>0,
                "vip_name" =>'',
                "vip_tes" => "",
                "vip_end_time" =>'',
                "user_vip_card_cue" =>'',
                "user_vip_card_icon" => getImageUrlArr("/wx-image/my/13619a5f379e2af12a3057dd069508ab.png"),
                "vip_eco" => "",
                "vip_button" =>[],
                "vip_equity" => []
            ],
            "orderNum" => [
                "non_order" =>0,
                "on_order" =>0,
                "com_order" =>0,
            ]
        ];
        return success($res);
    }

    //评论帖子
    public function addGoodsComment(Request $request)
    {
        $param = $request->param();
        checkCloseSpeck($request->loginInfo['id']);
        $user_id = $request->loginInfo['id'];
        $goods_id = $param['goods_id'];
        $content = $param['content'];
        $pid = isset($param['pid']) ? $param['pid'] : 0;
        $to_name = isset($param['to_name']) ? $param['to_name'] : '';
        $goods = Db::name('goods')->where('id',$goods_id)->find();
        $insert = Db::name('goods_comment')->insertGetId([
            'create_time' => time(),
            'user_id'     => $user_id,
            'goods_id'    => $goods_id,
            'content'     => $content,
            'pid'         => $pid,
            'to_name'     => $to_name,
            'fa_user_id'  => $goods['user_id']
        ]);
        $res = Db::name('goods_comment')->alias('a')
            ->join('user u','a.user_id = u.id')
            ->field('a.id,a.content,a.to_name,a.like_num,a.user_id,a.fa_user_id,u.nickname,u.avatar,a.create_time')
            ->where('a.id',$insert)
            ->select()->each(function($item)use($user_id){
                $item['ziji_id']=$user_id;
                $item['avatar'] = getImageUrlArr($item['avatar'],'avatar');
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });
        Db::name('goods')->where('id',$goods_id)->inc('ping_num')->update();
        addAfterMedal($request->loginInfo,'comment');//处理勋章
        return success($res,'评论成功');
    }

 

   //系统消息
    public function getMessageList(Request $request)
    {
        $id = $request->loginInfo['id'];
        $list = Db::name('message')
            ->where('to_id = 0 OR to_id = '.$id)
            ->paginate(10)
            ->each(function($item){
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });
        return success($list);
    }


    //评论我的
    public function commentMeList(Request $request)
    {
        $param = $request->param();
        $id = $request->loginInfo['id'];
        $fans = Db::name('goods_comment')->alias('a')
            ->field('a.goods_id goods_id,a.content,a.user_id,u.nickname,u.avatar,a.create_time')
            ->join('user u','a.user_id = u.id')
            ->where('a.fa_user_id = '.$id)
            ->paginate(10)
            ->each(function($item){
               $goods   = Db::name('goods')->where(['id' => $item['goods_id']])->find(); 
                $item['goods_image'] = getImageUrlArr(explode(',',$goods['images']));    
                $item['avatar'] = getImageUrlArr($item['avatar'],'avatar');
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });

        return success($fans);
    }
    //点赞我的
    public function likeMeList(Request $request)
    {
        $param = $request->param();
        $id = $request->loginInfo['id'];
        $fans = Db::name('goods_like')->alias('a')
            ->field('a.goods_id goods_id,a.user_id,u.nickname,u.avatar,a.create_time')
            ->join('user u','a.user_id = u.id')
            ->where('a.fa_user_id = '.$id)
            ->paginate(10)
            ->each(function($item){
                 $goods   = Db::name('goods')->where(['id' => $item['goods_id']])->find(); 
                $item['goods_image'] = getImageUrlArr(explode(',',$goods['images']));                                
                $item['avatar'] = getImageUrlArr($item['avatar'],'avatar');
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });

        return success($fans);
    }
     //操作帖子
    public function edieGoods(Request $request)
    {
        $param = $request->param();
        $uid = $request->loginInfo['id'];
        $goods = Db::name('goods')->where(['id'=>$param['id']])->find();
        $manage = Db::name('category_follow')->where(['cate_id'=>$param['id'],'user_id' => $uid,'is_manage' =>1])->find();
        
        if ($param['type'] =='1') {
        if ($goods['user_id'] == $uid || $manage) {
            $del= Db::name('goods')->where(['id'=>$param['id']])->delete();         
            deleteGoodsAfter($goods);
            return success([],'删除成功');
        }
        }
        if ($param['type'] =='2') {
              Db::name('goods')->where('id',$param['id'])->update([
            'is_tuijian' =>1          
        ]);
         return success([],'操作成功');                   
        }

         if ($param['type'] =='3') {
              Db::name('goods')->where('id',$param['id'])->update([
            'is_ding' =>1          
        ]);
         return success([],'操作成功');                   
        }
        return error([],'没有操作权限');
        
    }

   //操作评论
     public function editcomment(Request $request)
        {
        $param = $request->param();
            if ($param['type']=='del'){
            $del= Db::name('goods_comment')->where(['id'=>$param['id']])->delete(); 
            Db::name('goods')->where('id',$param['goods_id'])->dec('ping_num')->update();
            Db::name('goods_comment')->where('pid',$param['id'])->delete();
              return success('[]','删除成功');
            }

             if ($param['type']=='top'){
            Db::name('goods_comment')->where('id',$param['id'])->update([
            'is_ding' =>$param['num']         
              ]);
              return success('[]','操作成功');
            }
     
        }



    //我关注列表
    public function myFollowList(Request $request)
    {
        $param = $request->param();
        $id = $request->loginInfo['id'];
        $fans = \app\admin\model\User::where('id IN(SELECT user_id FROM xn_user_fans WHERE fans_id = '.$id.')')
            ->paginate(10)
            ->each(function($item){
                unset($item['open_id']);
                unset($item['password']);
                unset($item['ip']);
                unset($item['unionid']);
                return $item;
            });

        return success($fans);
    }

    //我关注的圈子
    public function flowGroup(Request $request)
    {
        $id = $request->loginInfo['id'];       
        $list = Db::name('category')
            ->where('id IN(SELECT cate_id FROM xn_category_follow WHERE user_id = '.$id.')')
            ->paginate(10)
            ->each(function($item){
                $item['image'] = getImageUrlArr($item['image'],'avatar');
                return $item;
            });

        return success($list);
    }

    //我发布的帖子
    public function myGoodsList(Request $request)
    {
        $param = $request->param();
        $myId = $request->loginInfo['id'];
        $res = Db::name('goods')->alias('a')
            ->join('user u','u.id = a.user_id')
            ->where('user_id',$myId)
            ->field('a.id,a.images mainImage,a.create_time date,a.tags_ids,u.avatar userAvatar,u.nickname userName,desc,content,view_num collectionCount,ping_num commentCount,like_num likeCount')
            ->order('id desc,date desc')
            ->paginate(10)
            ->each(function($item){
                $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_goods_like WHERE goods_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>0
                ]; 
                $item['userAvatar'] = getImageUrlArr($item['userAvatar'],'avatar');
                $item['mainImage'] = getImageUrlArr(explode(',',$item['mainImage']));
                $tags = Db::name('tags')->where('id','IN',$item['tags_ids'])->select();
                $item['label'] = $tags;
                unset($item['tags_ids']);
                return $item;
            });
        return success($res);
    }


    //我点赞的帖子
    public function myLikeGoodsList(Request $request)
    {
        $param = $request->param();
        $myId = $request->loginInfo['id'];
        $res = Db::name('goods')->alias('a')
            ->join('user u','u.id = a.user_id')
            ->where('a.id IN(SELECT goods_id FROM xn_goods_like WHERE user_id = '.$myId.')')
            ->field('a.id,a.images mainImage,a.create_time date,a.tags_ids,u.avatar userAvatar,u.nickname userName,content,view_num collectionCount,ping_num commentCount,like_num likeCount')
            ->order('id desc,date desc')
            ->paginate(10)
            ->each(function($item){
                $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_goods_like WHERE goods_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>0
                ]; 
                $item['userAvatar'] = getImageUrlArr($item['userAvatar'],'avatar');
                $item['mainImage'] = getImageUrlArr(explode(',',$item['mainImage']));
                $tags = Db::name('tags')->where('id','IN',$item['tags_ids'])->select();
                $item['label'] = $tags;
                unset($item['tags_ids']);
                return $item;
            });
        return success($res);
    }

    ///关注某人/ post用户atteuserids
    public function followUser(Request $request)
    {
        $param = $request->param();
        $id    = $param['user_id'];
        $myId  = $request->loginInfo['id'];
        $data = true;

        if ($id==$myId||$id==0){
            return error([],'别自恋，自己关注自己？');
        }


        $has   = Db::name('user_fans')->where(['user_id' => $id, 'fans_id' => $myId])->find();
        if ($has) {
            //取消关注
            $deletes = Db::name('user_fans')->where('id',$has['id'])->delete();
            Db::name('user')->where('id',$id)->dec('fans_num')->update();
            return success($data,'取消成功');
        }else{
            $insert = Db::name('user_fans')
            ->insert([
                'create_time' => time(),
                'fans_id'   => $myId,
                'user_id' => $id
            ]);
            Db::name('user')->where('id',$id)->inc('fans_num')->update();
            return success($data,'关注成功');
        }
    }



      ///报名活动
    public function followactive(Request $request)
    {
        $param = $request->param();
        $id    = $param['id'];
        $myId  = $request->loginInfo['id'];
        $data = true;
        $has   = Db::name('active_join')->where(['active_id' => $id, 'user_id' => $myId])->find();
        if ($has) {
            //取消关注
            $deletes = Db::name('active_join')->where('id',$has['id'])->delete();
            Db::name('active')->where('id',$id)->dec('join_num')->update();
            return success($data,'取消成功');
        }else{
            $insert = Db::name('active_join')
            ->insert([
                'create_time' => time(),
                'user_id'   => $myId,
                'active_id' => $id
            ]);
            Db::name('active')->where('id',$id)->inc('join_num')->update();
            return success($data,'报名成功');
        }
    }

     ///关注圈子
    public function followgroup(Request $request)
    {
        $param = $request->param();
        $id    = $param['id'];
        $myId  = $request->loginInfo['id'];
        $data = true;
        $has   = Db::name('category_follow')->where(['cate_id' => $id, 'user_id' => $myId])->find();
        if ($has) {
            //取消关注
            $deletes = Db::name('category_follow')->where('id',$has['id'])->delete();
            Db::name('category')->where('id',$id)->dec('follow_num')->update();
            return success($data,'取消成功');
        }else{
            $insert = Db::name('category_follow')
            ->insert([
                'create_time' => time(),
                'user_id'   => $myId,
                'cate_id' => $id
            ]);
            Db::name('category')->where('id',$id)->inc('follow_num')->update();
            return success($data,'关注成功');
        }
    }


    //点赞帖子
    public function likeGoods(Request $request)
    {
        $param = request()->param();
        $id    = $param['id'];
        $myId  = $request->loginInfo['id'];
        $data = true;
        $goods = Db::name('goods')->where('id',$id)->find();
        $has   = Db::name('goods_like')->where(['goods_id' => $id, 'user_id' => $myId])->find();
        if ($has) {
            //取消点赞
            $deletes = Db::name('goods_like')->where('id',$has['id'])->delete();
            Db::name('goods')->where('id',$id)->dec('like_num')->update();
            return success($data,'取消成功');
        }else{
            //点赞
            $insert = Db::name('goods_like')
            ->insert([
                'create_time'  => time(),
                'goods_id'     => $id,
                'fa_user_id'   => $goods['user_id'],
                'user_id'      => $myId
            ]);
            Db::name('goods')->where('id',$id)->inc('like_num')->update();
            addAfterMedal($request->loginInfo,'like');//处理勋章
            return success($data,'点赞成功');
        }
    }

    //点赞评论
    public function likeComment(Request $request)
    {
        $param = request()->param();
        $id    = $param['id'];
        $myId  = $request->loginInfo['id'];
        $data = true;
        $goods = Db::name('goods_comment')->where('id',$id)->find();
        $has   = Db::name('goods_comment_like')->where(['comment_id' => $id, 'user_id' => $myId])->find();
        // var_dump($has);exit;
        if ($has) {
            //取消点赞
            $deletes = Db::name('goods_comment_like')->where('id',$has['id'])->delete();
            Db::name('goods_comment')->where('id',$id)->dec('like_num')->update();
            return success($data,'取消成功');
        }else{
            //点赞
            $insert = Db::name('goods_comment_like')
            ->insert([
                'create_time'  => time(),
                'comment_id'     => $id,
                'fa_user_id'   => $goods['user_id'],
                'goods_id'   => $goods['goods_id'],
                'user_id'      => $myId
            ]);
            Db::name('goods_comment')->where('id',$id)->inc('like_num')->update();
            return success($data,'点赞成功');
        }
    }


    public function addOftenbuy(Request $request)
    {
        $param = $request->param();
        $uid = $request->loginInfo['id'];
        $did = $param['goods_id'];
        $has = Db::name('goods_often')->where(['user_id'=>$uid,'team_id'=>$did])->find();
        if (!$has) {
            //新增
            $goods = Db::name('goods')->where('id',$did)->find();
            Db::name('goods_often')->insert([
                'team_id' => $did,
                'user_id' => $uid,
                'cate_id' => $goods['cate_id2'],
                'create_time' => time()
            ]);
        }else{
            Db::name('goods_often')->where('id',$has['id'])->delete();
        }
        return success($has ? '取消成功' : '加入成功');
    }


 


    //获取小程序二维码
    public function goodShow_erweima(Request $request)
    {
        $header = $request->header();
        $param  = $request->param();       
        
        $userInfo = $request->loginInfo;
        $webInfo = $this->webinfo;

        $appid = $webInfo['xcx_appid'];
        $appsecret = $webInfo['xcx_secret'];
        
        $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $appid . "&secret=" . $appsecret;
        $weixin = file_get_contents($url);
        $jsondecode = json_decode($weixin); //对JSON格式的字符串进行编码
        $array = get_object_vars($jsondecode);//转换成数组
        $access_token = $array['access_token'];//输出token
            
        $ewmurl = "https://api.weixin.qq.com/wxa/getwxacode?access_token=" . $access_token;
        $sharepath = 'pages/tuan/detail?id='.$param['id'].'&user_id='.$userInfo['id'];

        $data = array(
            "path" => $sharepath,
            "width" => '80',
            
        );
        $datas = json_encode($data);
        $result = _Postrequest($ewmurl, $datas);
        
        $root = app()->getRootPath().'public';
        $path = "/uploads/miniqrcode/goods/";
        $newpath = $root . $path;
        $sjc = $userInfo['id'].'_'.$param['id'];
        if (!file_exists($newpath)) {
            mkdir($newpath);
        }
        file_put_contents($newpath . "/" . $sjc . ".png", $result);
        $imgpath = $request->domain()."/uploads/miniqrcode/goods/" . $sjc . ".png";
        
        return success([
            'info' => $imgpath         
        ]);
    }
    



   

    public function httpGet($url) {
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

    public function updateUserInfo(Request $request)
    {
        $param = $request->param();
        $userInfo = $request->loginInfo;
        $uid = $userInfo['id'];
        Db::name('user')->where('id',$uid)->update([
            'avatar' => $param['avatar'],
            'nickname' => $param['nickname'],
        ]);
        return success();
    }

    public function BinMobile(Request $request)
    {
        $site = xn_cfg('base');
        $param    = $request->param();
        $appid = $site['xcx_appid'];
        $appsecret = $site['xcx_secret'];
        $grant_type = "authorization_code"; //授权（必填）
        $code = $param['code'];    //ÓÐÐ§ÆÚ5·ÖÖÓ µÇÂ¼»á»°
        $encryptedData=$param['encryptedData'];
        $iv = $param['iv'];
        $url = "https://api.weixin.qq.com/sns/jscode2session?"."appid=".$appid."&secret=".$appsecret."&js_code=".$code."&grant_type=".$grant_type;

        $curlGet = $this->httpGet($url);
        $res = json_decode($curlGet,true);   
        $pc = new WXBizDataCrypt($appid,$res['session_key']);
        $err=$pc->decryptData($encryptedData, $iv, $data );    
        if ($err!=0){
            return error($data);    
        }       
        $phone= json_decode($data)->phoneNumber;


        $id = $request->loginInfo['id'];
        $upd = Db::name('user')->where('id',$id)->update(['mobile'=>$phone]);


        return success($upd);

    }


        //传图
    public function up_img(Request $request)
    {
        Session::set('admin_auth.id',$this->webid);
        $folder_name = $request->param('folder_name/s','file');
        // var_dump($request->file());exit;
        $result = (new UploadFilesModel)->upload($folder_name,3);
        return success($result);
    }


}