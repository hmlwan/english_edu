<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<link rel="stylesheet" type="text/css" href="/Public/Common/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/index.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/pagination.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/font/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Common/css/perfect-scrollbar.min.css" />
<style>html, body { overflow: visible;}</style>
<script>

var ADMIN_TEMPLATES_URL = 'Admin';
var LOADING_IMAGE = "/Public/Admin/images/loading.gif";
var ADMIN_RESOURCE_URL = '/Public/Admin';
var SITEURL = 'http://'+window.location.host;
var ACTION_NAME  = '<?php echo ACTION_NAME;?>';
var CONTROLLER_NAME	=	'<?php echo CONTROLLER_NAME;?>';

</script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.edit.js"></script>
<script type="text/javascript" src="/Public/Common/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/Public/Common/jquery-ui/zh-CN.js"></script>
<script type="text/javascript" src="/Public/Admin/js/uploadImg.js"></script>
<script type="text/javascript" src="/Public/Admin/js/flexigrid.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.validation.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.mousewheel.js"></script>
<script type="text/javascript" src="/Public/Common/plugin/layer/layer.js"></script>
<script type="text/javascript" src="/Public/Admin/js/common.js"></script>
<script type="text/javascript" src="/Public/Admin/js/admin.js"></script>


</head>
<body style="background-color: #FFF; overflow: auto;">

	<script type="text/javascript" src="/Public/Common/js/jquery/jquery.picTip.js"></script>
	<script type="text/javascript" src="/Public/Common/js/jquery/jquery.form.js"></script>
	<div id="append_parent"></div>
	<div id="ajaxwaitid"></div>
	<div class="page" style="padding:30px 1% 0 1%;">
		<div class="fixed-bar">
			<div class="item-title">
				<?php if(($back) != "0"): ?><a class="back" href="<?php echo U(CONTROLLER_NAME.'/index');?>" title="返回列表"><i class="fa fa-arrow-circle-o-left"></i></a><?php endif; ?>
				<div class="subject">
					<h3>教师管理</h3>
					<h5>教师信息的添加、修改和删除</h5>
				</div>
			</div>
		</div>
		<div class="mDiv">
				<div class="sDiv">
					<div class="sDiv2">
					<form action="<?php echo fn_getUrl();?>" method='post'>
						<input type="hidden" name="m" value="Admin">
						<input type="hidden" name="c" value="User">
						<input type="hidden" name="a" value="teacher">
						教师姓名搜索：
						<input type="text" placeholder="搜索相关数据..." class="qsbox" name="username" size="30" value="<?php echo ($username); ?>">
						手机号搜索：
						<input type="text" placeholder="搜索相关数据..." class="qsbox" name="phone" size="30" value="<?php echo ($phone); ?>">
						<input type="submit" value="搜索" class="btn">

					</form>
					</div>
				</div>
		</div>
		<table class="flex-table">
			<thead>
			<tr>
				<th width="24" align="center" class="sign"><i class="ico-check"></i></th>
				<th width="300" class="handle" align="center">操作</th>
				<th width="80" align="center">用户编号</th>
				<th width="120" align="center">教师姓名</th>
				<th width="150" align="center">注册时间</th>
				<th width="150" align="center">登录时间</th>
				<th width="100" align="center">登录次数</th>
				<th></th>
			</tr>
			</thead>
			<tbody>
			<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr data-id="<?php echo ($vo["admin_id"]); ?>">
					<td class="sign"><i class="ico-check"></i></td>
					<td class="handle">
						<a class="btn red" href="javascript:void(0);" onclick="fg_del(<?php echo ($vo["admin_id"]); ?>);"><i class="fa fa-trash-o"></i>删除</a>
						<a class="btn blue" href="<?php echo U('teacherEdit',array('id'=>$vo['admin_id']));?>"><i class="fa fa-pencil-square-o"></i>编辑</a>
						<a class="btn blue" href="<?php echo U(CONTROLLER_NAME.'/teacherDetail',array('id'=>$vo['admin_id']));?>"><i class="fa fa-file-o"></i>任教详情</a>
						<!--<a class="btn blue" href="<?php echo U(CONTROLLER_NAME.'/subjectDetail',array('id'=>$vo['admin_id']));?>"><i class="fa fa-file-o"></i>学科详情</a>-->
					</td>
					<td class="name"><?php echo ($vo["admin_id"]); ?></td>
					<td class="name"><?php echo ($vo["admin_name"]); ?></td>
					<td><?php echo (date('Y-m-d H:i:s',$vo["add_time"])); ?></td>
					<td><?php if($vo['login_time'] != 0): echo (date('Y-m-d H:i:s',$vo["login_time"])); endif; ?></td>
					<td><?php echo ($vo["login_num"]); ?></td>
					<td></td>
				</tr><?php endforeach; endif; else: echo "" ;endif; ?>
			</tbody>

		</table>
		<div class="page-main quotes"><?php echo ($page); ?>
			<form  method="post" action="<?php echo U('importData');?>" id="myform" style="float: right;padding-top:0">
				<input type="hidden" name="_type" value="2">
				<span style="color:#f52d08;"> 导入老师数据：</span><input style="width: 160px" class="uploadFile" name="file_stu" type="file" value="">
				<a href="javascript:void(0);"  onclick="sub()" >确定</a>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="/Public/Common/js/jquery/jquery.cookie.js"></script>
	<script>
        function sub(){
// 				$("#myform").submit();
            var options = {
                "success" : resultForm,
                "resetForm" : false,
                "dataType" : "json"
            };

            $("#myform").ajaxSubmit(options);
            return;
        }
        function resultForm(data, status) {
            //表单完成
            if(data.ret == 0){
                layer.msg(data.msg);
                return ;
            }

            layer.msg(data.msg);
            setTimeout(function(){
                window.location.reload();
			},2000);
        }

        function fg_operation(name,bDiv){
            if(name == 'add') {
                window.location.href = '<?php echo U("add");?>';
            }else if(name == 'del'){
                if($('.trSelected',bDiv).length == 0 ){

                }
                var itemids = new Array();
                $('.trSelected',bDiv).each(function(i){
                    itemids[i] = $(this).attr('data-id');
                });
                fg_del(itemids);
            }
        }

        function fg_del(ids){
            if(typeof ids == 'number'){
                var ids = new Array(ids.toString());
            };
            var id = ids.join(',');
            if(confirm('确认这些数据吗？')){
                $.getJSON('<?php echo U("del");?>',{'id':id},function(data){
                    if(data.status) {
                        location.reload();
                    }else {
                        showError(data.info);
                    }
                });
            }
        }

		$(function(){
			$('.flex-table').flexigrid({
				height:"auto",// 高度自动
				usepager: false,// 不翻页
				striped:false,// 不使用斑马线
				resizable: false,// 不调节大小
				title: '教师管理',// 表格标题
				reload: false,// 不使用刷新
				url: false,
				striped: true,
				method: 'POST',
				dataType: 'json', 
				columnControl: false,// 不使用列控制
				usepager:false,
				buttons : [
//					{display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add',url:"<?php echo U(CONTROLLER_NAME.'/add',array('cate_type'=>$cate_type));?>", onpress : fg_operation },
					{display: '<i class="fa fa-trash"></i>批量删除', name : 'del', bclass : 'del', title : '将选定行数据批量删除', onpress : fg_operation },
				],
				sortname: "sort",
				sortorder: "asc",
			});
			$('span[nc_type="inline_edit"]').inline_edit({c:CONTROLLER_NAME,a:'ajax_save_data'});
			$('.ordersale').click(function(event) {
				var adv = $(this).data('adv');
				$.cookie('adv_name_o',adv, { expires: 1, path: '/' });
			});
		});
	</script>
	<div id="goTop"> <a href="JavaScript:void(0);" id="btntop"><i class="fa fa-angle-up"></i></a><a href="JavaScript:void(0);" id="btnbottom"><i class="fa fa-angle-down"></i></a></div>
</body>
</html>