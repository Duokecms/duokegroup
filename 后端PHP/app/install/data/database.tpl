<?php

return [
    'default'         => env('database.driver', 'mysql'),

    'time_query_rule' => [],

    'resultset_type' => 'array',

    'auto_timestamp'  => true,

    'datetime_format' => 'Y-m-d H:i:s',


    'connections'     => [
    'mysql' => [

    'type'            => env('database.type', 'mysql'),

    'hostname'        => env('database.hostname', '%s'),

    'database'        => env('database.database', '%s'),

    'username'        => env('database.username', '%s'),

    'password'        => env('database.password', '%s'),

    'hostport'        => env('database.hostport', '%s'),

    'params'          => [],

    'charset'         => env('database.charset', '%s'),

    'prefix'          => env('database.prefix', '%s'),


    'deploy'          => 0,

    'rw_separate'     => false,

    'master_num'      => 1,

    'slave_no'        => '',

    'fields_strict'   => true,

    'break_reconnect' => false,

    'trigger_sql'     => env('app_debug', true),

    'fields_cache'    => false,
    ]
],
];
