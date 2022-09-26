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

class Goods extends Base
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

   
    
}
