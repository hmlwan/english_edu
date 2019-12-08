<?php
namespace Admin\Action;
use Think\Action;

class WordAction extends CommonAction
{



    function __construct()
    {
        parent::__construct();

    }

    public function index()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = $this->model->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = $this->model->order('id desc')->page($page . ',' . $rp)->select();

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
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = $this->model->where('id=' . $id)->save($data);
                } else {
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
        $where = array('id' => array('in', $sub_ids));

        $res = $this->model->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }
    public function type()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('word_type')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('word_type')->order('id asc')->page($page . ',' . $rp)->select();

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function type_edit()
    {

        if (IS_POST && I('form_submit') == 'ok') {

            $data = M('word_type')->create();
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = M('word_type')->where('id=' . $id)->save($data);
                } else {
                    $res = M('word_type')->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = M('word_type')->find($id);
            $this->assign('vo', $res);
            $this->display();

        }
    }
    public function type_del()
    {
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res =  M('word_type')->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }

    public function category()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('word_category')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('word_category')->order('sort asc')->page($page . ',' . $rp)->select();
        foreach ($res as &$v){
            $v[''] = M('word_type')->where(array('id'=>$v['word_type_id']))->getField('name');
        }
        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 修改
     */
    public function category_edit()
    {

        if (IS_POST && I('form_submit') == 'ok') {

            $data = M('word_category')->create();
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = M('word_category')->where('id=' . $id)->save($data);
                } else {
                    $res = M('word_category')->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = M('word_category')->find($id);

            $type_list = M('word_type')->select();

            $this->assign('type_list', $type_list);
            $this->assign('vo', $res);
            $this->display();

        }
    }
    public function  category_del()
    {
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res =  M('word_category')->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }
    /**
     * ajax修改类型
     */
    public function ajax_save_typecategory()
    {
        $db = M('word_category');
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