<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class GoodsStyleModel extends RelationModel{


    public function delGoodsStyle($gids){
        return $this->where(array('gid'=>array('in',$gids)))->delete();

    }
}