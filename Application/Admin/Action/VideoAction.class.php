<?php
namespace Admin\Action;
use Think\Action;

class VideoAction extends CommonAction
{
    private $video_model;

    function __construct()
    {
        parent::__construct();
        $this->video_model = M('video');
    }

    public function index()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = $this->video_model->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $this->video_model->order('video_id desc')->page($page . ',' . $rp)->select();

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function edit()
    {

        if (IS_POST && I('form_submit') == 'ok') {
            $data = $this->video_model->create();

            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = $this->video_model->where('video_id=' . $id)->save($data);
                } else {
                    $data['create_time'] = time();
                    $res = $this->video_model->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $this->video_model->find($id);
            $this->assign('vo', $res);
            $this->display();

        }
    }

    /**
     *删除
     */
    public function del()
    {
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('video_id' => array('in', $sub_ids));

        $res = $this->video_model->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }

    /*教学视频*/
    public function teaching_video()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;
        $db = M('teaching_video');
        $count = $db->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $db->order('id desc')->page($page . ',' . $rp)->select();
        foreach ($res as &$value){
            $value['video_name'] = M('video')->where(array('video_id'=>$value['video_id']))->getField('video_name');
            $value['video_cate_name'] = M('video_cate')->where(array('id'=>$value['video_cate_id']))->getField('title');
            $value['task_name'] = M('subject_task')->where(array('subject_task_id'=>$value['subject_task_id']))->getField('task_name');
        }

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function teaching_video_edit()
    {
        $db = M('teaching_video');
        if (IS_POST && I('form_submit') == 'ok') {
            $data = $db->create();
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = $db->where('id=' . $id)->save($data);
                } else {
                    $data['create_time'] = time();
                    $res = $db->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $db->find($id);
            /*课程*/
            $video_cate_list = D("video_cate")->where(array('status'=>1))->select();

            /*视频*/
            $video_list = D("Video")->where(array('status'=>1))->select();

            /*作业*/
            $task_list = D("subject_task")->where(array('status'=>1))->select();

            $this->assign('vo', $res);
            $this->assign('video_cate_list', $video_cate_list);
            $this->assign('video_list', $video_list);
            $this->assign('task_list', $task_list);
            $this->display();
        }
    }
    /**
     *删除
     */
    public function teaching_video_del()
    {
        $db = M('teaching_video');
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res = $db->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }

    /*师生讨论记录*/
    public function  discussion_record(){
        $page = I('p', 1, 'trim');
        $rp = 8;
        $teaching_video_id = I('get.teaching_video_id');

        $db = M('discussion');

        $where = array();
        if($teaching_video_id){
            $where['teaching_video_id'] =  $teaching_video_id;
        }

        $count = $db->where($where)->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $db->where($where)->order('id desc')->page($page . ',' . $rp)->select();
        foreach ($res as &$value){
            $value['title'] = M('teaching_video')->where(array('id'=>$value['teaching_video_id']))->getField('title');
            $value['nick_name'] = M('member')->where(array('member_id'=>$value['student_id']))->getField('nick_name');
            $value['teacher_name'] = M('teacher')->where(array('teacher_id'=>$value['teacher_id']))->getField('teacher_name');
            $discussion_detail = M('discussion_detail')->where(array('discussion_id'=>$value['id']))->find();
            $value['discussion_detail'] = $discussion_detail;
        }
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();

    }
    /**
     *删除
     */
    public function discussion_del()
    {
        $db = M('discussion');
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res = $db->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            M("discussion_detail")->where(array('discussion_id'=>array('in',$sub_ids)))->delete();
            $this->success('操作成功！');
        }
    }

    /*课程*/
    public function video_cate()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;
        $db = M('video_cate');
        $count = $db->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $db->order('id desc')->page($page . ',' . $rp)->select();
        foreach ($res as &$value){
            $value['cate_name'] = M('grate')->where(array('id'=>$value['cate_id']))->getField('grate_name');
            $value['teacher_name'] = M('teacher')->where(array('teacher_id'=>$value['teacher_id']))->getField('teacher_name');
        }

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function video_cate_edit()
    {
        $db = M('video_cate');
        if (IS_POST && I('form_submit') == 'ok') {
            $data = $db->create();
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = $db->where('id=' . $id)->save($data);
                } else {
                    $res = $db->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $db->find($id);
            /*选择年级*/
            $grate_list = D("grate")->where(array('status'=>1))->select();
            /*视频*/
            $teacher_list = D("teacher")->where(array('status'=>1))->select();

            $this->assign('vo', $res);
            $this->assign('grate_list', $grate_list);
            $this->assign('teacher_list', $teacher_list);
            $this->display();
        }
    }
    /**
     *删除
     */
    public function video_cate_del()
    {
        $db = M('video_cate');
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res = $db->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            M("discussion_detail")->where(array('discussion_id'=>array('in',$sub_ids)))->delete();
            $this->success('操作成功！');
        }
    }
    /**
     * ajax修改类型
     */
    public function ajax_save_data()
    {
        $db = M('teaching_video');
        $data = $db->create();

        $data[I('branch')] = I('value');
        $data['id'] = I('id');

        if ($data) {
            $res = $db->save($data);
        }
        if ($res === false) {
            $this->error('修改失败!');
        } else {
            $this->success('修改成功!');
        }
    }
}