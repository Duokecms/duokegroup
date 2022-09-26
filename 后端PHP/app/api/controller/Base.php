<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/9 - 3:39 下午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------
namespace app\api\controller;

use think\facade\Db;

class Base
{
    public $needLogin = true;

    protected $middleware = ['\\app\\api\\controller\\middleware\\Check'];

    public $siteConfig = [];
    public $webid = 1;
    public $webinfo = [];
    public $userid = 0;
    protected $request;
    public $isCheckRequestType = true; //检测请求方式

    public function __construct(\think\Request $request)
    {
        
        $this->request = $request;
        $webid = $request->header('webid');
        if($webid){
            $this->webid = $webid;
            $this->webinfo = Db::name('admin')->where('id',$webid)->find();
        }else{
            $this->webinfo = Db::name('admin')->where('id',$this->webid)->find();
        }
        $request->needLogin = $this->needLogin;
        $request->isCheckRequestType = $this->isCheckRequestType;
    }
}