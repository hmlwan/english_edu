<?php
namespace Admin\Action;
use Think\Action;
class DataAction extends CommonAction
{

    protected $user_model;
    private  $order_model;
    private  $orderGoods_model;
    private  $time;

    public function __construct()
    {
        parent::__construct();
        $this->user_model = D('User');
        $this->order_model = D('Order');
        $this->orderGoods_model = D('OrderGoods');
        $this->time = 3600;
    }
    //用户注册数量
    public function userRegisterNum(){
        $this->display('userRegister');
    }
    //商品销量
    public function goodSale(){
        $this->display('goodSale');
    }
    //订单销售数量，金额
    public function orderSale(){
        $this->display('orderSale');
    }
    public function searchAdv(){
        $adv_name = I('adv_name');
        $adviser_model = D('Adviser');

        $adv_where = array(
            'username'=>array('like','%'.$adv_name.'%')
        );
        $adv_data = $adviser_model->where($adv_where)->field('id,username')->order('id desc')->select();
        $arr = array();
        foreach ($adv_data as $adv_data_key=>$adv_data_item){
            $arr[] = $adv_data_item['id'].':'.$adv_data_item['username'];
        }
        if($arr){
            $this->ajaxReturn($arr);
        }else{
            $this->ajaxReturn(array());
        }
    }
    public function search($start_time,$end_time){
        if(strtotime($start_time)>strtotime($end_time)){
            $this->ajaxReturn(array('ret'=>0,'开始时间不能大于结束时间！'));
        }
        if(funcgetDate($start_time) == funcgetDate($end_time)){
            $con = array(
                'format'=> '%H:00',
                'type'  => 1
            );
        }else{
            $con = array(
                'format'=> '%m-%d',
                'type'  => 0
            );
        }
        return $con;
    }

    /**
     * 用户注册数量统计
     SELECT u.hour,
        COUNT(*)
        FROM (SELECT date_format(from_unixtime(reg_time),'%k') AS hour
        FROM cx_user
        WHERE date_format(from_unixtime(reg_time),'%Y-%m-%d') = date_format(now(),'%Y-%m-%d') ) u
        GROUP BY u.hour;
     */
    public function userRegisterData(){

        //七天的数据  "SELECT * FROM cx_user  WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(from_unixtime(reg_time));
        ##SELECT DATE(from_unixtime(reg_time)) reg_time,COUNT(*) FROM cx_user WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= DATE(from_unixtime(reg_time)) GROUP BY reg_time";
        $start_time = I('start_time').' 00:00:00';
        $end_time = I('end_time').' 23:59:59';
        $adv_id = I('adv_id');

        $condition = 'user'.strtotime($start_time).strtotime($end_time).$adv_id;
        $userRegisterData = S($condition);
        if($userRegisterData){
            $this->ajaxReturn($userRegisterData);
        }else {
            $con = $this->search($start_time,$end_time);
            $user_model = D("User");

            $where = "reg_time >= unix_timestamp('" . $start_time . "') AND reg_time <=  unix_timestamp('" . $end_time . "')";
            if ($adv_id) {
                $where .= " AND adviser_id=" . $adv_id;
            }
            $data = array(
                'model' => $user_model,
                'field' => 'reg_time',
                'where' => $where,
                'param1' => 'COUNT(*) num',
                'format' => $con['format'],
                'model_name' => 'cx_user'
            );

            $res = $this->getSearchData($data);

            $arr = funcgetDateArr($res, $start_time, $end_time, $con['type']);
            $data_time = $data_num = array();
            foreach ($arr as $key => $item) {
                if ($item[1]) {
                    $data_num[] = $item[1]['num'];
                } else {
                    $data_num[] = 0;
                }
                $data_time[] = $item[0];
            }
            $result['data_time'] = $data_time;
            $result['data_num'] = $data_num;
            S($condition, $result, $this->time);
            if ($result) {
                $this->ajaxReturn($result);
            }else {
                $this->ajaxReturn($arr);
            }
        }
    }

