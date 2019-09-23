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
	<div id="append_parent"></div>
	<div id="ajaxwaitid"></div>
	<div class="page">
		<div class="fixed-bar">
			<div class="item-title">
				<?php echo ($back_htn_html); ?>
				<div class="subject">
					<h3>班级列表</h3>
					<h5>班级管理的添加、修改和删除</h5>
				</div>
			</div>
		</div>
		<table class="flex-table">
			<thead>
				<tr>
					<th width="25" align="center" class="sign"><i class="ico-check"></i></th>
					<th width="160" class="handle" align="center">操作</th>
					<th width="60" align="center">排序</th>
					<th width="300" align="center">班级名称</th>
					<th width="300" align="center">年级名称</th>
					<th width="80" align="center">状态</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$r): $mod = ($i % 2 );++$i;?><tr data-id="<?php echo ($r["id"]); ?>">
					<td class="sign"><i class="ico-check"></i></td>
					<td class="handle">
						<a class="btn red" href="<?php echo U('Class/del',array('id'=>$r['id']));?>" onclick="if(confirm('删除后将不能恢复，确认删除这 1 项吗?')){return true;} else {return false;}"><i class="fa fa-trash-o"></i>删除</a>
						<a class="btn blue" href="<?php echo U('Class/edit',array('id'=>$r['id']));?>"><i class="fa fa-pencil-square-o"></i>编辑</a>
					</td>
					<td class="sort"><span title="可编辑" column_id="<?php echo ($r["id"]); ?>" fieldname="sort" nc_type="inline_edit" class="editable "><?php echo ($r["sort"]); ?></span></td>
					<td class="name"><span title="可编辑" column_id="<?php echo ($r["id"]); ?>" fieldname="class_name" nc_type="inline_edit" class="editable "><?php echo ($r["class_name"]); ?></span></td>
					</td>
					<td><?php echo ($r["grate_name"]); ?></td>
					<td>
						<?php if(($r["status"]) == "0"): ?><span class="no"><i class="fa fa-ban"></i>禁用</span>
						<?php else: ?>
						<span class="yes"><i class="fa fa-check-circle"></i>启用</span><?php endif; ?>
					</td>
					<td></td>
				</tr><?php endforeach; endif; else: echo "" ;endif; ?>
			</tbody>
	
		</table>
		<div class="page-main quotes"><?php echo ($page); ?></div>
	</div>
	<script>
		$(function(){
			$('.flex-table').flexigrid({
				height:"auto",// 高度自动
				usepager: false,// 不翻页
				striped:false,// 不使用斑马线
				resizable: false,// 不调节大小
				title: '班级管理',// 表格标题
				reload: false,// 不使用刷新
				url: false,
				striped: true,
				method: 'POST',
				dataType: 'json',
				columnControl: false,// 不使用列控制
				usepager:false,
				buttons : [
					{display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add',title : '将批量新增数据', onpress : fg_operation },
					{display: '<i class="fa fa-trash"></i>批量删除', name : 'del', bclass : 'del', title : '将选定行数据批量删除', onpress : fg_operation },
				],
				sortname: "sort",
				sortorder: "asc",
			});
			$('span[nc_type="inline_edit"]').inline_edit({c:'Class',a:'ajax_save_data'});
		});
			function fg_operation(name,bDiv){
				if(name == 'add') {
					window.location.href = '<?php echo U("Class/add");?>';
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
				$.getJSON('<?php echo U("Class/del");?>',{'id':id},function(data){
					if(data.status) {
						location.reload();
					}else {
						showError(data.info);
					}
				});
			}
		}
	</script>
	<div id="goTop"> <a href="JavaScript:void(0);" id="btntop"><i class="fa fa-angle-up"></i></a><a href="JavaScript:void(0);" id="btnbottom"><i class="fa fa-angle-down"></i></a></div>
</body>
</html>