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
use app\admin\model\Message as ThisModel;
use app\admin\model\Taocan;
use think\facade\Db;

class Message extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $model = new ThisModel();
        //构造搜索条件
        if( $param['keywords']!='' ) {
            $model = $model->where('goods_name','LIKE','%'.$param['keywords'].'%');
        }
        if( $param['start_date']!=''&&$param['end_date']!='' ) {
            $model = $model->whereBetweenTime('create_time',$param['start_date'],$param['end_date']);
        }
        $list = $model->order('id desc')->paginate(['query' => $param])->each(function ($item, $key) {
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',[
            'list'=>$list
        ]);
    }

    

    /**
     * 添加
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add()
    {
        $param = $this->request->param();
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $param['create_time'] = time();
            $insert_id = Db::name('message')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        if (isset($param['user_id'])) {
            $user_id = $param['user_id'];
        }else{
            $user_id = 0;
        }
        return view('form',['user_id'=>$user_id]);
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
            if(!isset($param['duotaocan'])){
                $param['duotaocan'] = 0;
            }
            if(isset($param['title']) && !isset($param['status'])){
                $param['status'] = 0;
            }
            if (isset($param['tags_ids'])) {
                $param['tags_ids'] = ','.implode(',',$param['tags_ids']).',';
            }
            $result = GoodsModel::update($param);
            if( $result ) {
                //处理套餐
                $this->doTaocan($param);
                xn_add_admin_log('修改产品信息');
                $this->success('修改成功','index','','1');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $data = GoodsModel::with('taocan')->find($id)->toArray();
        $cateOne = \app\admin\model\Category::where('fid',0)->select()->toArray();
        $cateTwo = \app\admin\model\Category::where('fid',$data['cate_id'])->select()->toArray();
        $assign = [
            'data'=> $data,
            'tags' => Db::name('tags')->select(),
            'tuanXiang' => json_decode($data['tuan_xiangmu'],true),
            'cateOne' => $cateOne,
            'cateTwo' => $cateTwo,
            'partner' => Db::name('partner')->select()
        ];
        // dump($assign);exit;
        return view('form', $assign);
    }

    public function doTaocan($param)
    {
        // var_dump($param);exit;
        for ($i=0; $i < count($param['taocan_title']); $i++) { 
            if ($param['taocan_id'][$i] == 0) {
                //新增
                $add = Db::name('goods_taocan')->insert([
                    'goods_id'    => $param['id'],
                    'title'       => $param['taocan_title'][$i],
                    'old_price'   => $param['taocan_old_price'][$i],
                    'price'       => $param['taocan_price'][$i],
                    'vip_price'   => $param['taocan_vip_price'][$i],
                    // 'yongjin_money' => $param['taocan_yongjin_money'][$i],
                    'kucun'       => $param['taocan_kucun'][$i],
                    'unit'       => $param['taocan_unit'][$i],
                    'limit_num'   => $param['taocan_limit_num'][$i],
                    'create_time' => time()
                ]);
            }else{
                //修改
                $upd = Db::name('goods_taocan')->where('id',$param['taocan_id'][$i])->update([
                    'goods_id'  => $param['id'],
                    'title'     => $param['taocan_title'][$i],
                    'old_price' => $param['taocan_old_price'][$i],
                    'price'     => $param['taocan_price'][$i],
                    'vip_price' => $param['taocan_vip_price'][$i],
                    // 'yongjin_money' => $param['taocan_yongjin_money'][$i],
                    'kucun'     => $param['taocan_kucun'][$i],
                    'unit'     => $param['taocan_unit'][$i],
                    'limit_num' => $param['taocan_limit_num'][$i],
                ]);
            }
        }
        return true;
    }


    /**
     * 删除节点
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>1) && $this->error('参数错误');
        // GoodsModel::destroy($id);
        Db::name('message')->where('id',$id)->delete();
        $this->success('删除成功');
    }

    public function getOption()
    {
        $id = intval($this->request->get('id'));
        $cate = Db::name('category')->where('fid',$id)->select();
        $htmls = '';
        foreach ($cate as $v) {
            $htmls .= '<option value="'.$v['id'].'">'.$v['title'].'</option>';
        }
        return $htmls;
    }
    /**
     * 删除套餐
     */
    public function del_taocan()
    {
        $id = intval($this->request->param('id'));
        $res = Taocan::destroy($id);
        xn_add_admin_log('删除套餐');
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
            $result = PartModel::where('id',$id)->update($param);
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
