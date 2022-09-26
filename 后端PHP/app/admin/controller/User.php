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
use app\admin\model\User as ThisModel;
use app\admin\model\Order;
use app\common\model\AuthGroup;
use app\common\model\AuthGroupAccess;
use think\facade\Db;

class User extends AdminBase
{
    public function index()
    {
        $param = $this->request->param();
        $model = new ThisModel();
        //构造搜索条件
        $model = $model->with(['parent']);
        if( $param['nickname']!='' ) {
            $model = $model->where('nickname','LIKE','%'.$param['nickname'].'%');
        }
        if( $param['mobile']!='' ) {
            $model = $model->where('mobile','LIKE','%'.$param['mobile'].'%');
        }
        if( $param['start_date']!=''&&$param['end_date']!='' ) {
            $model = $model->whereBetweenTime('create_time',$param['start_date'],$param['end_date']);
        }
        $list = $model->order('id desc')->paginate(['list_rows'=>10,'query' => $param]);
        return view('',['list'=>$list]);
    }

    

    //查看下级
    public function showSon()
    {

        $param = $this->request->param();
        $model = new ThisModel();
        $model = $model->where('id IN(SELECT user_id FROM xn_user_fans WHERE user_id = '.$param['id'].')');
        $list = $model->order('id ASC')->paginate(['list_rows'=>10,'query' => $param])->each(function ($item, $key) {
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
            $param['admin_id'] = $this->getAdminId();
            $insert_id = Db::name('user')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        return view('form');
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
            $result = ThisModel::update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $id = $this->request->get('id');
        $assign = [
            'info'=> ThisModel::find($id)
        ];
        return view('form', $assign);
    }

    public function addPing()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            // dump($param);exit;
            $insert_id = Db::name('user_ping')->strict(false)->insertGetId($param);
            if( $insert_id ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        return view();
    }

    /**
     * 删除节点
     */
    public function delete()
    {
        $id = intval($this->request->get('id'));
        !($id>1) && $this->error('参数错误');
        ThisModel::destroy($id);

        //删除用户后，删除帖子，评论 ，点赞，评论点赞，关注，被关注
        deleteUserAfter($id);
        $this->success('删除成功');
    }

    public function deletePing()
    {
        $id = intval($this->request->get('id'));
        !($id>1) && $this->error('参数错误');
        UserPing::destroy($id);
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
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $result = ThisModel::where('id',$id)->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $param = $this->request->param();
        $id = $param['id'];
        $user_data = ThisModel::find($id);

        return view('', [
            'user_data'  => $user_data
        ]);
    }

    public function change()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            if ($param['money'] != '') {
                $userId = $param['id'];
                $changeNum = $param['money'];
                $description = $param['money'] < 0 ? '后台扣除' : '后台充值';
                changeMoney($userId, $changeNum, $description);
            }
            if ($param['score'] != '') {
                $userId = $param['id'];
                $changeNum = $param['score'];
                $description = $param['score'] < 0 ? '后台扣除' : '后台充值';
                changeScore($userId, $changeNum, $description);
            }
            $this->success('处理成功');
        }
        $param = $this->request->param();
        $id = $param['id'];
        $user_data = ThisModel::find($id);

        return view('', [
            'user_data'  => $user_data
        ]);
    }

    public function vip()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $id = $param['id'];
            $user_data = ThisModel::find($id);
            if ($user_data['vip_time'] < time()) {
                $update = [
                    'vip'      => 1,
                    'vip_time' => time() + abs($param['dates']) * 3600 *24
                ];
            }else{
                $update = [
                    'vip'      => 1,
                    'vip_time' => $user_data['vip_time'] + abs($param['dates']) * 3600 *24
                ];
            }
            ThisModel::where('id',$id)->update($update);
            $this->success('处理成功');
        }
        $param = $this->request->param();
        $id = $param['id'];
        $user_data = ThisModel::find($id);

        return view('', [
            'user_data'  => $user_data
        ]);
    }

    public function infoPing()
    {
        if( $this->request->isPost() ) {
            $param = $this->request->param();
            $id = $param['id'];
            if (isset($param['file'])) {
                unset($param['file']);
            }
            $result = UserPing::where('id',$id)->update($param);
            if( $result ) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        }
        $param = $this->request->param();
        $id = $param['id'];
        $user_data = UserPing::find($id);

        return view('', [
            'user_data'  => $user_data
        ]);
    }

    public function pingQrcode()
    {
        $param = $this->request->param();
        $userPing = Db::name('user_ping')->where('id',$param['id'])->find();
        // $userInfo = Db::name('user')->where('utoken',$userPing['utoken'])->find();
        $info    = $this->getQrcode($userPing);
        // var_dump($userPing);exit;
        $newImage = createImg($info['info_path'],$info['info_haibao']);
        // var_dump($newImage);exit;
        return view('', [
            'image'  => $info['haibao_url']
        ]);
    }

    public function getQrcode($userInfo)
    {
        $webInfo  = Db::name('admin')->where('id', 1)->find();

        $appid     = $webInfo['xcx_appid'];
        $appsecret = $webInfo['xcx_secret'];

        $url          = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" . $appid . "&secret=" . $appsecret;
        $weixin       = file_get_contents($url);
        $jsondecode   = json_decode($weixin); //对JSON格式的字符串进行编码
        $array        = get_object_vars($jsondecode);//转换成数组
        $access_token = $array['access_token'];//输出token

        $ewmurl    = "https://api.weixin.qq.com/wxa/getwxacode?access_token=" . $access_token;
        $sharepath = 'pages/index/index?daren_id=' . $userInfo['id'];

        $data   = array(
            "path"  => $sharepath,
            "width" => '80',

        );
        $datas  = json_encode($data);
        $result = _Postrequest($ewmurl, $datas);

        $root    = app()->getRootPath() . 'public';
        $path    = "/uploads/miniqrcode/user/";
        $newpath = $root . $path;
        $sjc     = $userInfo['id'];
        if (!file_exists($newpath)) {
            mkdir($newpath);
        }
        file_put_contents($newpath . "/" . $sjc . ".jpg", $result);
        $imgpath = $this->request->domain() . "/uploads/miniqrcode/user/" . $sjc . ".jpg";
        $codeImage = "uploads/miniqrcode/user/" . $sjc . ".jpg";
        $infoHaibao = "uploads/miniqrcode/user/" . $sjc . "_haibao.jpg";
        $haibaoUrl = $this->request->domain() . "/uploads/miniqrcode/user/" . $sjc . "_haibao.jpg";
        
        return [
            'info'        => $imgpath,
            'info_path'   => $codeImage,
            'info_haibao' => $infoHaibao,
            'haibao_url'  => $haibaoUrl
        ];
    }
}
