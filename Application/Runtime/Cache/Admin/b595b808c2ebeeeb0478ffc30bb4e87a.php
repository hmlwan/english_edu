<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css" href="/Public/Common/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/index.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/font/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/Public/Common/css/jquery.Jcrop.min.css" />
<script type="text/javascript">
var ADMIN_SITE_URL = '/index.php?m=Admin';
var ADMIN_TEMPLATES_URL = '/Public/Admin';
//var ADMIN_RESOURCE_URL = 'http://wearmaker.cn//tesa/shopnc/resource';
//var SITEURL = 'http://wearmaker.cn//tesa/shopnc';
</script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/Public/Admin/js/common.js"></script>
<script src="/Public/Admin/dialog/dialog.js" id="dialog_js"></script>
<script type="text/javascript" src="/Public/Common/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.bgColorSelector.js"></script>
<script type="text/javascript" src="/Public/Admin/js/admincp.js"></script>
<script type="text/javascript" src="/Public/Common/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/Public/Common/plugin/layer/layer.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.Jcrop.js"></script>
</head>

<body>
	<div class="admincp-map ui-widget-content" nctype="map_nav" style="display:none;" id="draggable" >
	  <div class="title ui-widget-header" >
		<h3>管理中心全部菜单</h3>
		<h5>切换显示全部管理菜单，通过点击勾选可添加菜单为管理常用操作项，最多添加10个</h5>
		<span><a nctype="map_off" href="JavaScript:void(0);">X</a></span> </div>
		<div class="content"> 
			<ul class="admincp-map-nav">
				<li><a href="javascript:void(0);" data-param="map-system">平台</a></li>
				<li><a href="javascript:void(0);" data-param="map-shop">商城</a></li>
				<li><a href="javascript:void(0);" data-param="map-cms">资讯</a></li>
				<li><a href="javascript:void(0);" data-param="map-circle">圈子</a></li>
				<li><a href="javascript:void(0);" data-param="map-microshop">微商城</a></li>
				<li><a href="javascript:void(0);" data-param="map-mobile">手机端</a></li>
			</ul>
			<div class="admincp-map-div" data-param="map-system">
				<dl>
					<dt>设置</dt>
					<dd class="">
						<a href="javascript:void(0);" data-param="system|setting">站点设置</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="">
						<a href="javascript:void(0);" data-param="system|upload">上传设置</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="">
						<a href="javascript:void(0);" data-param="system|message">邮件设置</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="">
						<a href="javascript:void(0);" data-param="admin|index">权限设置</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="">
						<a href="javascript:void(0);" data-param="system|admin_log">操作日志</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="">
						<a href="javascript:void(0);" data-param="system|area">地区设置</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
					<dd class="selected">
						<a href="javascript:void(0);" data-param="system|cache">清理缓存</a>
						<i class="fa fa-check-square-o"></i>
					</dd>
				</dl>
			</div>
		</div>
	  <script>
		//固定层移动
		$(function(){
			//管理显示与隐藏
					$("#admin-manager-btn").click(function () {
						if ($(".manager-menu").css("display") == "none") {
							$(".manager-menu").css('display', 'block'); 
							$("#admin-manager-btn").attr("title","关闭快捷管理"); 
							$("#admin-manager-btn").removeClass().addClass("arrow-close");
						}
						else {
							$(".manager-menu").css('display', 'none');
							$("#admin-manager-btn").attr("title","显示快捷管理");
							$("#admin-manager-btn").removeClass().addClass("arrow");
						}           
					});
			
			$("#draggable").draggable({
				handle: "div.title"
			});
			$("div.title").disableSelection()
			//修改头像
			$('#avatar').change(uploadChange);
			function uploadChange(){
				var filepath=$(this).val();
				var extStart=filepath.lastIndexOf(".");
				var ext=filepath.substring(extStart,filepath.length).toUpperCase();
				if(ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
					alert("file type error");
					$(this).attr('value','');
					return false;
				}
				if ($(this).val() == '') return false;
				ajaxFileUpload();
			}
			function ajaxFileUpload()
			{
				$.ajaxFileUpload
				(
					{
						url: "<?php echo U('User/uploadAvatar');?>",
						secureuri:false,
						fileElementId:'avatar',
						dataType: 'json',
						type: 'POST',
						success: function (json_data, status)
						{
							$('img[nctype="admin_avatar"]').attr('src', json_data.data.admin_avatar);
							$('#avatar').bind('change',uploadChange);
							return;
						},
						error: function (json_data, status, e)
						{
							layer.alert(json_data.msg);
							$('#avatar').bind('change',uploadChange);
						}
					}
				)
			};
		});
