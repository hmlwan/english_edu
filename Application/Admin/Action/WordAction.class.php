<?php
namespace Admin\Action;
use Think\Action;

class WordAction extends CommonAction
{
    private $model;


    function __construct()
    {
        parent::__construct();
        $this->model = M('word');
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


}