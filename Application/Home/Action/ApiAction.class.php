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

    /*注册*/
    public function reg(){
        $this->ajaxReturn(array('ret'=>1,'data'=>1));
    }
    /*登录*/
    public function login(){

    }
    /*教师列表*/
    public function teacher_list(){

    }
    /*年级下视频*/
    public function cate_videos(){

    }
    /*单词学习*/
    public function learn_word(){

    }
    /*修改学生信息*/
    public function update_mem_info(){

    }
    /*教师下线*/
    public function teacher_off_line(){

    }
    /*消息已读*/
    public function read_news(){

    }
    /*在线答题*/
    public function online_answer(){

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
    /*视频课堂推荐*/
    public function  videos_classroom_recommend(){

    }
    /*视频客课堂列表*/
    public function videos_classroom(){

    }

    /*播放教学视频*/
    public function play_teaching_video(){

    }


}