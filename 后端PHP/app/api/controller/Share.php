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

class Share extends Base
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
    }

    public function myFx(Request $request)
    {
        $param = $request->param();
        if ($request->loginInfo['daren_id'] > 0) {
            $daren = Db::name('user')->where('id',$request->loginInfo['daren_id'])->find();
            $daren = $daren['nickname'];
        }else{
            $daren = '';
        }
        $res = [
            'fans_num'  => 0,
            'money'     => $request->loginInfo['money'],
            'nickname'  => $daren,
            'order_num' => 0,
            'is_daren'  => $request->loginInfo['is_daren'],
            'user_id'   => $request->loginInfo['id']
        ];
        return success($res);
    }





    public function myTgsy(Request $request)
    {
          $param = $request->param();

        $uid = $request->loginInfo['id'];
        $orderList = Db::name('order')
            ->where('daren_id',$uid)
            ->where('daren_money','>',0)


            ->field('id,order_no as ord_bh,pay_price,create_time as add_time,state,second,pay_status,daren_money,user_id')
            ->where(function (Query $query) use($param) {
                if (isset($param['type']) && $param['type'] == 'ing') {
                    //待支付
                    $query->where('pay_status',1);
                    $query->where('peisong','<>','W');
                }
                if (isset($param['type']) && $param['type'] == 'success') {
                    //进行中
                    $query->where('state','in','3,4');

                    $query->where('pay_status',1);
                }
                if (isset($param['type']) && $param['type'] == 'fail') {
                    //待评价
                    $query->where('state',6);
                    $query->where('tuikuan',2);
                    
                    $query->where('pay_status',1);
               
                }
            })   
            ->order('id desc')
            ->paginate(['list_rows' => 10, 'query' => $param])
            ->each(function($item){
                $goodsList = json_decode($item['second'],true);
                $item['original_img'] = [];
                foreach ($goodsList as $goods) {
                    $img = getImageUrlArr(explode(',', $goods['goodsImg']))[0];
                    array_push($item['original_img'],$img);
                }
                $daren = Db::name('user')->where('id',$item['user_id'])->find();

                if ($daren){
                    $darenname=$daren['nickname'];
                }else
                {
                    $darenname='会员不存在';

                }

                // var_dump($goodsList[0]);
                $item['post_type'] = 0;
                $item['goodsList'] =  json_decode($item['second'],true);

                $item['nickname'] = $darenname;

                $item['prom_type'] = "common";
                $item['add_time']  = date('Y-m-d H:i:s',$item['add_time']);
                $item['tui_bh']    = '';
                $item['buy_num']    =count($goodsList);          
                $type = ['空','待支付','待接单','配送中','已完成','已评价','已退款','退款中'];



                $item['oStatus'] = $item['state'];


                if ($item['state'] == '2') {
                    $item['oStatus'] = 33;
                }
                $item['pre_sale_type'] = 0;
                $item['goods_id'] = $goodsList[0]['goodsId'];
                $item['spec_id'] = 0;
                $item['payoff_time_start'] = 0;
                $item['payoff_time_end'] = 0;
                $item['status'] = $type[$item['state']];
                unset($item['second']);
                // var_dump($item);exit;
                return $item;
            });
        $orderList = $orderList->toArray()['data'];
        $orderList = !$orderList ? [] : $orderList;
        return success($orderList);
    }






    public function shenqing(Request $request)
    {
        $param = $request->param();
        Db::name('user')->where('id',$request->loginInfo['id'])->update(['is_daren'=>2]);
        return success('申请成功,等待审核!');
    }

    public function invite_info(Request $request)
    {
        $param = $request->param();
        $res = [
            "sum" =>0,
            "paiming" =>null,
            "money" =>0,
            "invite_rule" =>"<p>可以通过分享首页 商品页 商品图片(带二维码) 给新用户(必须是新用户) 登录成功后可以绑定分销关系</p>拉新需要新用户最低消费10元<br/>拉新成功奖励现金20元"
        ];
        return success($res);
    }


    public function invite_user_list(Request $request)
    {
        $param = $request->param();
        $res = [];
        return success($res);
    }
    public function invite_paiming_list(Request $request)
    {
        $param = $request->param();
        $res = [ [
            "add_time" =>"2021-05-10 11:03:12",
            "headimgurl" =>"https://thirdwx.qlogo.cn/mmopen/vi_32/cu1JaBmRuiaicsOfHRLWzx6FO4Fn6GpJokkbTqeonvpOSzOT8LYCUdYiaibugibd5XCq9WzBR08g23Uice8diauSXicn7w/132",
            "nickname" =>"北京世间万象科技-吴先生",
            "rownum" =>2
        ] ];
        return success($res);
    }
    
    public function invite_money_list(Request $request)
    {
        $param = $request->param();
        $res = [ [
            "add_time" =>"2021-05-10 11:03:12",
            "headimgurl" =>"https://thirdwx.qlogo.cn/mmopen/vi_32/cu1JaBmRuiaicsOfHRLWzx6FO4Fn6GpJokkbTqeonvpOSzOT8LYCUdYiaibugibd5XCq9WzBR08g23Uice8diauSXicn7w/132",
            "nickname" =>"北京世间万象科技-吴先生",
            "rownum" =>2
        ] ];
        return success($res);
    }

    public function myFans(Request $request)
    {
        $param = $request->param();
        $uid = $request->loginInfo['id'];
        $res = Db::name('user')
            ->field('id,nickname,avatar,create_time')
            ->where('daren_id',$uid)
            ->paginate(['list_rows' => 10, 'query' => $param])
            ->each(function($item){
                $item['headimgurl'] = getImageUrl($item['avatar']);
                $item['add_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });
        $res = $res->toArray()['data'];
        return success($res);
    }
    
        
    public function xcxImg_goods(Request $request)
    {
        $header = $request->header();
        $param  = $request->param();       
            $site = xn_cfg('base');
        $userInfo = $request->loginInfo;
   

        $appid = $site['xcx_appid'];
        $appsecret = $site['xcx_secret'];
        
        $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $appid . "&secret=" . $appsecret;
        $weixin = file_get_contents($url);
        $jsondecode = json_decode($weixin); //对JSON格式的字符串进行编码
        $array = get_object_vars($jsondecode);//转换成数组
        $access_token = $array['access_token'];//输出token
            
        $ewmurl = "https://api.weixin.qq.com/wxa/getwxacode?access_token=" . $access_token;
        $sharepath = $param['path'].'?id='.$userInfo['id'].'&goods_id='.$param['id'];

        $data = array(
            "path" => $sharepath,
            "width" => '80',
            
        );
        $datas = json_encode($data);
        $result = _Postrequest($ewmurl, $datas);
        
        $root = app()->getRootPath().'public';
        $path = "/uploads/miniqrcode/goods/";
        $newpath = $root . $path;
        $sjc = $userInfo['id'].'_'.$param['id'];
        if (!file_exists($newpath)) {
            mkdir($newpath);
        }
        file_put_contents($newpath . "/" . $sjc . ".png", $result);
        $imgpath = $request->domain()."/uploads/miniqrcode/goods/" . $sjc . ".png";
        
        return success($imgpath);
    }
 //获取小程序二维码
    public function xcxImg(Request $request)
    {
        $header = $request->header();
        $param  = $request->param();       
        $site = xn_cfg('base');
        $userInfo = $request->loginInfo;
   

        $appid = $site['xcx_appid'];
        $appsecret = $site['xcx_secret'];
        
        $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $appid . "&secret=" . $appsecret;
        $weixin = file_get_contents($url);
        $jsondecode = json_decode($weixin); //对JSON格式的字符串进行编码
        $array = get_object_vars($jsondecode);//转换成数组
        $access_token = $array['access_token'];//输出token
            
        $ewmurl = "https://api.weixin.qq.com/wxa/getwxacode?access_token=" . $access_token;
        $sharepath = 'pages/index/index?shareFn=saoma&scene='.$userInfo['id'];

        $data = array(
            "path" => $sharepath,
            "width" => '80',
            
        );
        $datas = json_encode($data);
        $result = _Postrequest($ewmurl, $datas);
        
        $root = app()->getRootPath().'public';
        $path = "/uploads/miniqrcode/user/";
        $newpath = $root . $path;
        $sjc = $userInfo['id'];
        if (!file_exists($newpath)) {
            mkdir($newpath);
        }
        file_put_contents($newpath . "/" . $sjc . ".png", $result);
        $imgpath = $request->domain()."/uploads/miniqrcode/user/" . $sjc . ".png";
        
        return success($imgpath);
    }

    public function fx_tx_data(Request $request)
    {
        $param  = $request->param();
        $userInfo = $request->loginInfo;
         $site = xn_cfg('base');
        $uid = $userInfo['id'];
        $res = [
            "tx_small_money" => [
                "id" =>251,
                "name" =>"tx_small_money",
                "title" =>"最低提现金额",
                "tip" =>"提现分销佣金",
                "value" =>"".$site['tixian_jine'].""
            ],
            "tx_sxf" => [
                "id" =>252,
                "name" =>"tx_sxf",
                "title" =>"提现手续费",
                "tip" =>"为0表示没有手续费 (百分比)",
                "value" =>"".$site['tixian_shouxu'].""
            ],
            "tx_action" => [
                "id" =>253,
                "name" =>"tx_action",
                "title" =>"提现方式",
                "tip" =>"1-系统余额 2-微信零钱",
                "value" =>[
                    [
                        "name" =>"微信零钱",
                        "value" =>2
                    ]
                ]
            ],
            "tx_rule" => [
                "id" =>254,
                "name" =>"tx_rule",
                "title" =>"提现说明",
                "tip" =>"提现的规则",
                "value" =>"<p>1.提现到钱包可直接用于购物，体现到支付宝请认真核对信息</p><p>2.低于平台设置最低提现金额不能提现&nbsp;</p><p>3.提现会扣除指定百分比的手续费</p><p>4.同一用户每天最多可提现10次</p><p>5.提现到微信零钱金额不能低于0.3元</p>最低提现金额为".$site['tixian_jine']."元<br/>提现手续费为".$site['tixian_shouxu']."%<br/>最终解释权归商家所有"
            ],
            "money" => $userInfo['money'],
            "template" => [
                "id" =>10,
                "title" =>"佣金到账提醒",
                "setx_title" =>null,
                "use_time" =>"佣金到账时",
                "mini_status" =>1,
                "public_status" =>0,
                "mini_template_id" =>"2BQaWTjTn_ggdOyJYp7nnhZb0m2dpG7ir-a60GXFPB8",
                "public_template_id" =>null,
                "type" =>1
            ]
        ];
        return success($res);
    }


    public function tx_log(Request $request)
    {
        $param = $request->param();
        $uid = $request->loginInfo['id'];
        $res = Db::name('fenxiao_user_tixian')         
            ->where('user_id',$uid)
            ->paginate(['list_rows' => 10, 'query' => $param])
            ->each(function($item){
             
              if ($item['is_check']==1){
                $shangtai='已处理';
              }
              else
            {
                $shangtai='未处理';

            }

                $item['status'] =$shangtai ;
                $item['money'] = $item['money'];
                $item['sx_money'] = $item['money']-$item['pay_money'];
                $item['add_time'] =$item['create_time'];
                

             //   $item['add_time'] = date('Y-m-d H:i:s',$item['create_time']);
                return $item;
            });
        $res = $res->toArray()['data'];
        return success($res);
    }

    public function fx_tx(Request $request)
    {
        $param = $request->param();
        $uid = $request->loginInfo['id'];
        $isCheck = 0;
        $bank='';
        if ($param['tx_type'] == 1) {
            //余额
            changeMoney($uid, $param['daoZhangMoney'],'分销佣金提现');
            $isCheck = 1;
        
        }

 if ($param['tx_type'] ==3) {    
           $bank=$param['zhifubaoid']."/".$param['zhifubaoname'];
        }


        $insert = Db::name('fenxiao_user_tixian')->insert([
            'user_id'  => $uid,          
            'type'  => $param['tx_type'],
            'money'  => $param['tx_money'],
            'pay_money'  => $param['daoZhangMoney'],
            'is_check'  => $isCheck,

             'bank'  => $bank,
            'phone'  => $request->loginInfo['mobile'],
            'create_time' => date('Y-m-d H:i:s',time())
        ]);
        $b = Db::name("user")
            ->where('id', $uid)
            ->dec('money', $param['tx_money'])
            ->update();
        
        return success('提现成功','提现成功');
    }
}
