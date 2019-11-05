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
    * teaching_video_id 教学视频id
    */
    public function online_question(){
        $db = M('teaching_video');

        $teaching_video_id = I('teaching_video_id','','');
        if($teaching_video_id){
            $data['status'] = 0;
            $data['info'] = "教学视频不存在";
            $this->ajaxReturn($data);
        }
        $subject_task_id = $db->where(array('id'=>$teaching_video_id))->getField('subject_task_id');
        $subject_task = M("subject_task")
            ->where(array('subject_task_id'=>$subject_task_id))
            ->field('subject_task_id,task_name,content')
            ->find();
        if(empty($subject_task)){
            $data['status'] = 0;
            $data['info'] = "该教学视频无作业";
            $this->ajaxReturn($data);
        }
        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $subject_task;
        $this->ajaxReturn($data);
    }

    /*
     * 在线答题
     * teaching_video_id 教学视频id
     * correct_task_id 作业id
     * content 作业 json
     */
    public function online_answer(){
        $db = M('teacher_correct_task');
        $correct_task_id = I("correct_task_id");
        $teaching_video_id = I('teaching_video_id','','');
        $content = I('content','','');
        $member_id = $_SESSION['USER_KEY_ID'];
        $save_info = array(
            'is_correct' => 0,
            'teaching_video_id' => $teaching_video_id,
            'member_id' => $member_id,
            'sub_time' => time(),
            'content' => $content
        );
        if($correct_task_id){
            $info = $db->where(array('id'=>$correct_task_id))->find();
            if($info['is_correct'] == 1){ //批改完
                $r = $db->add($save_info);
            }else{ //未批改
                $r = $db->where(array('id'=>$correct_task_id))->save($save_info);
            }
        }else{
            $r = $db->add($save_info);
        }
        if(false === $r){
            $data['status'] = 0;
            $data['info'] = "失败";
            $this->ajaxReturn($data);
        }else{
            $data['status'] = 1;
            $data['info'] = "成功";
            $this->ajaxReturn($data);
        }

    }
    /*
     *  老师评语内容
     *  teaching_video_id 教学视频id
     */
    public function  teacher_remark_view(){
        $teaching_video_id = I('teaching_video_id','','');

        $db = M('teacher_correct_task');
        $list = $db->where(array(
                'teaching_video_id'=>$teaching_video_id,
                'is_correct' => 0))
            ->field('id,teaching_video_id,member_id,content,sub_time,is_correct')
            ->order('sub_time desc')
            ->select();
        if(empty($list)){
            $data['status'] = 0;
            $data['info'] = "无需批改的作业";
            $this->ajaxReturn($data);
        }
        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $list;
        $this->ajaxReturn($data);
    }
    /*
     * 教学讨论
     * teaching_video_id 教学视频id
     */
    public function teaching_video_discussion(){
        $teaching_video_id = I('teaching_video_id','','');
        $db = M("discussion");
        $where['dis.teaching_video_id'] = $teaching_video_id;
        $list = $db->alias('dis')
            ->where($where)
            ->join('left join cx_discussion_detail as det ON det.discussion_id=dis.id')
            ->field('det.*,dis.student_id,dis.teacher_id,dis.teaching_video_id')
            ->order("det.stu_add_time desc")
            ->select();
        foreach ($list as $k=>$value){
            $mem_info =  M("member")->where(array('member_id'=>$value['student_id']))
                ->field('nick_name,head')
                ->find();
            $list[$k]['nick_name'] = $mem_info['nick_name'];
            $list[$k]['stu_head'] =  $mem_info['head'];
            $tea_info =  M("teacher")->where(array('teacher_id'=>$value['teacher_id']))
                ->field('teacher_name,head')
                ->find();
            $list[$k]['teacher_name'] = $tea_info['teacher_name'];
            $list[$k]['tea_head'] =  $tea_info['head'];
        }
        $data['status'] = 1;
        $data['info'] = "成功";
        $data['data'] = $list;
        $this->ajaxReturn($data);
    }

    /*
     * 老师批改
     * teacher_id 老师id
     * correct_task_id 批改作业id
     * content 批改内容 json
     */
    public function teacher_remark(){
        $correct_task_id = I('correct_task_id','','');
        $teacher_id = I('teacher_id','','');
        $content = I('content','','');
        $db = M('teacher_correct_task');

        $r =  $db->where(array(
            'teacher_id' => $teacher_id,
            'content' => $content,
            'add_time' => time()
        ))->save(array('id'=>$correct_task_id));
        if(false === $r){
            $data['status'] = 0;
            $data['info'] = "失败";
            $this->ajaxReturn($data);
        }else{
            $data['status'] = 1;
            $data['info'] = "成功";
            $this->ajaxReturn($data);
        }
    }
    /*
     * 学生提问
     * teaching_video_id 教学视频id
     * stu_content 学生留言内容
     */
    public function  stu_put_question(){
        $teaching_video_id = I('teaching_video_id','','');
        $stu_content = trim(I('stu_content','',''));
        $member_id = $_SESSION['USER_KEY_ID'];

        $db = M("discussion");
        $db_detail = M("discussion_detail");
        $r = $db->add(array(
            'teaching_video_id' => $teaching_video_id,
            'student_id' => $member_id,
        ));
        if($r){
            $detail_data = array(
                'discussion_id' => $r,
                'stu_content' => $stu_content,
                'stu_is_read' => 0,
                'tea_is_read' => 0,
                'stu_add_time' => time(),
            );
            $db_detail->add($detail_data);
            $data['status'] = 1;
            $data['info'] = "成功";
            $this->ajaxReturn($data);
        }else{
            $data['status'] = 0;
            $data['info'] = "失败";
            $this->ajaxReturn($data);
        }
    }
    /*
     * 老师回复
     * discussion_id 讨论id
     * teacher_id 老师id
     * tea_content 教师留言内容
     */
    public function tea_reply(){
        $discussion_id = I('discussion_id','','');
        $teacher_id = I('teacher_id','','');
        $tea_content = I('tea_content','','');
        $db = M("discussion");
        $db_detail = M("discussion_detail");


        $res1 = $db->where(array('id'=>$discussion_id))->save(array('teacher_id'=>$teacher_id));
        $detail_data = array(
            'tea_content' => $tea_content,
            'tea_add_time' => time(),
        );
        $res2 = $db_detail->where(array('discussion_id'=>$discussion_id))->save($detail_data);
        if($res1 && $res2){
            $data['status'] = 1;
            $data['info'] = "成功";
            $this->ajaxReturn($data);
        }else{
            $data['status'] = 0;
            $data['info'] = "失败";
            $this->ajaxReturn($data);
        }
    }
}