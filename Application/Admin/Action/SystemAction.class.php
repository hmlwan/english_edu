<?php
namespace Admin\Action;
use Think\Action;
use Think\Cache;

class SystemAction extends CommonAction{

	public function __construct()
	{
		parent::__construct();
	}

	public function site_setting(){

        $role_id = session('admin.role_id');
        $role_list = M('AdminRole')->find($role_id);
        $info = M('Admin')->find(session('admin.admin_id'));
        $where['admin_id'] = session('admin.admin_id');

        if($info['role_id'] == 2){ //学生
            $info['_grate_name'] = M('Grate')->where(array('sort'=>$info['grade']))->getField('grate_name');
            $info['_class_name'] = M('Class')->where(array('grate_id'=>$info['grate'],'sort'=>$info['class']))->getField('class_name');
            $info['_role_name'] = M('AdminRole')->where(array('role_id'=>$info['role_id']))->getField('role_name');
        }else if($info['role_id'] == 7){ //教师
            $info['_role_name'] = M('AdminRole')->where(array('role_id'=>$info['role_id']))->getField('role_name');

            $class = M('TeacherClass')->where($where)->select();
            $class_arr = array();
            if($class){
                foreach ($class as $key=>$val){
                    $class = M('Class')->where(array('grate_id'=>$val['grate_id'],'sort'=>$val['class_id']))->getField('class_name');
                    $grate = M('Grate')->where(array('sort'=>$val['grate_id']))->getField('grate_name');;
                    $class_arr[] = $grate.$class;
                }
            }


            $info['classmate'] = implode('，',$class_arr);

            //学科
            $subject_arr = array();
            $subject = M('TeacherDiscipline')->where($where)->select();
            if($subject){
                foreach ($subject as $s_k => $s_val){
                    $subject_res =  M('Discipline')->where(array('grate_id'=>$s_val['grate_id'],'sort'=>$s_val['dis_id']))->find();
                    $subject_arr[] = $subject_res['grate_name'].$subject_res['name'];
                }
            }

            $info['discipline'] = implode('，',$subject_arr);
            //主管部门
            if( $info['department_ids']){
                $department = M('Department')->where(array('sort'=>array('in',$info['department_ids'])))->field('department_name')->select();
                if($department){
                    $info['department'] = implode('，',array_column($department,'department_name'));
                }
            }

        }else{
            $info['_role_name'] = M('AdminRole')->where(array('role_id'=>$info['role_id']))->getField('role_name');

        }

        $this->assign('role_list',$role_list);
        $this->assign('vo',$info);
        $this->assign('subject', '个人信息');
        $this->display();
	}
	/**
	 * 设置微信 短信 支付
	 */
	public function system(){
		if(IS_POST && I('form_submit') == 'ok'){
			$data = D('System')->create();
			$set_id = I('post.id');
			if($data){
				if($set_id){
						$res = D('System')->where('id='.$set_id)->save();
				}else{
					$res = D('System')->add();
				}
			}
			if($res === false){
				$this->error('操作失败！');
			}else{
				$this->success('操作成功!');
			}
		}else{
			$type = I('get.type');
			if($type){
				$result = D('System')->where('type='.$type)->find();
				$this->assign('vo',$result);
			}
			}
		$this->display();
	}

	/**
	 * 清理缓存
	 */
	public function cache(){
		if (IS_POST) {
			$name = array_values(I(''));
			if($name){
				$count = count($name);
				for ($i = 0; $i < $count; $i++) {
					$abs_dir = RUNTIME_PATH;
					$index = $abs_dir . '/index1.html';

					if (file_exists($abs_dir)) {
						unlink($index);
					}
					$abs_dir .= $name[$i];
					$this->dirDel($abs_dir);
				}
				$this->ajaxReturn(array('ret'=> 1, 'msg' => '清理成功！'));
			}else{
				$this->ajaxReturn(array('ret'=> 0, 'msg' => '清理失败！'));
			}
		} else {
			$this->display();
		}
	}

	public function dirDel($path){
		$path = preg_replace('/(\/){2,}|{\\\}{1,}/', '/', $path); //正则匹配多个/ 并用一个'/'代替

		if (is_dir($path)) {          //判断目录是否存在
			if($dh = opendir($path)){      // 判断打开目录是否为空
				while ($file = readdir($dh)) {   // 遍历出目录下文件名
					if ($file != "." && $file != "..") {
						$fullpath = $path . "/" . $file;  // 得到要删除文件的路径
						if (!is_dir($fullpath)) {
							unlink($fullpath);          //删除文件
						} else {
							$this->dirDel($fullpath);   //如果还有目录，回调
						}
					}
				}
			}
		}
	}
}