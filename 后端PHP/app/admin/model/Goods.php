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

class Goods extends Model
{
    protected $autoWriteTimestamp = true;

    public function getCreateTimeAttr($value)
    {
        return date('Y-m-d H:i:s',$value);
    }

    public function getBeginTimeAttr($value)
    {
        if($value > 0) return date('Y-m-d H:i:s',$value);
        return '';
    }
    public function setBeginTimeAttr($value)
    {
        return strtotime($value);
    }
    public function setEndTimeAttr($value)
    {
        return strtotime($value);
    }
    public function getEndTimeAttr($value)
    {
        if($value > 0) return date('Y-m-d H:i:s',$value);
        return '';
    }

    public function partner()
    {
        return $this->belongsTo('Partner', 'partner_id');
    }
    public function user()
    {
        return $this->belongsTo('User', 'user_id');
    }
    public function cate()
    {
        return $this->belongsTo('Category', 'cate_id');
    }
}