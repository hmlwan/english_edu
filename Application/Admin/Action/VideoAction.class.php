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
            $value['teacher_name'] = M('teacher')->where(array('teacher_id'=>$value['teacher_id']))->getField('teacher_name');
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
            /*教师*/
            $teacher_list = D("Teacher")->getAllUserData(array('status'=>1));
            /*视频*/
            $video_list = D("Video")->where(array('status'=>1))->select();

            /*作业*/
            $task_list = D("subject_task")->where(array('status'=>1))->select();

            $this->assign('vo', $res);
            $this->assign('teacher_list', $teacher_list);
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

    /**
     * ajax修改类型
     */
    public function ajax_save_data()
    {
        $data = $this->type_model->create();

        $data[I('branch')] = I('value');
        $data['id'] = I('id');

        if ($data) {
            $res = $this->type_model->save($data);
        }
        if ($res === false) {
            $this->error('修改失败!');
        } else {
            $this->success('修改成功!');
        }
    }
}