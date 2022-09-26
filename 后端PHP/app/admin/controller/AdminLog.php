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
use app\common\model\AdminLog as AdminLogModel;
use think\facade\Db;

class AdminLog extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $model = new AdminLogModel();
        if( $param['start_date']!=''&&$param['end_date']!='' ) {
            $model = $model->whereBetweenTime('create_time',$param['start_date'],$param['end_date']);
        }
        $list = $model->order('id desc')->paginate(['query' => $param]);
        return view('',['list'=>$list]);
    }

    /**
     * 清除日志
     */
    public function clear()
    {
        $model = Db::name('admin_log');
        $day = $this->request->param('day/d');
        if( $day > 0 ) {
            $model = $model->whereTime('create_time', '<=', strtotime(date('Y-m-d',time()-$day*86400)) );
            $result = $model->delete();
        } else {
            $result = $model->delete(true);
        }
        if( $result ) {
            xn_add_admin_log('清除日志');
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }
}
