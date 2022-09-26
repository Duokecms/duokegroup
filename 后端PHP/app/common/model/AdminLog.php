<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\common\model;

use think\Model;

class AdminLog extends Model
{
    protected $autoWriteTimestamp = true;

    public function admin()
    {
        return $this->belongsTo(Admin::class,'admin_id');
    }
}