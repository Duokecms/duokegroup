<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\admin\controller;

use app\common\controller\Base;
use app\common\model\Admin;
use think\captcha\facade\Captcha;
use think\exception\ValidateException;
use think\facade\Session;

class Login extends Base
{
    public function index()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            try {
                $this->validate($param,'login');
            } catch (ValidateException $e) {
                $this->error($e->getError());
            }

            //是否开启验证码
            if( xn_cfg('base.login_vercode') == 1 ) {
                if( !captcha_check($param['vercode']) ) {
                    $this->error('验证码错误');
                }
            }

            $admin_data = Admin::where([
                'username' => $param['username'],
                'password' => xn_encrypt($param['password']),
            ])->field('id,username,status,last_login_ip,last_login_time')->find();

            if( empty($admin_data) ) {
                $this->error('用户名或密码不正确');
            }
            if($admin_data['status']!=1) {
                $this->error('您的账户已被禁用');
            }

            Session::set('admin_auth', $admin_data);
            xn_add_admin_log('后台登录');
            $this->success('登录成功', url('admin/index'));
        }
        return view('index1');
    }

    public function logout()
    {
        Session::set('admin_auth',null);
        $this->redirect(url('index'));
    }

    /**
     * 生成验证码
     * @return \think\Response
     */
    public function verify()
    {
        return Captcha::create();
    }
}
