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

class Config extends AdminBase
{
    //配置文件目录
    protected $folder = 'cfg';

    /**
     * 基本配置
     * @return \think\response\View
     */
    public function base()
    {
        $file = $this->request->action();
        if( $this->request->isPost() ) {
            $param = $this->request->post();
            $this->_set($param, $file);
            $this->success('设置成功');
        }
        return view($file,['data'=>$this->_load($file)]);
    }

    /**
     * 上传配置
     * @return \think\response\View
     */
    public function upload()
    {
        $file = $this->request->action();
        if( $this->request->isPost() ) {
            $param = $this->request->post();
            $this->_set($param, $file);
            $this->success('设置成功');
        }
        return view($file,['data'=>$this->_load($file)]);
    }

    /**
     * 写入配置文件
     * @param $param
     * @param string $filename
     */
    protected function _set($param, $filename="base")
    {
        if( is_array($param) && !empty($param) ) {
            $file = config_path() . $this->folder. "/" . $filename . '.php';
            $str = "<?php\r\nreturn [\r\n";
            foreach ($param as $key=>$val) {
                $str .= "\t'$key' => '$val',";
                $str .= "\r\n";
            }
            $str .= '];';
            file_put_contents($file, $str);
        }
    }

    /**
     * 加载配置文件
     * @param $filename
     * @return array
     */
    protected function _load($filename)
    {
        $data = \think\facade\Config::load($this->folder. "/" . $filename, $filename);
        return $data;
    }
}
