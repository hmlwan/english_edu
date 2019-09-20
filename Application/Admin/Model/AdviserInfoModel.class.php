<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class AdviserInfoModel extends RelationModel{

    //获取顾问数据
    public function getAdviserInfo($where,$filed){
        $filed = $filed ? $filed : 'id,adviser_id,real_name,indroduce,card_code,card_pic,area,address,shop_phone,case_pic';
        return $this->where($where)->field($filed)->find();
    }
}