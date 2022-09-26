<?php
// +----------------------------------------------------------------------
// | Created by [ PhpStorm ]
// +----------------------------------------------------------------------
// | Copyright (c) 2021-2022.
// +----------------------------------------------------------------------
// | Create Time (2021/11/19 - 5:41 下午)
// +----------------------------------------------------------------------
// | Author: 唐轶俊 <tangyijun@021.com>
// +----------------------------------------------------------------------

namespace server\pay;

use server\curl\Curl;
use server\log\Log;
use server\Single;

class Withdraw
{
    use Single;


    /**
     * @param string $payUrl
     * @param array $native
     * @param string $md5Key
     * @param string $productName
     * 执行提现
     * @return array
     */
    public function doWithdraw(string $payUrl, array $native, string $md5Key, string $productName): array
    {
        ksort($native);
        $md5str = "";
        foreach ($native as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }

        $sign = strtoupper(md5($md5str . "key=" . $md5Key));

        $native["pay_md5sign"] = $sign;
        $payRes = Curl::getInstance()->post($payUrl, $native);
        var_dump($payRes);exit;
        Log::getInstance()->info([
            $payUrl,
            $native,
            $md5Key,
            $productName,
            $payRes
        ], '', 'withdraw', true);


        return json_decode($payRes, true);
    }
}