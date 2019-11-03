<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 16:23
 */

/**
 * 调试输出数据
 */
function dd($data=''){
    echo '<pre>';
    print_r($data);
    echo "</pre>";
    die;
}
/** 短信认证
 * @param $phone 电话号码
 * @param $name  发送标题
 * @param $user  短息接口用户名
 * @param $pass  短信接口密码
 * @return mixed 错误信息
 */
function sandPhone($phone,$name='',$user='',$pass=''){
    $statusStr = array(
        "0" => "短信发送成功",
        "-1" => "参数不全",
        "-2" => "服务器空间不支持,请确认支持curl或者fsocket，联系您的空间商解决或者更换空间！",
        "30" => "密码错误",
        "40" => "账号不存在",
        "41" => "余额不足",
        "42" => "帐户已过期",
        "43" => "IP地址限制",
        "50" => "内容含有敏感词",
        "100"=>'您操作太频繁，请稍后再试'
    );


    $mobile = $phone;
    $smsAPI = "";
    $time = session('time');
    if (time()-$time<60&&!empty($time)){
        return $statusStr['100'];
    }
    $code=rand(100000, 999999);

    session(array('name'=>'code','expire'=>600));
    session('code',$code);  //设置session
    session('time',time());

    $content ="【侗红实业】您正在进行手机操作，您的验证码是：".$code;//要发送的短信内容

    $postArr = array(
        'appid' => $user,
        'signature' => $pass,
        'content' => $content,
        'to' => $mobile
    );
    $result = curlPost($smsAPI,$postArr);
    $res = json_decode($result, true);
    if ($res['status'] == 'success') {
        return "短信发送成功";
    } else {
        return "短信发送失败";
    }
}

/**
 * 通过CURL发送HTTP请求
 * @param string $url  //请求URL
 * @param array $postFields //请求参数
 * @return mixed
 */
function curlPost($url,$postFields){
    $postFields = http_build_query($postFields);
    $ch = curl_init ();
    curl_setopt ( $ch, CURLOPT_POST, 1 );
    curl_setopt ( $ch, CURLOPT_HEADER, 0 );
    curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
    curl_setopt ( $ch, CURLOPT_URL, $url );
    curl_setopt ( $ch, CURLOPT_POSTFIELDS, $postFields );
    if (1 == strpos("$".$url, "https://"))
    {
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    }
    $result = curl_exec ( $ch );
    curl_close ( $ch );
    return $result;
}
