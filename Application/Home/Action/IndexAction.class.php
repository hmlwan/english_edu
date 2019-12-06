<?php
namespace Home\Action;
use Think\Action;

/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 16:19
 * X-Token
 */
class IndexAction extends Action
{
    /*
     * 注册
     */
    public function reg(){

        if(IS_POST) {
            //增加添加时间,IP
            $_POST['reg_time'] = time();
            $_POST['ip'] = get_client_ip();
            $_POST['status'] = 1;
            $_POST['code'] = 1234;
            if(!$_POST['phone']){
                $data['status'] = 0;
                $data['info'] = '手机号码存在';
                $this->ajaxReturn($data);
            }
            if(!$_POST['pwd']){
                $data['status'] = 0;
                $data['info'] = '密码不存在';
                $this->ajaxReturn($data);
            }
            $_POST['pwd'] = md5($_POST['pwd']);
            if(!preg_match("/^1[34578]{1}\d{9}$/",$_POST['phone'])){
                $data['status']=-1;
                $data['info'] = "手机号码不正确";
                $this->ajaxReturn($data);
            }
            $_SESSION['code'] = 1234;
            if ($_POST['code'] != $_SESSION['code']) {
                $data['status'] = 0;
                $data['info'] = '验证码错误';
                $this->ajaxReturn($data);
            }
            $M_member = D('Member');
            $info = M('Member')->where(array('phone' => $_POST['phone']))->find();
            if ($info) {
                $data['status'] = 0;
                $data['info'] = "手机号码已经存在";
                $this->ajaxReturn($data);
            }
            if (!$M_member->create()) {
                // 如果创建失败 表示验证没有通过 输出错误提示信息
                $data['status'] = 0;
                $data['info'] = $M_member->getError();
                $this->ajaxReturn($data);
            } else {
                $r = $M_member->add();
                if ($r) {
                    $data['status'] = 1;
                    $data['info'] = '注册成功';
                    $this->ajaxReturn($data);
                } else {
                    $data['status'] = 0;
                    $data['info'] = '服务器繁忙,请稍后重试';
                    $this->ajaxReturn($data);
                }
            }
        }
    }
    /**
     * ajax 发送手机号码
     */
    public function ajaxSandPhone(){

        $phone = urldecode($_REQUEST['phone']);
        $type = $_REQUEST['type'];
        if(empty($phone)){
            $data['status']=0;
            $data['info'] = "参数错误";
            $this->ajaxReturn($data);
        }
        if(!preg_match("/^1[34578]{1}\d{9}$/",$phone)){
            $data['status']=-1;
            $data['info'] = "手机号码不正确";
            $this->ajaxReturn($data);
        }
        if($type == 1){ /*注册*/
            $res = M('member')->where(array('phone'=>$phone))->find();
            if($res){
                $data['status'] = 0;
                $data['info'] = "该手机号已被注册";
                $this->ajaxReturn($data);
            }
        }elseif($type == 2){ /*忘记密码*/
            $res = M('member')->where(array('phone'=>$phone))->find();
            if(!$res){
                $data['status'] = 0;
                $data['info'] = "该手机号不存在";
                $this->ajaxReturn($data);
            }
        }

        $r = sandPhone($phone,$this->config['CODE_NAME'],$this->config['CODE_USER_NAME'],$this->config['CODE_USER_PASS']);
        if($r!="短信发送成功"){
            $data['status']=0;
            $data['info'] = $r;
            $this->ajaxReturn($data);
        }else{
            $data['status']=1;
            $data['info'] = $r;
            $this->ajaxReturn($data);
        }
    }
    /*
     * 学生登录
     * phone 手机号
     * pwd 密码
     *
     */
    public function login(){
        $phone = I('post.phone');
        $pwd = md5(I('post.pwd'));


        $M_member = D('Member');
        $info = $M_member->logCheckPhone($phone);

        //验证手机
        if($info == false){
            $data['status'] = 0;
            $data['info']="用户不存在";
            $this->ajaxReturn($data);
        }
        //验证密码
        if($info['pwd'] != $pwd){
            $data['status'] = 0;
            $data['info'] = "密码输入错误";
            $this->ajaxReturn($data);
        }
        if($info['status'] != 1){
            $data['status'] = 2;
            $data['info']="非常抱歉您的账号已被锁定";
            $this->ajaxReturn($data);
        }

        //验证身份信息如果身份证存在并且 当前IP 和上次登录Ip不一样
        //如果当前操作Ip和上次不同更新登录IP以及登录时间
        $save_data['login_ip'] = get_client_ip();
        $save_data['login_time']= time();
        $where['member_id'] = $info['member_id'];
        $r = $M_member->where($where)->save($save_data);
        if($r === false){
            $data['status'] = 0;
            $data['info']="服务器繁忙,请稍后重试";

            $this->ajaxReturn($data);
        }
//        session('USER_KEY_ID',$info['member_id']);
//        session('USER_KEY',$info['phone']);
        $m_info = $M_member->where($where)->field('member_id as login_mem_id,phone,head,nick_name,is_vip')->find();
        $jwt = new \Common\Lib\Jwt();
        $Token = $jwt->genToken($m_info);
        $param = array(
            'm_info' => $m_info,
            'X-Token' => $Token
        );
        $data['status'] = 1;
        $data['info'] = "登录成功";
        $data['data'] = $param;
        $this->ajaxReturn($data);
    }
    /*
     * 登录
     * phone 手机号
     * pwd 密码
     * type 老师登录
     */
    public function teacher_login(){
        $username = I('post.username');
        $pwd = md5(I('post.pwd'));

        $teacher = D('teacher');
        $info = $teacher->where(array('username'=>$username))->find();

        if(!$info){
            $data['status'] = 2;
            $data['info']="账号不存在";
            $this->ajaxReturn($data);
        }
        if($info['status'] != 1){
            $data['status'] = 2;
            $data['info']="非常抱歉您的账号已被锁定";
            $this->ajaxReturn($data);
        }
        //验证密码
        if($info['pwd'] != $pwd){
            $data['status'] = 0;
            $data['info'] = "密码输入错误";
            $this->ajaxReturn($data);
        }
        //验证身份信息如果身份证存在并且 当前IP 和上次登录Ip不一样
        //如果当前操作Ip和上次不同更新登录IP以及登录时间
        $save_data['login_ip'] = get_client_ip();
        $save_data['login_time']= time();
        $where['teacher_id'] = $info['teacher_id'];
        $r = $teacher->where($where)->save($save_data);
        if($r === false){
            $data['status'] = 0;
            $data['info']="服务器繁忙,请稍后重试";

            $this->ajaxReturn($data);
        }
//        session('USER_KEY_ID',$info['member_id']);
//        session('USER_KEY',$info['phone']);
        $tea_info = $teacher->where($where)->field('teacher_id as login_mem_id,username,is_online,teacher_name')->find();
        $jwt = new \Common\Lib\Jwt();
        $Token = $jwt->genToken($tea_info);
        $param = array(
            'm_info' => $tea_info,
            'X-Token' => $Token
        );
        $data['status'] = 1;
        $data['info'] = "登录成功";
        $data['data'] = $param;
        $this->ajaxReturn($data);
    }
    /*
     * 教师列表,一对一教学
     */
    public function teacher_list(){
        $db = M('teacher');
        $list = $db->where(array('status'=>1))
            ->field("teacher_id,teacher_name,is_recomment,teacher_info,qrcode_url,head,img,is_online")
            ->select();

        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $list;
        $this->ajaxReturn($data);
    }

