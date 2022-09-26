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
use app\common\model\AuthRule;
use utils\Data;

class Auth extends AdminBase
{
    public function index()
    {
        $list = AuthRule::order('sort asc, id asc')->select()->toArray();
        $list = Data::tree($list, 'title','id');
        return view('',['list'=>$list])->filter(function($content){
            return str_replace("&amp;emsp;",'&emsp;',$content);
        });
    }

    /**
     * 编辑节点
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $result = AuthRule::update($param);
            if( $result ) {
                if(isset($param['is_curd']) && $param['is_curd'] == 1){
                    //自动生成add  eidt  delete
                    // $this->curd($param,$param);
                }
                xn_add_admin_log('编辑权限节点');
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $data = AuthRule::where('id',$id)->find();
        $list = AuthRule::select()->toArray();
        $list = Data::tree($list, 'title','id');
        return view('form',['data'=>$data,'list'=>$list,'pid'=>$data['pid']])->filter(function($content){
            return str_replace("&amp;emsp;",'&emsp;',$content);
        });
    }

    /**
     * 添加节点
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $result = AuthRule::create($param);
            if( $result ) {
                if(isset($param['is_curd']) && $param['is_curd'] == 1){
                    //自动生成add  eidt  delete
                    $this->curd($param,$result->toArray());
                }
                xn_add_admin_log('添加权限节点');
                $this->success('操作成功');
            } else {
                $this->success('操作失败');
            }
        }
        $list = AuthRule::select()->toArray();
        $list = Data::tree($list, 'title','id');
        return view('form',['list'=>$list,'pid'=>$this->request->get('pid')])->filter(function($content){
            return str_replace("&amp;emsp;",'&emsp;',$content);
        });
    }

    public function curd($param,$pid)
    {
        $pid = $pid['id'];
        $curd = [
            [
                'pid' => $pid,
                'title' => '添加',
                'name'  => xn_str_lreplace(strrchr($param['name'],'/'),'/add',$param['name'])
            ],
            [
                'pid' => $pid,
                'title' => '编辑',
                'name'  => xn_str_lreplace(strrchr($param['name'],'/'),'/edit',$param['name'])
            ],
            [
                'pid' => $pid,
                'title' => '删除',
                'name'  => xn_str_lreplace(strrchr($param['name'],'/'),'/delete',$param['name'])
            ]
        ];
        // var_dump($curd);exit;
        foreach ($curd as $v){
            $res = AuthRule::create($v);
        }
        return $res;
    }

    /**
     * 删除节点
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>0) && $this->error('参数错误');
        $child_count = AuthRule::where('pid',$id)->count();
        $child_count && $this->error('请先删除子节点');
        AuthRule::destroy($id);
        xn_add_admin_log('删除权限节点');
        $this->success('删除成功');
    }

    /**
     * 排序
     */
    public function sort()
    {
        $param = $this->request->post();
        foreach ($param as $k => $v) {
            $v=empty($v) ? null : $v;
            AuthRule::where('id', $k)->save(['sort'=>$v]);
        }
        $this->success('排序成功', url('index'));
    }
}
