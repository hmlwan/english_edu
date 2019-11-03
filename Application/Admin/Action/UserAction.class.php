<?php
namespace Admin\Action;
use Think\Action;
use Think\Think;
use Think\Upload;

class UserAction extends CommonAction {

    public function __construct(){
        parent::__construct();
    }
    
    public function _filter(&$map)
    {
        $map['cate_type'] = $this->user_type;
    }

    /**
     * 用户详情
     */
    public function userDetail(){
        $id = I("get.id");
        $userInfo_model = D('UserInfo');
        $user_model = D('User');

        $userRes = $userInfo_model->where('uid='.$id)->find();
        if($userRes) {
            $userRes['life_pic'] = funcCreatPic($userRes['life_pic']);
        }
        $user_data = $user_model->getUserData('id='.$id,'username,mobile');
        $userRes['username'] = $user_data['username'];
        $userRes['mobile'] = $user_data['mobile'];
        $this->assign('vo',$userRes);
        $this->display();
    }
    //学生信息
    public function student(){

        $user_model = D('Member');
        $page = I('p',1,'trim');
        $rp = 10;
        $username = I('phone');


        $where_data = array();
        if($username){
            $where_data['phone'] = array(
                'like','%'.$username.'%'
            );
            $this->assign('phone',$username);
        }
        $count = $user_model->where($where_data)->count();
        $Page = new \Think\Page($count,$rp);
        $show = $Page->show();
        $res = $user_model->where($where_data)->page($page.','.$rp)->order('member_id asc')->select();



        $this->assign('page',$show);
        $this->assign('list',$res);
        $this->display();
    }
    /**
     * 老师信息
     */
    public function teacher(){

        $user_model = D('Teacher');
        $page = I('p',1,'trim');
        $rp = 10;
        $username = I('username');
        $teacher_name = I('teacher_name');

        $where_data = array();
        if($username){
            $where_data['username'] = array(
                'like','%'.$username.'%'
            );
            $this->assign('username',$username);
        }
        if($teacher_name){
            $where_data['teacher_name'] = array(
                'like','%'.$teacher_name.'%'
            );
            $this->assign('teacher_name',$teacher_name);
        }
        $count = $user_model->where($where_data)->count();
        $Page = new \Think\Page($count,$rp);
        $show = $Page->show();
        $res = $user_model->where($where_data)->page($page.','.$rp)->order('teacher_id asc')->select();
        foreach ($res as &$val){
            $val['grate_name'] = M("grate")->where(array('id'=>$val['grate_id']))->getField('grate_name');
        }

        $this->assign('page',$show);
        $this->assign('list',$res);
        $this->display();
    }
    /*导入学生数据*/
    public function importData(){

        $filename = $_FILES['file_stu']['tmp_name'];
        if(!$filename){
            $this->ajaxReturn(array('ret'=>0,'msg'=>'请选择文件（xls格式）'));
        }
        Vendor('phpexcel.PHPExcel.IOFactory');
        $PHPExcel = new \PHPExcel();
        $inputFileType = 'Excel5';//写入有用
        $objPHPExcel = \PHPExcel_IOFactory::load($filename);
        
        $sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);

        if(empty ($sheetData))
        { 
           $this->ajaxReturn(array('ret'=>0,'msg'=>'请选择文件（xls,csv格式）'));
        }
        $admin_model = D('Admin');
        $data_arr = array();
        foreach ($sheetData as  $val){
            $data_arr[] = $val;
        }