//		//裁剪图片后返回接收函数
//		function call_back(picname){
//			$.getJSON('index.php?act=index&op=save_avatar&avatar=' + picname, function(data){
//				if (data) {
//					$('img[nctype="admin_avatar"]').attr('src', 'http://wearmaker.cn//tesa/data/upload/admin/avatar/' + picname);
//				}
//			});
//		}
		</script> 
	</div>
	<div class="admincp-header">
		<div class="bgSelector"></div>
		<div id="foldSidebar"><i class="fa fa-outdent " title="展开/收起侧边导航"></i></div>
		<div class="admincp-name">
			<h1>平台</h1>
			<h2>后台系统管理中心</h2>
		</div>
		<div class="nc-module-menu">
			<ul class="nc-row">
			<?php if(is_array($auth_menu)): $i = 0; $__LIST__ = $auth_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$r): $mod = ($i % 2 );++$i;?><li data-param="menu<?php echo ($r["menu_id"]); ?>"><a href="javascript:void(0);"><?php echo ($r["menu_name"]); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
			</ul>
		</div>
		<div class="admincp-header-r">
			<div class="manager">
				<dl>
					<dt class="name"><?php echo ($admin["admin_name"]); ?></dt>
					<dd class="group"><?php echo ($admin["role_name"]); ?></dd>
				</dl>

				<span class="avatar">
					<input name="avatar" type="file" class="admin-avatar-file" id="avatar" title="设置管理员头像" value="<?php echo ($admin_avatar); ?>"/>
					<img alt="" nctype="admin_avatar" src="<?php echo ($admin_avatar); ?>">
				</span>
				<i class="arrow" id="admin-manager-btn" title="显示快捷管理菜单"></i>
				<div class="manager-menu">
					<div class="title">
						<h4>最后登录</h4>
						<a href="javascript:void(0);"  class="edit-password">修改密码</a>
					</div>
					<div class="login-date">
						<?php echo (date("Y-m-d H:i:s",time())); ?>
						<span>(IP:<?php echo ($_SERVER['REMOTE_ADDR']); ?>)</span>
					</div>
				</div>
			</div>
			<ul class="operate nc-row">
				<li style="display: none !important;" nctype="pending_matters"><a class="toast show-option" href="javascript:void(0);" onclick="$.cookie('commonPendingMatters', 0, {expires : -1});ajax_form('pending_matters', '待处理事项', 'http://wearmaker.cn//tesa/shopnc/index.php?act=common&op=pending_matters', '480');" title="查看待处理事项">&nbsp;<em>0</em></a></li>
				<!--<li><a class="sitemap show-option" nctype="map_on" href="javascript:void(0);" title="查看全部管理菜单">&nbsp;</a></li>-->
				<li><a class="style-color show-option" id="trace_show" href="javascript:void(0);" title="给管理中心换个颜色">&nbsp;</a></li>
				<!--<li><a class="homepage show-option" target="_blank" href="http://wearmaker.cn//tesa/shop" title="新窗口打开裁缝邦首页">&nbsp;</a></li>-->
				<li><a class="login-out show-option" href="<?php echo U('index/logout');?>" title="安全退出管理中心">&nbsp;</a></li>
			</ul>
		</div>
		<div class="clear"></div>
	</div>

	<div class="admincp-container unfold">
		<div class="admincp-container-left">
			<div class="top-border"><span class="nav-side"></span><span class="sub-side"></span></div>
			<?php if(is_array($auth_menu)): $i = 0; $__LIST__ = $auth_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$m1): $mod = ($i % 2 );++$i;?><div id="admincpNavTabs_menu<?php echo ($m1["menu_id"]); ?>" class="nav-tabs">
				<?php if(is_array($m1["sub"])): $i = 0; $__LIST__ = $m1["sub"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$m2): $mod = ($i % 2 );++$i;?><dl>
					<dt>
						<a href="javascript:void(0);">
							<span class="<?php echo ($m2["class_name"]); ?>"></span>
							<h3><?php echo ($m2["menu_name"]); ?></h3>
						</a>
					</dt>
					<dd class="sub-menu">
						<ul>
						<?php if(is_array($m2["sub"])): $i = 0; $__LIST__ = $m2["sub"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$m3): $mod = ($i % 2 );++$i;?><li><a href="javascript:void(0);" data-param="<?php echo ($m3["module_name"]); ?>|<?php echo ($m3["action_name"]); ?>|<?php echo ($m1["menu_id"]); ?>|<?php echo ($m3["menu_id"]); ?>|<?php echo ($m3["data"]); ?>"><?php echo ($m3["menu_name"]); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</dd>
				</dl><?php endforeach; endif; else: echo "" ;endif; ?>
			</div><?php endforeach; endif; else: echo "" ;endif; ?>
			<div class="about" title="关于一裁缝邦" onclick="ajax_form('about', '', 'http://wearmaker.cn/', 640);">
				<i class="fa fa-copyright"></i>
				<span>CAIFENGBANG</span>
			</div>
		</div>
		<div class="admincp-container-right">
			<div class="top-border"></div>
			<iframe src="" id="workspace" name="workspace" style="overflow: visible;" frameborder="0" width="100%" height="94%" scrolling="yes" onload="window.parent"></iframe>
		</div>
	</div>
	<form id="modifyPwd_form" method="post" action="<?php echo U('User/modifyPwd');?>">
    <div class="ncap-form-default">
        <input type="hidden" name="admin" value="luokun">
        <dl class="row">
            <dt class="tit">
                <label for="pid"><em>*</em></label>
            </dt>
            <dd class="opt" >
                <input type="text" name="oldpassword" id="oldpassword" value="" placeholder="旧密码" required style="width: 94%;font-size: 16px;padding:10px 4px;border-radius: 7px;">
                <span class="err"></span>
            </dd>
        </dl>
        <dl class="row">
            <dt class="tit">
                <label for="pid"><em>*</em></label>
            </dt>
            <dd class="opt">
                <input type="text" name="newpassword" id="newpassword"  placeholder="新密码" value="" required style="width: 94%;font-size: 16px;padding:10px 4px;border-radius: 7px;">
                <span class="err"></span>
            </dd>
        </dl>
        <dl class="row">
            <dt class="tit">
                <label for="pid"><em>*</em></label>
            </dt>
            <dd class="opt">
                <input type="text" name="repassword" id="repassword" placeholder="确认密码" value="" required style="width: 94%;font-size: 16px;padding:10px 4px;border-radius: 7px;">
                 <span class="err"></span>
            </dd>
        </dl>        
       <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submitBtn" style="width:66%;border-radius: 20px;padding: 8px 19px;font-size: 19px;">确认修改</a>
        <!--   <div class="bot"><input class="ncap-btn-big ncap-btn-green" id="submitBtn" type="submit" value="确认提交"></div>-->
        </div>
        </div>
     <div class="close-btn" style="text-align:center; font-size: 16px;cursor:pointer;" >取消</div>
