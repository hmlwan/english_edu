<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta charset="UTF-8">
<title>跳转提示</title>
<link rel="stylesheet" type="text/css" href="/Public/Admin/css/index.css" />
</head>
<body>
<div class="msgpage">
	<div class="msgbox">
		<div class="pic"></div>
		<div class="con">
		<?php if($message != ""): echo ($message); ?> 
		<?php else: ?>
			<?php echo ($error); endif; ?>
		</div>
        <div class="scon"><b id="wait"><?php echo ($waitSecond); ?></b> 秒后自动跳转，页面如不能自动跳转，选择手动操作...</div>
		<div class="button">
            <a href="<?php echo ($jumpUrl); ?>" id="href" class="ncap-btn">返回上一页</a> 
        </div>
     </div>
</div>
</body>
</html>
<script type="text/javascript">
(function(){
var wait = document.getElementById('wait'),href = document.getElementById('href').href;
var interval = setInterval(function(){
	var time = --wait.innerHTML;
	if(time <= 0) {
		location.href = href;
		clearInterval(interval);
	};
}, 1000);
})();
</script>