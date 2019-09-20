<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/12/21 0021
 * Time: 下午 9:20
 */

namespace Admin\Action;


class AwardAction extends CommonAction
{
    protected $ext_arr = array();
    protected $size_arr = array();
    protected $params = NULL;
    function _initialize() {
        defined('UPLOAD_PATH') or define('UPLOAD_PATH', '');

        $ext_arr = array(
            'image' => explode('|', 'jpg|png|gif'),
            'flash' => array('swf', 'flv'),
            'media' => array('swf', 'flv', 'mp3', 'wav', 'wma', 'wmv', 'mid', 'avi', 'mpg', 'asf', 'rm', 'rmvb'),
            'file' => explode('|','zip|rar|txt|doc|docx')
        );
        $size_arr = array(
            'image' => 2,
            'flash' => 3,
            'media' => 3,
            'file' => 2
        );
    }

    public function index(){

        $user_model = D('Award');
        $page = I('p',1,'trim');
        $rp = 15;
        $username = I('get.username');
        $award_name = I('get.award_name');
        $department_list = I('get.department_list');

        $start_time = I('get.start_time');
        $end_time = I('get.end_time');

        $admin_id = session('admin.admin_id');
        $admin_info = M("Admin")->find($admin_id);
    
        $where_data = array();
        if($award_name){
            $where_data['award_name'] = array(   'like','%'.$award_name.'%');

            $this->assign('award_name',$award_name);
        }
        if($department_list){
            $where_data['department'] = $department_list;
            $this->assign('de_id',$department_list);
        }
        if($start_time && !$end_time){
            $where_data['award_time'] = array('EGT',strtotime($start_time));
            $this->assign('start_time',$start_time);
        }
        if($end_time && !$start_time){
            $where_data['award_time'] = array('ELT',strtotime($end_time));
            $this->assign('end_time',$end_time);
        }
        if($end_time && $start_time){
            $where_data['award_time'] = array(array('EGT',strtotime($start_time)),array('ELT',strtotime($end_time)));
            $this->assign('end_time',$end_time);
            $this->assign('start_time',$start_time);
        }

        $role_id = session('admin.role_id');


        if($role_id == 7 || $role_id == 2){ //教师

//            $map['username'] = session('admin.admin_name');
            if($role_id == 2){
                $role_where['is_self'] = 1;
                $role_where['username'] = session('admin.admin_name');
                $where_data['username'] = session('admin.admin_name');
                $role_where['is_pt'] = 1;
            }else if(($role_id == 7) && $admin_info['department_ids'] != ''){
                if($username){
                    $where_data['username'] = array(
                        'like','%'.$username.'%'
                    );
                    $this->assign('username',$username);
                }else{
                    $map['username'] =  session('admin.admin_name');

                    $map['department'] = array('in',$admin_info['department_ids']);
                    $map['_logic'] = 'OR';
                    $where_data['_complex'] = $map;
                }


                $role_where['is_depart'] = 1;
                $role_where['is_ids'] = 1;
                $role_where['department_ids'] = explode(',',$admin_info['department_ids']);
            }else if($role_id == 7 && $admin_info['department_ids'] == ''){
                $role_where['is_pt'] = 1;
                $role_where['username'] = session('admin.admin_name');
                $where_data['username'] = session('admin.admin_name');
            }



            $this->assign($role_where);
        }else if($role_id == 1){ //管理员
            $role_where['is_depart'] = 1;
            $this->assign($role_where);
        }else{
            if($username){
                $where_data['username'] = array(
                    'like','%'.$username.'%'
                );
                $this->assign('username',$username);
            }
        }

        $department_list = M('Department')->order('sort asc')->select();
        $this->assign('department_list',$department_list);
        $count = $user_model->where($where_data)->count();
        $Page = new \Think\Page($count,$rp);
        $show = $Page->show();
        $res = $user_model->where($where_data)->page($page.','.$rp)->order('award_time desc')->select();

        if($res){
            foreach ($res as $key => $val){
                $res[$key]['_department'] = M('Department')->where(array('sort' =>$val['department']))->getField('department_name');
            }
        }

        $this->assign('page',$show);
        $this->assign('list',$res);
        $this->display();
    }
    /*添加获奖记录*/
    public function add(){
        $award_model = M('Award');
        $award_image_model = M('AwardImages');
        if(IS_POST){

            $data = $award_model->create();
            if($data){
                $data['create_time'] = time();
                $data['award_time'] = strtotime(I('award_time'));
                $data['teacher_charge'] = trim(preg_replace('/，/',',',I('teacher_charge')),',');
                $data['unit'] = trim(preg_replace('/，/',',',I('unit')),',');

                $res = $award_model->add($data);
                if(false !== $res){
                    if(I('carousel_img')){
                        foreach (I('carousel_img') as $key => $val){
                            $arr['award_id'] = $res;
                            $arr['award_image'] = $val['path'];
                            $award_image_model->add($arr);
                        }
                    }
                    $this->ajaxReturn(array('ret'=>1,'msg'=>'操作成功'));
                }else{
                    $this->ajaxReturn(array('ret'=>0,'msg'=>'操作失败'));
                }
            }
        }else{
            $department_list = M('Department')->order('sort asc')->select();
            $this->assign('department_list',$department_list);
            $this->display();
        }
    }
    /*编辑获奖记录*/
    public function edit(){

        $award_model = M('Award');
        $award_image_model = M('AwardImages');
        if(IS_POST){
            $id = I('id');
            $data = $award_model->create();
            $data['award_time'] = strtotime(I('award_time'));
            $data['teacher_charge'] = trim(preg_replace('/，/',',',I('teacher_charge')),',');
            $data['unit'] = trim(preg_replace('/，/',',',I('unit')),',');

            if($data){
                $res = $award_model->where(array('id'=>$id))->save($data);
                if(false !== $res){
                    if(I('carousel_img')){
                        $carousel_img =  I('carousel_img');
                        $award_image = $award_image_model->where(array('award_id'=>$id))->getField('award_image',true);

                        if($award_image){
                            foreach ($award_image as $value){

                                unlink($value);
                            }
                        }
                        $award_image_model->where(array('award_id'=>$id))->delete();
                        $arr = array();
                        foreach ($carousel_img as  $key => $val){
                            $arr['award_id'] = $id;
                            $arr['award_image'] = $val['path'];
                            $award_image_model->add($arr);
                        }
                    }
                    $this->ajaxReturn(array('ret'=>1,'msg'=>'操作成功'));
                }else{
                    $this->ajaxReturn(array('ret'=>0,'msg'=>'操作失败'));
                }
            }

        }else{
            $id = I('get.id');
            $list = $award_model->find($id);

            $this->assign('vo',$list);

            $image_list = $award_image_model->where(array('award_id'=>$id))->select();
            $this->assign('carousel_img',$image_list);
            $department_list = M('Department')->order('sort asc')->select();
            $this->assign('department_list',$department_list);

            $this->display();
        }
    }

