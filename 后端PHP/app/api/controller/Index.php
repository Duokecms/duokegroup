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
use server\sms\Sms;
use think\db\Query;

class Index extends Base
{
    public function __construct(Request $request)
    {
        //如果有JWT则自动获取用户id
        $jwt = $request->header('token');
        if (!$jwt) {
            $jwt = $request->param('token');
        }
        if ($jwt) {
            $jwtDecode         = Jwt::decode($jwt, Config::get('jwt.key'), ['HS256']);
            $request->userInfo = Db::name('user')->where('id', $jwtDecode->uid)->find();
            if (!empty($request->userInfo)) {
                $request->loginInfo = $request->userInfo;
                $request->userId    = $jwtDecode->uid;

            }
        }
        
    }

    public function text()
    {
       $login_token = Jwt::encode([
                'uid' => 1
            ], Config::get('jwt.key'));
       echo $login_token;
    }

    public function nouser(Request $request)
    {
        $res = [];
        return success($res);
    }

    //获取随机颜色
    public function getRandColor()
    {
        $userInfo = Db::name('user')->where('id',1)->find();
        $res = addAfterLevel($userInfo,'goods');
        var_dump($res);exit;
        $res = ip2address('183.222.247.163');
        var_dump($res);
    }

    //所有会员
    public function allUserList(Request $request)
    {
        $param = $request->param();
        $user = \app\admin\model\User::order('fans_num desc')->paginate(10)->each(function($item){
            // $item['avatar'] = getImageUrlArr($item['avatar']);
            unset($item['open_id']);
            unset($item['password']);
            unset($item['ip']);
            unset($item['unionid']);
            return $item;
        });
        return success($user);
    }

