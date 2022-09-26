
/**
 * 弹出msg，自动关掉
 * @param tip
 */
function xn_msg(msg){
    var time = arguments[1] ? arguments[1]*1000 : 2000;
    layer.msg(msg, {
        time: time
    });
}
function showImg(obj){
    var url = $(obj).data('href');
    var thisimg = $(obj).siblings().find('img')
    var img = "<img src='" + url + "'  />";
    var setting = {
        type: 1,
        title: false,
        closeBtn: 0,
        skin: 'layui-layer-nobg', //没有背景色
        shadeClose: true,
        shade: 0.6, //遮罩透明度
        content: img
    }

    var windowH = $(window).height();
    var windowW = $(window).width();

    getImageWidth(url,function(w,h){
        //console.log("win:"+windowH+","+windowW);
        //console.log("img:"+h+","+w);
        // 调整图片大小
        if(w>windowW || h>windowH){
            if(w>windowW && h>windowH){
                w = thisimg .width()*3;
                h = thisimg .height()*3;
                setting.area = [w+"px",h+"px"];
            }else if(w>windowW){
                setting.area = [windowW+"px",windowW*0.5/w*h+"px"];
            }else{
                setting.area = [w+"px",windowH+"px"];
            }
        }else{
            setting.area = [w+"px",h+"px"];
        }
        // 设置layer
        layer.open(setting);
    });
}

function getImageWidth(url,callback){
    var img = new Image();
    img.src = url;

    // 如果图片被缓存，则直接返回缓存数据
    if(img.complete){
        callback(img.width, img.height);
    }else{
        // 完全加载完毕的事件
        img.onload = function(){
            callback(img.width, img.height);
        }
    }

}
/**
 * 弹出对话窗  不会自动关掉
 * @param msg
 */
function xn_alert(msg){
    var icon = arguments[1] ? arguments[1] : '';
    var btn_text = arguments[2] ? arguments[2] : '确定';
    if( icon!='' ) {
        layer.open({
            content: msg,
            skin: 'layui-layer-black',
            btn: btn_text,
            icon: icon,
            yes: function(index){
                layer.close(index);
            }
        });
    } else {
        layer.open({
            content: msg,
            skin: 'layui-layer-black',
            btn: btn_text,
            yes: function(index){
                layer.close(index);
            }
        });
    }
}

/**
 * 确定后刷新
 * @param msg
 */
function xn_alert_reload(msg){
    var icon = arguments[1] ? arguments[1] : '';
    var btn_text = arguments[2] ? arguments[2] : '确定';
    if( icon!='' ) {
        layer.open({
            content: msg,
            skin: 'layui-layer-black',
            btn: btn_text,
            icon: icon,
            yes: function(index){
                location.reload();
            }
        });
    } else {
        layer.open({
            content: msg,
            skin: 'layui-layer-black',
            btn: btn_text,
            yes: function(index){
                location.reload();
            }
        });
    }
}

/**
 * 点击确定后跳转URL
 * @param msg
 * @param btn_text
 * @param btn_url
 */
function xn_alert_gourl(msg,btn_url){
    var btn_text = arguments[2] ? arguments[2] : '确定';
    layer.open({
        content: msg,
        skin: 'layui-layer-black',
        btn: btn_text,
        yes: function(){
            window.location.href = btn_url;
        }
    });
}