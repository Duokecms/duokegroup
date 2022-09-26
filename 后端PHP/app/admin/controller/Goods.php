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
use app\admin\model\Goods as GoodsModel;
use app\admin\model\Taocan;
use think\facade\Db;

class Goods extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $model = new GoodsModel();
        $model = $model->with(['user'=>function($query){
            $query->field('id,nickname,avatar');
        }]);
        $model = $model->with(['cate'=>function($query){
            $query->field('id,title');
        }]);
        // $model = $model->where('admin_id',$this->getAdminId());
        $model = $model->where('delete_time',0);
        //构造搜索条件
        if( $param['keywords']!='' ) {
            $model = $model->where('content','LIKE','%'.$param['keywords'].'%');
        }
        if( $param['partner_title']!='' ) {
            $model = $model->where("partner_id IN(SELECT id FROM XN_PARTNER WHERE title LIKE '%".$param['partner_title']."%')");
        }
        if( $param['start_date']!=''&&$param['end_date']!='' ) {
            $model = $model->whereBetweenTime('create_time',$param['start_date'],$param['end_date']);
        }
        if( $param['cate_id']!='') {
            $model = $model->where('cate_id',$param['cate_id']);
        }
        $list = $model->order('id desc')->paginate(10,false,['query' => $param])->each(function ($item, $key) {
            $images = getImageUrlArr(explode(',', $item['images']));
            $item['images'] = $images[0];
            $item['tags'] = Db::name('tags')->where('id','IN',$item['tags_ids'])->select()->toArray();
            return $item;
        });
        // dump($list->toArray());exit;
        return view('',[
            'list'=>$list,
            'cate'=>Db::name('category')->where('fid',0)->select()
        ]);
    }

    public function showPing()
    {

        $param = $this->request->param();

        $list = Db::name('goods_comment')
            ->where('goods_id',$param['id'])
            ->paginate(10)->each(function($item) use($param){
                $item['user'] = Db::name('user')->where('id',$item['user_id'])->find();
                $item['child'] = Db::name('goods_comment')
                    ->where('pid',$item['id'])
                    ->where('goods_id',$param['id'])
                    ->select()->each(function($item2){
                        $item['user'] = Db::name('user')->where('id',$item['user_id'])->find();
                        
                        return $item2;
                    });
                return $item;
            });
        return view('',['list'=>$list]);
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
            $param['create_time'] = time();
            
            if (isset($param['tags_ids'])) {
                $param['tags_ids'] = ','.implode(',',$param['tags_ids']).',';
            }
            
            $insert_id = Db::name('goods')->strict(false)->insertGetId($param);
            
            if( $insert_id ) {
                Db::name('category')->where('id',$param['cate_id'])->inc('goods_num')->update();
                Db::name('active')->where('id',$param['tags_ids'])->inc('goods_num')->update();
                $this->success('添加成功');
            } else {
                $this->error('操作失败');
            }
        }
         $assign = [
          //  'data'=> GoodsModel::find($id),
            'cateOne' => \app\admin\model\Category::where('fid',0)->where('status',1)->select(),
            'tags' => Db::name('tags')->select(),
            'data' => [
                'limit_num'=>0,
                'kucun'=>9999,
                'begin_time' => date('Y-m-d H:i:s',time()),
                'end_time' => date('Y-m-d H:i:s',time()+3600*24*30)
            ]
        ];
        return view('form', $assign);
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


    /**
     * 删除节点
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>1) && $this->error('参数错误');
        // GoodsModel::destroy($id);
        $info = Db::name('goods')->where('id',$id)->find();
        deleteGoodsAfter($info);
        Db::name('goods')->where('id',$id)->delete();
        $this->success('删除成功');
    }

    public function deletePing()
    {
        $id = intval($this->request->get('id'));
        $comment = Db::name('goods_comment')->where('id',$id)->find();
        Db::name('goods_comment')->where('id',$id)->delete();
        Db::name('goods')->where('id',$comment['goods_id'])->dec('ping_num')->update();
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
        $param = $this->request->param();
        $id = $param['id'];
        $user_data = GoodsModel::find($id);
        $user_data['images'] = explode(',',$user_data['images']);
        return view('', ['user_data'=>$user_data]);
    }
}
