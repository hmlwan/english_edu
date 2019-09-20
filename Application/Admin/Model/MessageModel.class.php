<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class MessageModel extends RelationModel{

    //获取审核信息
    public function getMessageData($where,$filed){
        $filed = $filed ? $filed : 'id,title,contents,create_time,type,is_read,adviser_id';
        return $this->where($where)->field($filed)->find();
    }

}