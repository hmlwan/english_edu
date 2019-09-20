<?php
namespace Admin\Action;
use Think\Action;
use Think\Upload\Driver\Upyun;
use Think\Page;
class CommonAction extends Action {

	public function __construct(){
		parent::__construct();
//		dd($_SERVER);
//		$url = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		if(isset($_SERVER['HTTP_REFERER'])){
			$url = $_SERVER['HTTP_REFERER'];
			session('_JUMPURL_',$url);
		}
        $imgHost = 'http://img.51Admin.com/';
        $this->assign('imgHost',$imgHost);

		$this->check_login();
 		$this->check_auth();
		
	}
	public function check_login(){
	    
		if(!in_array(ACTION_NAME,array('login','logout','makecode','synchronous'))){
			$admin = session('admin');
			if(!($admin['admin_id'] && $admin['admin_name'])){
				$this->redirect('index/login');
				exit;
			}
			$this->assign('admin',$admin);
		}
	}

	/**
	 * 检查权限
	 * @return bool
	 */
	public function check_auth(){
		if(in_array(CONTROLLER_NAME, array('Index'))){
            return true;
        }
		
		$select_menu = D('AdminRole')->check_auth();

		if($select_menu){
			if(I('menu_id')){
				$menu_id = I('menu_id');
				$menu_arr = fn_array_column($select_menu,'menu_name','menu_id');

				$menu_name = isset($menu_arr[$menu_id])?$menu_arr[$menu_id]:'穿形';
				session('menu_name',$menu_name);
			}else{
				$menu_name = session('menu_name');
				$child_name = $select_menu['0']['menu_name'];
				$this->assign('child_name',$child_name);
			}


			$this->assign('menu_name',$menu_name);
		}


		//if(!$select_menu) $this->error('对不起，你没有权限');
	}
	
	public function makecode(){
		$Verify = new \Think\Verify(array('fontSize'=>20,'length'=>4,'fontttf'=>'5.ttf'));
		$Verify->entry();
	}
	/**
	 * 获取操作表名
	 */
	public function getTableName(){

	    if(isset($this->_table) && $this->_table){
	        $name  =   $this->_table;
	    }else{
			$name = CONTROLLER_NAME;
		}
	    return $name;
	}


	public function index() {
	    //列表过滤器，生成查询Map对象
	    $map = $this->_search ();
	    if (method_exists ( $this, '_filter' )) {
	        $this->_filter ( $map );
	    }
	   $name = $this->getTableName();

	    $model = D ($name);

	    if (! empty ( $model )) {
	        $this->_list ( $model, $map );
	    }
        cookie('pageUrl',funcurl());
        $this->display ();
	    return;
	}
	/**
	 +----------------------------------------------------------
	 * 取得操作成功后要返回的URL地址
	 * 默认返回当前模块的默认操作
	 * 可以在action控制器中重载
	 +----------------------------------------------------------
	 * @access public
	 +----------------------------------------------------------
	 * @return string
	 +----------------------------------------------------------
	 * @throws ThinkExecption
	 +----------------------------------------------------------
	 */
	function getReturnUrl() {
	    return __URL__ . '?' . C ( 'VAR_MODULE' ) . '=' . MODULE_NAME . '&' . C ( 'VAR_ACTION' ) . '=' . C ( 'DEFAULT_ACTION' );
	}
	
	/**
	 +----------------------------------------------------------
	 * 根据表单生成查询条件
	 * 进行列表过滤
	 +----------------------------------------------------------
	 * @access protected
	 +----------------------------------------------------------
	 * @param string $name 数据对象名称
	 +----------------------------------------------------------
	 * @return HashMap
	 +----------------------------------------------------------
	 * @throws ThinkExecption
	 +----------------------------------------------------------
	 */
	protected function _search($name = '') {
	    //生成查询条件
	    $name = $this->getTableName();

	    $model = D ( $name );

	    $map = array ();
	    foreach ( $model->getDbFields () as $key => $val ) {
	        if (isset ( $_REQUEST [$val] ) && $_REQUEST [$val] != '') {

	            $map [$val] = array('like','%'.$_REQUEST [$val].'%');
	        }
	    }
	    return $map;
	}
	/**
	 +----------------------------------------------------------
	 * 根据表单生成查询条件
	 * 进行列表过滤
	 +----------------------------------------------------------
	 * @access protected
	 +----------------------------------------------------------
	 * @param Model $model 数据对象
	 * @param HashMap $map 过滤条件
	 * @param string $sortBy 排序
	 * @param boolean $asc 是否正序
	 +----------------------------------------------------------
	 * @return void
	 +----------------------------------------------------------
	 * @throws ThinkExecption
	 +----------------------------------------------------------
	 */
	protected function _list($model, $map, $sortBy = '', $asc = false) {
	    //排序字段 默认为主键名
	    if (isset ( $_REQUEST ['_order'] )) {
	        $order = $_REQUEST ['_order'];
	    } else {
	        $order = ! empty ( $sortBy ) ? $sortBy : $model->getPk ();
	    }
	    //排序方式默认按照倒序排列
	    //接受 sost参数 0 表示倒序 非0都 表示正序
	    if (isset ( $_REQUEST ['_sort'] )) {
	        $sort = $_REQUEST ['_sort'];
	    } else {
	        $sort = $asc ? 'asc' : 'desc';
	    }

	    //取得满足条件的记录数
	    $count = $model->where ( $map )->count ( '*' );
	    if ($count > 0) {
// 	        import ( "@.ORG.Page" );
	        
	        //创建分页对象
	        if (! empty ( $_REQUEST ['listRows'] )) {
	            $listRows = $_REQUEST ['listRows'];
	        } else {
	            $listRows = '10';
	        }
	       
	     //   $p->setConfig('header','<li class="rows">共<b>%TOTAL_ROW%</b>条记录&nbsp;&nbsp;每页<b>%LIST_ROW%</b>条&nbsp;&nbsp;第<b>%NOW_PAGE%</b>页/共<b>%TOTAL_PAGE%</b>页</li>');
	        //分页查询数据
	        $show_page = I('p',1,'trim');

// 	        $voList = $model->where($map)->order( "`" . $order . "` " . $sort)->page($show_page)->select ();
	        $firstRow = ($show_page-1)*$listRows;
 	       $voList = $model->where($map)->order( "`" . $order . "` " . $sort)->limit($firstRow . ',' . $listRows)->select ();
// 	        dd($model->getlastsql());

	        //列表排序显示
	        $sortImg = $sort; //排序图标
	        $sortAlt = $sort == 'desc' ? '升序排列' : '倒序排列'; //排序提示
	        $sort = $sort == 'desc' ? 1 : 0; //排序方式
	        if(IS_AJAX){
	            //$fields = array('id','sort','title','advert_img|show_img','type','status|show_test|show_status');
	            if(method_exists($this, '_fields')){
	                $fields = $this->_fields();
	            }else{
	                $fields = $model->getDbFields();
	            }
	            
    			header('Content-Type:text/xml; charset=utf-8');
    			exit(list_xml_encode(array('page'=>$show_page,'total'=>$count,'data'=>$voList,'fields'=>$fields)));
	        }else{
	            $p = new Page ( $count, $listRows );
	            $p->setConfig('theme','%totalRow% %header% %nowPage%/%totalPage% 页 %upPage% %first%  %prePage%  %linkPage%  %nextPage% %downPage% %end%');
	            //分页跳转的时候保证查询条件
	            foreach ( $map as $key => $val ) {
	                if (! is_array ( $val )) {
	                    $p->parameter .= "$key=" . urlencode ( $val ) . "&";
	                }
	            }
	            //分页显示
	            $page = $p->show ();
	            //模板赋值显示

	            $this->assign ( 'list', $voList );
	            $this->assign ( 'sort', $sort );
	            $this->assign ( 'order', $order );
	            $this->assign ( 'sortImg', $sortImg );
	            $this->assign ( 'sortType', $sortAlt );
	            $this->assign ( "page", $page );
	        }
	      
	    }
		cookie( '_currentUrl_', __SELF__ );
	    return;
	}
	function insert() {
	    //B('FilterString');
	    if(function_exists('getActionName')){
	        $name  =   $this->getActionName();
	    }else{
	        $name = CONTROLLER_NAME;
	    }
	    
	    $model = D ($name);

	    if (false === $model->create ()) {
	        $this->error ( $model->getError () );
	    }
	    //保存当前数据对象
	    $list=$model->add();
	    if ($list!==false) { //保存成功

// 	        $this->assign ( 'jumpUrl', Cookie::get ( '_currentUrl_' ) );
	        $this->set_back('_currentUrl_');
	        $this->success ('新增成功!',U($name."/index"));
	    } else {
	        //失败提示
	        $this->error ('新增失败!');
	    }
	}
	
	public function add() {
	    $this->set_back();
	    $this->display ();
	}
	
	function read() {
	    $this->edit ();
	}
	function edit() {
		$name = $this->getTableName();
	    $model = M ( $name );
	    $id = $_REQUEST [$model->getPk ()];
	    $vo = $model->getById ( $id );
	    $this->assign ( 'vo', $vo );
	    $this->display ();
	}
	
	function update() {
//	    B('FilterString');
	    $name = $this->getTableName();
		$model = D ( $name );

	    if (false === $data = $model->create()) {
	        $this->error ( $model->getError());
	    }
		// 更新数据
		$list = $model->save();

	    if (false !== $list) {
	        //成功提示
	        $this->success ('编辑成功!',U($name."/index"));
	    } else {
	        //错误提示
	        $this->error ('编辑失败!');
	    }

	}
	/**
	 +----------------------------------------------------------
	 * 默认删除操作
	 +----------------------------------------------------------
	 * @access public
	 +----------------------------------------------------------
	 * @return string
	 +----------------------------------------------------------
	 * @throws ThinkExecption
	 +----------------------------------------------------------
	 */
	public function delete() {
	    //删除指定记录
	    $name = $this->getTableName();
	    $model = M ($name);
	    if (! empty ( $model )) {
	        $pk = $model->getPk ();
	        $id = $_REQUEST [$pk];
	        if (isset ( $id )) {
	            $condition = array ($pk => array ('in', explode ( ',', $id ) ) );
	            $list=$model->where ( $condition )->setField ( 'status', - 1 );
	            if ($list!==false) {
	                $this->success ('删除成功！' );
	            } else {
	                $this->error ('删除失败！');
	            }
	        } else {
	            $this->error ( '非法操作' );
	        }
	    }
	}
	/**
	 * 永久删除
	 */
	public function foreverdelete() {
	    //删除指定记录
	    $name = $this->getTableName();
	    $model = D ($name);
	    if (! empty ( $model )) {
	        $pk = $model->getPk ();
	        $id = $_REQUEST [$pk];
	        if (isset ( $id )) {
	            $condition = array ($pk => array ('in', explode ( ',', $id ) ) );
	            if (false !== $model->where ( $condition )->delete ()) {
	                
	                $this->success ('删除成功！');
	            } else {
	                $this->error ('删除失败！');
	            }
	        } else {
	            $this->error ( '非法操作' );
	        }
	    }
	    $this->forward ();
	}
	public function ajax_save_data(){
	    $name = $this->getTableName();
	    $model = D ($name);
	    $data[I('branch')] = I('value');
	    $data[$model->getPk()] = I('id');

		if(false === $data = $model->create($data)){
	        $e = $model->getError();
	        $this->error($e);
	    }
	    $result = $model->save();
	    if($result === false){
	        $this->error('保存失败',cookie('pageUrl'));
	    }else{
	        $this->success('保存成功',cookie('pageUrl'));
	    }
	}
	public function clear() {
	    //删除指定记录
	    $name = $this->getTableName();
	    $model = D ($name);
	    if (! empty ( $model )) {
	        if (false !== $model->where ( 'status=1' )->delete ()) {
	            $this->assign ( "jumpUrl", $this->getReturnUrl () );
	            $this->success ( L ( '_DELETE_SUCCESS_' ) );
	        } else {
	            $this->error ( L ( '_DELETE_FAIL_' ) );
	        }
	    }
	    $this->forward ();
	}
	/**
	 +----------------------------------------------------------
	 * 默认禁用操作
	 *
	 +----------------------------------------------------------
	 * @access public
	 +----------------------------------------------------------
	 * @return string
	 +----------------------------------------------------------
	 * @throws FcsException
	 +----------------------------------------------------------
	 */
	public function forbid() {
	    $name=$this->getActionName();
	    $model = D ($name);
	    $pk = $model->getPk ();
	    $id = $_REQUEST [$pk];
	    $condition = array ($pk => array ('in', $id ) );
	    $list=$model->forbid ( $condition );
	    if ($list!==false) {
	        $this->assign ( "jumpUrl", $this->getReturnUrl () );
	        $this->success ( '状态禁用成功' );
	    } else {
	        $this->error  (  '状态禁用失败！' );
	    }
	}
	
	public function checkPass() {
	    $name=$this->getActionName();
	    $model = D ($name);
	    $pk = $model->getPk ();
	    $id = $_GET [$pk];
	    $condition = array ($pk => array ('in', $id ) );
	    if (false !== $model->checkPass( $condition )) {
	        $this->assign ( "jumpUrl", $this->getReturnUrl () );
	        $this->success ( '状态批准成功！' );
	    } else {
	        $this->error  (  '状态批准失败！' );
	    }
	}
	
	public function recycle() {
	    $name=$this->getActionName();
	    $model = D ($name);
	    $pk = $model->getPk ();
	    $id = $_GET [$pk];
	    $condition = array ($pk => array ('in', $id ) );
	    if (false !== $model->recycle ( $condition )) {
	
	        $this->assign ( "jumpUrl", $this->getReturnUrl () );
	        $this->success ( '状态还原成功！' );
	
	    } else {
	        $this->error   (  '状态还原失败！' );
	    }
	}
	public function recycleBin() {
	    $map = $this->_search ();
	    $map ['status'] = - 1;
	    $name=$this->getActionName();
	    $model = D ($name);
	    if (! empty ( $model )) {
	        $this->_list ( $model, $map );
	    }
	    $this->display ();
	}
	
	/**
	 +----------------------------------------------------------
	 * 默认恢复操作
	 *
	 +----------------------------------------------------------
	 * @access public
	 +----------------------------------------------------------
	 * @return string
	 +----------------------------------------------------------
	 * @throws FcsException
	 +----------------------------------------------------------
	 */
	function resume() {
	    //恢复指定记录
	    $name=$this->getActionName();
	    $model = D ($name);
	    $pk = $model->getPk ();
	    $id = $_GET [$pk];
	    $condition = array ($pk => array ('in', $id ) );
	    if (false !== $model->resume ( $condition )) {
	        $this->assign ( "jumpUrl", $this->getReturnUrl () );
	        $this->success ( '状态恢复成功！' );
	    } else {
	        $this->error ( '状态恢复失败！' );
	    }
	}
	
	
	function saveSort() {
	    $seqNoList = $_POST ['seqNoList'];
	    if (! empty ( $seqNoList )) {
	        //更新数据对象
	        $name=$this->getActionName();
	        $model = D ($name);
	        $col = explode ( ',', $seqNoList );
	        //启动事务
	        $model->startTrans ();
	        foreach ( $col as $val ) {
	            $val = explode ( ':', $val );
	            $model->id = $val [0];
	            $model->sort = $val [1];
	            $result = $model->save ();
	            if (! $result) {
	                break;
	            }
	        }
	        //提交事务
	        $model->commit ();
	        if ($result!==false) {
	            //采用普通方式跳转刷新页面
	            $this->success ( '更新成功' );
	        } else {
	            $this->error ( $model->getError () );
	        }
	    }
	}
	
	/**
	 * 单图上传
	 * 
	 */
	public function upfile(){

	    $cbk = I('cbk');
	 
	    $savepath = CONTROLLER_NAME.'/'.date('Y').'/'.date('m').'/'.date('d').'/';
	    $field = 'image';
		$image_name = $_FILES['image']['name'];
		$image_name_arr = explode('.',$image_name);

	    if(end($image_name_arr)=='apk'){
			$savepath = CONTROLLER_NAME.'/software/';
		}

	    $upload_info = $this->upload_file($savepath,$field);
	    $showJson = array('pic' =>  $upload_info['file_path'],'pic_path'=>'Uploads/'.$upload_info['savepath'].$upload_info['savename']);
	    
		exit('<script>parent.' . $cbk . '(' . json_encode($showJson) . ')</script>');
		
	}
	//设置后退按钮
	protected function set_back($url=''){
		$url = $url ? $url : 'javascript:history.go(-1)';
		$html = '<a class="back" href="'.$url.'" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a>';
		$this->assign('back_htn_html',$html);
	}
	//上传附件
	public function upload(){

	    $savepath = CONTROLLER_NAME.'/'.date('Y').'/'.date('m').'/'.date('d').'/';
	    $field = 'fileupload';

	    $upload_info = $this->upload_file($savepath,$field);
		dd($upload_info);

	  //  header('Content-Type:application/json; charset=utf-8');
	  //判断是否kindEditor上传的文件

	  if(I('is_kindEditor')){
	      exit(json_encode(array('error'=>0,'url'=>$upload_info['file_path'])));
	  }else{
	      exit(json_encode(array('status'=>1,'data'=>array('file_path'=>$upload_info['file_path'],'file_id'=>date('YmdHis')))));
	  }
	}
	//删除上传的文件
	public function remove_pic(){
	    $file_path = I('file_path');
	    $path_info = parse_url($file_path);

	    $upload = new Upyun();
	    $res = $upload->delete($path_info['path']);

	    if($res){
	        exit(json_encode(array('status'=>1)));
	    }else{
	        exit(json_encode(array('status'=>0)));
	    }
	}
	
	//上传文件
	protected function upload_file($savepath,$field){
		$upload = new \Think\Upload(C('UPLOAD_CONFIG'));
		$upload->savePath = $savepath;
//		$upload->subName = $group_id;

		$file_arr = pathinfo($_FILES[$field]['name']);
		$extension = $file_arr['extension'];
		if($extension=='apk'){
			$upload->maxSize = 0;
			$upload->saveName = $file_arr['filename'];
			$upload->replace = 'true';
			$upload->exts = array('apk','gif','jpg','jpeg','png');
		}

		$upload_info = $upload->upload();
        dd($upload_info);
		if(!$upload_info) { 
			$this->error($upload->getError());
		}else{
			$file_path = C('IMG_HTTP').'Uploads/'.ltrim($upload_info[$field]['savepath'],'.').$upload_info[$field]['savename'];
			$upload_info[$field]['file_path'] = $file_path;
			return $upload_info[$field];
		}
	}

	
}