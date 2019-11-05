<?php
namespace Home\Action;
use Think\Action;
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 16:19
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
            if(!$_POST['pwd']){
                $data['status'] = 0;
                $data['info'] = '密码不存在';
                $this->ajaxReturn($data);
            }
            $_POST['pwd'] = md5($_POST['pwd']);

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
     * 登录
     * phone 手机号
     */
    public function login(){
        $phone = I('post.phone');
        $pwd = md5(I('post.pwd'));
        $M_member = D('Member');
        $info = $M_member->logCheckPhone($phone);

        if($info['status'] != 1){
            $data['status'] = 2;
            $data['info']="非常抱歉您的账号已被锁定";
            $this->ajaxReturn($data);
        }
        //验证手机
        if($info == false){
            $data['status'] = 0;
            $data['info']="用户名不存在";
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
        $data['login_ip'] = get_client_ip();
        $data['login_time']= time();
        $where['member_id'] = $info['member_id'];
        $r = $M_member->where($where)->save($data);
        if($r === false){
            $data['status'] = 0;
            $data['info']="服务器繁忙,请稍后重试";
            $this->ajaxReturn($data);
        }
        session('USER_KEY_ID',$info['member_id']);
        session('USER_KEY',$info['phone']);

        $data['status'] = 1;
        $data['info'] = "登录成功";
        $this->ajaxReturn($data);
    }
    /*
     * 教师列表,一对一教学
     */
    public function teacher_list(){
        $db = M('teacher');
        $list = $db->where(array('status'=>1))
            ->field("teacher_id,teacher_name,is_recomment,teacher_info,head,img,is_online")
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
        $data['status'] = 0;
        $data['info'] = "成功";
        $data['data'] = $list;
        $this->ajaxReturn($data);

    }
    /*单词学习*/
    public function learn_word(){



    }


}