    /*删除获奖记录*/
    public function del()
    {
        $award_model = M('Award');
        $award_image_model = M('AwardImages');
        $ids = I('id');
        if($ids){
            $sub_ids = explode(',',$ids);

            $where = array('id'=>array('in',$sub_ids));
            $res = $award_model->where($where)->delete();
            if($res === false){
                $this->error('操作失败！');
            } else{
                $award_where['award_id'] = array('in',$sub_ids);
                $award_image = $award_image_model->where($award_where)->getField('award_image',true);
                if($award_image){
                    foreach ($award_image as $value){
                        unlink($value);
                    }
                }
                $award_image_model->where($award_where)->delete();
                $this->success('操作成功！');
            }
        }
    }

    /*获奖详情*/
    public function detail(){
        $id = I('get.id');

        $list = M('Award')->find($id);
        $list['_department'] = M('Department')->where(array('sort' =>$list['department']))->getField('department_name');
        $award_image = M('AwardImages')->where(array('award_id'=>$id))->select();

        $this->assign('award_image',$award_image);
        $this->assign('vo',$list);
        $this->display();
    }

    //上传附件
    public function upload_attachment(){
//        $savepath = 'Uploads/award/'.date('Y').'/'.date('m').'/'.date('d').'/';

        $dir_name = empty($_GET['dir']) ? 'image' : trim($_GET['dir']);
        $uploadPath = './Uploads/';

        $upload = new \Think\Upload(C('UPLOAD_CONFIG'));
        //实例化上传类
        $upload->maxSize = 2*1048576;// 设置附件上传大小
        $upload->autoSub = true;
        $upload->rootPath = $uploadPath;    //上传文件实际保存路径
        $upload->exts = $this->ext_arr['image']; // 设置附件上传类型
        $info = $upload->upload();

        $file_path ='Uploads/'.ltrim($info['fileupload']['savepath'],'.').$info['fileupload']['savename'];

        $data = array(
            'status'=>1,
            'data'=>array(
                'file_path'=>$file_path,
                'file_id'=>date('YmdHis').rand(10,99),
                'file_val'=> $info['savepath'].$info['savename']
            )
        );
        $this->ajaxReturn($data);
    }
    /*下载单个用户获奖证书*/
    public function importImage(){

        $id = I('get.id');
        $award_image = M('AwardImages')->where(array('award_id'=>$id))->select();
        $award_list = M('Award')->find($id);
        Vendor('PhpZip');
        $phpzip = new \PHPZip();
        $img = array();
        foreach ($award_image as $value){
            $img[] =  __ROOT__.$value['award_image'];
        }
        $file = $img;
        $zipfilename = $award_list['username'].'--'.$award_list['award_name'];
        $phpzip->ZipFile($file,$zipfilename,1);
    }
    /*批量下载证书*/
    public function importAllImage(){
        $id = I('get.id');
        $sub_ids['award_id'] = array('in',$id);
        $award_image = M('AwardImages')->where($sub_ids)->select();

        Vendor('PhpZip');
        $phpzip = new \PHPZip();
        $img = array();
        foreach ($award_image as $value){
            $img[] =  __ROOT__.$value['award_image'];
        }
        $file = $img;
        $zipfilename = '获奖证书';
        $phpzip->ZipFile($file,$zipfilename,1);
    }

    /*导出excel*/
    public function importExcel(){
        $id = I('get.id');

        $sub_ids['id'] = array('in',$id);
        $list = M('Award')->where($sub_ids)->order('id asc')->select();

        $rank_arr = array('镇级','区级','市级','国家级','全球级');
        $form_arr = array('教师个人','教师团体','学生个人','学生团体','学生荣誉');
        $department_arr = array('所属部门','教务处','体卫科艺','政教处','团体','校办','人事','工会','科研');
        foreach ($list as $key => $val){
            $list[$key]['_award_rank'] = $rank_arr[$val['award_rank']];
            $list[$key]['_award_form'] = $form_arr[$val['award_form']];
            $list[$key]['_department'] = $department_arr[$val['department']];
            $list[$key]['_award_time'] = date('Y-m-d',$val['award_time']);
        }

        funcOutgetExcel($list);

    }

    //删除附件
    public function remove_pic(){
        $file_path = I('file_path');
        $this->ajaxReturn(array('status'=>1));
//        if($file_path){
//            $this->ajaxReturn(array('status'=>1));
//
//        }else{
//            $this->ajaxReturn(array('status'=>0));
//        }
    }

}