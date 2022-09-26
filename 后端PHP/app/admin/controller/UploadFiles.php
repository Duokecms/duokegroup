<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\admin\controller;

use app\common\controller\AdminBase;
use app\common\lib\Oss;
use app\common\lib\Qiniu;
use OSS\Core\OssException;
use think\exception\ValidateException;
use think\facade\Filesystem;
use app\common\model\UploadFiles as UploadFilesModel;

class UploadFiles extends AdminBase
{
    protected $noAuth = ['upload','select'];

    public function index()
    {
        $param = $this->request->param();
        $model = new UploadFilesModel();
        //构造搜索条件
        if( $param['storage']!='' ) {
            $model = $model->where('storage',$param['storage']);
        }
        if( $param['start_date']!=''&&$param['end_date']!='' ) {
            $model = $model->whereBetweenTime('create_time',$param['start_date'],$param['end_date']);
        }
        $list = $model->order('id desc')->paginate(['query' => $param]);
        return view('',['list'=>$list]);
    }

    public function select()
    {
        $list = UploadFilesModel::where('app',1)->where('user_id','IN','1,'.$this->getAdminId())->order('id desc')->paginate(['list_rows'=>24,'query' => $this->request->param()]);
        $num = intval($this->request->get('num'));
        return view('',['list'=>$list,'num'=>$num]);
    }

    /**
     * 删除文件
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>0) && $this->error('参数错误');
        $file_data = UploadFilesModel::find($id);
        $storage = $file_data->getData('storage');
        if( $storage == 1 ) {
            $key = explode(xn_cfg('upload.oss_endpoint').'/', $file_data->url);
            //删除远程oss文件
            if( isset($key[1]) ) {
                $oss = new Oss();
                $oss->delete($key[1]);
            }
        } elseif ( $storage == 2 ) {
            //删除七牛远程文件
            $domain = xn_cfg('upload.qiniu_domain');
            $key = str_replace($domain,'',$file_data->url);
            $qiniu = new Qiniu();
            $qiniu->delete($key);
        } else {
            //删除本地服务器文件
            $file_path = xn_root()."/".ltrim($file_data->url,'/');
            if( file_exists($file_path) ) {
                unlink($file_path);
            }
        }
        UploadFilesModel::destroy($id);
        xn_add_admin_log('删除文件');
        $this->success('删除成功');
    }

    /**
     * 文件上传
     * @return \think\response\Json
     * @throws OssException
     */
    public function upload()
    {
        $folder_name = $this->request->param('folder_name/s','file');
        $result = UploadFilesModel::upload($folder_name);
        return json($result);
    }

    
}
