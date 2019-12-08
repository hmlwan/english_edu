<?php
namespace Admin\Action;
use Think\Action;

class WordLibraryAction extends CommonAction
{


    function __construct()
    {
        parent::__construct();
    }
    /*近义词*/
    public function synonyms()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('word_s')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('word_s')->order('sort asc')->page($page . ',' . $rp)->select();

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
        $db = I('model');
        $model = M($db);
        $index = I('index');

        if (IS_POST && I('form_submit') == 'ok') {

            $data = $model->create();
            $id = I('id');
            if ($data) {
                $data['op_time'] = time();
                if ($id) {
                    $res = $model->where('id=' . $id)->save($data);
                } else {
                    $res = $model->add($data);
                }
            }
            if (false === $res) {
                $this->error('操作失败!', cookie('pageUrl'));
            } else {
                $this->success('操作成功！', cookie('pageUrl'));
            }
        } else {
            $id = I('id');
            $res = $model->find($id);
            $this->assign('vo', $res);
            $this->assign('index', $index);
            $this->assign('model', $db);
            $this->display();

        }
    }
    /**
     *删除
     */
    public function del()
    {
        $db = I('model');
        $model = M($db);
        $ids = I('id');
        $sub_ids = explode(',', $ids);
        $where = array('id' => array('in', $sub_ids));

        $res = $model->where($where)->delete();
        if ($res === false) {
            $this->error('操作失败！');
        } else {
            $this->success('操作成功！');
        }
    }
//    /*中国化解释*/
    public function chinese_exp()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('word_c')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('word_c')->order('sort asc')->page($page . ',' . $rp)->select();

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }


    /*词源*/
    public function etymology()
    {
        $page = I('p', 1, 'trim');
        $rp = 8;

        $count = M('word_e')->count();
        $Page = new \Think\Page($count, $rp);
        $show = $Page->show();
        $res = M('word_e')->order('sort asc')->page($page . ',' . $rp)->select();

        cookie('pageUrl', funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }


    /**
     * ajax修改类型
     */
    public function ajax_save_wl()
    {
        $db = I('model');
        $model = M($db);
        $data = $model->create();

        $data[I('branch')] = I('value');
        $data['id'] = I('id');

        if ($data) {
            $res = $model->save($data);
        }
        if ($res === false) {
            $this->error('修改失败!');
        } else {
            $this->success('修改成功!');
        }
    }
}