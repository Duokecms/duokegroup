<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\common\lib;

use OSS\Core\OssException;
use OSS\OssClient;
use think\facade\Filesystem;

/**
 * 阿里云oss
 * Class Oss
 * @package app\common\lib
 */
class Oss
{
    private $ak='';
    private $sk='';
    private $bucket='';
    private $endpoint='';
    public function __construct()
    {
        $config = xn_cfg('upload');
        empty($this->ak) && $this->ak = $config['oss_ak'];
        empty($this->sk) &&  $this->sk = $config['oss_sk'];
        empty($this->bucket) &&  $this->bucket = $config['oss_bucket'];
        empty($this->endpoint) &&  $this->endpoint = $config['oss_endpoint'];
    }

    /**
     * 上传文件
     * @param $file
     * @return bool
     * @throws \OSS\Core\OssException
     */
    public function putFile($file,&$err='')
    {
        try {
            $folder = config('filesystem.disks.folder'); //根路径文件夹
            $savename = Filesystem::disk('public')->putFile($folder,$file);
            if ($savename) {
                $object_path = str_replace("\\","/",$savename);
                $content = file_get_contents($object_path);
                //删除本地文件
                unlink($object_path);
                try {
                    $oss = new OssClient($this->ak, $this->sk, $this->endpoint);
                    $reslut = $oss->putObject($this->bucket, $object_path, $content);
                    $file_path = $reslut['info']['url'];
                    return $file_path;
                } catch (OssException $e) {
                    $err = $e->getMessage();
                    return false;
                }
            } else {
                $err = '上传失败';
                return false;
            }
        } catch (\Exception $e) {
            $err = $e->getMessage();
            return false;
        }
    }

    /**
     * 删除远程文件
     * @param $object
     * @param $err
     * @return bool
     */
    public function delete($object,&$err='')
    {
        try{
            $oss = new OssClient($this->ak, $this->sk, $this->endpoint);
            $oss->deleteObject($this->bucket, $object);
        } catch(OssException $e) {
            $err = $e->getMessage();
            return $err;
        }
    }
}