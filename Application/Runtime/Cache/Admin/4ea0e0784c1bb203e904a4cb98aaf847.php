<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<link rel="stylesheet" type="text/css" href="/Public/Common/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/index.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/font/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Common/css/perfect-scrollbar.min.css" />
<style>html, body { overflow: visible;}</style>
<script>

var ADMIN_TEMPLATES_URL = '/Public/Admin';
var LOADING_IMAGE = "/Public/Admin/images/loading.gif";
var ADMIN_RESOURCE_URL = '/Public/Admin';
</script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/Public/Common/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/Public/Common/jquery-ui/zh-CN.js"></script>
<script type="text/javascript" src="/Public/Admin/js/admin.js"></script>
<script src="/Public/Admin/dialog/dialog.js" id="dialog_js"></script>
<script type="text/javascript" src="/Public/Admin/js/flexigrid.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.validation.min.js"></script>
<script type="text/javascript" src="/Public/Admin/js/common.js"></script>
<script type="text/javascript" src="/Public/Common/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.mousewheel.js"></script>

</head>
<body style="background-color: #FFF; overflow: auto;">
	<script type="text/javascript" src="/Public/Common/js/jquery/jquery.picTip.js"></script>
	<div id="append_parent"></div>
	<div id="ajaxwaitid"></div>

	<div class="page">
		<div class="fixed-bar">
			<div class="item-title">
				<div class="subject">
					<h3><?php echo ($subject); ?></h3>
					<h5>个人的基本详细信息</h5>
				</div>
			</div>
		</div>
		<!-- 操作说明 -->
		<div class="explanation" id="explanation">
			<div class="title" id="checkZoom">
				<i class="fa fa-lightbulb-o"></i>
				<h4 title="提示相关设置操作时应注意的要点">操作提示</h4>
				<span id="explanationZoom" title="收起提示"></span> 
			</div>
			<ul>
				<li>个人基本信息包括个人资料，班级信息等。</li>
			</ul>
		</div>
		<?php if($role_list['role_id'] == 2): ?><div class="ncap-form-default">
				<dl class="row">
					<dt class="tit">
						<label for="pid"><em>*</em>账号名称</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["admin_name"]); ?>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>角色</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["_role_name"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>年级</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["_grate_name"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>班级</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["_class_name"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>最后登录时间</label>
					</dt>
					<dd class="opt">
						<?php echo (date("Y-m-d H:i:s",$vo["last_login_time"])); ?>
						<span class="err"></span>
					</dd>
				</dl>
			</div>

		<?php elseif($role_list['role_id'] == 7): ?>
			<div class="ncap-form-default">
				<dl class="row">
					<dt class="tit">
						<label for="pid"><em>*</em>账号名称</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["admin_name"]); ?>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>角色</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["_role_name"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>年级班级</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["classmate"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
			  	<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>负责科目</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["discipline"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>主管部门</label>
					</dt>
					<dd class="opt">
						<?php if($vo['department']): echo ($vo["department"]); ?>
						<?php else: ?>
							无<?php endif; ?>

						<span class="err"></span>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>最好登录时间</label>
					</dt>
					<dd class="opt">
						<?php echo (date($vo["last_login_time"],"Y-m-d H:i:s")); ?>
						<span class="err"></span>
					</dd>
				</dl>
			</div>
		<?php else: ?>
			<div class="ncap-form-default">
				<dl class="row">
					<dt class="tit">
						<label for="pid"><em>*</em>账号名称</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["admin_name"]); ?>
					</dd>
				</dl>
				<dl class="row">
					<dt class="tit">
						<label for="menu_name"><em>*</em>角色</label>
					</dt>
					<dd class="opt">
						<?php echo ($vo["_role_name"]); ?>
						<span class="err"></span>
					</dd>
				</dl>
			</div><?php endif; ?>
	</div>
	<script type="text/javascript">
	$(function(){
		
	});
	</script> 
	<div id="goTop"> 
		<a href="JavaScript:void(0);" id="btntop">
			<i class="fa fa-angle-up"></i>
		</a>
		<a href="JavaScript:void(0);" id="btnbottom">
			<i class="fa fa-angle-down"></i>
		</a>
	</div>
</body>
</html>