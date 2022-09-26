<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/10 - 9:26 上午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------
namespace app\api\controller\middleware;

use server\jwt\Jwt;
use think\facade\Config;
use think\facade\Request;
use think\facade\Db;

class Check
{

    public function handle($request, \Closure $next)
    {

        if (true === $request->needLogin) {
            $this->payload($request);
        }
        // if( true === $request->isCheckRequestType){
        //     $this->checkRequestType();
        // }
        return $next($request);
    }

    /**
     * 检测请求方式是否是post,非post直接拦截
     */
    public function checkRequestType()
    {
        if(!Request::isPost()){
            header("content-Type: application/json; charset=utf-8");
            die(json_encode(['msg' => 'request is not post', 'code' => 0], JSON_UNESCAPED_UNICODE));
        }
    }

    /**
     * @param $request
     * 校验
     */
    public function payload($request)
    {
        $jwt = $request->header('token');

        if (empty($jwt)) {
            $jwt = $request->param('token');
            if(empty($jwt)){
                header("content-Type: application/json; charset=utf-8");
                die(json_encode(['msg' => 'token error', 'code' => 408], JSON_UNESCAPED_UNICODE));
            }
        }
        $jwtDecode = Jwt::decode($jwt, Config::get('jwt.key'), ['HS256']);
        $request->userid = $jwtDecode->uid;
        $request->loginInfo = $request->userInfo = Db::name('user')->where('id',$jwtDecode->uid)->find();
        if (empty($request->userInfo)) {
            header("content-Type: application/json; charset=utf-8");
            die(json_encode(['msg' => '请重新登陆', 'code' => 408], JSON_UNESCAPED_UNICODE));
        }
        
    }
}