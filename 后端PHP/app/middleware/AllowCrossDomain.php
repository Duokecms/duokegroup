<?php
namespace app\middleware;

class AllowCrossDomain{
    /**
     * 设置跨域
     * @param $request
     * @param \Closure $next
     * @return mixed|void
     */
    public function handle($request, \Closure $next)
    {
        $response = $next($request);
        $origin = $request->header('Origin', '');
        //OPTIONS请求返回204请求
        if ($request->method(true) === 'OPTIONS') {
            $response->code(204);
        }
        $response->header([
            'Access-Control-Allow-Origin'      => $origin,
            'Access-Control-Allow-Methods'     => '*',
            'Access-Control-Allow-Credentials' => 'true',
            'Access-Control-Allow-Headers'     => '*',
        ]);
        return $response;
    }
}