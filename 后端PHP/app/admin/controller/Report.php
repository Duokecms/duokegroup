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
use app\admin\model\Report as ThisModel;
use think\facade\Db;

class Report extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $model = new ThisModel();
        $model = $model->with(['user'=>function($query){
            $query->field('id,nickname,avatar');
        }]);
        $model = $model->with(['faUser'=>function($query){
            $query->field('id,nickname,avatar');
        }]);
        $list = $model->paginate(['query' => $param])->each(function ($item, $key) use($type){
            $item['image'] = getImageUrlArr($item['image']);
            $item['type'] = $type[$item['type']];
            return $item;
        });
        return view('',['list'=>$list,'type'=>$type]);
    }

    
    /**
     * 编辑
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $result = ThisModel::update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $type = getMedalType();
        $assign = [
            'info'=> ThisModel::find($id),
            'type' => $type
        ];
        return view('form', $assign);
    }

    /**
     * 删除节点
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>1) && $this->error('参数错误');
        ThisModel::destroy($id);
        $this->success('删除成功');
    }

    /**
     * 修改资料
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function info()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $id = $this->getAdminId();
            if( $param['password']!='' ){
                $param['password'] = xn_encrypt($param['password']);
            } else {
                unset($param['password']);
            }
            $result = ThisModel::where('id',$id)->update($param);
            if( $result ) {
                xn_add_admin_log('修改个人资料');
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->getAdminId();
        $user_data = ThisModel::find($id);
        return view('', ['user_data'=>$user_data]);
    }
}