    /**
     * 订单金额，数量统计
     * $this->field('username,max(score)')->group('user_id')->having('count(test_time)>3')->select();
     */
    public function orderSaleData(){

        $order_model = D("Order");
        $start_time = I('start_time').' 00:00:00';
        $end_time = I('end_time').' 23:59:59';
        $adv_id = I('adv_id');

        $adv = '';
        if($adv_id){
            $adv = 'adv'.$adv_id;
        }
        $condition = 'order'.strtotime($start_time).strtotime($end_time).$adv;
        $orderSaleData = S($condition);
        if($orderSaleData){
            $this->ajaxReturn($orderSaleData);
        }else{
            $con = $this->search($start_time,$end_time);
            $where = "create_time >= unix_timestamp('".$start_time."') AND create_time <=  unix_timestamp('".$end_time."') 
             AND pay_status = 1 AND order_status != 3 AND order_status != 2";
            if($adv_id){
                $where .= " AND adviser_id=".$adv_id;
            }
            //订单消费金额，订单消费数量
            $data = array(
                'model' => $order_model,
                'field' => 'create_time',
                'where' => $where,
                'param1' => 'sum(money) money,COUNT(*) num',
                'format'=> $con['format'],
                'model_name' => 'cx_order',
                'param2' => 'money'
            );

            $res = $this->getSearchData($data);

            $arr = funcgetDateArr($res,$start_time,$end_time,$con['type']);

            $data_time = $data_num = $data_money= array();
            foreach ($arr as $key=>$item){
                if($item[1]){
                    $data_num[] = $item[1]['num'];
                    $data_money[] = $item[1]['money'];
                }else{
                    $data_num[] = 0;
                    $data_money[] = 0;
                }
                $data_time[] = $item[0];
            }
            $result['data_time'] = $data_time;
            $result['data_num'] = $data_num;
            $result['data_money'] = $data_money;

            S($condition,$result,$this->time);
            if($result){
                $this->ajaxReturn($result);
            }else{
                $this->ajaxReturn($arr);
            }
        }
    }
    /**
     * 单品销售统计
     */
    public function goodSaleData(){
        $order_model = D("Order");
        $orderGoods_model = D('OrderGoods');
        $start_time = I('start_time').' 00:00:00';
        $end_time = I('end_time').' 23:59:59';
        $adv_id = I('adv_id');

        $condition = 'good'.strtotime($start_time).strtotime($end_time).$adv_id;
        $goodSaleData = S($condition);
        if($goodSaleData){
            $this->ajaxReturn($goodSaleData);
        }else{
            $con = $this->search($start_time,$end_time);
            $where = "create_time >= unix_timestamp('".$start_time."') AND create_time <=  unix_timestamp('".$end_time."') 
            AND pay_status = 1 AND order_status != 3 AND order_status != 2";
            if($adv_id){
                $where .= " AND adviser_id=".$adv_id;
            }
            //订单消费金额，订单消费数量
            $data = array(
                'model' => $order_model,
                'field' => 'create_time',
                'where' => $where,
                'param1' => 'u.id',
                'format'=> $con['format'],
                'model_name' => 'cx_order',
                'param2' => 'id'
            );
            $res = $this->getSearchData($data);
            $arr = funcgetDateArr($res,$start_time,$end_time,$con['type']);
            $data_num = $data_title = $res_arr = $gid_arr = $gid_str = array();
            foreach ($arr as $arr_key => $arr_item){
                $res_arr[] = $arr_item[1]['id'];
            }

            $order_where = array(
                'order_id' => array('in',implode(',',array_filter($res_arr)))
            );
            //前十的销量排名

            $orderGoods = $orderGoods_model->where($order_where)->field('order_id,gid,title,sum(num) num')
                ->group('gid')->limit(10)->order('num desc')->select();

            foreach ($orderGoods as $str_key => $str_item ){
                $data_num[] = $str_item['num'];
                $data_title[] = $str_item['title'];
            }
            $result['data_num'] = $data_num;
            $result['data_title'] = $data_title;
            S($condition,$result,$this->time);
            if($result){
                $this->ajaxReturn($result);
            }else{
                $this->ajaxReturn(array());
            }
        }
    }

    /**
     * @param $model
     * @param $field
     * @param $format查询数据
     * @param $where
     * @return mixed
     */
    public function getSearchData($data){

        $model = $data['model'];
        $field = $data['field'];
        $where = $data['where'];
        $param1 = $data['param1'];
        $format = $data['format'];
        $model_name = $data['model_name'];
        $param2 = $data['param2'] ? ','.$data['param2'] : '';

        $data = $model->query("SELECT u.time,
				".$param1."
		FROM (SELECT date_format(from_unixtime(".$field."),'".$format."') AS time".$param2."
						FROM ".$model_name."
					 WHERE ".$where.") u
                GROUP BY u.time");
        return $data;
    }
}
	
