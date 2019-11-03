<?php
namespace Home\Model;
use Think\Model;
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 21:27
 */
class MemberModel extends Model
{


    public function logCheckPhone($phone){
        $where['phone'] = $phone;
        $info = $this->where($where)->find();
        if($info){
            return $info;
        }else{
            return false;
        }
    }

}