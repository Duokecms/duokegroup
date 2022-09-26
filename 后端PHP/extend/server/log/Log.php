<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/19 - 4:51 下午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------

namespace server\log;

use server\Single;
use think\facade\Config;

class Log
{
    use Single;


    /**
     * @param $data
     * @param string $type
     * @param string $file_name
     * @param false $cut_by_dt
     * @param bool $show_timestamp
     * @param string $sep
     * @return false|int
     */
    public function info(array $data, string $type = '', string $file_name = '', bool $cut_by_dt = false, bool $show_timestamp = true, string $sep = "\t"): bool
    {

        $now = time();
        $date = date('Y-m-d H:i:s', $now);
        $result = [$date];
        if ($show_timestamp) $result[] = $now;

        if (!empty($type)) $result[] = $type;

        foreach ( $data as $item ) {
            if (is_array($item) || is_object($item)) $item = json_encode($item);
            $result[] = str_replace("\t", '', $item);
        }
        $txt = implode($sep, $result) . PHP_EOL;
        $file_output = !empty($cut_by_dt) ? ($file_name . '_' . date('Y-m-d') . '.log') : ($file_name . '.log');

        $path = Config::get('log.path');

        if (!is_dir($path)) mkdir($path, 0755, true);

        return file_put_contents($path . $file_output, $txt, FILE_APPEND);
    }

    /**
     * @param string $msg
     * @param string $file_name
     * @param bool $cut_by_dt
     */
    public function error(string $msg, string $file_name = '', bool $cut_by_dt = false)
    {
        $debugInfo = debug_backtrace();
        $stack = "[";
        foreach ($debugInfo as $key => $val) {
            if (array_key_exists("file", $val)) {
                $stack .= ",file:" . $val["file"];
            }
            if (array_key_exists("line", $val)) {
                $stack .= ",line:" . $val["line"];
            }
            if (array_key_exists("function", $val)) {
                $stack .= ",function:" . $val["function"];
            }
        }
        $stack .= "]";
        $this->info([$stack . $msg], 8, $file_name, $cut_by_dt);
    }
}