<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/12 - 11:03 上午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------

namespace server\curl;

use server\Single;

class Curl
{
    use Single;

    protected $curl_handler = null; //curl句柄

    protected $config = [
        'agent' => 'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:45.0) Gecko/20100101 Firefox/45.0 FirePHP/0.7.4)',//http浏览器信息
        'timeout' => 5,  //超时间
        'referer' => '',//
        'follow_redirect' => 1, //是否跟踪301跳转
    ];

    protected $curl_info = [];

    protected $start_time = 0;

    public function __construct()
    {
        $this->curl_handler = curl_init();
        curl_setopt($this->curl_handler, CURLOPT_TIMEOUT, $this->config['timeout']);
        curl_setopt($this->curl_handler, CURLOPT_USERAGENT, $this->config['agent']);
        curl_setopt($this->curl_handler, CURLOPT_REFERER, $this->config['referer']);
        curl_setopt($this->curl_handler, CURLOPT_FOLLOWLOCATION, $this->config['follow_redirect']);
        curl_setopt($this->curl_handler, CURLOPT_RETURNTRANSFER, 1);//返回结果
    }

    public function __destruct()
    {
        curl_close($this->curl_handler);
    }

    /**
     * @param $url
     * @param array $params
     * @param array $option
     * @return mixed|string
     * @throws \Exception
     * get
     */
    public function get($url, $params = [], $option = [])
    {
        if (empty($url)) return '';
        if (substr($url, 0, strlen('http')) != 'http') $url = 'http:' . $url;
        $this->start_time = $this->microtime_float();
        if (is_array($params) && !empty($params)) $url = $url . "?" . http_build_query($params);
        curl_setopt($this->curl_handler, CURLOPT_URL, $url);

        if (!empty($option) && is_array($option)) foreach ($option as $key => $value) {
            curl_setopt($this->curl_handler, $key, $value);
        }
        try {
            $result = curl_exec($this->curl_handler);
        } catch (\Exception $e) {
            throw new \Exception($url);
        }

        $this->curl_info['status_code'] = curl_getinfo($this->curl_handler, CURLINFO_HTTP_CODE);
        $this->curl_info['time_exe'] = $this->microtime_float() - $this->start_time;

        return $result;
    }

    /**
     * @param $url
     * @param array $params
     * @param array $option
     * @return mixed|string
     * post
     */
    public function post($url, $params = [], $option = [])
    {
        if (empty($url)) return '';
        $this->start_time = $this->microtime_float();
        curl_setopt($this->curl_handler, CURLOPT_URL, $url);
        curl_setopt($this->curl_handler, CURLOPT_POST, 1);
        if (is_array($params) && !empty($params)) $params = http_build_query($params);
        curl_setopt($this->curl_handler, CURLOPT_POSTFIELDS, !empty($params) ? $params : []);
        if (!empty($option) && is_array($option)) foreach ($option as $key => $value) {
            curl_setopt($this->curl_handler, $key, $value);
        }
        $result = curl_exec($this->curl_handler);
        $this->curl_info['status_code'] = curl_getinfo($this->curl_handler, CURLINFO_HTTP_CODE);
        $this->curl_info['time_exe'] = $this->microtime_float() - $this->start_time;
        return $result;
    }

    /**
     * @param $url
     * @param array $params
     * @param array $option
     * @return mixed|string
     * post application/json
     */
    public function post_json($url, $params = [], $option = [])
    {
        if (empty($url)) return '';
        $this->start_time = $this->microtime_float();
        curl_setopt($this->curl_handler, CURLOPT_URL, $url);
        curl_setopt($this->curl_handler, CURLOPT_POST, 1);
        curl_setopt($this->curl_handler, CURLOPT_HTTPHEADER, ['Content-type: application/json;charset=UTF-8']);
        if (!empty($option) && is_array($option)) foreach ($option as $key => $value) {
            curl_setopt($this->curl_handler, $key, $value);
        }
        curl_setopt($this->curl_handler, CURLOPT_HEADER, 0);
        curl_setopt($this->curl_handler, CURLOPT_POSTFIELDS, json_encode($params));
        $result = curl_exec($this->curl_handler);
        $this->curl_info['status_code'] = curl_getinfo($this->curl_handler, CURLINFO_HTTP_CODE);
        $this->curl_info['time_exe'] = $this->microtime_float() - $this->start_time;
        return $result;
    }

    /**
     * @param $url
     * @param array $params
     * @return mixed|string
     * post x-www-form-urlencoded
     */
    public function post_form_urlencoded($url, $params = [])
    {
        if (empty($url)) return '';
        $this->start_time = $this->microtime_float();
        $data = http_build_query($params);
        curl_setopt($this->curl_handler, CURLOPT_URL, $url);
        curl_setopt($this->curl_handler, CURLOPT_POST, 1);
        curl_setopt($this->curl_handler, CURLOPT_HTTPHEADER, ['Content-type: application/x-www-form-urlencoded;charset=UTF-8']);
        curl_setopt($this->curl_handler, CURLOPT_HEADER, 0);
        curl_setopt($this->curl_handler, CURLOPT_POSTFIELDS, $data);
        $result = curl_exec($this->curl_handler);
        $this->curl_info['status_code'] = curl_getinfo($this->curl_handler, CURLINFO_HTTP_CODE);
        $this->curl_info['time_exe'] = $this->microtime_float() - $this->start_time;
        return $result;
    }

    public function microtime_float()
    {
        list($usec, $sec) = explode(" ", microtime());
        return ((float)$usec + (float)$sec);
    }
}