<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\common\model;

use app\common\lib\Oss;
use app\common\lib\Qiniu;
use app\common\model\UploadFiles as UploadFilesModel;
use think\exception\ValidateException;
use think\facade\Filesystem;
use think\facade\Session;
use think\Image;
use think\Model;

class UploadFiles extends Model
{
    /**
     * 获取器 - 文件上传来自应用名
     * @param $value
     * @return mixed
     */
    public function getAppAttr($value)
    {
        $status = [0=>'前台',1=>'后台'];
        return $status[$value];
    }

    /**
     * 获取器 - 存储位置
     * @param $value
     * @return mixed
     */
    public function getStorageAttr($value)
    {
        $status = [0=>'本地',1=>'OSS',2=>'七牛'];
        return $status[$value];
    }

    /**
     * 获取器 - 格式化文件大小
     * @param $value
     * @return string
     */
    public function getFileSizeAttr($value)
    {
        return xn_file_size($value);
    }

    public function upload($folder_name='files',$app=1)
    {
        try {
            $param = request()->param();
            $file = request()->file('file');
            //文件后缀名
            $ext = $file->getOriginalExtension();
            //配置信息
            $config = xn_cfg('upload');
            //存储类型
            $storage = $config['storage'];
            $isImage = 1;
            //图片水印处理
            if (isset($param['water'])) {
                if( in_array( strtolower($ext), ['png','jpg','jpeg','gif','bmp'] ) ) {
                    if( self::setWater($file,$param['water']) === false ) {
                        return ['code'=>0,'msg'=>'水印配置有误'];
                    }
                }
            }
            
            //avi、wmv、mpeg、mp4、m4v、mov、asf、flv、f4v、rmvb、rm、3gp、vob
            if( in_array( strtolower($ext), ['avi','wmv','mpeg','mp4','m4v','mov','asf','flv','f4v','rmvb','rm','3gp','vob'] ) ) {
                $isImage = 0;
            }
            

            if( $storage==1 ) {
                //上传到阿里云oss
                $oss = new Oss();
                $file_path = $oss->putFile($file,$err,$folder_name);
                if( !$file_path ) {
                    return ['code'=>0,'msg'=>$err];
                }
            } elseif ($storage==2){
                //上传到七牛云
                $adminid= intval(Session::get('admin_auth.id'));
                $qiniu = new Qiniu();
                $savename =$adminid.'/'. date('Ymd') . '/' . md5((string) microtime(true)).'.'. $ext;
                $file_path = $qiniu->putFile($savename, $file->getRealPath());
                if( !$file_path ) {
                    return ['code'=>0,'msg'=>'上传失败'];
                }
            } else {
                  $adminid= intval(Session::get('admin_auth.id'));
                //上传到本地服务器
                $folder = config('filesystem.disks.folder') . '/'.$adminid.'/' . $folder_name; //存文件目录
                $savename = Filesystem::disk('public')->putFile($folder,$file);
                if (!$savename) {
                    return ['code'=>0,'msg'=>'上传失败'];
                }
                $file_path = '/' . str_replace("\\","/",$savename);

                //缩略图
                if(isset($param['thumb']) && $param['thumb']!='' ) {
                    self::createThumb($file,$param['thumb'],$savename);
                }
            }

            //记录入文件表
            $insert_data = [
                'url' => $file_path,
                'storage' => $storage,
                'app' => $app,
                'user_id' => intval(Session::get('admin_auth.id')),
                'file_name' => $file->getOriginalName(),
                'file_size' => $file->getSize(),
                'file_type' => 'image',
                'extension' => strtolower(pathinfo($file->getOriginalName(), PATHINFO_EXTENSION)),
                'create_time' => time()
            ];
            if ($isImage == 1) {
                self::create($insert_data);
            }
            return ['code'=>1,'file'=>$file_path];
        } catch (ValidateException $e) {
            return ['code'=>0,'msg'=>$e->getMessage()];
        }
    }


    /**
     * 图片添加水印
     * @param $file
     * @param null $is_water
     */
    public function setWater($file,$is_water=null)
    {
        if( $is_water=='0' ) {
            return true;
        }
        $config = xn_cfg('upload');
        //图片水印
        if( $config['is_water']==1 || $is_water=='1' ) {
            $water_path = xn_root()."/".ltrim($config['water_img'],'/');
            if( !file_exists($water_path) ) {
                return false;
            }
            $image = Image::open($file);
            $image->water($water_path, $config['water_locate'], $config['water_alpha']);
            $image->save($file->getPathName());
        }
        return true;
    }

    /**
     * 生成缩略图
     * @param object $file
     * @param string $thumb 缩略图格式,如 200,200  多张用 | 好隔开
     * @param string $save_path 保存文件的路径
     */
    public function createThumb($file,$thumb,$save_path)
    {
        $thumbs = explode('|',$thumb);
        foreach ($thumbs as $w_h) {
            $arr = explode('.',$save_path);
            $w_h = explode(',',$w_h);
            $thumb_name = $arr[0].'_'.$w_h[0].'_'.$w_h[1].'.'.$arr[1];
            $image = Image::open($file);
            $image->thumb($w_h[0],$w_h[1],3);
            $image->save(xn_root()."\\" .$thumb_name);
        }
    }
}