<?php
namespace Admin\Action;
use Think\Action;

class DisciplineAction extends CommonAction{
    private $type_model;

    function __construct(){
        parent::__construct();
        $this->type_model = D('Discipline');
    }

    public function index(){
        $page = I('p',1,'trim');
        $rp = 8;

        $count =  $this->type_model->count();
        $Page = new \Think\Page($count,$rp);
        $show = $Page->show();
        $res =  $this->type_model->order('id desc')->page($page.','.$rp)->select();
        if($res){
            foreach ($res as $key => $val){
                $res[$key]['grate_name'] = M('Grate')->where(array('sort' => $val['grate_id']))->getField('grate_name');
            }
        }

        cookie('pageUrl',funcurl());
        $this->assign('list',$res);
        $this->assign('page',$show);
        $this->display();
    }

    /**
     * 添加类型
     */
    public function add(){
        if(IS_POST && I('form_submit') == 'ok'){
            $this->save_type();
        }else{
            $list = D('Grate')->order('id desc')->select();
            $this->assign('class_list',$list);
            $this->display();
        }
    }

    /**
     * 修改类型
     */
    public function edit(){
        if(IS_POST && I('form_submit') == 'ok'){
            $this->save_type();
        }else{
            $id = I('id');
            $res = $this->type_model->find($id);

            $this->assign('vo',$res);
            $list = D('Grate')->order('id desc')->select();
            $this->assign('class_list',$list);
            $this->display();

        }
    }

    /**
     *删除类型
     */
    public function del(){
        $ids = I('id');
        $sub_ids = explode(',',$ids);
        $where = array('id'=>array('in',$sub_ids));

        $res = $this->type_model->where($where)->delete();
        if($res === false){
            $this->error('操作失败！');
        } else{
            $this->success('操作成功！');
        }
    }

    /**
     * ajax修改类型
     */
    public function ajax_save_data(){
        $data = $this->type_model->create();

        $data[I('branch')] = I('value');
        $data['id'] = I('id');

        if($data){
            $res = $this->type_model->save($data);
        }
        if($res === false){
            $this->error('修改失败!');
        }else{
            $this->success('修改成功!');
        }
    }

    public function save_type(){
        $data = $this->type_model->create();
        $id = I('id');
        $grate = M('Grate')->where(array('sort'=>$data['grate_id']))->find();
        $data['grate_name'] = $grate['grate_name'];
        if($data){
            if($id){
                $res = $this->type_model->where('id='.$id)->save($data);
            }else{
                $res = $this->type_model->add($data);
            }
        }
        if(false === $res){
            $this->error('操作失败!',cookie('pageUrl'));
        }else{
            $this->success('操作成功！',cookie('pageUrl'));
        }
    }
}