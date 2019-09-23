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
					<h3>获奖管理</h3>
					<h5>获奖信息的添加、修改和删除</h5>

				</div>
			</div>
		</div>
		<div class="mDiv">
			<div class="sDiv">

				<div class="sDiv2">
				<form action="<?php echo U('index');?>" method='get'>
					<input type="hidden" name="m" value="Admin">
					<input type="hidden" name="c" value="Award">
					<input type="hidden" name="a" value="index">
					奖项名称：
					<input type="text" placeholder="搜索数据..." class="qsbox" name="award_name"  size="15" value="<?php echo ($award_name); ?>">
					获奖对象：
					<input type="text" placeholder="搜索数据..." class="qsbox" <?php if($is_pt == 1): ?>readonly<?php endif; ?>  name="username" size="15" value="<?php echo ($username); ?>">
					<?php if($is_depart == 1): ?>部门查询：
						<select name="department_list">
							<option value="">--请选择--</option>
							<?php if(($is_ids) == "1"): if(is_array($department_list)): $i = 0; $__LIST__ = $department_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i; if(in_array($v['sort'],$department_ids)): ?><option value="<?php echo ($v["sort"]); ?>" <?php if($de_id == $v['sort']): ?>selected<?php endif; ?>><?php echo ($v["department_name"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; ?>
							<?php else: ?>
								<?php if(is_array($department_list)): $i = 0; $__LIST__ = $department_list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["sort"]); ?>" <?php if($de_id == $v['sort']): ?>selected<?php endif; ?>><?php echo ($v["department_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; endif; ?>
						</select><?php endif; ?>

					开始日期：
					<input type="text" id="start" readonly placeholder="选择日期..." class="qsbox" name="start_time" size="15" value="<?php echo ($start_time); ?>">
					结束日期：
					<input type="text" id="end" readonly placeholder="选择日期..." class="qsbox" name="end_time" size="15" value="<?php echo ($end_time); ?>">



					<input type="submit" value="搜索" class="btn">
				</form>

				</div>
			</div>
		</div>

		<table class="flex-table">

			<thead>
				<tr>
					<th width="24" align="center" class="sign"><i class="ico-check"></i></th>
					<th width="250" class="handle" align="center">操作</th>
					<th width="80" align="center">编号</th>
					<th width="120" align="center">奖项名称</th>
					<th width="120" align="center">奖项级别</th>
					<th width="120" align="center">获奖形式</th>
					<th width="120" align="center">获奖姓名</th>
					<th width="150" align="center">获奖日期</th>
					<th width="150" align="center">所属部门</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr data-id="<?php echo ($vo["id"]); ?>">
					<td class="sign"><i class="ico-check"></i></td>
					<td class="handle">
					<a class="btn red" href="javascript:void(0);" onclick="fg_del(<?php echo ($vo["id"]); ?>);"><i class="fa fa-trash-o"></i>删除</a>
					<a class="btn blue" href="<?php echo U(CONTROLLER_NAME.'/detail',array('id'=>$vo['id']));?>"><i class="fa fa-file-o"></i>详情</a>
					<a class="btn blue" href="<?php echo U('edit',array('id'=>$vo['id']));?>"><i class="fa fa-pencil-square-o"></i>编辑</a>
					<a class="btn green" href="<?php echo U(CONTROLLER_NAME.'/importImage',array('id'=>$vo['id']));?>"><i class="fa fa-download"></i>下载获奖证书</a>
					</td>
					<td class="name"><?php echo ($vo["id"]); ?></td>
					<td class="name"><?php echo ($vo["award_name"]); ?></td>
					<td class="name">
						<?php switch($vo['award_rank']): case "1": ?>镇级<?php break;?>
							<?php case "2": ?>区级<?php break;?>
							<?php case "3": ?>市级<?php break;?>
							<?php case "4": ?>国家级<?php break;?>
							<?php case "5": ?>全球级<?php break; endswitch;?>
					</td>
					<td class="name">
						<?php switch($vo['award_form']): case "1": ?>教师个人<?php break;?>
							<?php case "2": ?>教师团体<?php break;?>
							<?php case "3": ?>学生个人<?php break;?>
							<?php case "4": ?>学生团体<?php break;?>
							<?php case "5": ?>学生荣誉<?php break; endswitch;?>
					</td>
					<td class="name"><?php echo ($vo["username"]); ?></td>
					<td><?php echo (date('Y-m-d',$vo["award_time"])); ?></td>
					<td>
						<?php echo ($vo["_department"]); ?>
					</td>
					<td></td>
				</tr><?php endforeach; endif; else: echo "" ;endif; ?>
			</tbody>
	
		</table>
		<div class="page-main quotes"><?php echo ($page); ?></div>
	</div>
	<script type="text/javascript" src="/Public/Common/plugin/laydate/laydate.js"></script>
	<script type="text/javascript" src="/Public/Common/plugin/layer/layer.js"></script>
	<script>
        laydate({
            elem: '#hello3',
            min: '1900-06-16', //-1代表昨天，-2代表前天，以此类推
            max: laydate.now(), //+1代表明天，+2代表后天，以此类推
        });
	</script>
	<script type="text/javascript">
        var start = {
            elem: '#start',
            format: 'YYYY/MM/DD',
            min: '1900-06-16',
            max:  laydate.now(), //最大日期
            istime: true,
            istoday: false,
            choose: function(datas){
                end.min = datas;
                end.start = datas
            }
        };
        var end = {
            elem: '#end',
            format: 'YYYY/MM/DD',
            min:  laydate.now(),
            max: laydate.now(),
            istime: true,
            istody: false,
            choose: function(datas){
                start.max = datas;
            }
        }
        laydate(start);
        laydate(end);
	</script>
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
                layer.msg(data.msg)
				return ;
			}
            layer.msg(data.msg);
            setTimeout(function(){
                window.location.reload();
            },2000);
        }


		$(function(){
			$('.flex-table').flexigrid({
				height:"auto",// 高度自动
				usepager: false,// 不翻页
				striped:false,// 不使用斑马线
				resizable: false,// 不调节大小
				title: '获奖管理',// 表格标题
				reload: false,// 不使用刷新
				url: false,
				striped: true,
				method: 'POST',
				dataType: 'json', 
				columnControl: false,// 不使用列控制
				usepager:false,
				buttons : [
                    {display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add',title : '将批量新增数据', onpress : fg_operation },
					{display: '<i class="fa fa-download"></i>批量下载证书', name : 'download', bclass : 'download',title : '批量下载证书',url:"<?php echo U(CONTROLLER_NAME.'/importAllImage');?>", onpress : fg_operation },
					{display: '<i class="fa fa-file-excel-o"></i>导出excel', name : 'importExcel', bclass : 'importExcel',title : '导出excel', onpress : fg_operation },
					{display: '<i class="fa fa-trash"></i>批量删除', name : 'del', bclass : 'del', title : '将选定行数据批量删除', onpress : fg_operation },
				],
				sortname: "sort",
				sortorder: "asc",
			});
			$('span[nc_type="inline_edit"]').inline_edit({c:CONTROLLER_NAME,a:'ajax_save_data'});
		});

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
            }else if(name == 'download'){
                if($('.trSelected',bDiv).length == 0 ){

                }
                var itemids = new Array();
                $('.trSelected',bDiv).each(function(i){
                    itemids[i] = $(this).attr('data-id');
                });
                fg_down(itemids);
			}else if(name == 'importExcel'){
                if($('.trSelected',bDiv).length == 0 ){

                }
                var itemids = new Array();
                $('.trSelected',bDiv).each(function(i){
                    itemids[i] = $(this).attr('data-id');
                });
                fg_excel(itemids);
            }
        }
        function fg_excel(ids){
            if(typeof ids == 'number'){
                var ids = new Array(ids.toString());
            };
            var id = ids.join(',');
            if(id == ''){
                alert('请选择至少一项');
                return false;
            }
            if(confirm('确认打印这些数据吗？')){
                var url = '/index.php?m=Admin&c=Award&a=importExcel&id='+id;
                window.location.href = url;
            }
        }

        function fg_down(ids){
            if(typeof ids == 'number'){
                var ids = new Array(ids.toString());
            };
            var id = ids.join(',');
            if(id == ''){
                alert('请选择至少一项');
                return false;
            }
            if(confirm('确认下载这些数据吗？')){
                var url = '/index.php?m=Admin&c=Award&a=importAllImage&id='+id;
                window.location.href = url;
            }
        }

        function fg_del(ids){
            if(typeof ids == 'number'){
                var ids = new Array(ids.toString());
            };
            var id = ids.join(',');
            if(id == ''){
                alert('请选择至少一项');
                return false;
            }
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

	</script>
	<div id="goTop"> <a href="JavaScript:void(0);" id="btntop"><i class="fa fa-angle-up"></i></a><a href="JavaScript:void(0);" id="btnbottom"><i class="fa fa-angle-down"></i></a></div>
</body>
</html>