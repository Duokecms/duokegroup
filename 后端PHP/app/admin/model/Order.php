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

class Order extends Model
{
    protected $autoWriteTimestamp = true;

    public function getCreateTimeAttr($value)
    {
        return date('Y-m-d H:i:s',$value);
    }
    public function getKuaidiTimeAttr($value)
    {
        if ($value) {
            return date('Y-m-d',$value);
        }else{
            return '';
        }
        
    }
    
    public function partner()
    {
        return $this->belongsTo('Partner', 'partner_id');
    }

    public function daren()
    {
        return $this->belongsTo('User', 'daren_id');
    }

    public function user()
    {
        return $this->belongsTo('User', 'user_id');
    }

    public function goods()
    {
        return $this->belongsTo('Goods', 'goods_id');
    }
}