<?php
header('Content-Type:text/html; charset=utf-8');
return array(
    'UPLOAD_CONFIG' => array(
        'maxSize' => 3145728,
        'saveName' => array('uniqid',''),
        'exts' => array('jpg', 'gif', 'png', 'jpeg'),
        'autoSub' => true,

    ),
);