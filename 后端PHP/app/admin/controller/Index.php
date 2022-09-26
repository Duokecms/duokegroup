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
use app\common\model\AuthRule;
use think\facade\Session;
use think\facade\Db;

class Index extends AdminBase
{
    protected $noAuth = ['index','home'];
    public function index()
    {
        // 分配菜单数据
        $auth = new AuthRule();
        $menu_data = $auth->getMenu();
        //dump($menu_data);exit;
        foreach ($menu_data as $k => $v) {
            if ( $this->checkMenuAuth($v['name']) ) {
                foreach ($v['_data'] as $m => $n) {
                    if( $this->checkMenuAuth($n['name'])!==true ){
                        unset($menu_data[$k]['_data'][$m]);
                    }
                }
            }else{
                // 删除无权限的菜单
                // unset($menu_data[$k]);
            }
        }

        return view('',['menu'=>$menu_data,'admin_data'=>Session::get('admin_auth')]);
    }

    public function home()
    {
        $total = [
            'one'       => date('Y-m-d H:i:s'),
            'two'       => Db::name('category')->count(),
            'three'     => Db::name('user')->count(),
            'four'      => Db::name('goods')->count(),
            'five'      => Db::name('active')->count(),
            'orderAll'  => Db::name('user')->count()
        ];
        $weeks = [];
        $week = date('w') == 0 ? 7 : date('w');
        for ($i=1; $i <= 7; $i++) { 
            if ($i == 7) {
                $time = strtotime('today +' . (8 - $week) . 'day -1second');
                $count = Db::name('goods')->whereTime('create_time','today +' . (8 - $week) . 'day -1second')->count();
                array_push($weeks,$count);
            }else{
                $time = strtotime('today -' . ($week - $i) . 'day');
                $count = Db::name('goods')->whereTime('create_time','today -' . ($week - $i) . 'day')->count();
                array_push($weeks,$count);
            }
        }
        $weeks = implode(',',$weeks);
        return view('',[
            'total' => $total,
            'weeks' => $weeks
        ]);
    }

    public function about()
    {
        return view();
    }
}
