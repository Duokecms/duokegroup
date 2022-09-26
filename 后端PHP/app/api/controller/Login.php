<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/9 - 4:00 下午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------
namespace app\api\controller;

use server\jwt\Jwt;
use think\Exception;
use think\facade\Config;
use think\facade\Request;
use think\facade\Validate;
use wechat\xcx\WXBizDataCrypt;
use think\facade\Db;
use server\curl\Curl;
use server\log\Log;

class Login extends Base
{
    public $needLogin = false;


    public function index()
    {
        $a = [
            'a' => 1,
            'b' => 2,
            'c' => 3
        ];
        trace($a, 'dandan');
        try {
            $post = Request::post();
            $login_token = Jwt::encode([
                'uid' => 1
            ], Config::get('jwt.key'));

            return success([
                'login_token' => $login_token
            ]);

        } catch (\Exception $exception) {
            return error($exception->getMessage(), $exception->getCode());
        }
    }

    public function sendsms(Request $request)
    {
        $param  = Request::param();
        $phone = $param['mobile'];
        $site = xn_cfg('base');
        $code = rand(1000, 9999);
        cmf_verification_code_log($phone,$code);
        if (isset($site['sms_is'])) {
            //走正常发送渠道
            $res = sendSms($param['mobile'],$code);
            return success([
                'sms_is' =>1,
                'code'   => 200
            ]); 
            exit;    
        }else{
            return success([
                'sms_is' =>0,
                'code' => $code
            ]); 
        }
    }

    public function getopenid()
    {
        $param  = Request::param();

        $appid = $this->webinfo['xcx_appid'];
        $appsecret = $this->webinfo['xcx_secret'];
        $grant_type = "authorization_code"; //授权（必填）
        $code = $param['code'];    //有效期5分钟 登录会话
        $encryptedData  = $param['encryptedData'];
        $iv = $param['iv'];

        // $unionid = $this->jscode2Session($code);
        // dump($unionid);exit;
        // 拼接url
        $url = "https://api.weixin.qq.com/sns/jscode2session?"."appid=".$appid."&secret=".$appsecret."&js_code=".$code."&grant_type=".$grant_type;
        $curlGet = $this->httpGet($url);
        $res = json_decode($curlGet,true);
        
        $pc = new WXBizDataCrypt($appid,$res['session_key']);
        $err=$pc->decryptData($encryptedData, $iv, $data );   
        if ($err!=0){
            return error($data);  
        }   
        return success($res);
    }

    public function getmobile(Request $request)
    {
        $param  = Request::param();
        $appid = $this->webinfo['xcx_appid'];
        $appsecret = $this->webinfo['xcx_secret'];
        $grant_type = "authorization_code"; //授权（必填）
        $code = $param['code'];    //ÓÐÐ§ÆÚ5·ÖÖÓ µÇÂ¼»á»°
        $encryptedData=$_GET['encryptedData'];
        $iv = $param['iv'];
        $url = "https://api.weixin.qq.com/sns/jscode2session?"."appid=".$appid."&secret=".$appsecret."&js_code=".$code."&grant_type=".$grant_type;
        $curlGet = xn_httpGet($url);
        $res = json_decode($curlGet,true);
        $pc = new WXBizDataCrypt($appid,$res['session_key']);
        $err=$pc->decryptData($encryptedData, $iv, $data );    
        if ($err!=0){
            return error($data);    
        }       
        $phone = json_decode($data)->phoneNumber;
        $param['mobile'] = $phone;
        $res = $this->xcxreg($param);
        if (!$res) {
            return error('','注册失败');
        }else{
            return success($res);
        }
    }

    public function mobileLogin(Request $request)
    {
        $param  = Request::param();
        $mobile = $param['mobile'];
        if (cmf_check_verification_code($param['mobile'], $param['code'], false) != '') {
            return error('',"验证码错误!");
        }
        $login_user = Db::name('user')->where('mobile',$mobile)->find();
        $ip = Request::ip();
        $cityArr = ip2address($ip);
        $cityArr = json_decode($cityArr,true);
        $city = isset($cityArr['city']) ? $cityArr['province'].'-'.$cityArr['city'] : '';
        if ($login_user){ //已注册
            $login_token = Jwt::encode([
                'uid' => $login_user['id']
            ], Config::get('jwt.key'));
            Db::name('user')->where('id',$login_user['id'])->update([
                'ip' => $ip,
                'city' => $city
            ]);
            return success([
                'login_token' => $login_token,
                'user_id'     => $login_user['id']
            ]);
        }else{
            //注册用户
            $data                    = [];
            $data['username']        = $mobile;
            $data['mobile']          = $mobile;
            $data['nickname']        = '匿名';
            $data['last_login_time'] = time();
            $data['create_time']     = time();
            $data['platform']        = isset($param['platform']) ? $param['platform'] : 'H5';
            $data['dec']             = '这个用户很懒,什么也没留下...';
            $data['ip']              = $ip;
            $data['city']            = $city;
            $userId = $this->doRegister($data);
            if ($userId) {
                $login_token = Jwt::encode([
                    'uid' => $userId
                ], Config::get('jwt.key'));
                return success([
                    'login_token' => $login_token,
                    'user_id'     => $userId
                ]);

            } else {
                return error('',"注册失败!");
            }
        }

    }


