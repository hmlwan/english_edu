<?php
namespace Home\Action;
use Think\Action;
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 16:19
 */
class ApiAction extends CommonAction
{

    /*
     * 修改学生信息
     *  nick_name 昵称
     */
    public function update_mem_info(){
        $db = M('member');
        $member_id = $_SESSION['USER_KEY_ID'];
        $nick_name = trim(I('nick_name','',''));
        if(!$nick_name){
            $data['status'] = 0;
            $data['info'] = "请输入昵称";
            $this->ajaxReturn($data);
        }
        if(!$member_id){
            $data['status'] = 0;
            $data['info'] = "用户不存在";
            $this->ajaxReturn($data);
        }
        if(mb_strlen($nick_name,'utf8')>8){
            $data['status'] = 0;
            $data['info'] = "昵称不能超过8个字符";
            $this->ajaxReturn($data);
        }
        if($r = $db->create()){
            $res = $db->where(array('member_id'=>$member_id))->save($r);
            if($res){
                $data['status'] = 1;
                $data['info'] = "超过";
                $this->ajaxReturn($data);
            }else{
                $data['status'] = 0;
                $data['info'] = "失败";
                $this->ajaxReturn($data);
            }
        }else{
            $data['status'] = 0;
            $data['info'] = "失败";
            $this->ajaxReturn($data);
        }

    }
    /*
     * 教师下线
     * teacher_id 教师id
     * is_online 是否上线 1 上线 0下线
     *
     */
    public function teacher_off_line(){
        $teacher_id = I("teacher_id",'','');
        $is_online = I('is_online','','');
        if(!$teacher_id){
            $data['status'] = 0;
            $data['info'] = "用户不存在";
            $this->ajaxReturn($data);
        }
        $db = M('teacher');
        $res = $db->where(array('teacher_id'=>$teacher_id))->save(array('is_online'=>$is_online));
        if(false !== $res ){
            $data['status'] = 1;
            $data['info'] = "失败";
        }else{
            $data['status'] = 0;
            $data['info'] = "失败";

        }
        $this->ajaxReturn($data);

    }
    /*
     * 消息已读
     * teaching_video_id 教学视频id
     * login_type 登录方式 1 学生登录 2 老师登录
     * teacher_id 老师id
     */
    public function read_news(){
        $teaching_video_id = I('teaching_video_id','','');
        $member_id = $_SESSION['USER_KEY_ID'];
        $teacher_id = I("teacher_id",'','');
        $login_type = I('login_type');
        if(!$teaching_video_id){
            $data['status'] = 0;
            $data['info'] = "教学视频不存在";
            $this->ajaxReturn($data);
        }
        $where = array(
            'teaching_video_id'=>$teaching_video_id
        );
        $detail_where = array();
        if($login_type == 1){ //学生登录
            $where['student_id'] = $member_id;
            $detail_where = array(
                'stu_is_read' => 0
            );
            $field = "stu_is_read";
        }else if($login_type == 2){ //教师登录
            $where['teacher_id'] = $teacher_id;
            $detail_where = array(
                'tea_is_read' => 0
            );
            $field = "tea_is_read";
        }
        $dis_info = M('discussion')
            ->where($where)
            ->getField('id',true);
        $dis_info = array_filter(array_unique($dis_info));
        if(empty($dis_info)){
            $data['status'] = 1;
            $data['info'] = "暂无讨论";
            $this->ajaxReturn($data);
        }
        $detail_where['discussion_id'] = array('in',$dis_info);
        $r = M("discussion_detail")
            ->where($detail_where)
            ->save(array($field => 1));
        if(false !== $r){
            $data['status'] = 1;
            $data['info'] = "成功";
        }else{
            $data['status'] = 0;
            $data['info'] = "失败";
        }
        $this->ajaxReturn($data);

    }
    /*
     * 在线答题
     * teaching_video_id
     */
    public function online_answer(){
        $db = M('teacher_correct_task');

        $teaching_video_id = I('teaching_video_id','','');
        $content = I('content','','');
        $member_id = $_SESSION['USER_KEY_ID'];
        $save_info = array(
            'is_correct' => 0,
            'teaching_video_id' => $teaching_video_id,
            'member_id' => $member_id,

        );


    }
    /*教师批语 */
    public function teacher_remark(){

    }
    /*学生提问*/
    public function  stu_put_question(){

    }
    /*老师回复*/
    public function tea_reply(){

    }


    /*播放教学视频*/
    public function play_teaching_video(){

    }


}