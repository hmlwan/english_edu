<?php
/**
 * Created by PhpStorm.
 * User: v_huizzeng
 * Date: 2019/11/3
 * Time: 21:08
 */

namespace Home\Action;
use Think\Action;

class CommonAction extends Action
{

    public function _initialize(){

        parent::_initialize();

        if(empty($_SESSION['USER_KEY_ID'])){
            $data['status'] = 2;
            $data['info'] = '请先登陆';
            $this->ajaxReturn($data);
        }


    }







}