<?php
namespace Admin\Model;
use Think\Model;

class GrateModel extends Model{
	

    public function getAllData($where,$sort,$filed){
        $filed = $filed ? $filed : '*';
        return $this->where($where)->order($sort)->field($filed)->find();
    }
    public function getInfoById($id){

        $where = array();
        if($id){
            $where['id'] = $id;
        }
        $list = $this->where($where)->find();
        return $list;

    }

}