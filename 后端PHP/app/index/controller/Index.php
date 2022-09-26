<?php
namespace app\index\controller;

use app\common\controller\Base;

class Index extends Base
{
    public function index()
    {
        //$this->redirect('admin/login/index');
        $site = xn_cfg('base');
        return view('',['site'=>$site]);
    }

    public function chat()
    {
        $fromid = input("fromid");
        $toid =  input('toid');
        return view('',[
            'fromid' => $fromid,
            'toid'   => $toid
        ]);
    }


    public function lists()
    {
        return view('',[
            'fromid' => input('fromid'),
            'toid'   => $toid
        ]);
    }
}