    ///小程序udenglu
    public function third(Request $request)
    {
        $site = xn_cfg('base');
        $param  = Request::param();
        $appid = $site['xcx_appid'];
        $appsecret = $site['xcx_secret'];
        $grant_type = "authorization_code"; //授权（必填）
        $code = $param['code'];    //有效期5分钟 登录会话
        $encryptedData  = $param['encryptedData'];
        $iv = $param['iv'];

        // $unionid = $this->jscode2Session($code);
        // dump($unionid);exit;
        // 拼接url
        $url = "https://api.weixin.qq.com/sns/jscode2session?"."appid=".$appid."&secret=".$appsecret."&js_code=".$code."&grant_type=".$grant_type;
        $curlGet = $this->httpGet($url);
        $res = json_decode($curlGet,true);
        
        $param['open_id']=$res['openid'];

        $res = $this->xcxreg($param);
        if (!$res) {
            return error('','注册失败');
        }else{
            return success($res);
        }
    

    }

    public function xcxreg($param)
    {
        $openid = $param['open_id'];
        $mobile = '';
        $unionid = '';
        $ip = Request::ip();
        $cityArr = ip2address($ip);
        $cityArr = json_decode($cityArr,true);
        $city = isset($cityArr['city']) ? $cityArr['province'].'-'.$cityArr['city'] : '';
        $login_user = Db::name('user')->where('open_id',$openid)->find();

        $param['nickname']=mb_substr($param['nickname'], 0,6);


        if ($login_user){ //已注册
            Db::name('user')->where('id',$login_user['id'])->update([
                'open_id'=>$openid,
                'avatar' => $param['avatar'],
                'nickname' => $param['nickname'],
                'ip' => $ip,
                'city' => $city
            ]);
            $login_token = Jwt::encode([
                'uid' => $login_user['id']
            ], Config::get('jwt.key'));
            return [
                'login_token' => $login_token,
                'user_id'     => $login_user['id']
            ];
        }else{
            //注册用户
            $data                    = [];
            $data['avatar']          = $param['avatar'];
            $data['nickname']        = $param['nickname'];
            $data['last_login_time'] = time();
            $data['sex']             = $param['sex'];
            $data['create_time']     = time();
            $data['platform']        = isset($param['platform']) ? $param['platform'] : 'H5';
            $data['dec']             = '这个用户很懒,什么也没留下...';
            $data['ip']              = $ip;
            $data['city']            = $city;
            $data['open_id']          = $openid;
            $userId = $this->doRegister($data);
            if ($userId) {
                $login_token = Jwt::encode([
                    'uid' => $userId
                ], Config::get('jwt.key'));
                return [
                    'login_token' => $login_token,
                    'user_id'     => $userId
                ];
            } else {
                return [];
            }
        }

    }

    //批量注册
    public function batchAddUser()
    {
        $str = '且听风铃,微光倾城,偷得浮生,雨晨的清风,烛光里的愿,紫色的彩虹,伊人泪满面,青丝茧,微醉阳光,如花的旋律,代价是折磨,倚靠窗畔,花舞花落,泪梦里花,浅浅嫣然笑,深巷的猫,漫步云海涧,执手不忆殇,云纹梦纷蝶,阳光温暖,空屋触摸阳光,闪耀旳白梦,橱窗的光,初晓微芒,深渊的那支花,地平线,无际烟雨彷徨,回忆的沙漏,黑魅惑,钢琴上的芭蕾,潮起潮落,半颗心的暖,焰火灿烂时,化思念为星,流苏书包,芭比萌妹,不再回忆谁,海氹有点甜,梦梦贝莉雅,三字故事,乱世小熊,呵呵恩恩哦,一瞬之光,萌傻卿,勇敢的小萝卜';
        $nickArr = explode(',',$str);exit;
        foreach ($nickArr as $nickname) {
            $username = $mobile = '13567'.rand(111111,999999);
            $data                    = [];
            $data['username']        = $username;
            $data['mobile']          = $mobile;
            $data['nickname']        = $nickname;
            $data['last_login_time'] = time();
            $data['create_time']     = time();
            $data['dec']             = '这个用户很懒,什么也没留下...';
            $data['ip']              = Request::ip();
            // var_dump($data);exit;
            $userId = $this->doRegister($data);
        }
        
        
    }

    /**
     * 执行注册
     */
    private function doRegister($data)
    {
        $result = Db::name("user")->insertGetId($data);
        return $result;
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

    //小程序获取openid unionid
    public function jscode2Session($js_code)
    {
        // $js_code = $param['js_code'];
        $url     = "https://api.weixin.qq.com/sns/jscode2session?appid=wx12edc177bfff46fb&secret=c620311ab13e401142838fa504527d36&js_code={$js_code}&grant_type=authorization_code";
        //初始化
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        // 执行后不直接打印出来
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, false);
        // 跳过证书检查
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        // 不从证书中检查SSL加密算法是否存在
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

        //执行并获取HTML文档内容
        $output = curl_exec($ch);

        //释放curl句柄
        curl_close($ch);
        return $output;
    }


}