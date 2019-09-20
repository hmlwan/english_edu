<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class GoodsModel extends RelationModel{

    protected $_validate = array(
        array('cid','require','请选择商栏目'),
        array('title','require','请填写商品名称'),
        array('main_img','require','请上传商品主图'),
        array('original_price','require','请填写商品原价'),
        array('current_price','require','请填写商品现价'),
        array('detail','require','请填写商品详情内容'),
    );

    protected $_auto = array(
        array('sort','_auto_sort',1,'callback'),
        array('create_time','time',3,'function'),
    );

    protected function _auto_sort($value){
        $value = $value ? $value : 0;
        return $value;
    }

    protected $_link = array(
        'carousel_img' => array(
            'mapping_type'  => self::HAS_MANY,
            'class_name'    => 'news_attachment',
            'foreign_key'   => 'nid',
            'mapping_name'  => 'carousel_img',
        ),
    );



}