    //所有活动is_sh
    public function allActiveList(Request $request)
    {
        $param = $request->param();
        $user = Db::name('active')->where('is_sh',1)->order('id desc')->paginate(10)->each(function($item){
            $item['images'] = getImageUrlArr(explode(',',$item['images']));
            $item['logo'] = isset($item['images'][0]) ? $item['images'][0] : '';

             $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_active_join WHERE active_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>$item['join_num'] 
                ]; 
                 
                $user = Db::name('user')->where('id',$item['user_id'])->find();
                $item['userAvatar'] = getImageUrlArr($user['avatar'],'avatar');
            return $item;
        });
        return success($user);
    }

   //活动详情
    public function Active_detail(Request $request)
    {
        $param = $request->param();
        $item = Db::name('active')->where('id',$param['id'])->find();
        Db::name('active')->where('id',$param['id'])->inc('view_num')->update();


            $item['images'] = getImageUrlArr(explode(',',$item['images']));
            $item['logo'] = isset($item['images'][0]) ? $item['images'][0] : '';

                $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_active_join WHERE active_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>$item['join_num'] 
                ]; 
              
                $user = Db::name('user')->where('id',$item['user_id'])->find();
                $item['userAvatar'] = getImageUrlArr($user['avatar'],'avatar');
                
            $item['is_follow'] = Db::name('active_join')->where(['user_id'=>$request->loginInfo['id'],'active_id' => $item['id']])->count() > 0;
    
        return success($item);
    }







    //广场
    public function guangChang(Request $request)
    {
        $param = $request->param();
        $user = \app\admin\model\User::order('fans_num desc')->limit(10)->select()->each(function($item){
            unset($item['open_id']);
            unset($item['password']);
            unset($item['ip']);
            unset($item['unionid']);
            return $item;
        });
        $tags = Db::name('tags')->order('goods_num desc')->limit(10)->select();
        $allUser = Db::name('user')->count();
        $category = Db::name('category')->count();
        $goods = Db::name('goods')->count();
        $goodsLike = Db::name('goods_like')->count();
        $goodsComment = Db::name('goods_comment')->count();
        $goodsView = Db::name('goods')->sum('view_num');
        return success([
            'user' => $user,
            'tags' => $tags,
            'count'=> [
                'allUser' => $allUser,
                'category' => $category,
                'goods' => $goods,
                'goodsLike' => $goodsLike,
                'goodsComment' => $goodsComment,
                'goodsView' => $goodsView,
            ]
        ]);
    }


    public function GetConfig(Request $request)
    {
        $site = xn_cfg('base'); 

        
        $sit_c='#FF7043';
        $wenzi_c='#FFFFFF';
        
        $sitekey=explode('@',$site['sitekey']);

         $res = '{
             "config":{            
            "web_site_text_color":"'.$wenzi_c.'",
            "web_site_color":"'.$sit_c.'",
            "web_site_bg_tow":"'.$sit_c.'",            
            "mobile":"'.$site['kefu_tel'].'",
            "goods_pay_history":"0", 
            "shoname":"'.$site['xcx_title'].'",
            "site_logo":"'.getImageUrlArr($site['site_logo']).'",            
            "sitekey":'.json_encode($sitekey).',
            "vege_text_color":"'.$wenzi_c.'",            
            "vege_color":"'.$sit_c.'",
            "user_background_color":"'.$sit_c.'",
            "corporation_tel":"'.$site['kefu_tel'].'",
             "path":"'.$site['siteurl'].'",
             "slogan":"'.$site['slogan'].'",
             
             "dodecorate":[
                {
                    "field":"dls",
                    "img":"\/uploads\/images\/dls.gif"
                },
                {
                    "field":"dzf",
                    "img":"\/uploads\/images\/20200916\/b5271d26117f8aa8f48cd74e2c949c94.png"
                },
                {
                    "field":"jxz",
                    "img":"\/uploads\/images\/20200916\/aee6f5b2162865f0549427631ded11fa.png"
                },
                {
                    "field":"dpj",
                    "img":"\/uploads\/images\/20200916\/e0af88b5c87e66336f62f5e51b7bb882.png"
                }]
                }
             }';
   
       return success(json_decode($res));
   }



    public function index(Request $request)
    {
        $param = $request->param();
        $res = [];
        //分类      

        $res['bloggerList'] = Db::name('category')->where(['fid'=>0,'is_tui'=>1,'is_sh'=>1])->order('id desc')->limit(6)->select()->each(function($item){
            $item['image'] = getImageUrlArr($item['image']);            
            return $item;
        })->toArray();
        $res['bloggerhotList'] = Db::name('category')->where(['fid'=>0,'is_sh'=>1])->order('hot desc,id desc')->limit(6)->select()->each(function($item){
            $item['image'] = getImageUrlArr($item['image']);            
            return $item;
        })->toArray();
         $res['swiperList'] = Db::name('adinfo')->where('type',$param['type'])->select()->each(function($item){
            $item['image'] = getImageUrlArr($item['image']);
               $item['type'] = 'image'; 
                         
            return $item;
         })->toArray();


         return success($res);
    }

    

    //圈子的粉丝列表
    public function quanFansList(Request $request)
    {
        $param = $request->param();
        $id    = $param['id'];
        $fans = \app\admin\model\User::where('id IN(SELECT user_id FROM xn_category_follow WHERE is_manage = 0 AND cate_id = '.$id.')')
            ->paginate(10)
            ->each(function($item){
                $item['avatar'] = getImageUrlArr($item['avatar'],'avatar');
                unset($item['open_id']);
                unset($item['password']);
                unset($item['ip']);
                unset($item['unionid']);
                return $item;
            });

        return success($fans);
    }

    //圈子的管理员列表
    public function quanManageList(Request $request)
    {
        $param = $request->param();
        $id    = $param['id'];
        $fans = \app\admin\model\User::where('id IN(SELECT user_id FROM xn_category_follow WHERE is_manage = 1 AND cate_id = '.$id.')')
            ->select()
            ->each(function($item){
                $item['avatar'] = getImageUrlArr($item['avatar'],'avatar');
                unset($item['open_id']);
                unset($item['password']);
                unset($item['ip']);
                unset($item['unionid']);
                return $item;
            });

        return success($fans);
    }

    public function page(Request $request)
    {
        $param = $request->param();
        $id = $param['id'];
        if ($param['type']=="pages"){
        $res = Db::name('pages')->where('id',$id)->find();
    }
        if ($param['type']=="msg"){
        $res = Db::name('message')->where('id',$id)->find();
        $res['detail']=$res['content'];
        }

        return success($res);


    }

    //获取帖子列表o
    
    
    public function getGoodslist(Request $request)
    {
        $param = $request->param();
        $userInfo = $request->loginInfo;
        $myId = $request->loginInfo['id'];

         //var_dump($userInfo);exit;      
        $where = [];
        $where2 = 'is_sh = 1';
        $order = 'id desc,date desc';
        if (isset($param['to_id']) && $param['to_id'] > 0) {
            $where = 'user_id = '.$param['to_id'];
        }

        if (isset($param['to_id']) &&$param['to_id']==0) {
            $where = 'user_id = '.$myId;
        }
        
        if (isset($param['cate_id']) && $param['cate_id'] > 0) {
            $where = 'cate_id = '.$param['cate_id'].' AND is_ding = 0';
            $order = 'is_ding desc,id desc';
        }
        if (isset($param['hot_type']) && $param['hot_type']==2) {
            $where = 'is_tuijian = 1';
        }
        if (isset($param['tags_id']) && $param['tags_id'] > 0) {
            $where = "tags_ids LIKE '%,".$param['tags_id'].",%'";
        }

        if (isset($param['hot_type']) && $param['hot_type']==1) {
            $myId = $request->loginInfo['id'];
            $where = 'a.user_id IN(SELECT user_id FROM xn_user_fans WHERE fans_id = '.$myId.')';
        }

        if (isset($param['my_add']) && $param['my_add'] > 0) {
            $myId = $request->loginInfo['id'];
            $where2 = [];
            $where = 'user_id = '.$myId;
        }

         if (isset($param['key'])) {          
           $where = "content LIKE '%".$param['key']."%'";
        }


        // var_dump($where);
        $res = Db::name('goods')->alias('a')
            ->join('user u','u.id = a.user_id')
            ->field('a.id,a.user_id,a.images mainImage,a.create_time date,a.tags_ids,a.cate_id,u.avatar userAvatar,u.nickname userName,content,view_num collectionCount,ping_num commentCount,like_num likeCount,a.is_sh,a.is_ding,a.is_tuijian,u.lv')
            ->where($where)
            ->where($where2)
            ->order($order)
            ->paginate(10)
            ->each(function($item)use($userInfo){
                $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_goods_like WHERE goods_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>0
                ]; 
                $item['userAvatar'] = getImageUrlArr($item['userAvatar'],'avatar');
                $item['medal_list'] = \app\admin\model\Medal::field('image')->where('id IN(SELECT medal_id FROM xn_medal_list WHERE user_id = '.$item['user_id'].')')->select();
                $item['mainImage'] = getImageUrlArr(explode(',',$item['mainImage']));
                $tags = Db::name('tags')->where('id','IN',$item['tags_ids'])->select();
                $label = [];              
                if ($userInfo['id']==$item['user_id']){
                $item['ziji'] =1;
                }else{
                $item['ziji'] =0;
                 }
          
                $managecate = Db::name('category_follow')->where(['user_id'=>$userInfo['id'],'cate_id'=>$item['cate_id'],'is_manage' =>1])->find(); 




                if ($managecate){
                $item['manage'] =1;
                }else{
                $item['manage'] =0;
                 }


                $item['label'] = $tags;
                unset($item['tags_ids']);
                $item['date'] = date('Y-m-d H:i:s',$item['date']);
                return $item;
            });
        return success($res);
    }

    //帖子详情
    public function goodsdetail(Request $request)
    {
        $param = $request->param();

        $res = Db::name('goods')->alias('a')
            ->join('user u','u.id = a.user_id')
            ->where('a.id',$param['id'])            
            ->field('a.id,a.user_id,a.images mainImage,a.create_time date,a.tags_ids,u.avatar userAvatar,u.nickname userName,content,view_num collectionCount,ping_num commentCount,like_num likeCount,u.lv')
            ->order('id desc,date desc')
            ->paginate(10)
            ->each(function($item) use($request){
                $likeUser = \app\admin\model\User::field('avatar src')->where('id IN(SELECT user_id FROM xn_goods_like WHERE goods_id = '.$item['id'].')')->limit(5)->select();
                $item['viewUser'] = [
                    'latestUserAvatar' => $likeUser,
                    'viewUserCount' =>0
                ]; 
                $item['userAvatar'] = getImageUrlArr($item['userAvatar'],'avatar');
                $item['mainImage'] = getImageUrlArr(explode(',',$item['mainImage']));
                $item['medal_list'] = \app\admin\model\Medal::field('image')->where('id IN(SELECT medal_id FROM xn_medal_list WHERE user_id = '.$item['user_id'].')')->select();
                $tags = Db::name('tags')->field('id,title')->where('id','IN',$item['tags_ids'])->select();
                $item['label']     = $tags;
                $item['is_like']   = Db::name('goods_like')->where(['user_id'=>$request->loginInfo['id'],'goods_id' => $item['id']])->count() > 0;
                $item['is_follow'] = Db::name('user_fans')->where(['fans_id'=>$request->loginInfo['id'],'user_id' => $item['user_id']])->count() > 0;
                unset($item['tags_ids']);
                $item['date'] = date('Y-m-d H:i:s',$item['date']);
                return $item;
            });
       


        Db::name('goods')->where('id',$param['id'])->inc('view_num')->update();
        return success($res);
    }

    //评论列表
    public function goodsCommentList(Request $request)
    {
        $param = $request->param();
        $id = $param['id'];
        $userInfo = $request->loginInfo;

        $list = Db::name('goods_comment')->alias('a')
            ->join('user u','a.user_id = u.id')
            ->field('a.id,a.is_ding,a.content,a.to_name,a.like_num,a.user_id,a.fa_user_id,u.nickname,u.avatar,a.create_time')
            ->where('goods_id',$id)
            ->where('pid',0)
            ->order('a.is_ding desc,a.create_time desc,a.id desc')
            ->paginate(10)
            ->each(function($item)use($request,$userInfo){
                $item['ziji_id']=$userInfo['id'];                
                $item['avatar'] =getImageUrlArr($item['avatar'],'avatar');
                $item['is_like']   = Db::name('goods_comment_like')->where(['user_id'=>$request->loginInfo['id'],'comment_id' => $item['id']])->count() > 0;
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);                  
                $item['child'] = Db::name('goods_comment')->alias('a')
                    ->join('user u','a.user_id = u.id')
                    ->field('a.id,a.content,a.to_name,a.like_num,a.user_id,a.fa_user_id,u.nickname,u.avatar,a.create_time')
                    ->where('pid',$item['id'])->order('create_time Asc')->select()->each(function($item2)use($request,$userInfo){
                        $item2['ziji_id']=$userInfo['id']; 
                        $item2['avatar'] = getImageUrl($item2['avatar'],'avatar');
                        $item2['is_like']   = Db::name('goods_comment_like')->where(['user_id'=>$request->loginInfo['id'],'comment_id' => $item2['id']])->count() > 0;
                        $item2['create_time'] = date('Y-m-d H:i:s',$item2['create_time']);
                        return $item2;
                    });
                return $item;
            });

        return success($list);
    }

    public function urlname(Request $request)
    {
        $header = $request->header();
        $param  = $request->param();       
            $site = xn_cfg('base');     

        $appid = $site['xcx_appid'];
        $appsecret = $site['xcx_secret'];
        
        $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $appid . "&secret=" . $appsecret;
        $weixin = file_get_contents($url);
        $jsondecode = json_decode($weixin); //对JSON格式的字符串进行编码
        $array = get_object_vars($jsondecode);//转换成数组
        $access_token = $array['access_token'];//输出token
            
        $ewmurl = "https://api.weixin.qq.com/wxa/generate_urllink?access_token=" . $access_token;
       $data = [
      'path'=>'/pages/index/index'      
        ];
        $datas = json_encode($data);
        $result = _Postrequest($ewmurl, $datas);
        $data=json_decode($result);
      return success($data); 
        
    }


     //获取博主基本信息
    public function GetUser(Request $request)
    {
        $site = xn_cfg('base');  
        $param = $request->param();
         if (isset($param['user_id'])&&$param['user_id']!==0) {
 
         $id    = $param['user_id'];
         }
         else{


           $id = $request->loginInfo['id'];
         }

       



        $userInfo   = \app\admin\model\User::where(['id' => $id])->find();    
        
 


        $headimg = $userInfo['avatar'] ? $userInfo['avatar'] : '/uploads/head.jpg';

        if (!$userInfo){
            $res = [
                "userinfo" => [
                    "avatar" => getImageUrl($headimg),
                    "nickname" =>'请登陆',             
                    "city" => '', 
                    "dec" =>$userInfo['dec'],  
                    "is_see_follow" =>0, 
                    "is_see_fans" =>0,
                    "dec" =>$userInfo['dec'],
                    "fansi" => 0,
                    "guanzhu" =>0,
                    "zhan" =>0,
                    "sex" => 0,
                    "is_follow" => 0,
                    "bg_img" => getImageUrl($userInfo['bg_img']?$userInfo['bg_img']:$site['fenxiao_image'])                
                ]            
            ];

        }else{

            $medal_list = \app\admin\model\Medal::where('id IN(SELECT medal_id FROM xn_medal_list WHERE user_id = '.$id.')')->select()->each(function($item){
                $item['type'] = getMedalType()[$item['type']];
                return $item;
            });

            $res = [
                "userinfo" => [
                    "medal_list"=>$medal_list,
                    "avatar" => getImageUrl($userInfo['avatar'],'avatar'),
                    "nickname" => $userInfo['nickname'],             
                    "city" => $userInfo['city'], 
                    "lv" => $userInfo['lv'],                     
                    "dec" =>$userInfo['dec'],  
                    "is_see_follow" =>$userInfo['is_see_follow'], 
                    "is_see_fans" =>$userInfo['is_see_fans'],
                    "dec" =>$userInfo['dec'],
                    "fansi" => $userInfo['fans_num'],
                    "guanzhu" => Db::name('user_fans')->where(['fans_id'=>$id])->count(),
                    "zhan" => Db::name('goods_like')->where(['fa_user_id'=>$id])->count(),
                    "sex" => $userInfo['sex'],
                    "is_follow" => Db::name('user_fans')->where(['fans_id'=>$request->loginInfo['id'],'user_id' => $id])->count() > 0,
                    "bg_img" => getImageUrl($userInfo['bg_img']?$userInfo['bg_img']:$site['fenxiao_image'])                
                ]            
            ];
        }
        return success($res);
    }



 //用户关注了谁列表 不传user_id 读取自己的关注列表
    public function followList(Request $request)
    {
        $param = $request->param();
        if (isset($param['user_id']) && $param['user_id'] > 0) {
            $id = $param['user_id'];
        }else{
            $id = $request->loginInfo['id'];
        }
        $fans = \app\admin\model\User::where('id IN(SELECT user_id FROM xn_user_fans WHERE fans_id = '.$id.')')
            ->paginate(10)
            ->each(function($item){
                $item['color'] = getRandColor();                
                return $item;
            });

        return success($fans);
    }

    //用户粉丝列表 不传user_id 读取自己粉丝
    public function fansList(Request $request)
    {
        $param = $request->param();
        if (isset($param['user_id']) && $param['user_id'] > 0) {
            $id = $param['user_id'];
        }else{
            $id = $request->loginInfo['id'];
        }
        $fans = \app\admin\model\User::where('id IN(SELECT fans_id FROM xn_user_fans WHERE user_id = '.$id.')')
            ->paginate(10)
            ->each(function($item){
                $item['color'] = getRandColor();
                return $item;
        });

        return success($fans);
    }





}
