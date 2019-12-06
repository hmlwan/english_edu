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

    public function __construct(){

        parent::__construct();
      
        $jwt = new \Common\Lib\Jwt();
        /*获取响应头参数*/
        $token = $_SERVER['HTTP_X_TOKEN'];
        $uid = $jwt->verifyToken($token);
        if(!$token || !$uid){
            $data['status'] = 100;
            $data['info'] = '请先登陆';
            $this->ajaxReturn($data);
        }
        $_SESSION['USER_KEY_ID'] = $uid['login_mem_id'];
        if( empty($_SESSION['USER_KEY_ID'])){
            $data['status'] = 100;
            $data['info'] = '请先登陆';
            $this->ajaxReturn($data);
        }
    }
  
  //上传附件
	public function upload(){

	    $savepath = MODULE_NAME.'/';
	    $field = 'fileupload';

	    $upload_info = $this->upload_file($savepath,$field);


	  //  header('Content-Type:application/json; charset=utf-8');
	  //判断是否kindEditor上传的文件

	  if(I('is_kindEditor')){
	      exit(json_encode(array('error'=>0,'url'=>$upload_info['file_path'])));
	  }else{
	     // exit(json_encode(array('status'=>1,'data'=>array('file_path'=>$upload_info['file_path'],'file_id'=>date('YmdHis')))));
        $data['status'] = 1;
        $data['data'] = array('file_path'=>$upload_info['file_path'],'file_id'=>date('YmdHis'));
         $this->ajaxReturn($data);
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

		if(!$upload_info) { 
			$this->error($upload->getError());
		}else{
			$file_path = 'http://'.$_SERVER['HTTP_HOST'].'/Uploads/'.ltrim($upload_info[$field]['savepath'],'.').$upload_info[$field]['savename'];
			$upload_info[$field]['file_path'] = $file_path;

			return $upload_info[$field];
		}
	}
  
}