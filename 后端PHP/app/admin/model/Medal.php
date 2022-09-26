<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\admin\model;

use think\Model;

class Medal extends Model
{
    protected $autoWriteTimestamp = true;

    public function getImageAttr($val)
    {
        return getImageUrlArr($val);
    }
}