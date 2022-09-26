var jspath = window.location.protocol+"//"+document.domain;
var u = navigator.userAgent;
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
/**
 * 
 * @param url
 * @param data
 * @param callBack
 */ 
function doPost(url, data, callBack) {
	$.ajax({
	   type: "POST",
	   url: url,
	   data: data,
	   dataType: "json",
	   success: function(data){
		   callBack(data);
	   },
	   error: function(){
		   callBack();
	   }
	});
}

/**
 * 获取地址栏参数
 * @param index  参数名
 * @returns
 */
function getRequestParam(key) {
    var requestParams = {};
    var urlParams = location.search;
    if (urlParams && urlParams.indexOf('?') != -1) {
        urlParams = urlParams.substr(1);
        var params = urlParams.split("&");
        for (var i = 0; i < params.length; i++) {
            var param = params[i].split("=");
            if (param && param.length == 2) {
                requestParams[param[0]] = param[1];
            }
        }
    }
    return requestParams[key];
}


/**
 * 判断是否是微信环境
 * @returns
 */
function isWeiXin(){ 
	var ua = window.navigator.userAgent.toLowerCase(); 
	if(ua.match(/MicroMessenger/i) == 'micromessenger')
	{ 
		return true; 
	}else
	{ 
		return false; 
	} 
}

/**
 * 复制字符串到剪贴板
 * @param str
 * @param msg
 */
function copyToPasteboard(str,msg){
	if(undefined == msg || 'undefined' == msg || '' == msg){
		msg = "";
	}
	if(isiOS){
		bridges.callHandler('copyToPasteboard', {"str":str,"msg":msg}, function(response) {
	    });
	}else{
		android.callHandler('copyToPasteboard', {"str":str,"msg":msg}, function(response) {
	    });
	}
}

/**
 * squareFlag 是否需要裁剪图片  0不需要 1需要
 * 清除缓存
 */
function uploadFileApp(squareFlag,callBack){
	if(squareFlag == '' || squareFlag == null || squareFlag == undefined) {
		squareFlag = 0;
	}
	if(isiOS){
		bridges.callHandler('uploadFile', {"flag":squareFlag}, callBack);
	}else{
		android.callHandler('uploadFile', {"flag":squareFlag}, callBack);
	}
}

/**
 * 上传视频
 */
function uploadMediaApp(callBack){
	if(isiOS){
		bridges.callHandler('uploadMediaApp', {}, callBack);
	}else{
		android.callHandler('uploadMediaApp', {}, callBack);
	}
}

/**
 * 上传认证成功，到待审核状态
 */
function uploadAuthSuccess(){
	if(isiOS){
		bridges.callHandler('uploadAuthSuccess', {}, function(response) {
	    });
	}else{
		android.callHandler('uploadAuthSuccess', {}, function(response) {
	    });
    }
}

/**
 * 安卓端返回键点击事件
 */
function androidBackEvent(callBack){
	if(!isiOS){
		android.callHandler('backEvent', {}, callBack);
	}
}

/**
 * 开始认证
 */
function startAppAuth(){
	if(isiOS){
		bridges.callHandler('startAppAuth', {}, function(response) {
	    });
	}else{
		android.callHandler('startAppAuth', {}, function(response) {
	    });
    }
}

/**
 * 开始认证 APP调起网页支付
 */
function openAppAuthPay(url){
	if(isiOS){
		bridges.callHandler('openAppAuthPay', {"url":url}, function(response) {
	    });
	}else{
		android.callHandler('openAppAuthPay', {"url":url}, function(response) {
	    });
    }
}

/**
 * 开始认证 网页调起APP支付
 */
function openAppInnerAuthPay(){
	if(isiOS){
		bridges.callHandler('openAppInnerAuthPay', {}, function(response) {
	    });
	}else{
		android.callHandler('openAppInnerAuthPay', {"money":28}, function(response) {
	    });
    }
}

/**
 * 添加意见反馈
 */
function openAddFeedBack(){
	if(isiOS){
		bridges.callHandler('openAddFeedBack', {}, function(response) {
	    });
	}else{
		android.callHandler('openAddFeedBack', {}, function(response) {
	    });
    }
}


/**
 * 返回
 */
function goBack(){
	if(isiOS){
		bridges.callHandler('goBack', {}, function(response) {
	    });
	}else{
		android.callHandler('goBack', {}, function(response) {
	    });
    }
}

/**
 * 退出登录
 */
function nativeLogOut(){
	if(isiOS){
		bridges.callHandler('nativeLogOut', {}, function(response) {
	    });
	}else{
		android.callHandler('nativeLogOut', {}, function(response) {
	    });
    }
}

/**
 * 打开用户详情
 */
function openUserDetail(uid){
	if(isiOS){
		bridges.callHandler('openUserDetail', {"uid":uid}, function(response) {
	    });
	}else{
		android.callHandler('openUserDetail', {"uid":uid}, function(response) {
	    });
    }
}

