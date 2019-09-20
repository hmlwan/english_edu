<?php
/**
 * 信鸽推送消息
 * @param $data
 * @return array|mixed
 */
function funXgPush($data)
{
    $device_type = $data['device_type'];
    $custom = $data['custom'];
    $token = $data['token'];
    $title = $data['title'];
    $des = isset($data['des']) ? $data['des'] : '';

    $content = array(
        'content' => $device_type == 2 ? $custom : json_encode($custom),
    );
    $jpush = new \Common\Lib\Jpush($device_type);

    $res = $jpush->push($token, $title, $des, $content);
    if ($res['ret_code'] != 0) {
        funLog('消息发送失败:' . json_encode($content) . json_encode($res), 'push.log');
        return false;
    }
    return true;
}
/**
 * 发送极光推送
 */
function funcjgPush($type,$role_id,$mess_id,$title,$push_token,$contents){

    Vendor('JPush.autoload');
    $client = new \JPush\Client(C('JPUSH_APPKEY'),C('JPUSH_MASTERSECRET'));

    $push_data = array(
        'type'      =>  $type,
        'content' =>  array(
            'message_id'    => $mess_id,
            'message_title' => $title,
            'role_id'       => $role_id
        )
    );
    $notification = array(
        'sound' => 'default',
        'badge' => '+1',
        'content-available' => true,
        'mutable-content' => true,
        'category' => 'iOS category',
        'extras' => $push_data,
    );
    if(C('ENVIRON')){
        $apns_production = False ; //开发环境（未上线）
    }else{
        $apns_production = True;   //生产环境（已上线）
    }
    if($push_token){
        $tmp = $client->push()
            ->setPlatform('all')
            ->addRegistrationId($push_token)
            ->setNotificationAlert($title)
            ->addAndroidNotification($title, $title,
                1, array("data"=>$push_data))
            ->iosNotification($title.$contents,$notification)
            ->setOptions($sendno = time(), $time_to_live = 86400, $override_msg_id = null,
                $apns_production, $big_push_duration = null)
            ->send();
    }

    if($tmp['http_code']==200){
        return true;
    }else{
        return false;
    }
}

/**
 *  切分图片字符串并加上域名
 */
function funcCreatPic($pic){

    $pic_arr = explode('|',$pic);
    if($pic_arr){
        $pic_list = array();
        foreach($pic_arr as $key => $item){
            if($item){
                $pic_list[] = C('IMG_HTTP').$item;
            }
        }
        return $pic_list;
    }else{
        return '';
    }
}

/**
 * 构造时间
 */
function funcgetDate($time){
    return date("Y-m-d",strtotime($time));

}

/**
 * 构造连续的时间数值
 */
function funcgetDateArr($res,$start_time,$end_time,$type){
    $arr = $res_list = array();
    foreach ($res as $res_item){
        $res_list[$res_item['time']] = $res_item;
    }
    if($type == 1){
        for($i=strtotime($start_time);$i<=strtotime($end_time);$i+=3600){
            $arr[][]= date('H:00',$i);
        }
    }else{
        for($i=strtotime($start_time);$i<=strtotime($end_time);$i+=86400){
            $arr[][]= date('m-d',$i);
        }
    }

    foreach ($arr as $str_key => $str_item){
        $arr[$str_key][] = $res_list[$str_item[0]];
    }
    return $arr;
}





