</form>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.validation.min.js"></script>
<script type="text/javascript">
    $(function(){
        $('#modifyPwd_form').validate({
            errorPlacement: function(error,element){
                var error_td = element.parent('dd').children('span.err');
                error_td.append(error);
            },
            /*submitHandler:function(form) {
                var sub_data = $('#modifyPwd_form').serialize();
                var response_url = $('#modifyPwd_form').attr('action');

                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: response_url,
                    data: sub_data,
                    success: function (json_data) {
//                        alert(json_data.msg);
                        if(json_data.ret==1){
                            layer.msg(json_data.msg, {
                                icon: 1,
                                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                layer.closeAll();
                                $(".manager-menu").slideUp('slow');
                            });
                        }else{
                            layer.msg(json_data.msg, {
                                icon: 2,
                                time: 5000 //2秒关闭（如果不配置，默认是3秒）
                            });
                        }
                    }
                })
            },*/

            rules: {
                oldpassword:{
                    required:true,
                },
                newpassword:{
                    required:true,
                    minlength:6
                },
                repassword:{
                    required:true,
                    minlength:6,
                    equalTo:"#newpassword"
                }
            },
            messages: {
                oldpassword:{
                    required:'<i class="fa fa-exclamation-circle"></i>请输入原密码',
                    minlength:'<i class="fa fa-exclamation-circle"></i>密码不能少于6个字符'
                },
                newpassword:{
                    required:'<i class="fa fa-exclamation-circle"></i>请输入新密码',
                    minlength:'<i class="fa fa-exclamation-circle"></i>密码不能少于6个字符'
                },
                repassword:{
                    required:'<i class="fa fa-exclamation-circle"></i>请输入确认密码',
                    minlength:'<i class="fa fa-exclamation-circle"></i>密码不能少于6个字符',
                    equalTo: '<i class="fa fa-exclamation-circle"></i>请再次输入相同的密码'
                }
            }
        });
    });
