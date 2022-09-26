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

namespace server\sms;

use server\Single;
use think\facade\Config;


class Sms
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
    public function sendSms($phone,$code)
    {
        
        var_dump(require_onece __DIR__ . '/autoload.php');exit;
        AlibabaCloud\Client\AlibabaCloud::accessKeyClient('LTAI5t9PZ7HZnxcm5M2DS4FY', 'N6QtSupk3BuggeEHFlspUjnvvwzQsq')
        ->regionId('cn-hangzhou') // replace regionId as you need
        ->asDefaultClient();
        try {
            $result = AlibabaCloud\Client\AlibabaCloud::rpc()
            ->product('Dysmsapi')
            // ->scheme('https') // https | http
            ->version('2017-05-25')
            ->action('SendSms')
            ->method('POST')
            ->options([
                    'query' => [
                      'TemplateCode' => "SMS_234241746",
                      'PhoneNumbers' => $phone,
                      'SignName' => "公装助手",
                      'TemplateParam' => "{'code':'".$code."'}",
                    ],
                ])
            ->request();
            $res = $result->toArray();
             
            //var_dump($res,$code);
            if($res['Message'] == 'OK'){
                return success('','发送成功!');
            }
             
        } catch (AlibabaCloud\Client\Exception\ClientException $e) {
            return error('','发送失败!', $e->getErrorMessage() . PHP_EOL);
        } catch (AlibabaCloud\Client\Exception\ServerException $e) {
            return error('','发送失败!', $e->getErrorMessage() . PHP_EOL);
        }
    }

    
}