    /*
     * 视频课堂推荐
     */
    public function  videos_classroom_recommend(){
       $db = M('video_cate');
       $list = $db->where(array('status'=>1,'is_recommend'=>1))
           ->field('id,title,teacher_id,img')
           ->select();

        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $list?$list:array();
        $this->ajaxReturn($data);

    }
    /*视频客课堂列表*/
    public function videos_classroom(){

        $db = M('video_cate');
        $list = $db->where(array('status'=>1,'is_recommend'=>1))
            ->field('id,title,teacher_id,img')
            ->select();
        $arr = array();
        foreach ($list as $k =>$v){
            $teacher_name = M('teacher')
                ->where(array('teacher_id'=>$v['teacher_id']))
                ->getField('teacher_name');
            $arr[$teacher_name][] = $v;
        }

        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $arr;
        $this->ajaxReturn($data);

    }
    /*
     * 播放教学视频
     * video_cate_id 课程id
     */
    public function play_teaching_video(){
        $db = M('teaching_video');
        $video_cate_id = I('video_cate_id','','');
        if(!$video_cate_id){
            $data['status'] = 0;
            $data['info'] = "课程不存在";
            $this->ajaxReturn($data);
        }

        $list = $db->where(array('video_cate_id'=>$video_cate_id))
            ->order("sort asc")
            ->select();
        if($list){
            foreach ($list as &$v){
                //视频信息
                $video_info = M("video")
                    ->where(array('video_id'=>$v['video_id']))
                    ->field('video_url,video_name,blackboard_writing,status')
                    ->find();
                //作业信息
                $task_info = M("subject_task")
                    ->where(array('subject_task_id'=>$v['subject_task_id']))
                    ->field('subject_task_id,task_name,content')
                    ->find();

                $v['blackboard_writing'] = $video_info['blackboard_writing'];
                $v['video_status'] = $video_info['status'];
                $v['video_url'] = $video_info['video_url'];
                $v['task_name'] = $task_info['task_name'];
                $v['task_content'] = $task_info['content'];
            }
        }
        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $list;
        $this->ajaxReturn($data);

    }
    /*单词学习*/
    public function learn_word(){



    }
  public function singleSend1(){
        header("Content-Type:text/html;charset=utf-8");
        $apikey = "bac32b51a7a9e7d8b2acb0d2c8ed00e8"; //修改为您的apikey(https://www.yunpian.com)登录官网后获取
        $mobile = "15179811531"; //请用自己的手机号代替
        $code= rand(100000, 999999);
        $text="【摩根平台】尊敬的用户：您的校验码：{$code}，工作人员不会索要，请勿泄露。";
        $ch = curl_init();

        /* 设置验证方式 */
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept:text/plain;charset=utf-8',
            'Content-Type:application/x-www-form-urlencoded', 'charset=utf-8'));
        /* 设置返回结果为流 */
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        /* 设置超时时间*/
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);

        /* 设置通信方式 */
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

