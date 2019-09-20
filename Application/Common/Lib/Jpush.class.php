<?php
namespace Common\Lib;
/**
 ** 极光推送
 **/
class Jpush{

    private $app_key = '';            //待发送的应用程序(appKey)，只能填一个。
    private $master_secret = '';      //主密码
    private $url = "https://api.jpush.cn/v3/push";            //推送的地址
    protected $device_type;

    //若实例化的时候传入相应的值则按新的相应值进行  
    public function __construct($device_type=1,$url=null) {

        $this->_config = C('JPUSH_CONFIG');
        $device_str = $device_type==2?'IOS_CONFIG':'ANDROID_CONFIG';
        $this->app_key = $this->_config[$device_str]['APPKEY'];
        $this->master_secret = $this->_config[$device_str]['MASTERSECRET'];
        $this->device_type = $device_type;
        if ($url) $this->url = $url;
    }

    /*  $receiver 接收者的信息 
        all 字符串 该产品下面的所有用户. 对app_key下的所有用户推送消息 
        tag(20个)Array标签组(并集): tag=>array('昆明','北京','曲靖','上海'); 
        tag_and(20个)Array标签组(交集): tag_and=>array('广州','女'); 
        alias(1000)Array别名(并集): alias=>array('93d78b73611d886a74*****88497f501','606d05090896228f66ae10d1*****310');
        registration_id(1000)注册ID设备标识(并集): registration_id=>array('20effc071de0b45c1a**********2824746e1ff2001bd80308a467d800bed39e');
        $content 推送的内容。 
        $extras  附加字段  array类型 0
        $m_time 保存离线时间的秒数默认为一天(可不传)单位为秒  +/*
    */
    public function push($receiver='all', $title='', $content='', $extras, $m_time='86400'){
       // $json = '{"platform":"ios","audience":"{\"registration_id\":[\"0818650c2ff\"]}","notification":"{\"ios\":{\"content-available\":true,\"alert\":\"????--jpush test\",\"extras\":{\"detailtype\":\"3\",\"gnFlag\":\"tzfb\",\"ckzt\":\"0\",\"tzryid\":\"\",\"tznrid\":\"838294\",\"creatTimeStamp\":\"1465810675\",\"receiverid\":\"J1168103703900000009\"}}}","options":"{\"apns_production\":true}"}';

        $base64 =base64_encode("{$this->app_key}:{$this->master_secret}");
        $header=array("Authorization:Basic {$base64}","Content-Type:application/json");
        $data = array();
        $data['platform'] = $this->device_type==1?'android':'ios';          //目标用户终端手机的平台类型android,ios,winphone
             //目标用户
        //发送通知
        if($this->device_type==1){
            $data['audience']['registration_id'] = array($receiver);
            $_data['android'] = array(
                "alert"=>$content,
                "title"=>$title,
                "builder_id"=>1,
                "extras"=>$extras
            );
            $apns_production = 0;
        }else{
            $data['audience']['registration_id'] = array($receiver);
            $_data['ios'] = array(
                "alert"=>$content,
                "content-available"=>true,
                "badge"=>1,
                "sound"=>"default",
                "extras"=>$extras
            );
            $apns_production = 0;
        }
        $data['notification'] = $_data;

        //自定义信息  
        $data['message'] = array(
            "msg_content"=>$content,
            "extras"=>$extras
        );

        //附加选项  
        $data['options'] = array(
            "sendno"=>time(),
            "time_to_live"=>$m_time,      //保存离线时间的秒数默认为一天  
            "apns_production"=>$apns_production,        //指定 APNS 通知发送环境：0开发环境，1生产环境。
        );
        $param = json_encode($data);
        $res = $this->push_curl($param,$header);

        if($res){       //得到返回值--成功已否后面判断  
            return $res;
        }else{          //未得到返回值--返回失败  
            return false;
        }
    }

    //推送的Curl方法  
    public function push_curl($param="",$header="") {
        if (empty($param)) { return false; }
        $postUrl = $this->url;
        $curlPost = $param;

        $ch = curl_init();                                      //初始化curl  
        curl_setopt($ch, CURLOPT_URL,$postUrl);                 //抓取指定网页  
        curl_setopt($ch, CURLOPT_HEADER, 0);                    //设置header  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);            //要求结果为字符串且输出到屏幕上  
        curl_setopt($ch, CURLOPT_POST, 1);                      //post提交方式  
        curl_setopt($ch, CURLOPT_POSTFIELDS, $curlPost);
        curl_setopt($ch, CURLOPT_HTTPHEADER,$header);           // 增加 HTTP Header（头）里的字段   
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);        // 终止从服务端进行验证  
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $data = curl_exec($ch);                                 //运行curl  
        curl_close($ch);
        return $data;
    }
    //发送通知
    public function pushMess(){

        //组装需要的参数
        $receive = 'all'; //全部
        //$receive = array('tag'=>array('1','2','3')); //标签
        //$receive = array('alias'=>array('111')); //别名
        $title = "测试";
        $content = "推送测试";
        $m_time = '86400'; //离线保留时间
        $extras = array("versionname"=>"测试", "versioncode"=>"123"); //自定义数组
        //调用推送,并处理
        $result = $this->push($receive,$title,$content,$extras,$m_time);
        if($result){
            $res_arr = json_decode($result, true);
            if(isset($res_arr['error'])){ //如果返回了error则证明失败
                //错误信息 错误码
                //$this->error($res_arr['error']['message'].'：'.$res_arr['error']['code']);
                echo $res_arr['error']['message'].'：'.$res_arr['error']['code'];
            }else{
                //处理成功的推送......
                //可执行一系列对应操作~
                return true;
            }
        }else{ //接口调用失败或无响应
            return false;
        }
    }
}

?>  