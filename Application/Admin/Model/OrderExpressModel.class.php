<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class OrderExpressModel extends RelationModel{

    //获取订单物流数据
    public function getOrderExpressData($where){
        $field = 'id,order_id,com,com_no,status,express_no,detail,create_time';
        return $this->where($where)->field($field)->find();
    }
    //存入物流号
    public function addExpressNo($data){
        return $this->add($data);
    }
}
