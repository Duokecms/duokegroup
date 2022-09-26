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

class Active extends AdminBase
{

    //首页滚动新闻
    public function index()
    {
        $list = Db::name('active')->select()->each(function($item){
            $item['goods_count'] = count(explode(',', rtrim($item['goods_ids'],',')));
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',['list'=>$list]);
    }

    public function add()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $param['goods_ids'] = ','.implode(',',$param['goods_list']).',';
            unset($param['goods_list']);
            $insert_id = Db::name('active')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        return view('form');
    }

    public function edit()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $result = Db::name('active')->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $info = Db::name('active')->where('id',$id)->find();
        $assign = [
            'info'=> $info,
            'allGoods' => Db::name('goods')->field('id,goods_name')->select()->toArray(),
            'selectGoods' => Db::name('goods')->where('id','IN',$info['goods_ids'])->select()->toArray()
        ];
        // dump($assign);exit;
        return view('form', $assign);
    }

    //查看下级
    public function showJoin()
    {

        $param = $this->request->param();
        $model = new \app\admin\model\User();
        $model = $model->where('id IN(SELECT user_id FROM xn_active_join WHERE active_id = '.$param['id'].')');
        $list = $model->order('id ASC')->paginate(['list_rows'=>10,'query' => $param])->each(function ($item, $key) {
            return $item;
        });
        return view('',['list'=>$list]);
    }

    public function delete()
    {
        $id = intval($this->request->get('id'));
        Db::name('active')->where('id',$id)->delete();
        $this->success('删除成功');
    }

}