</script>
	 <div class="page" id="clear_cache">
	<table border="0" cellpadding="2" cellspacing="1" style="width:100%" >
		<div class="ncap-form-default">
			<dd class="opt" nowrap align="center">
					<input type="checkbox" name="Cache" class="cache" value="Cache"/>清理缓存<br>
					<input type="checkbox" name="Data" class="cache" value="Data"/>清理数据<br>
					<input type="checkbox" name="Logs" class="cache" value="Logs"/>清理日志<br>
					<input type="checkbox" name="Temp" class="cache" value="Temp"/>清理临时文件<br>
					<input type="checkbox" name="allcheck"  id="allcheck" value=""/>全选/反选<br>
				<dt><span id="mess"></span></dt>
			<div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" id="submit_Btn">一键加速</a></div>
			<div class="close_cache" style="text-align:center; font-size: 16px;cursor:pointer;" >取消</div>
			</dd>
		</div>
    </table>
 </div>

<script type="text/javascript">
	$(function(){
		$('#allcheck').click(function(){
			if($(this).attr('checked')){
				$('.cache').attr("checked",true);
			}else{
				$('.cache').attr("checked",false);
			}
		});
	});
</script>

	<script type="text/javascript">
		$('.edit-password').click(function(){
			var index = layer.open({
				type: 1,
				title:'修改密码',
				content: $('#modifyPwd_form'),
				area: ['400px', '350px'],
				shadeClose:true,
				shift :3,
				closeBtn:0,
				success: function(layero, index1){
					$('#submitBtn').click(function(){
						if($('#modifyPwd_form').valid()) {
							var sub_data = $('#modifyPwd_form').serialize();
							var response_url = $('#modifyPwd_form').attr('action');

							$.ajax({
								type: "POST",
								dataType: 'json',
								url: response_url,
								data: sub_data,
								success: function (json_data) {
									if(json_data.ret==1){
										layer.msg(json_data.msg, {
											icon: 1,
											time: 2000 //2秒关闭（如果不配置，默认是3秒）
										}, function(){
											layer.closeAll();
											$(".manager-menu").slideUp('slow');
										});
									}else{
										layer.msg(json_data.msg, {
											icon: 2,
											time: 5000 //2秒关闭（如果不配置，默认是3秒）
										});
									}
								}
							})
						}
					})
				}
			});
		});
		$('.close-btn').click(function(){
			layer.closeAll();
		});

		$('.clear_cache').click(function(){
			var index = layer.open({
				type: 1,
				title:'清理缓存',
				content: $('#clear_cache'),
				area: ['350px', '400px'],
				shadeClose:true,
				shift :3,
				closeBtn:0,
				success: function(layero, index1){
					$('#submit_Btn').click(function(){
						var val = $('.cache').serialize();
						if(val){
							if(confirm('确认要清理吗？'))
							var response_url = "<?php echo U('System/cache');?>";
							$.ajax({
								type : "POST",
								data : val,
								dataType : 'json',
								url : response_url,
								success : function(json_data){
									if(json_data.ret == 1){
										$('#mess').html(json_data.msg);
										layer.msg(json_data.msg,{
											time:2000
										},function(){
											layer.closeAll();
											$('.manager-menu').slideUp('slow');
										});
									}else{
										$('#mess').html(json_data.msg);
										layer.msg(json_data.msg);
									}
								}
							});
						}else{
							alert('请先选择要清理的文件！');
						}
					})
				}
			});
		});
		$('.close_cache').click(function(){
			layer.closeAll();
		});
		$(function(){
			$(".change_version").click(function(){
				var moudel = $(this).data('model');
				var ip = $(this).data('ip');
				if(moudel == 'Dapei'){
					window.location.href = ip+'index.php?m=Admin&c=index&a=index';
				}else{
					window.location.href = ip+'index.php?m=Dapei&c=index&a=index';
				}
			});
		});
	</script>
</body>
</html>