// 取得用户信息
        $json_data = get_user($ch,$apikey);
        $array = json_decode($json_data,true);
        echo '<pre>';print_r($array);
        $data=array('text'=>$text,'apikey'=>$apikey,'mobile'=>$mobile);
        $json_data = send($ch,$data);
        $array = json_decode($json_data,true);
        echo '<pre>';print_r($array);
    }
   public function singleSend() {
        $mobile = 15179811531;
        $apikey = "bac32b51a7a9e7d8b2acb0d2c8ed00e8";
//        $apikey = $this->config['phone_apikey'];
        $phone_yzm_text = $this->config['phone_yzm_text'];
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
        $time = session('time');
//        if (time()-$time<60&&!empty($time)){
//            return $statusStr['100'];
//        }
        $code= rand(100000, 999999);

        session(array('name'=>'code','expire'=>600));
        session('code',$code);  //设置session
        session('time',time());

        $text ="【摩根平台】尊敬的用户：您的校验码：{$code}，工作人员不会索要，请勿泄露。";//要发送的短信内容
//        $text = str_replace("{code}",$code,$phone_yzm_text);

        $param = [
            'apikey' => $apikey,
            'mobile' => $mobile,
            'text' => $text,
        ];
     $res = curlPost("https://sms.yunpian.com/v2/sms/single_send.json", $param);
     dd($res);
        return $res;
    }
  
  
	

}