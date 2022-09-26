<?php
// +----------------------------------------------------------------------
// | 小牛Admin
// +----------------------------------------------------------------------
// | Website: www.xnadmin.cn
// +----------------------------------------------------------------------
// | Author: dav <85168163@qq.com>
// +----------------------------------------------------------------------

namespace app\api\model;

use think\Model;
use app\api\model\Goods;

class Collect extends Model
{
    protected $autoWriteTimestamp = true;

    public function getCreateTimeAttr($value)
    {
        return date('Y-m-d H:i:s',$value);
    }

    static function getList($param)
    {
    	return self::
    		with(['goods'=>function($query){
	            $query->field('id,title');
	        }])->where('user_id',$param['user_id'])->select();
    }

    public function goods()
    {
        return $this->belongsTo('Goods', 'goods_id');
    }
}