/**
 * 打开APP主页
 */
function openMainTab(){
	if(isiOS){
		bridges.callHandler('openMainTab', {}, function(response) {
	    });
	}else{
		android.callHandler('openMainTab', {}, function(response) {
	    });
    }
}

/**
 * 逛一逛
 * @param uid
 * @param nickName
 * @param uheader
 */
function openJustLook(uid,nickName,uheader){
	if(isiOS){
		bridges.callHandler('justLook', {"uid":uid,"nickName":nickName,"uheader":uheader}, function(response) {
	    });
	}else{
		android.callHandler('justLook', {"uid":uid,"nickName":nickName,"uheader":uheader}, function(response) {
	    });
    }
}

/**
 * 我要上榜
 * @param uid
 * @param nickName
 * @param uheader
 */
function iWantOnTop(msg){
	if(isiOS){
		bridges.callHandler('iWantOnTop', {"msg":msg}, function(response) {
	    });
	}else{
		android.callHandler('iWantOnTop', {"msg":msg}, function(response) {
	    });
    }
}

/**
 * 快速升级
 */
function openQuickLevelPage(){
	if(isiOS){
		bridges.callHandler('openQuickUpLevel', {}, function(response) {
	    });
	}else{
		android.callHandler('openQuickUpLevel', {}, function(response) {
	    });
    }
}

/**
 * 打开原生图片分享
 */
function openPicShare(){
	if(isiOS){
		bridges.callHandler('openPicShare', {}, function(response) {
	    });
	}else{
		android.callHandler('openPicShare', {}, function(response) {
	    });
    }
}

/**
 * 打开成为会员页
 */
function openBecomeMemberPage(uid,nickName,uheader){
	if(isiOS){
		bridges.callHandler('openBecomeMember', {"uid":uid,"nickName":nickName,"uheader":uheader}, function(response) {
	    });
	}else{
		android.callHandler('openBecomeMember', {"uid":uid,"nickName":nickName,"uheader":uheader}, function(response) {
	    });
    }
}

/**
 * 消息提示
 */
function nativeToast(msg){
	if(isiOS){
		bridges.callHandler('nativeToast', {"msg":msg}, function(response) {
	    });
	}else{
		android.callHandler('nativeToast', {"msg":msg}, function(response) {
	    });
    }
}

/**
 * 认证测试做完了
 */
function doneAuthExam(){
	if(isiOS){
		bridges.callHandler('doneAuthExam', {}, function(response) {
	    });
	}else{
		android.callHandler('doneAuthExam', {}, function(response) {
	    });
	}
}

/**
 * 调用原生分享能力
 * @param title
 * @param descr
 * @param imgurl
 * @param url
 * @returns
 */
function nativeShare(title,descr,imgUrl,url){
	if(isiOS){
		bridges.callHandler('nativeShare', {"title":title,"descr":descr,"imgUrl":imgUrl,"url":url}, function(response) {
	    });
	}else{
		android.callHandler('nativeShare', {"title":title,"descr":descr,"imgUrl":imgUrl,"url":url}, function(response) {
	    });
    }
}

/**
 * 调用原生选择图片
 */
function nativeSelectPhoto(maxCount,callback){
    if(isiOS){
        bridges.callHandler('nativeSelectPhoto', {"maxCount":maxCount}, callback);
    }else{
        android.callHandler('nativeSelectPhoto', {"maxCount":maxCount}, callback);
    }
}

/**
 * 调用原生用户信息
 * callback返回uid、authToken、authUser
 */
function getNativeUserInfo(callback){
    if(isiOS){
        bridges.callHandler('getUserInfo', {}, callback);
    }else{
		var userInfo = window.app.getUserInfo();
        callback(JSON.parse(userInfo));
    }
}

function uploadImgByNative(base64s,callback){
    if(isiOS){
        bridges.callHandler('uploadImgByNative', {"base64s":base64s}, callback);
    }else{
        android.callHandler('uploadImgByNative', {"base64s":base64s}, callback);
    }
}

/**
 * 调用原生选择图片
 */
function nativeSheetView(strings,callback){
    if(isiOS){
        bridges.callHandler('nativeSheetView', {"strings":strings}, callback);
    }else{
        android.callHandler('nativeSheetView', {"strings":strings}, callback);
    }
}

//iOS
//payType 1会员 2充值 5 SVIP
//productId 1 白银会员   2黄金  3 钻石
//安卓
// payType  1 vip充值、2 驭豆充值 3、入圈 
// vipType  1 白银会员   2黄金  3 钻石   4 svip   默认支付宝支付
// 如果payType=3时 ,vipType 就是入圈所需的money
function callInpurchasePay(payType,productId,callback){
	if(isiOS){
	    bridges.callHandler('callInpurchasePay', {"payType":payType,"productId":productId}, callback);
	}else{
	    android.callHandler('callInpurchasePay', {"payType":payType,"vipType":productId}, function(){});
	}
}

