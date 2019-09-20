<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class GoodsSpecModel extends RelationModel{


    public function delGoodsSpec($gids){
        return $this->where(array('gid'=>array('in',$gids)))->delete();

    }


}