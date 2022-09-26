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
use app\admin\model\Category as CateModel;
use app\common\model\AuthGroup;
use app\common\model\AuthGroupAccess;
use think\facade\Db;

class Category extends AdminBase
{
    public function index()
    {
        $list = Db::name('category')->where('fid',0)->select()->each(function($item){
            $item['son'] = Db::name('category')->where('fid',$item['id'])->select();
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',['list'=>$list]);
    }

    //查看下级
    public function showFollow()
    {
        $param = $this->request->param();
        if (isset($param['keywords']) && $param['keywords'] != '') {
            $where = [
                ['u.mobile|u.nickname','LIKE','%'.$param['keywords'].'%']
            ];
        }
        // var_dump($where);exit;
        $list = Db::name('category_follow')->alias('a')
            ->join('user u','a.user_id = u.id')
            ->field('a.id fid,a.user_id,a.is_manage')
            ->where($where)
            ->where('a.cate_id',$param['id'])->select()->order('is_manage desc,id desc')->each(function($item){
                $item['user'] = Db::name('user')->where('id',$item['user_id'])->find();
                return $item;
            });

      
        
        return view('',['list'=>$list,'id'=>$param['id']]);
    }

    public function setManage()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            // var_dump($param);exit;
            $result = Db::name('category_follow')->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
    }

    /**
     * 添加管理员
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $insert_id = Db::name('category')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                xn_add_admin_log('添加分类');
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $category = Db::name('category')->where('fid',0)->select();
        return view('form',['category'=>$category]);
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
            // var_dump($param);exit;
            $result = CateModel::update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $category = Db::name('category')->where('fid',0)->where('id','<>',$id)->select();
        $assign = [
            'info'=> CateModel::find($id),
            'category'=>$category
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
        CateModel::destroy($id);
        Db::name('category_follow')->where('cate_id',$id)->delete();

        xn_add_admin_log('删除圈子');
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
            $result = CateModel::where('id',$id)->update($param);
            if( $result ) {
                xn_add_admin_log('修改个人资料');
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->getAdminId();
        $user_data = CateModel::find($id);
        return view('', ['user_data'=>$user_data]);
    }
}
