<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class UserModel extends RelationModel{
	
    public function getUserData($where,$filed){
        $filed = $filed ? $filed : 'id,username,avatar,mobile,device_token,token,status';
        return $this->where($where)->field($filed)->find();
    }
    //保存顾问数据
    public function saveUserData($where,$data){
        return $this->where($where)->save($data);
    }
    
}