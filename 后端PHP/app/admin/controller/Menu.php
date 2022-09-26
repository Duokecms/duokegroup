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
use think\facade\Db;

class Menu extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $list = Db::name('menu')->paginate(['query' => $param])->each(function ($item, $key) {
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',['list'=>$list]);
    }



    public function category()
    {
        $list = Db::name('category_menu')->where('fid',0)->select()->each(function($item){
            $item['son'] = Db::name('category_menu')->where('fid',$item['id'])->select();
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',['list'=>$list]);
    }
    /**
     * 添加管理员
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add_cate()
    {
        $param = $this->request->param();
        if( $this->request->isPost() ) {
            
            $insert_id = Db::name('category_menu')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }

        if ($param['fid'] > 0) {
            $category = Db::name('category_menu')->where('id',$param['fid'])->select();
        }else{
            $category = Db::name('category_menu')->where('fid',0)->select();
        }
        
        return view('form_cate',['category'=>$category]);
    }

    public function add()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $param['create_time'] = time();
            $insert_id = Db::name('menu')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $category = Db::name('category_menu')->where('fid','<>',0)->select();
        return view('form',['category'=>$category]);
    }
    /**
     * 编辑
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit_cate()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            // var_dump($param);exit;
            $result = Db::name('category_menu')->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $category = Db::name('category_menu')->where('fid',0)->where('id','<>',$id)->select();
        $assign = [
            'info'=> Db::name('category_menu')->where('id',$id)->find(),
            'category'=>$category
        ];
        return view('form_cate', $assign);
    }

    public function edit()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            // var_dump($param);exit;
            unset($param['file']);
            $result = Db::name('menu')->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $category = Db::name('category_menu')->where('fid','<>',0)->select();
        $assign = [
            'data'=> Db::name('menu')->where('id',$id)->find(),
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
        Db::name('menu')->where('id',$id)->delete();
        $this->success('删除成功');
    }

    /**
     * 删除节点
     */
    public function delete_cate()
    {
        $id = intval($this->request->get('id'));
        Db::name('category_menu')->where('id',$id)->delete();
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
