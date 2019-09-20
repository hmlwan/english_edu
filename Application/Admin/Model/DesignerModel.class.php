<?php
namespace Admin\Model;
use Think\Model\RelationModel;

class DesignerModel extends RelationModel{
	
	protected $_validate = array(
		array('name','require','请填写设计师名称'),
		array('introduction','require','设计师简介不能为空'), 
		array('contents','require','请填完善详细内容'),
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
		'attachment' => array(
			'mapping_type'  => self::HAS_MANY,    
			'class_name'    => 'news_attachment',    
			'foreign_key'   => 'nid',   
			'mapping_name'  => 'attachment',
		),
	);
}