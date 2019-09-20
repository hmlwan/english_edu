<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class GoodsGrouponModel extends RelationModel{


    public function delGoodsGroupon($gids){
        return $this->where(array('gid'=>array('in',$gids)))->delete();

    }


}