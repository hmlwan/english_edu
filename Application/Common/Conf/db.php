<?php
    return array(
        /* 数据库设置 */
        'DB_CHARSET'  => 'utf8',// 数据库编码默认采用utf8
        'DB_TYPE'               =>  'mysql',     // 数据库类型
        'DB_HOST'               =>  '127.0.0.1', // 服务器地址
        'DB_NAME'               =>  'english_edu',          // 数据库名
//        'DB_USER'               =>  'english_edu',      // 用户名
        'DB_USER'               =>  'root',      // 用户名
        'DB_PWD'                =>  'root',          // 密码
//        'DB_PWD'                =>  'aPRYzsnGpwKTbs6w',          // 密码
        'DB_PORT'               =>  '3306',        // 端口
        'DB_PREFIX'             =>  'cx_',    // 数据库表前缀
        //'DB_PARAMS'          	=>  array(), // 数据库连接参数
        'DB_PARAMS' => array(\PDO::ATTR_CASE => \PDO::CASE_NATURAL),
        'DB_DEBUG'  			=>  false, // 数据库调试模式 开启后可以记录SQL日志
        'DB_FIELDS_CACHE'       =>  false,        // 启用字段缓存
        'DB_DEBUG'  =>  true,
    );


