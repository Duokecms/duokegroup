<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\common\lib;

use Qiniu\Auth;
use Qiniu\Config;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;
use Qiniu\Http\Client;

/**
 * 七牛云
 * Class Qiniu
 * @package app\common\lib
 */
class Qiniu
{
    private $ak='';
    private $sk='';
    private $bucket='';
    private $domain='';
    public function __construct()
    {
        $config = xn_cfg('upload');
        empty($this->ak) && $this->ak = $config['qiniu_ak'];
        empty($this->sk) &&  $this->sk = $config['qiniu_sk'];
        empty($this->bucket) &&  $this->bucket = $config['qiniu_bucket'];
        empty($this->domain) &&  $this->domain = $config['qiniu_domain'];
    }

    /**
     * 上传文件
     * @param $path
     * @param $name
     * @return bool
     * @throws \Exception
     */
    public function putFile($key,$filePath)
    {
        $token = $this->getToken();
        $uploadMgr = new UploadManager();
        list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
        if ($err !== null) {
            return false;
        } else {
            return $this->domain . $ret['key'];
        }
    }

    /**
     * 文字审核
     * @param $path
     * @param $name
     * @return bool
     * @throws \Exception
     */
    function imageCheck()
    {   
        // 用于签名的公钥和私钥
        $ak ="";//这里填写你的ak
        $sk ="";//这里填写你的sk
        $image_url='https://img-home.csdnimg.cn/images/20211129024917.jpg';//这里是图片地址
        $host = 'ai.qiniuapi.com';
        $url = 'http://ai.qiniuapi.com/v3/image/censor';//请求接口
        $contentType = 'application/json';
        $method='POST';
        //审核类型scenes与相应的label/group（值）
        $scenes = [
            'censor' => ['pulp', 'terror', 'politician', 'ads'],
            'pulp' => ['pulp'],
            'terror' => ['terror'],
            'politician' => ['politician'],
            'ads' => ['ads']
        ];

        $body = [
            'data' => ['uri' => $image_url],
            'params' => ['scenes' => $scenes['censor']]//图片审核类型
        ];


        $auth = new Auth($this->ak,$this->sk);
        $headers = $auth->authorizationV2($url, $method, json_encode($body), $contentType);
        // var_dump($headers);
        $headers['Content-Type']  = $contentType;
        $headers['Host'] = $host;
        $res = http_request_qiniu($url,json_encode($body),$headers);
        return $res;
        $res = $res->body;
        $res = json_decode($res,true);
        return $res;
    }
    public function textCheck($text)
    {
        $url = 'http://ai.qiniuapi.com/v3/text/censor';
        $method = "POST";
        $host = "ai.qiniuapi.com";
        $contentType = "application/json";
        $body = [
            'data'    => [
                'text' => $text
            ],
            'params'   => [
                'scenes' => ["antispam"]
            ]
        ];
        $auth = new Auth($this->ak,$this->sk);
        $headers = $auth->authorizationV2($url,$method,json_encode($body),$contentType);
        $headers['Content-Type']= $contentType;
        $headers['Host']= $host;
        $res = Client::post($url,json_encode($body), $headers);
        $ret = json_decode($res->body,true);
        if (isset($ret['result'])) {
            return $ret['result'];
        }else{
            return [
                'suggestion' => 'error',
                'scenes' => []
            ];
        }
        return $ret;
        
    }

    /**
     * 删除远程文件
     * @param $key
     */
    public function delete($key)
    {
        $auth = new Auth($this->ak,$this->sk);
        $config = new Config();
        $bucketManager = new BucketManager($auth, $config);
        $bucketManager->delete($this->bucket, $key);
    }

    /**
     * 获取token
     * @return string
     */
    protected function getToken()
    {
        $auth = new Auth($this->ak,$this->sk);
        $token = $auth->uploadToken($this->bucket);
        return $token;
    }
}