//修改导航栏背景色
function changeNavigationBarBgColor(color){
	if(isiOS){
	    bridges.callHandler('changeNavigationBarBgColor', {"color":color}, function(){});
	}else{
		var colorJson = JSON.stringify({"color":color});
		window.app.changeNavigationBarBgColor(colorJson);
	}
}

//修改导航栏字体颜色
function changeNavigationBarTintColor(color){
	if(isiOS){
	    bridges.callHandler('changeNavigationBarTintColor', {"color":color}, function(){});
	}else{
		var colorJson = JSON.stringify({"color":color});
		window.app.changeNavigationBarTintColor(colorJson);
	}
}

/**
 * 上传图片
 * @param file
 * @param callBack
 */
function uploadWxImage(data,callBackData){
    doPost('/mobile/common/uploadImgByUserData', {
        "fileData": data
    },
    function(data){
    	callBackData(data);
    });
}
/**
 * 图片压缩，默认同比例压缩
 * @param {Object} path    
 *         pc端传入的路径可以为相对路径，但是在移动端上必须传入的路径是照相图片储存的绝对路径
 * @param {Object} obj
 *         obj 对象 有 width， height， quality(0-1)
 * @param {Object} callback
 *         回调函数有一个参数，base64的字符串数据
 */
function dealImage(path, obj, callback){
    var img = new Image();
    img.src = path;
    img.onload = function(){
        var that = this;
        // 默认按比例压缩
        var w = that.width;
        var h = that.height;
        var scale = w / h;
        if(w > obj.width){
        	w = obj.width;
        }
        h = w / scale;
        var quality = 0.7;        // 默认图片质量为0.7
        //生成canvas
        var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
        
        // 创建属性节点
        var anw = document.createAttribute("width");
        anw.nodeValue = w;
        var anh = document.createAttribute("height");
        anh.nodeValue = h;
        canvas.setAttributeNode(anw);
        canvas.setAttributeNode(anh);
              
        ctx.drawImage(that, 0, 0, w, h);
        // 图像质量
        if(obj.quality && obj.quality <= 1 && obj.quality > 0){
            quality = obj.quality;
        }
        // quality值越小，所绘制出的图像越模糊
        var base64 = canvas.toDataURL('image/jpeg', quality);
        // 回调函数返回base64的值
        callback(base64);
    }
}

function getObjectURL(file) {
    var url = null;
    if (window.createObjectURL != undefined) {
        url = window.createObjectURL(file)
    } else if (window.URL != undefined) {
        url = window.URL.createObjectURL(file)
    } else if (window.webkitURL != undefined) {
        url = window.webkitURL.createObjectURL(file)
    }
    return url;
}

/**
 * 公用字符串拼接对象
 */
function StringBuffer(str){
    var arr = [];
    str = str || "";
    arr.push(str);
    this.append = function(str1)
    {
        arr.push(str1);
        return this;
    };
    this.toString = function()
    {
        return arr.join("");
    };
}

/**
 * 获取方图
 */
function getSquareImg(imageUrl) {
	if(imageUrl != undefined &&
		imageUrl != null &&
		imageUrl.length > 0){
		var index = imageUrl.indexOf('myqcloud.com');
		if (index >= 0) {
			return imageUrl + '/maskarty11';
		}else{
			return imageUrl;
		}
	}
	return '';
}

/**
 * 打开客服对话
 */
function contactWithCustomer(){
	if(isiOS){
		bridges.callHandler('contactWithCustomer', {}, function(response) {
	    });
	}else{
		android.callHandler('contactWithCustomer', {}, function(response) {
	    });
    }
}

function htmlEscape(text){ 
	  return text.replace(/[<>"&]/g, function(match, pos, originalText){
	    switch(match){
	    case "<": return "&lt;"; 
	    case ">":return "&gt;";
	    case "&":return "&amp;"; 
	    case "\"":return "&quot;"; 
	  } 
	  }); 
}


function dataFormat(strTime,format){
	var date = new Date();
	if(null != strTime && "" != strTime){
		strTime = strTime.replace('.0','');
		date = new Date(strTime.replace(/-/g, "/"));
	}
	return date.format(format);
}

Date.prototype.format = function(format){
	var o = {
	"M+" : this.getMonth()+1, //month
	"d+" : this.getDate(), //day
	"h+" : this.getHours(), //hour
	"m+" : this.getMinutes(), //minute
	"s+" : this.getSeconds(), //second
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter
	"S" : this.getMilliseconds() //millisecond
	}
	if(/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	}

	for(var k in o) {
		if(new RegExp("("+ k +")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
		}
	}
	return format;
}