        $data = array();
        if(I('post._type') == 1){ //导入学生是数据
            foreach ($data_arr as  $key => $data_val){
                if($key > 0){
                    $data['admin_name'] = $data_val['A'];
                    $data['admin_password'] = md5($data_val['B']);
                    $data['status'] = 1;
                    $data['add_time'] = time();
                    $data['grade'] = $data_val['C'];
                    $data['class'] = $data_val['D'];
                    $data['role_id'] = $data_val['E'];
                    $admin_model->add($data);
                }
            }
        }else{  //导入老师数据
            foreach ($data_arr as  $k => $val){
                if($k > 0){
                    $data['admin_name'] = $val['A'];
                    $data['admin_password'] = md5($val['B']);
                    $data['status'] = 1;
                    $data['add_time'] = time();
                    $data['role_id'] = $val['E'];
                    $data['grade'] = $val['C'];
                    $data['phone'] = $val['F'];
                    $data['department_ids'] = trim(preg_replace('/，/',',',$val['H']),','); //部门主管ids
                    $res = $admin_model->add($data);
                    if(false !== $res){
                        $D = trim(preg_replace('/，/',',',$val['D']),',');
                        $class_id_arr = explode(',',$D);
                        $class_str = array();
                        foreach ($class_id_arr as $c_k => $c_v){
                            $class_str[$c_k]['class_id'] = $c_v;
                            $class_str[$c_k]['grate_id'] = $val['C'];
                            $class_str[$c_k]['admin_id'] = $res;
                        }
                        M('TeacherClass')->addAll($class_str); //班级

                        $G = trim(preg_replace('/，/',',',$val['G']),',');
                        $dis_id_arr = explode(',',$G);
                        $dis_str = array();
                        foreach ($dis_id_arr as $d_k => $d_v){
                            $dis_str[$d_k]['dis_id'] = $d_v;
                            $dis_str[$d_k]['grate_id'] = $val['C'];
                            $dis_str[$d_k]['admin_id'] = $res;
                        }
                        M('TeacherDiscipline')->addAll($dis_str); //学科
                    }
                }
            }
        }
        $this->ajaxReturn(array('ret'=>1,'msg'=>'导入成功'));
    }

    public function userEdit(){

        $class_model = M('Class');
        $grate_model = M('Grate');
        $admin_model = M("Admin");
        if(IS_POST){

            $id = I('id');
            $data = $admin_model->create();
            if(I('post.admin_password')){
                $data['admin_password'] = md5(I('post.admin_password'));
            }
           
            if($data){
                $res = $admin_model->where(array('admin_id'=>$id))->save($data);
                if(false !== $res){
                    $this->ajaxReturn(array('ret'=>1,'msg'=>'操作成功'));
                }else{
                    $this->ajaxReturn(array('ret'=>0,'msg'=>'操作失败'));
                }
            }

        }else{
            $id = I('get.id');
            $list = $admin_model->find($id);
            $this->assign('vo',$list);

            $grate_list = $grate_model->select();
            $class_list = $class_model->where(array('grate_id'=>$list['grade']))->select();
            $this->assign('class_list',$class_list);
            $this->assign('grate_list',$grate_list);
            $this->display();
        }
    }


    public function userdel()
    {
        $model = M('member');
        $ids = I('id');
        if ($ids) {
            $sub_ids = explode(',', $ids);
            $where = array('member_id' => array('in', $sub_ids));
            $res = $model->where($where)->delete();
            if ($res === false) {
                $this->error('操作失败！');
            } else {
                $this->success('操作成功！');
            }
        }
    }

    public function teacherEdit(){

        $model = D('Teacher');
        $grate_model = M('Grate');
        if(IS_POST){
            $id = I('id');
            $data = $model->create();
            if(I('post.pwd')){
                $data['pwd'] = md5(I('post.pwd'));
            }else{
                $data['pwd'] = I('post.repwd');
            }
            if($data){
                if($id){
                    $res = $model->where(array('$id'=>$id))->save($data);
                }else{
                    $data['add_time'] = time();
                    $res = $model->add();
                }
                if(false !== $res){
                    $this->ajaxReturn(array('ret'=>1,'msg'=>'操作成功'));
                }else{
                    $this->ajaxReturn(array('ret'=>0,'msg'=>'操作失败'));
                }
            }
        }else{
            $id = I('get.id');
            $list = $model->find($id);

            $this->assign('vo',$list);
            $assign['grate_list'] = $grate_model->select();
            $this->assign($assign);
            $this->display();
        }
    }


    public function teacherdel()
    {
        $model = M('teacher');
        $ids = I('id');
        if ($ids) {
            $sub_ids = explode(',', $ids);
            $where = array('teacher_id' => array('in', $sub_ids));
            $res = $model->where($where)->delete();
            if ($res === false) {
                $this->error('操作失败！');
            } else {
                $this->success('操作成功！');
            }
        }
    }
    /*------------------任教管理----------*/

    public function getclass(){
        $grate_id = I('post.grate_id');
        $class_model = M('Class');
        $class_list = $class_model->where(array('grate_id'=>$grate_id))->select();
        $this->ajaxReturn($class_list);
    }


    /*--------------------------------学科管理-----------------------*/
    public function subjectEdit(){
        $class_model = M('Class');
        $grate_model = M('Grate');
        $admin_model = M("Admin");
        $department_model = M("Department");
        if(IS_POST){
            $id = I('id');
            $data = $admin_model->create();
            $data['admin_password'] = md5(I('post.admin_password'));
            $data['department_ids'] = implode(',',I('post.department'));
            if($data){
                $res = $admin_model->where(array('admin_id'=>$id))->save($data);
                if(false !== $res){
                    $this->ajaxReturn(array('ret'=>1,'msg'=>'操作成功'));
                }else{
                    $this->ajaxReturn(array('ret'=>0,'msg'=>'操作失败'));
                }
            }

        }else{
            $id = I('get.id');
            $list = $admin_model->find($id);
            $list['_department_ids'] = explode(',',$list['department_ids']);
            $this->assign('vo',$list);

            $assign['class_list'] = $class_model->select();
            $assign['grate_list'] = $grate_model->select();
            $assign['department_list'] = $department_model->select();
            $this->assign($assign);
            $this->display();
        }

    }
    public function subjectDel(){
        $model = M('Admin');
        $ids = I('id');
        if ($ids) {
            $sub_ids = explode(',', $ids);
            $where = array('admin_id' => array('in', $sub_ids));
            $res = $model->where($where)->delete();
            if ($res === false) {
                $this->error('操作失败！');
            } else {
                $this->success('操作成功！');
            }
        }
    }

    /*----------------------------------------------------------------------------------*/


    /**
     * 会员等级管理
     */
    public function userRank(){
        $userRank_model = D('UserRank');
        $page = I('p',1,'trim');
        $rp = 15;

        $count = $userRank_model->count();
        $Page = new \Think\Page($count,$rp);
        $show = $Page->show();
        $res = $userRank_model->order('id desc')->page($page . ','. $rp)->select();

        $this->assign('list',$res);
        $this->assign('page',$show);
        $this->display();
    }

    /**
     * 修改密码
     */
    public function modifyPwd(){
        $data = I();
        $admin_model = D('Admin');
        $data_oldpassword = $data['oldpassword'];
        $where = array('admin_id'=>$_SESSION['admin']['admin_id'],'admin_password'=>md5($data_oldpassword));

        $admin_res =  $admin_model->where($where)->find();
        if(!$admin_res){
            $this->ajaxReturn(array('ret'=>0,'msg'=>"旧密码错误或不存在！"));

        }

        $data_newpassword = $data['newpassword'];
        $data_pass['admin_password'] = md5($data_newpassword);

        $res = $admin_model->where($where)->save($data_pass);

        if($res !== false){
            $this->ajaxReturn(array('ret'=>1,'msg'=>'修改成功！'));
        }else{
            $this->ajaxReturn(array('ret'=>0,'msg'=>'修改失败！'));
        }
    }
/*    /**
     * 修改上传头像
     */
    public function uploadAvatar(){
        $savepath = CONTROLLER_NAME.'/'.date('Y').'/'.date('m').'/'.date('d').'/';
        $upload_res = $this->upload_file($savepath,'avatar');
        $where['admin_id'] = $_SESSION['admin']['admin_id'];

        if($upload_res){
            $admin_avatar = $upload_res['file_path'];
            $admin_res = M('admin')->where($where)->save(array('admin_avatar'=>$admin_avatar));
            $res['data'] = array('admin_avatar'=>$admin_avatar);
            $res["error"] = "";       //成功信息
            $res["msg"] = "上传成功";  //提示信息
        }else{
            $res["error"] = "error";  //错误信息
            $res["msg"] = "上传失败";  //提示信息
        }
        exit(json_encode($res));
    }




}