<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class TeacherModel extends RelationModel{
	
    public function getUserData($where,$filed){
        $filed = $filed ? $filed : '*';
        return $this->where($where)->field($filed)->find();
    }

    public function saveUserData($where,$data){
        return $this->where($where)->save($data);
    }

    public function getAllUserData($where,$sort,$filed){
        $filed = $filed ? $filed : '*';
        return $this->where($where)->order($sort)->field($filed)->select();
    }

}