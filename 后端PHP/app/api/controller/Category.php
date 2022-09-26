<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\api\controller;

use think\facade\Session;
use think\Exception;
use server\jwt\Jwt;
use think\facade\Config;
use app\api\model\Tags;
use think\Request;
use think\facade\Db;
use server\log\Log;
use think\db\Query;

class Category extends Base
{
    public function __construct(Request $request)
    {
        //如果有JWT则自动获取用户id
        $jwt = $request->header('token');
        if ($jwt) {
            $jwtDecode         = Jwt::decode($jwt, Config::get('jwt.key'), ['HS256']);
            $request->userInfo = Db::name('user')->where('id', $jwtDecode->uid)->find();
            if (!empty($request->userInfo)) {
                $request->loginInfo = $request->userInfo;
                $request->userId    = $jwtDecode->uid;

            }
        }
        $webid = $request->header('webid');
        if ($webid) {
            $this->webid   = $webid;
            $this->webinfo = Db::name('admin')->where('id', $webid)->find();
        } else {
            $this->webinfo = Db::name('admin')->where('id', $this->webid)->find();
        }
    }

    public function GetCategory(Request $request)
    {
        $param = $request->param();
        $id = $param['id'];
        Db::name('category')->where('id',$param['id'])->inc('hot')->update(); 
        $res = Db::name('category')->where('id',$param['id'])->find();
        $res['image'] = getImageUrlArr($res['image']);   
        $res['banner'] = getImageUrlArr(explode(',',$res['banner']));
        $res["is_follow"] = Db::name('category_follow')->where(['user_id'=>$request->loginInfo['id'],'cate_id' => $id])->count() > 0;
        $res['goods'] = Db::name('goods')->field('id,content')->where(['cate_id'=>$id,'is_ding'=>1,'is_sh'=>1])->limit(5)->select();
        return success($res);
    }

    public function GetTags(Request $request)
    {
        $param = $request->param();
        $id = $param['id'];
        $res = Db::name('tags')->where('id',$param['id'])->find();
        return success($res);
    }

    public function GetCategoryList(Request $request)
    {
        $param = $request->param();
        $hot = Db::name('category')
            ->where('is_sh',1)
            ->order('hot desc')->limit(5)->select()->each(function($item){
                $item['image'] = getImageUrlArr($item['image']);   
                return $item;
            });
        $all = Db::name('category')
            ->where('is_sh',1)
            ->order('id desc')->paginate(10)->each(function($item){
                $item['image'] = getImageUrlArr($item['image']);  
                $likeUser = Db::name('user')->field('avatar src')
                    ->whereTime('create_time','month')
                    ->where('id IN(SELECT user_id FROM xn_goods WHERE cate_id = '.$item['id'].')')
                    ->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' => count($likeUser)
                ];  
                return $item;
            });
        $res['hot'] = $hot;   
        $res['all'] = $all;
        return success($res);
    }

    //获取圈子帖子列表
    public function GetCategoryGoods(Request $request)
    {
         $param = $request->param();

        $res = Db::name('goods')->alias('a')
            ->join('user u','u.id = a.user_id')
            ->field('a.id,a.images mainImage,a.create_time date,a.tags_ids,u.avatar userAvatar,u.nickname userName,desc,content,view_num collectionCount,ping_num commentCount,like_num likeCount')
            ->order('id desc,date desc')
            ->paginate(20)
            ->each(function($item){
                $likeUser = Db::name('user')->field('avatar src')->where('id IN(SELECT user_id FROM xn_goods_like WHERE goods_id = '.$item['id'].')')->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>0
                ]; 
                $item['mainImage'] = getImageUrlArr(explode(',',$item['mainImage']));
                $tags = Db::name('tags')->where('id','IN',$item['tags_ids'])->select();
                $label = [];
                foreach ($tags as $tag) {
                    if (isset($tag['title'])) {
                        array_push($label,$tag['title']);
                    }
                }
                $item['label'] = $label;
                unset($item['tags_ids']);
                return $item;
            });
        return success($res);      
      
    }

   

    
}
