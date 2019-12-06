<?php
namespace Admin\Action;
use Think\Action;

class TaskAction extends CommonAction
{
    private $model;
    private $cate_model;

    function __construct()
    {
        parent::__construct();
        $this->model = M('subject_task');
        $this->cate_model = M('subject_category');
    }

    public function index()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = $this->model->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $this->model->order('subject_task_id desc')->page($page . ',' . $rp)->select();

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

            $data = $this->model->create();
            $data['content'] = I("content",'','');
            $id = I('id');
            if ($data) {
                $data['op_man'] = time();
                if ($id) {
                    $res = $this->model->where('subject_task_id=' . $id)->save($data);
                } else {
                    $data['create_time'] = time();
                    $res = $this->model->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $this->model->find($id);

            $res['content'] = json_decode($res['content'],true);
            $this->assign('vo', $res);
            /*作业类型*/
            $cate_list = M("subject_category")->where(array('status'=>1))->select();

            $this->assign('cate_list', $cate_list);
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
        $where = array('subject_task_id' => array('in', $sub_ids));
		
        $res = $this->model->where($where)->delete();

        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }
    /**
     * ajax修改类型
     */
    public function ajax_save_task()
    {
        $data = $this->model->create();

        $data[I('branch')] = I('value');
        $data['subject_task_id'] = I('id');

        if ($data) {
            $res = $this->model->save($data);
        }
        if ($res === false) {
            $this->error('修改失败!');
        } else {
            $this->success('修改成功!');
        }
    }
    public function category()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = $this->cate_model->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $this->cate_model->order('id desc')->page($page . ',' . $rp)->select();

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function categoryedit()
    {
        if (IS_POST && I('form_submit') == 'ok') {
            $data = $this->cate_model->create();
            $id = I('id');
            if ($data) {
                $data['add_time'] = time();
                if ($id) {
                    $res = $this->cate_model->where('id=' . $id)->save($data);
                } else {
                    $res = $this->cate_model->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $this->cate_model->find($id);
            $this->assign('vo', $res);
            $this->display();

        }
    }

    /**
     *删除
     */
    public function categorydel()
    {
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res = $this->cate_model->where($where)->delete();
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
    public function ajax_save_cate()
    {
        $data = $this->cate_model->create();

        $data[I('branch')] = I('value');
        $data['id'] = I('id');

        if ($data) {
            $res = $this->cate_model->save($data);
        }
        if ($res === false) {
            $this->error('修改失败!');
        } else {
            $this->success('修改成功!');
        }
    }
    /*批改作业记录*/
    public function correct_record()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('teacher_correct_task')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('teacher_correct_task')->order('id desc')->page($page . ',' . $rp)->select();
        foreach ($res as &$value){
            $value['teaching_video_title'] = M('teaching_video')->where(array('id'=>$value['teaching_video_id']))->getField('title');
            $value['stu_name'] = M('member')->where(array('member_id'=> $value['member_id']))->getField('nick_name');
            $value['tea_name'] = M('teacher')->where(array('teacher_id'=> $value['member_id']))->getField('teacher_id');
        }

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }
   /**
     *删除
     */
    public function correct_record_del()
    {
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));
		
        $res = M('teacher_correct_task')->where($where)->delete();

        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }
    /*评语详情*/
    public function view(){
        $id = I('id');

        $info = M('teacher_correct_task')->find($id);
        $content = json_decode($info['content'],true);
        $this->assign('content', $content);
        $this->display();
    }


}