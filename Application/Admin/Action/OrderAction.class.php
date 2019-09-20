<?php
namespace Admin\Action;

use Think\Action;

class OrderAction extends CommonAction
{
    public $adviser_model;
    public $user_model;
    protected $order_model;

    function __construct()
    {
        parent::__construct();
        $this->order_model = D('Order');
        $this->user_model = D('User');
        $this->adviser_model = D('Adviser');

    }

    public function index()
    {
        $condition = $this->search();
        $order = 'id desc';
        $page = I('p', 1, 'trim');
        $type = I('type');
        $rp = 20;

        $total = $this->order_model->where($condition)->count();
        $Page = new \Think\Page($total, $rp);
        $show = $Page->show();
        $res = $this->order_model->where($condition)->page($page . ',' . $rp)->order($order)->select();

        if($res){
            foreach ($res as $item){
                $uids[] = $item['uid'];
                $aids[] = $item['adviser_id'];
            }
            $user_info  = $this->user_model->where(array('id'=>array('in',implode(',',array_unique($uids)))))->field('id,username')->select();
            $user_str = array();
            foreach($user_info as $user_info_item){
                $user_str[$user_info_item['id']] = $user_info_item['username'];
            }

            $adviser_info = $this->adviser_model->where(array('id'=>array('in',implode(',',array_unique($aids)))))->field('id,username')->select();
            $adviser_str = array();
            foreach ($adviser_info as $adviser_item){
                $adviser_str[$adviser_item['id']] = $adviser_item['username'];
            }
            foreach ($res as $res_key=>$res_item){
                $res[$res_key]['username'] = $user_str[$res_item['uid']];
                $res[$res_key]['adviser_name'] = $adviser_str[$res_item['adviser_id']];
            }
        }
        if($type == 'output'){
            $res = funcOrderStatsNum($res);
            funcOutgetExcel($res);
        }
        cookie('pageUrl',funcurl());
        $this->assign('list', $res);
        $this->assign('page', $show);
        $this->display();
    }

    /**
     * 订单条件查询
     */
    private function search()
    {
        $out_trade_no = I('get.out_trade_no','','trim');
        $username = I('get.username','','trim');
        $adviser_name = I('get.adviser_name','','trim');
        $start_time = $_GET['start_time'];
        $end_time = $_GET['end_time'];
        $order_state = I('order_state');

        if ($out_trade_no) {
            $condition['out_trade_no'] = array('like', '%' . $out_trade_no . '%');
            $this->assign('out_trade_no', $out_trade_no);
        }
        if ($username) {
            $user_where['username'] = array('like', '%' . $username . '%');
            $user_nam = $this->user_model->field('id')->where($user_where)->select();//得到是一个数组
            $user_str = '';
            foreach ($user_nam as $user_val) {
                $user_str .= $user_val['id'] . ',';
            }
            $user_str = rtrim($user_str, ',');//把右边的','去掉
            $condition['uid'] = array('in', $user_str);
            $this->assign('username', $username);
        }
        if ($adviser_name) {
            $adviser_where['username'] = array('like', '%' . $adviser_name . '%');
            $adviser_nam = $this->adviser_model->field('id')->where($adviser_where)->select();//得到是一个数组
            $adviser_str = '';
            foreach ($adviser_nam as $adviser_nam_val) {
                $adviser_str .= $adviser_nam_val['id'] . ',';
            }
            $adviser_arr = rtrim($adviser_str, ',');//把右边的','去掉
            $condition['adviser_id'] = array('in', $adviser_arr);
            $this->assign('adviser_name', $adviser_name);
        }

        if ($start_time && $end_time) {
            $condition['create_time'] = array(array('egt', strtotime($start_time)), array('lt', strtotime($end_time) + 86400));
            $this->assign('start_time', $start_time);
            $this->assign('end_time', $end_time);
        }
        if($order_state){
            $condition['pay_status'] = funcOrderState($order_state)['pay_status'];
            $condition['handle_status'] = funcOrderState($order_state)['handle_status'];
            $condition['order_status'] = funcOrderState($order_state)['order_status'];
            $this->assign('order_state', $order_state);

        }
        return $condition; //注意要返回结果值
    }

    /**
     * 订单详情
     */
    public function detail()
    {
        $order_id = I('id');

        $orderGoods_model = D('OrderGoods');
        $orderExpress_model = D('OrderExpress');
        $Goods_model = D('Goods');
        $order_info = $this->order_model->where('id=' . $order_id)->field('id,address,remark,adviser_remark')->find();
        $address_info = unserialize($order_info['address']);
        $order_info['addr'] = $address_info;
        $this->assign('order_info',$order_info);

        $orderGoods_data = $orderGoods_model->where('order_id='.$order_id)->order('id desc')->select();
        if($orderGoods_data){
            foreach ($orderGoods_data as $orderGoods_key => $orderGoods_item){
                $gids[] = $orderGoods_item['gid'];
                if($orderGoods_item['img']){
                    $orderGoods_data[$orderGoods_key]['img'] = C('IMG_HTTP').$orderGoods_item['img'];
                }
            }
        }
        $goods_where = array(
            'id' => array('in',implode(',',$gids))
        );
        $goods_data = $Goods_model->where($goods_where)->field('id,art_no')->select();
        $goods_list = array();
        foreach ($goods_data as $goods_item){
            $goods_list[$goods_item['id']] = $goods_item['art_no'];
        }
        foreach ($orderGoods_data as $key=>$item){
            $orderGoods_data[$key]['art_no'] = $goods_list[$item['gid']];
        }
        $orderExpress_data = $orderExpress_model->getOrderExpressData('order_id='.$order_id);
        if($orderExpress_data){
            $order_detail = unserialize($orderExpress_data['detail']);
            $orderExpress_arr = array_reverse($order_detail['result']['list']);
        }

        $this->assign('orderExpress',$orderExpress_data);
        $this->assign('item',$order_detail['result']);
        $this->assign('detail',$orderExpress_arr);
        $this->assign('list',$orderGoods_data);
        $this->display();
    }
    /**
     * 填写物流号
     */
    Public function addExpress(){
        $order_id = I('id');
        $express_no = I('express_no');
        $com_no = I('com_no');
        $orderExpress_model = D('OrderExpress');

        $com = array(
            'sf'    =>  '顺丰',
            'sto'   =>  '申通',
            'yt'    =>  '圆通',
            'yd'    =>  '韵达',
            'tt'    =>  '天天',
            'ems'   =>  'EMS',
            'zto'   =>  '中通',
            'ht'    =>  '汇通',
            'qf'    =>  '全峰',
            'db'    =>  '德邦',
            'zt'    =>  '自提/送货'
        );
        $data = array(
            'order_id'    =>    $order_id,
            'com'         =>    $com[$com_no] ,
            'com_no'      =>    $com_no,
            'express_no'  =>    $express_no,
            'status'      =>    2,
            'create_time' =>    time()
        );

        if($order_id){
            $res = $orderExpress_model->addExpressNo($data);
            $data = array(
                'handle_status' => 1
            );
            $this->order_model->saveOrderData('id='.$order_id,$data);
        }
        if($res){
            $this->success('填写成功！',cookie('pageUrl'));
        }else{
            $this->success('填写失败！',cookie('pageUrl'));

        }
    }
}