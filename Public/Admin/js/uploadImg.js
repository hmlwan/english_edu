if (false) {//(if false相当于注释)
    $(function() {
        //html::::------------
        /*
         *<div>
         * <a class="upPic" href="#">点击上传图片</a>
         * <a class="upPic" href="#">点击上传图片</a>
         * <a class="upPic" href="#">点击上传图片</a>
         * </div>
         * */
        $('.upPic').each(function(i, v) {
            uploadImage({
                'dom' : $(v), //点击dom弹出文件选择框
                'posturl' : '/index/sentImg', //提交图片的路径
                'filename' : 'image', //接收的图片的名称(input type=file name=filename)
                'cbkinput' : 'cbk', //接收回调函数名称的字段名
                'callback' : function(_jsn) {//图片提交成功后的回调
                    var img = _jsn.pic;
                    $(v).html('<img src="' + img + '"/>');
                }
            });
        })
    })
}

function uploadImage(o) {//
    function getRandId() {//获取唯一的ID,frm+(时间戳*1+(0-9999)随机数),如果仍然重复,就回调,另取一个随机数
        var tid = 'frm' + ((new Date()) * 1 + Math.floor(Math.random() * 9999));
        ($('#' + tid).length || window[tid]) && ( tid = this.getRand());
        return tid;
    }

    var purl = o.posturl, fnm = o.filename, cbki = o.cbkinput, callback = o.callback, dom = o.dom;
    var frmId = getRandId();
    //回调函数的函数名
    var winCbkname = 'cbk_' + frmId;
    window[winCbkname] = function(_json) {//一个全局函数,函数名随机且唯一(防止冲突),用于提交图片后执行回调
        callback(_json);
    }
    if (!!window.ActiveXObject) {//IE浏览器
        dom.click(function() {
            $('iframe.upImgNoRefresh').remove();
            $('body').append('<iframe class="upImgNoRefresh" id="' + frmId + '" style="position: absolute;height: 1px;width: 1px;left: -50px;top: -50px"></iframe>');
            setTimeout(function() {
                var ifmBody = $($('#'+frmId)[0].contentWindow.document.body);
                ifmBody.html('<form action="' + purl + '" method="post" enctype="multipart/form-data" id="ifrmForm"><input name="' + cbki + '" value="' + winCbkname + '"/><input onchange="document.getElementById(\'ifrmForm\').submit()" id="ifrmFile" type="file" name="' + fnm + '"/></form>');
                ifmBody.find('#ifrmFile')[0].click();
            }, 500)
        })
    } else {
        var fileId = 'file' + frmId;
        var formId = 'form' + frmId;
        $('body').append('<div style="position: absolute;width: 1px;height: 1px;right: -50px;top: -50px;overflow: hidden"><form action="' + purl + '" id="' + formId + '" method="post" enctype="multipart/form-data" target="' + frmId + '"><input id="' + fileId + '" type="file" name="' + fnm + '"/><input name="' + cbki + '" value="' + winCbkname + '"/><input type="submit" value="提交"/></form><iframe name="' + frmId + '"></iframe></div>')
        $('#' + fileId).change(function() {
            $(this).val() && $('#' + formId).submit();
        })
        dom.click(function() {
            $('#'+fileId)[0].click();
        })
    }

}