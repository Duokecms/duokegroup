<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\common\model;

use think\facade\Db;
use think\Model;
use utils\Data;

class AuthRule extends Model
{
    public function getMenu()
    {
        $list = $this->where(['status'=>1,'is_menu'=>1])->order('sort asc, id asc')->select()->toArray();
        $data = Data::channelLevel($list,0,'&nbsp;','id');
        return $data;
    }

    /**
     * 获取面包屑当前位置数据
     * @param $bcid
     * @return array
     */
    public function getBreadcrumb($bcid)
    {
         $ids = explode('_', $bcid);
         $list = Db::name('auth_rule')->where('id','in',$ids)->column('id,name,title','id');
         foreach ($list as &$_list) {
             $_list['url'] = !empty($_list['name']) ? url($_list['name']) : 'javascript:void(0)';
         }
         $data = [];
         foreach ($ids as $key=>$id) {
             $data[$id] = $list[$id];
         }
         return $data;
    }
}