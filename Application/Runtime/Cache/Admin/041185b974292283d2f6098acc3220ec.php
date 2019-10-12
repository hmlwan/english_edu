<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<title>您需要登录后才可以使用本功能</title>
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/login.css" />
<link rel="stylesheet" type="text/css" href="/Public/Admin/font/font-awesome.min.css" />

<script type="text/javascript" src="/Public/Common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/Public/Admin/js/common.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.validation.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.supersized.min.js"></script>
<script type="text/javascript" src="/Public/Common/js/jquery/jquery.progressBar.js"></script>
</head>

<body style="background: url(/Public/Admin/images/bg.png);">

<div class="login-layout">
	<div class="top">
	<h5>管理平台<em></em></h5>
		<h2>系统管理中心</h2>
	</div>
	<form method="post" id="form_login">
		<input type='hidden' name='formhash' value='8TR3R1W8UDe-UJ7zPLVpObDQ6zQ2WBm' />    <input type="hidden" name="form_submit" value="ok" />
		<input type="hidden" name="SiteUrl" id="SiteUrl" value="http://51youxiang.com/" />
		<div class="lock-holder">
			<div class="form-group pull-left input-username">
				<label>账号</label>
				<input name="admin_name" id="admin_name" autocomplete="off" type="text" class="input-text" value="" required>
			</div>
			<i class="fa fa-ellipsis-h dot-left"></i> <i class="fa fa-ellipsis-h dot-right"></i>
			<div class="form-group pull-right input-password-box">
				<label>密码</label>
				<input name="admin_password" id="admin_password" class="input-text" autocomplete="off" type="password" required pattern="[\S]{6}[\S]*" title="密码不少于6个字符">
			</div>
		</div>
		<div class="avatar">
			<img src="/Public/Admin/images/admin_avatar.jpg" alt=""></div>
		<div class="submit"> 
			<!--<span>-->
				<!--<div class="code">-->
					<!--<div class="arrow"></div>-->
					<!--<div class="code-img"><img src="<?php echo U_hash('index/makecode');?>" name="codeimage" id="codeimage" border="0"/></div>-->
					<!--<a href="javascript:void(0);" id="hide" class="close" title="关闭"><i></i></a>-->
					<!--<a href="javascript:void(0);" onclick="javascript:document.getElementById('codeimage').src='<?php echo U_hash('index/makecode');?>&' + Math.random();" class="change" title="看不清,点击更换验证码"><i></i></a> -->
				<!--</div>-->
				<!--<input name='verify_code' type="text" required class="input-code" id="verify_code" placeholder="输入验证" pattern="[A-z0-9]{4}" title="验证码为4个字符" autocomplete="off" value="" >-->
			<!--</span> -->
			<span>
				<input name="" class="input-button btn-submit" type="button" value="登录">
			</span>

		</div>
		<div class="submit2"></div>
	</form>

</div>

<script>
$(function(){
       /* $.supersized({

        // 功能
        slide_interval     : 4000,    
        transition         : 1,    
        transition_speed   : 1000,    
        performance        : 1,    

        // 大小和位置
        min_width          : 0,    
        min_height         : 0,    
        vertical_center    : 1,    
        horizontal_center  : 1,    
        fit_always         : 0,    
        fit_portrait       : 1,    
        fit_landscape      : 0,    

        // 组件
        slide_links        : 'blank',    
        slides             : [    
                                 {image : 'http://www.wearmaker.cn/tesa/shopnc/templates/default/images/login/1.jpg'},
                                 {image : 'http://www.wearmaker.cn/tesa/shopnc/templates/default/images/login/2.jpg'},
                                 {image : 'http://www.wearmaker.cn/tesa/shopnc/templates/default/images/login/3.jpg'},
								 {image : 'http://www.wearmaker.cn/tesa/shopnc/templates/default/images/login/4.jpg'},
								 {image : 'http://www.wearmaker.cn/tesa/shopnc/templates/default/images/login/5.jpg'}
                       ]

    });*/
	//显示隐藏验证码
    $("#hide").click(function(){
        $(".code").fadeOut("slow");
    });
    $("#verify_code").focus(function(){
        $(".code").fadeIn("fast");
    });
    //跳出框架在主窗口登录
	if(top.location!=this.location)	top.location=this.location;
    $('#admin_name').focus();
    if ($.browser.msie && ($.browser.version=="6.0" || $.browser.version=="7.0")){
        window.location.href='http://www.wearmaker.cn/tesa/shopnc/templates/default/ie6update.html';
    }
    $("#captcha").nc_placeholder();
	//动画登录
    $('.btn-submit').click(function(e){
		$('.input-username,dot-left').addClass('animated fadeOutRight')
		$('.input-password-box,dot-right').addClass('animated fadeOutLeft')
		$('.btn-submit').addClass('animated fadeOutUp')
		setTimeout(function () {
				  $('.avatar').addClass('avatar-top');
				  $('.submit').hide();
				  $('.submit2').html('<div class="progress"><div class="progress-bar progress-bar-success" aria-valuetransitiongoal="100"></div></div>');
				  $('.progress .progress-bar').progressbar({
					  done : function() {$('#form_login').submit();}
				  }); 
		  },
	  300);
	});

    // 回车提交表单
    $('#form_login').keydown(function(event){
        if (event.keyCode == 13) {
            $('.btn-submit').click();
        }
    });
});

</script>
</body>
</html>