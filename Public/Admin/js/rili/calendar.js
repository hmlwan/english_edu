//闭包限定命名空间
/*
type:1 普通模式，点确定提交表单
type:2 简单模式，无日历，只有最近7天，最近14天等
type:3 普通模式, 不提交表单，获取页面原有参数，打开页面
type:4 对比模式 
*/
(function ($) {
    $.fn.extend({
        "yeeFxCal": function (options) {
            //检测用户传进来的参数是否合法
            if (!isValid(options))
                return this;
            var opts = $.extend({}, defaluts, options); //使用jQuery.extend 覆盖插件默认参数
            return this.each(function () {  //这里的this 就是 jQuery对象。这里return 为了支持链式调用
                //遍历所有的要高亮的dom,当调用 highLight()插件的是一个集合的时候。
                var $this = $(this); //获取当前dom 的 jQuery对象，这里的this是当前循环的dom
				
				if(opts.starttime!=''){
					var startdate = opts.starttime.split("-");
				}
				if(opts.endtime!=''){
					var enddate = opts.endtime.split("-");
				}
				
				var starttime_int = Date.parse(opts.starttime);
				var endtime_int = Date.parse(opts.endtime);

				var today  = Date.parse(GetDateStr(0));
				var yestoday  = Date.parse(GetDateStr(-1));
				var sevendays =  Date.parse(GetDateStr(-7));
				var fourteendays =  Date.parse(GetDateStr(-14));
				var thirtydays =  Date.parse(GetDateStr(-30));
				
				var selected_1='',selected_2='',selected_3='',selected_4='',selected_5='',showdate='',prev_next_day='';
				if(starttime_int == today && starttime_int==endtime_int){
					selected_1 = "selected"; 
					showdate = "今天";
				}
				else if(starttime_int == yestoday && starttime_int==endtime_int){
					selected_2 = "selected";
					showdate = "昨天";
				}
				else if(starttime_int == sevendays && endtime_int==yestoday){
					selected_3 = "selected";
					showdate = "过去7天";
				}
				else if(starttime_int == fourteendays && endtime_int==yestoday){
					selected_4 = "selected";
					showdate = "过去14天";
				}
				else if(starttime_int == thirtydays && endtime_int==yestoday){
					selected_5 = "selected";
					showdate = "过去30天";
				}
				else{
					showdate = opts.starttime+" - "+opts.endtime;
				}

				if(starttime_int == today && starttime_int==endtime_int){
					prev_next_day = "<a href='javascript:;' timedata='7' class='yfx_clicktime'>上一天</a>";
				}
				else if(starttime_int==endtime_int && starttime_int != today){
					prev_next_day = "<a href='javascript:;' timedata='7' class='yfx_clicktime'>上一天</a><a href='javascript:;' timedata='8' class='yfx_clicktime'>下一天</a>";
				}

				
				$this.children('span').text(showdate);


				/*if(opts.url==''){
					url = window.location.href;
				}
				else{
					url = opts.url;
				}
				if(url.indexOf("starttime") >= 0 && url.indexOf("endtime") >= 0){
					var strs=url.split("&");
					for(i=0;i<strs.length;i++){
						if(strs[i].indexOf("starttime")>=0){
							strs.splice(i,1);
						}
					}
					for(i=0;i<strs.length;i++){
						if(strs[i].indexOf("endtime")>=0){
							strs.splice(i,1);
						}
					}
					url = strs.join("&");					
				}*/

				
				if(opts.type==2){
					var calendar = $("<div class='rendezvous-box clearfix' type='"+opts.type+"'><div class='rendezvous-right'><a timedata='1' class='yfx_clicktime "+selected_1+"'>今天</a><a timedata='2'  class='yfx_clicktime "+selected_2+"'>昨天</a><a timedata='3' class='yfx_clicktime "+selected_3+"'>过去7天</a><a timedata='4' class='yfx_clicktime "+selected_4+"'>过去14天</a><a timedata='5' class='yfx_clicktime "+selected_5+"'>过去30天</a>"+prev_next_day+"</div></div>");
				}
				else{
					var calendar = $("<div class='rendezvous-box clearfix' type='"+opts.type+"'><div class='rendezvous-left' ><div class='rendezvous-div'><div class='s_title'>开始日期</div><div id='starttime_yx'></div></div><div class='rendezvous-div'><div class='s_title'>结束日期</div><div id='endtime_yx'></div></div></div><div class='rendezvous-right'><a timedata='1' class='yfx_clicktime "+selected_1+"'>今天</a><a timedata='2'  class='yfx_clicktime "+selected_2+"'>昨天</a><a timedata='3' class='yfx_clicktime "+selected_3+"'>过去7天</a><a timedata='4' class='yfx_clicktime "+selected_4+"'>过去14天</a><a timedata='5' class='yfx_clicktime "+selected_5+"'>过去30天</a>"+"<span id='confirm' timedata='6' class='yfx_clicktime'>确定</span></div></div>");
				}

				

                //根据参数来设置 dom的样式
                $this.click(function() {
					if($('.rendezvous-box').length>0){
						calendar.remove();
					}
					else{
						$("body").append(calendar);
						var windowWidth = $(window).width();
						var windowHeight = $(window).height();
						var objWidth = $this.width();
						var objHeight = $this.height();
						var calendarWidth = $('.rendezvous-box').width();
						var calendarHeight = $('.rendezvous-box').height();
						var offsetTop = $this.offset().top;
						var offsetLeft = $this.offset().left;
						var offsetRight = windowWidth - offsetLeft - objWidth;
						var offsetBottom = windowHeight - offsetTop - objHeight;

						var calendarX,calendarY;

						if(offsetRight < calendarWidth ){
							calendarX = offsetLeft + objWidth - calendarWidth-20;
						}
						else{
							calendarX = offsetLeft;
						}

						
						if(offsetBottom < calendarHeight ){
							calendarY = offsetTop - calendarHeight +3;
						}
						else{
							calendarY = offsetTop + objHeight+3;	
						}
						

						$('.rendezvous-box').css({ top: calendarY+"px", left: calendarX+"px" });
						
						$('#starttime_yx').html(''); //清除绑定日历
						$('#endtime_yx').html(''); //清除绑定日历

						if(opts.type!=2){
							$('#starttime_yx').RendezVous({
								inputEmptyByDefault: false,
								canClose: false,
								openByDefault: true,
								formats: {
									display: {
										date: '%Y-%M-%D'
									}
								},
								defaultDate: {
									day: startdate[2],    // 1 through 31
									month: startdate[1]-1,  // 0 through 11
									year: startdate[0] // No limits
								}
							});
							$('#endtime_yx').RendezVous({
								inputEmptyByDefault: false,
								canClose: false,
								openByDefault: true,
								formats: {
									display: {
										date: '%Y-%M-%D'
									}
								},
								defaultDate: {
									day: enddate[2],    // 1 through 31
									month: enddate[1]-1,  // 0 through 11
									year: enddate[0] // No limits
								}
							});
						}
					}
                });

				$(document).bind("click",function(e){
					var target  = $(e.target);
						if(target.closest(".rendezvous-box,.calender,.calender2").length == 0 && target.prop("tagName")!="BUTTON"){
							if($('.rendezvous-box').length>0){
								calendar.remove();
								e.stopPropagation();
							}
						}
				})
				
				$(document).on("click",'.yfx_clicktime',function(){
					var type = $(".rendezvous-box").attr("type");
					var timedata = $(this).attr('timedata');
					if(timedata==1){
						var starttime = GetDateStr(0);
						var endtime = GetDateStr(0);
					}
					else if(timedata==2){
						var starttime = GetDateStr(-1);
						var endtime = GetDateStr(-1);
					}
					else if(timedata==3){
						var starttime = GetDateStr(-7);
						var endtime = GetDateStr(-1);
					}
					else if(timedata==4){
						var starttime = GetDateStr(-14);
						var endtime = GetDateStr(-1);
					}
					else if(timedata==5){
						var starttime = GetDateStr(-30);
						var endtime = GetDateStr(-1);
					}
					else if(timedata==6){
						var starttime = $("#starttime_yx").children('.rendezvous-input').children('.rendezvous-input-date').val();
						var endtime = $("#endtime_yx").children('.rendezvous-input').children('.rendezvous-input-date').val();
					}
					else if(timedata==7){
						var starttime = getLocalTime(Date.parse(opts.starttime)/1000 - 86400);
						var endtime = getLocalTime(Date.parse(opts.starttime)/1000 - 86400);
					}
					else if(timedata==8){
						var starttime = getLocalTime(Date.parse(opts.starttime)/1000 + 86400);
						var endtime = getLocalTime(Date.parse(opts.starttime)/1000 + 86400);
					}

					var intstarttime = Date.parse(new Date(starttime))/1000;
					var intendtime = Date.parse(new Date(endtime))/1000;

					if(intendtime < intstarttime){
						alert("开始时间不能大于结束时间");
						return;
					}
					else{
						if(type==3){
							//clickPage('&starttime='+starttime+'&endtime='+endtime,'');
						}
						else if(type==4){
							//clickPage('&starttime_c='+starttime+'&endtime_c='+endtime,'');
						}
						else{
							$("input[name=starttime]").val(starttime);
							$("input[name=endtime]").val(endtime);
							//$("#select_date").submit();
						}
					}
					
				})
            });

        }
    });

    //默认参数
    var defaluts = {
        starttime: GetDateStr(0),
		endtime: GetDateStr(0),
		type: 1
    };

    //私有方法，检测参数是否合法
    function isValid(options) {
        return !options || (options && typeof options === "object") ? true : false;
    }

	//获取时间
	function GetDateStr(AddDayCount) {
	    var dd = new Date();
	    dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
	    var y = dd.getFullYear();
	    var m = dd.getMonth()+1;//获取当前月份的日期
	    var d = dd.getDate();
	    return y+"-"+m+"-"+d;
	}
	
	//格式化时间戳
	function getLocalTime(time) {
		var d =  new Date(parseInt(time) * 1000 );
		return d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
	} 
	
	// //获取url原有参数
	// function clickPage(geturl,newpage,clicktype){
	// 	var i,j= 0,k = 0;
	// 	var currenturl = self.location.search.replace(/[?]/i, '');
	// 	var newgetarray = new Array();
	// 	var newhtmlarray = new Array();
	// 	var returnhtmlarray = new Array();
	// 	var subkeyarray     = new Array();

	// 	if( typeof( clicktype ) == 'undefined' || clicktype == 'undefined')
	// 	{
	// 		clicktype = '';
	// 	}
	// 	if( typeof( newpage ) == 'undefined' || newpage == 'undefined')
	// 	{
	// 		newpage = '';
	// 	}
	// 	if( typeof( geturl ) == 'undefined' || geturl == 'undefined')
	// 	{
	// 		geturl = '';
	// 	}
	// 	newhtmlarray   = currenturl.split('&');
	// 	newgetarray    = geturl.split('&');

	// 	for(i=0;i<newhtmlarray.length;i++)
	// 	{
	// 		if( newhtmlarray[i] )
	// 		{
	// 			subkeyarray = newhtmlarray[i].split('=');
	// 			returnhtmlarray["'"+subkeyarray[0]+"'"] = subkeyarray[0]+'='+subkeyarray[1];
	// 		}
	// 	}
	// 	for(i=0;i<newgetarray.length;i++)
	// 	{
	// 		if( newgetarray[i] )
	// 		{
	// 			subkeyarray = newgetarray[i].split('=');
	// 			returnhtmlarray["'"+subkeyarray[0]+"'"] = subkeyarray[0]+'='+subkeyarray[1];
	// 		}
	// 	}
	// 	var returnstr = '';
	// 	var returnarray = new Array();
	// 	for(j in returnhtmlarray)
	// 	{
	// 		var jj = j.replace(/\'/g,'');
	// 		if( ( jj == 'website' || jj == 'server' || jj == 'eaction' || geturl.indexOf('&' + jj + '=') > -1 ) && clicktype == 'report' )
	// 		{
	// 			returnarray[k] = returnhtmlarray[j];
	// 			k++;
	// 		}
	// 		if( clicktype != 'report' || clicktype == '' )
	// 		{
	// 			returnarray[k] = returnhtmlarray[j];
	// 			k++;
	// 		}
	// 	}
	// 	window.location.href = newpage+'?'+returnarray.join("&");
	// }

})(window.jQuery);