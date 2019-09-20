<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class AdviserModel extends RelationModel{
	
    public function getAdviserData($where,$filed){
        $filed = $filed ? $filed : 'id,username,avatar,mobile,device_token,token,status';
        return $this->where($where)->field($filed)->find();
    }
    //保存顾问数据
    public function saveAdviserData($where,$data){
        return $this->where($where)->save($data);
    }
    
}