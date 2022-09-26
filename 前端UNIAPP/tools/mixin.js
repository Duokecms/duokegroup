
import {
	host
} from '@/tools/siteinfo.js'

import {
	mapState
} from 'vuex'


import {
	checkTelReg,
	assertString,
	assertObject,
	assertArray,
	transNumFn,
	toDoubleNumFn	
} from '@/tools/tools'
export default {
	data() {
		return {			
		};
	},
	methods: {
		// 停止3秒钟
		sleepFn(time = 3) {
			console.log(`sleepFn 阻止程序${time}秒`);
			return new Promise(resFn => {
				setTimeout(() => {
					resFn(`sleepFn 阻塞完毕${time}秒`)
				}, time * 1000)
			})
		},
		
		// main 文件 下 created 方法执行 不操作dom
		mainCreatedFn() {
			let that = this;
			that.$store.commit('setAppStaticPath'); // 设置程序里使用的静态图片路径 (永远不换的图片)
			let token = assertString(uni.getStorageSync('token'));
			if (token.length > 0) {
				that.$store.commit('setToken', token);
				that.hasTokenGetUserInfo(() => {});
			} else {
				that.$store.commit('setToken', '');
				//that.unHasTokenGetUserInfo(() => {});
			}
		
			
			/* 
			let tokenMap = {
				[`https://dev.sjwxsc.com`]: 'a69b2371-58fc-40fd-8b88-894fb9facf5e',
				[`https://localdev.sjwxsc.com`]: '586ea319-8a1e-4461-a6d7-e77358a68fd8'
			}
			that.$store.commit('setToken', tokenMap[host]);
			 */
		
		
		
		},
		async launchFn(e) {
			let that = this;
			
		},

		/*
			@description 全局的 工具函数request封装
			@param
				options <Object> 
					发起网络请求的配置参数
			@return <Promise>
		*/
		['$request'](options) {
			let that = this;
			let {
				method, // 请求方式 <String>
				loading, // 是否显示 加载中 的 等待 动画 <Boolean> 
				temUrl, // 临时的请求地址 一般用来调试 一般用不到
				url, // 请求地址 <String>
				data, // 请求数据 <Object>
				header, // 请求头 <Object>
				useTokenRule, // 使用token规则  <String> 一共两种情况 1.必须使用 否则弹框(传'mustUseToken')   2.默认 有token带上 没有就不带 ('default') 不传使用默认
			} = options;

			// 处理请求的动画
			if (loading) {
				that.hideAllFn();
				uni.showLoading({})
			}
			// 处理可能调试使用的 临时网络地址
			if (temUrl) { // 有临时的请求地址 就 用 临时的请求地址
				url = temUrl;
			} else { // 否则用默认的 host + url 
				url = `${host}${url}`;
			}
			// 处理 使用token规则 header对象


			/* 
				使用token规则
				'mustUseToken' 接口必须有token 如果没有 就 弹框 提示登录
				'toTheFullUseToken'  表示 有token 带上  没有token 留空 也是默认情况
				'notUseToken'  表示 不管有没有token 都不带
			*/



			let headerObj = {};
			if (useTokenRule === 'mustUseToken') {
		
				
				if (uni.getStorageSync('token')) {
					headerObj.token = that.globalToken
				} else {
					that.closeGlobalLoginFn(true);
					return new Promise((resFn, rejFn) => {
						that.logOutFn(); // 先退出登录一下
						resFn({
							statusCode: 200,
							data: {
								code: 400,
								msg: '未登录',
							},
						});
					});
				}
			} else if (useTokenRule === 'notUseToken') {
				headerObj = {};
			} else {
				if (uni.getStorageSync('token')) {
					headerObj.token = that.globalToken
					// console.log('打印全局的token that.globalToken', that.globalToken);
				}
			}
			/* 
			console.log(
				'发起请求时带的header头', headerObj
			);
			 */

			return new Promise((resFn, rejFn) => {
				uni.request({
					timeout: 1000 * 6, // 请求超过6s 自动断开
					method,
					url,
					data,
					header: {
						...headerObj,
						...header,
					},
					success(e) {
						if (e.statusCode == 200 && e.data.code == 401) {
							that.logOutFn(); // 先退出登录一下
							that.closeGlobalLoginFn(true);
							resFn({
								statusCode: 200,
								data: {
									code: 400,
									msg: '未登录',
								},
							});
							return false;
						} else {
							resFn(e);
						}
						if (loading) {
							that.hideAllFn();
						}
					},
					fail(e) {
						resFn(e)
					},
				})
			})
		},
		// 返回上一页
		toBackFn() { // 正常返回上一页 如果没有上一页 就回首页
			if (getCurrentPages().length >= 2) {
				uni.navigateBack({})
			} else {
				this.navigateToFn({
					isTab: true,
					url: '/pages/index/index',
				})
			}
		},

	

		regTel(tel) {
			return checkTelReg.test(tel);
		},
		// 随机的颜色
		tagStyle(index) {
			let arr = ['blueStyle', 'orangeStyle', 'pinkStyle', 'yellowStyle', 'redStyle'];
			index = index ? index : 0;
			return arr[index % arr.length]
		},
		// 生成随机数 传入0,1  会有50%是0  会有50%是1
		randFn(min, max) {
			return Math.round(Math.random() * (max - min)) - min;
		},
		// 页面跳转函数
		
		navigateToFn(obj) {
			
		
			if (obj.checkLogin && !uni.getStorageSync('token')) { // 需要登录才能跳转
				this.closeGlobalLoginFn(true);
				return false;
			}
			if (obj.isTab) { // 是否tab-bar页面
				uni.switchTab({
					url: obj.url,
				})
				return false;
			}
			let typeAttr; // 其他跳转方式
			if (obj.type) {
				typeAttr = obj.type;
			} else {
				typeAttr = 'navigateTo';
			}

			if (getCurrentPages().length >= 9) { // 如果跳转超过9页 就只能删除掉前一页面 重新覆盖  redirectTo 方式
				typeAttr = 'redirectTo';
			}
			uni[typeAttr]({
				...obj,
			})
		},

	


		replaceFn(str, n) {
			let reg = /\{(\d|\D)*\}/;
			if (!reg.test(str)) {
				return str;
			}
			let res = str.match(reg)['0'];
			let result = str.replace(res, n);
			return result
		},


		
		closeGlobalLoginFn(flag) {	
			uni.$emit('setLoginBoxFlag', !!flag);
			uni.$emit('setLoginBoxFlag_indexmine', !!flag);
			uni.$emit('setLoginBoxFlag_indexcircle', !!flag);
			uni.$emit('setLoginBoxFlag_preferred', !!flag);
			uni.$emit('setLoginBoxFlag_home', !!flag);
		},



		/* 
			@description
				去除字符串空格
			@return <Boolean>
				如果不是字符串返回 false
			@param 
				str <String>
					参数传入字符串 返回字符串
		*/
		trimFn(str) {
			if (checkTypeFn(str) == 'String') {
				return this.strTrimFn(str)
			}
			return false
		},
		// 传入的必须是字符串 返回字符串 并把 两边空格去掉
		strTrimFn(str) {
			return assertString(str).trim();
		},

		timeZero(time) {
			let str = time + '';
			return ('000' + str).slice(-2)
		},
		// js对象 转 style标签内 样式
		obj2styleStr(styleObj) {
			let styleStr = '';
			for (let key in styleObj) {
				styleStr += `${key}:${styleObj[key]};`;
			}
			return styleStr;
		},

		// 遮罩层弹框 阻止 下面页面 滚动 阻止冒泡
		catchTouchMove() {
			return false;
		},


		// 给vuex设置 全局配置
		setConfigFn() {
			let that = this;
			return new Promise(async (res) => {			
			
				let result = await that.$request({
					url: '/api/index/GetConfig',
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						let resultObj = assertObject(result.data.data);
						that.$store.commit('setConfigInfo', resultObj.config);									
						res(resultObj.config)
					} else {
						uni.showToast({
							icon: 'none',
							title: result.data.msg
						})
					}
				} else {
					uni.showToast({
						icon: 'none',
						title: that.$errorMsg
					})
				}

			})

		},
		// 判断是否 苹果设备
		checkIsiPhoneXFn() {
			let that = this;
			uni.getSystemInfo({
				success(res) {
					let iPhoneList = ['iPhone X', 'iPhone 11', 'iPhone 11 Pro Max'];
					let modelmes = res.model,
						bool = false;
					iPhoneList.forEach(item => {
						if (modelmes.search(item) != -1) {
							bool = true;
						}
					})
					that.$store.commit('setIsiPhoneX', bool);
				}
			});
		},
		
		// 颜色 16进制色值 转rgba
		hexToRgba(hex, opacity) {
			return "rgba(" + parseInt("0x" + hex.slice(1, 3)) + "," + parseInt("0x" + hex.slice(3, 5)) + "," + parseInt(
				"0x" +
				hex.slice(5, 7)) + "," + opacity + ")";
		},
		// 待开发的提示框
		msg(title) {
			uni.showToast({				
				title:title,
				icon:'none'
			
			})
		},
		// 获取配置里的图片
		getConfigImg(flag) {		
			for (let i = 0; i < this.configInfo.dodecorate.length; i++) {
				if (this.configInfo.dodecorate[i].field == flag) {
					return this.addimgPathHostFn(this.configInfo.dodecorate[i].img)
				}
			}
		},

		// 获取配置里是否显示该项目
		getConfigIsShow(flag) {
			for (let i = 0; i < this.configInfo.dodecorate.length; i++) {
				if (this.configInfo.dodecorate[i].field == flag) {
					return this.configInfo.dodecorate[i].xs == '1'
				}
			}
		},
		// 对比两个数 把高度大的那个值返回
		getH(h1, winh) {
			if (h1 <= winh) {
				return winh;
			}
			return h1;
		},

		/* 
		  分享的函数
			参数obj:{Object}
			  path {String} 纯路径不带参数
			  query {Object} ?后的查询字符串对象
			  options {Object} 官网给出的返回对象配置 例 title imgUrl...
		*/
		shareFn(obj) {
			let that = this;
			let resultObj = {
				...obj.options,
			}


			// 需要带参数并且需要带分享者的 加密字符串
			if (checkTypeFn(obj.query) == 'Object' && Object.keys(obj.query).length > 0 && obj.query.scene) {
					
				if (that.isLogin) {
					obj.query.scene = that.userInfoEncrypt;
				} else {
					delete obj.query.scene;
				}
			}
			resultObj.path = (() => {

				let pathStr = obj.path;

				if (checkTypeFn(obj.query) == 'Object' && Object.keys(obj.query).length > 0) {
					pathStr += `?shareFn=true&`;

					for (let i in obj.query) {
						pathStr += `${i}=${obj.query[i]}&`;
					}
					pathStr = pathStr.substr(0, pathStr.length - 1);
				}
				return pathStr;
			})();


			console.log(
				resultObj, '分享出去的对象', '\n',
			);
			return resultObj;
		},
		// app分享
		shareAppFn(obj) {
			let that = this;
			let resultObj;

			if (Object.keys(assertObject(obj.options)).length > 0) {
				resultObj = {
					...obj.options,
				}
			} else {
				resultObj = {}
			}

			// 需要带参数并且需要带分享者的 加密字符串
			if (checkTypeFn(obj.query) == 'Object' && Object.keys(obj.query).length > 0 && obj.query.scene) {
				if (that.isLogin) {
					obj.query.scene = that.userInfoEncrypt;
				} else {
					delete obj.query.scene;
				}
			}
			resultObj.path = (() => {
				let pathStr = obj.path;

				if (checkTypeFn(obj.query) == 'Object' && Object.keys(obj.query).length > 0) {
					pathStr += `?shareFn=true&`;

					for (let i in obj.query) {
						pathStr += `${i}=${obj.query[i]}&`;
					}
					pathStr = pathStr.substr(0, pathStr.length - 1);
				}
				return pathStr;
			})();

			let {
				imageUrl,
				title,
				path,
			} = resultObj;

			let opt = {
				provider: 'weixin',
				type: 5,
				scene: 'WXSceneSession',
				imageUrl,
				title,
				miniProgram: {
					// id: 'gh_19b177f69985',
					id: that.configInfo.originalid,
					path,
					type: 0, // 微信小程序版本类型，可取值： 0-正式版； 1-测试版； 2-体验版。 默认值为0。
					webUrl: 'https://uniapp.dcloud.io'
				},
				complete(e) {
					console.log(
						'分享完返回的东西', e
					);

				}
			};
			uni.share(opt)
			console.log(
				'app分享的参数信息', opt
			);
		},
		// 打开权限列表函数
		openSettingFn(settingStr) {
			uni.openSetting()
		},

		// 查看权限信息
		settingInfoFn(settingStr) {
			return new Promise((resFn, rejFn) => {
				let obj = {};
				uni.getSetting({
					success(res) {
						obj.type = 'success';
						obj.msg = '获取权限列表成功';
						let keys = Object.keys(res.authSetting);
						if (keys.includes(settingStr)) {
							obj.isFirst = false;
							if (res.authSetting[settingStr]) {
								obj.isOk = true;
							} else {
								obj.isOk = false;
							}
						} else {
							obj.isFirst = true;
						}
						resFn(obj);
					},
					fail() {
						rejFn({
							type: 'error',
							msg: '获取权限列表失败',
							result: '获取权限列表失败'
						});
					}
				});
			});
		},

		/* 
			首页的模板消息 是否被同意过
			@description 查看首页的模板消息 是否被永久同意  同意过后 首页不再弹框
			@param 
				list <Array>
					传首页模板id列表
			@return Object
				Object.type == 'success' 代表 列表里的模板id全部同意过 并 不再弹框提示
				Object.type == 'error'   代表 列表里的模板id 可以弹框提示
		*/
		homeTempIdListIsConfirm(list) {

			return new Promise((resFn, rejFn) => {
				uni.getSetting({
					withSubscriptions: true, //是否同时获取用户订阅消息的订阅状态，默认不获取
					success: res => {
						let arr = [];
						list.forEach((message) => {
							if (res.subscriptionsSetting && res.subscriptionsSetting
								.itemSettings && res.subscriptionsSetting.itemSettings[
									message] == 'accept') {
								arr.push(true);
							} else {
								arr.push(false);
							}
						})
						let everyResult = arr.every(item => item == true)

						if (arr.length == list.length && everyResult) {
							resFn({
								type: 'success',
							})
						} else {
							resFn({
								type: 'error',
							})
						}
					}
				});
			})
		},
		//  查看全局的 订阅消息是否被开启
		getGlobalSendMsgFlag() {
			return new Promise((resFn, rejFn) => {
				uni.getSetting({
					withSubscriptions: true, //是否同时获取用户订阅消息的订阅状态，默认不获取
					success(res) {
						if (checkTypeFn(res.subscriptionsSetting) == 'Object' && Object.keys(res
								.subscriptionsSetting).length > 0 &&
							res.subscriptionsSetting.mainSwitch) {
							resFn({
								type: 'success',
								msg: '订阅消息已开启',
								result: res
							})
						} else {
							resFn({
								type: 'error',
								msg: '订阅消息未开启',
								result: res
							})
						}
					},
					fail(e) {
						resFn({
							type: 'error',
							msg: '获取失败',
							result: e
						})
					}
				});
			})
		},



		/*
			@description 是否是 用户手动关闭的 订阅消息
			@return <Boolean>
				是手动关闭返回 true
				否则返回 false
		*/
		isUserCloneMsg(list) {
			list = assertArray(list);
			return new Promise((resFn, rejFn) => {
				uni.getSetting({
					withSubscriptions: true, //是否同时获取用户订阅消息的订阅状态，默认不获取
					success: res => {
						if (checkTypeFn(res.subscriptionsSetting) == 'Object' && Object.keys(res
								.subscriptionsSetting).length > 0 &&
							res.subscriptionsSetting.mainSwitch) {
							let arr = [];
							list.forEach((message) => {
								if (res.subscriptionsSetting.itemSettings && res
									.subscriptionsSetting.itemSettings[message] == 'reject'
								) {
									arr.push(true);
								} else {
									arr.push(false);
								}
							})
							if (arr.includes(true)) {
								resFn({
									type: 'success',
								})
							} else {
								resFn({
									type: 'error',
								})
							}
						} else {
							resFn({
								type: 'error',
							})
						}
					},
					fail() {
						resFn({
							type: 'error',
						})
					}
				});
			})

		},
		// 返回个人中心数据 没登录时
		getMyPageFn() {
			let that = this;	
			return new Promise(async (resFn, rejFn) => {
				let result = await that.$request({
					url: '/api/index/nouser',
				});
				let resObj = {};
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						let resultObj = assertObject(result.data.data); // 后台返回的数据
						let headWrapInfo = assertObject(resultObj.vip); // 个人中心头部的数据


						let vipIconList = assertArray(headWrapInfo.vip_equity); // 会员权益列表
						let bannerList = assertArray(resultObj.image); // 个人中心的轮播图数据
						let laBaMsg = headWrapInfo
							.user_vip_card_cue; // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
						let vipIcon = headWrapInfo
							.user_vip_card_icon; // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
						let vipTitle = headWrapInfo.vip_eco; // V的图标后的标题文字 后端字段是 vip_eco
						let vipBtnText = headWrapInfo.vip_button; // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button

						resObj = {
							type: 'success',
							msg: result.data.msg,
							result: {
								vipIconList, // 会员权益列表
								bannerList, // 个人中心的轮播图数据
								laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
								vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
								vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
								vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
							}
						}

					} else {
						resObj = {
							type: 'error',
							msg: result.data.msg,
						}
					}
				} else {
					resObj = {
						type: 'error',
						msg: that.$errorMsg,
					}
				}
				resFn(resObj);
			})

		},

		// 返回个人中心数据 登录状态
		getUserInfoFn() {
			let that = this;
			return new Promise(async (resFn, rejFn) => {
				let result = await that.$request({
					url: '/api/User/index',

				});
				let resObj = {};
				if (result.statusCode == 200) {
					if (result.data.code == 200) {					
					
						
						let resultObj = assertObject(result.data.data); // 后台返回的数据

						// 个人中心头部的数据 - 用户的数据
						let userInfoObj = assertObject(resultObj.userinfo);
						let userInfoAvatar = userInfoObj.avatar // 头像地址
						let userInfoNickName = userInfoObj.nickname // 网名
						let userInfoLv = userInfoObj.lv // 等级
						let userInfoMoney = userInfoObj.money // 余额
						let userInfoCoupon = userInfoObj.coupon // 优惠券数量
						let userInfoMc = userInfoObj.mc // 商品券
						let userInfoIntegral = userInfoObj.integral // 积分
						let userInfoMobile = userInfoObj.mobile // 手机号
						let userInfoEncrypt = userInfoObj.encrypt // 加密字符串
						uni.setStorageSync('userInfoEncrypt',userInfoObj.encrypt)


						// 个人中心头部的数据 - 卡片里的东西
						let headWrapInfo = assertObject(resultObj.userVip); // 
						let isVip = headWrapInfo.is_vip == 1 ? true : false; // 是否是vip用户
						let vipName = headWrapInfo.vip_name; // 会员名称   不是会员传的是 普通会员
						let vipTes = headWrapInfo.vip_tes; // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
						let vipEndTime = headWrapInfo.vip_end_time; // 会员过期时间文字  此字段没提示就是空  直接用就行了



						let laBaMsg = headWrapInfo
							.user_vip_card_cue; // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
						let vipIcon = headWrapInfo
							.user_vip_card_icon; // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
						let vipTitle = headWrapInfo.vip_eco; // V的图标后的标题文字 后端字段是 vip_eco
						let vipBtnText = headWrapInfo.vip_button; // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
						let vipIconList = assertArray(headWrapInfo.vip_equity); // 会员权益列表

						// 我的订单-订单数 数据
						let orderNumObj = resultObj.orderNum;
						let orderNumUn = orderNumObj.non_order; // 我的订单-待支付数量
						let orderNumIng = orderNumObj.on_order; // 我的订单-进行中数量
						let orderNumEd = orderNumObj.com_order; // 我的订单-待评价数量


						resObj = {
							type: 'success',
							msg: result.data.msg,
							result: {




								// 个人中心头部的数据 - 用户的数据
								userInfoAvatar, // 头像地址
								userInfoNickName, // 网名
								userInfoLv, // 等级
								userInfoMoney, // 余额
								userInfoCoupon, // 优惠券数量
								userInfoMc, // 商品券
								userInfoIntegral, // 积分
								userInfoMobile, // 手机号
								userInfoEncrypt, // 加密字符串






								isVip, // 是否是vip用户
								vipName, // 会员名称   不是会员传的是 普通会员
								vipTes, // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
								vipEndTime, // 会员过期时间文字  此字段没提示就是空  直接用就行了


								laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
								vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
								vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
								vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
								vipIconList, // 会员权益列表



								// 我的订单-订单数 数据
								orderNumUn, // 我的订单-待支付数量
								orderNumIng, // 我的订单-进行中数量
								orderNumEd, // 我的订单-待评价数量


							}
						}

					} else {
						resObj = {
							type: 'error',
							msg: result.data.msg,
						}
					}
				} else {
					resObj = {
						type: 'error',
						msg: that.$errorMsg,
					}
				}
				resFn(resObj);
			})
		},

		// 没有token的状态获取个人中心数据 并 赋值给vuex
		async unHasTokenGetUserInfo(fn) {
			let that = this;
			let result = await that.getMyPageFn();
			if (result.type == 'success') {
				let {
					vipIconList, // 会员权益列表
					bannerList, // 个人中心的轮播图数据
					laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
					vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
					vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
					vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
				} = result.result;

				that.$store.commit('setPage', {
					vipIconList,
					bannerList,
					laBaMsg,
					vipIcon,
					vipTitle,
					vipBtnText,
				})
			} else {
				uni.showToast({
					icon: 'none',
					title: result.msg,
				})

			}
			fn && fn();
		},

		// 有token状态 获取 我的
		async hasTokenGetUserInfo(fn) {
			let that = this;
			let [myPageResult, userInfoResult] = await Promise.all([that.getMyPageFn(), that.getUserInfoFn()]);
			console.log(
				'个人中心有登录状态下返回的数据'
			);
			
		

			let errorMsg;
			if (myPageResult.type == 'error') {
				errorMsg = myPageResult.msg;
			}
			if (userInfoResult.type == 'error') {
				errorMsg = userInfoResult.msg;
			}


			if (myPageResult.type == 'success' && userInfoResult.type == 'success') {
				let bannerList = myPageResult.result.bannerList; // 个人中心的轮播图数据
				let {
					// 个人中心头部的数据 - 用户的数据
					userInfoAvatar, // 头像地址
					userInfoNickName, // 网名
					userInfoLv, // 等级
					userInfoMoney, // 余额
					userInfoCoupon, // 优惠券数量
					userInfoMc, // 商品券
					userInfoIntegral, // 积分
					userInfoMobile, // 手机号
					userInfoEncrypt, // 加密字符串


					isVip, // 是否是vip用户
					vipName, // 会员名称   不是会员传的是 普通会员
					vipTes, // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
					vipEndTime, // 会员过期时间文字  此字段没提示就是空  直接用就行了


					laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
					vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
					vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
					vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
					vipIconList, // 会员权益列表



					// 我的订单-订单数 数据
					orderNumUn, // 我的订单-待支付数量
					orderNumIng, // 我的订单-进行中数量
					orderNumEd, // 我的订单-待评价数量

				} = userInfoResult.result;






				that.$store.commit('setUserInfoAndPage', {
					// 个人中心头部的数据 - 用户的数据
					userInfoAvatar, // 头像地址
					userInfoNickName, // 网名
					userInfoLv, // 等级
					userInfoMoney, // 余额
					userInfoCoupon, // 优惠券数量
					userInfoMc, // 商品券
					userInfoIntegral, // 积分
					userInfoMobile, // 手机号
					userInfoEncrypt, // 加密字符串


					isVip, // 是否是vip用户
					vipName, // 会员名称   不是会员传的是 普通会员
					vipTes, // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
					vipEndTime, // 会员过期时间文字  此字段没提示就是空  直接用就行了


					laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
					vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
					vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
					vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
					vipIconList, // 会员权益列表



					// 我的订单-订单数 数据
					orderNumUn, // 我的订单-待支付数量
					orderNumIng, // 我的订单-进行中数量
					orderNumEd, // 我的订单-待评价数量

					bannerList, // 个人中心的轮播图数据

				})




			} else {
				uni.showToast({
					icon: 'none',
					msg: errorMsg,
				})
			}
			fn && fn();
		},

		// 小程序 使用 手机号登录时需要获取的信息
		async getLoginData() {
			let that = this;
			return new Promise((resFn, rejFn) => {
				uni.getUserInfo({
					//获取用户信息
					success(userInfoRes) {
						//第一次提示用户授权 成功后的回调 授权后再点直接成功 拿回来用户信息
						uni.login({
							success(e) {
								/* 
								console.log(
									'uni.getUserInfo', userInfoRes, '\n',
									'uni.login', e, '\n',
								);
								 */
								resFn({
									type: 'success',
									msg: '成功',
									result: {
										encryptedData: userInfoRes.encryptedData,
										iv: userInfoRes.iv,
										code: e.code,
									}
								})
							}
						});
					},
				});
			})

		},
		// 获取用户信息
		getUserProfileFn() {
			// #ifdef MP-WEIXIN
			return new Promise((resFn) => {
				uni.getUserProfile({
					desc: '登录信息',
					success(e) {
						console.log('uni.getUserProfile success函数', e);
						resFn({
							type: 'success',
							result: {
								avatarUrl: e.userInfo.avatarUrl,
								nickName: e.userInfo.nickName,
								province: e.userInfo.province,
								city: e.userInfo.city,
								gender: e.userInfo.gender
							},
							msg: '获取个人信息成功'
						})

					},
					fail(e) {
						console.log('失败', e);
						resFn({
							type: 'error',
							result: e,
							msg: '获取个人信息失败'
						})
					}
				});
			});
			// #endif
			// #ifdef APP-PLUS
			return new Promise((resFn) => {
				uni.getUserInfo({
					provider: 'weixin',
					success(infoRes) {
						resFn({
							type: 'success',
							result: {
								avatarUrl: infoRes.userInfo.avatarUrl,
								nickName: infoRes.userInfo.nickName,
								area: `${infoRes.userInfo.province}-${infoRes.userInfo.city}`,
								gender: infoRes.userInfo.gender,
							},
							msg: '获取个人信息成功'
						})
					},
					fail(e) {
						console.log('失败', e);
						resFn({
							type: 'error',
							result: e,
							msg: '获取个人信息失败'
						})
					}
				})
			});
			// #endif
		},
		// 小程序登录
		async loginFn() {
			let that = this;

			let userProfileObject = await that.getUserProfileFn();


			let avatarUrl, nickName, province, city, gender;

			console.log('getUserProfileFn 返回数据', userProfileObject);


			if (userProfileObject.type == 'success') {
				avatarUrl = userProfileObject.result.avatarUrl;
				nickName = userProfileObject.result.nickName;
				province = userProfileObject.result.province;
				city = userProfileObject.result.city;
				gender = userProfileObject.result.gender;


			} else {
				uni.showToast({
					icon: 'none',
					title: '获取个人信息失败'
				})
				return false
			}


			uni.getUserInfo({
				//获取用户信息
				success(userInfoRes) {


					let iv = encodeURIComponent(userInfoRes.iv);
					let encryptedData = encodeURIComponent(userInfoRes.encryptedData);


					console.log('uni.getUserInfo success函数 userInfoRes 数据', userInfoRes);
					//第一次提示用户授权 成功后的回调 授权后再点直接成功 拿回来用户信息
					uni.login({
						async success(e) {
							let code = e.code;
							// 登录时 把分享者的字符串带上
							console.log('uni.login success函数 e数据', e);
							let sharerObj = {};
							let sharerStr = uni.getStorageSync('sharer'); // 带上分享上级的加密字符串
							if (sharerStr) {
								sharerObj.sharer = sharerStr;
							}


							let data = {
								platform: 'wechat_applet',
								code,
								iv,
								encryptedData,
								avatar: avatarUrl,
								nickname: nickName,
								area: `${en2ch(province)}-${en2ch(city)}`,
								sex: gender,
								daren_id:uni.getStorageSync('daren_id'),
								...sharerObj
							};

							let result = await that.$request({
								loading: true,
								url: '/api/User/third',
								data,
							});


							console.log('用户登录时带的参数', data, '\n', '返回的结果', result, '\n');



							if (result.statusCode == 200) {
								if (result.data.code == 200) {

									that.logOutFn(); // 先退出登录一下

									let token = assertObject(result.data.data).token;


									that.$store.commit('setToken', token)

									uni.setStorageSync('token', token);

									that.hideAllFn()
									uni.showLoading({})
									that.hasTokenGetUserInfo(() => {
										uni.hideLoading()
										uni.showToast({
											icon: 'success',
											title: '登录成功'
										})
										setTimeout(() => {
											that.toBackFn() // 正常返回上一页 如果没有上一页 就回首页
										}, 500)
									});
								} else {
									uni.showToast({
										icon: 'none',
										title: result.data.msg
									});
								}
							} else {
								uni.showToast({
									icon: 'none',
									title: that.$errorMsg
								});
							}
						}
					});
				},
				fail(e) {
					console.log(
						'登录失败 小程序 getUserInfo 接口fail ', e
					);
				}
			});

		},

		// #ifdef APP-PLUS


		/*
			@description
				安卓微信登录 获取用户的基本信息
			@param
				platform <String>
					app微信登录 传指定字符串  AppWechatApplet
				avatar <String>
					头像
				nickname <String>
					昵称
				area <String>
					地区
				sex <Number>
					性别 0-未知  1-男  2-女
				sharer
					分享者参数
				app_openid <String>
					用户授权 返回的 openid
				app_unionid <String>
					用户授权 返回的 unionid 
				app_access_token <String>
					用户授权 返回的 access_token
			@return <Promise>
		*/
		getLoginDataFn() {
			return new Promise((resFn, rejFn) => {
				uni.login({
					// onlyAuthorize: true,
					provider: 'weixin',
					success(loginRes) {
						console.log('uni.login success执行', loginRes);
						uni.getUserInfo({
							provider: 'weixin',
							success(infoRes) {
								console.log('uni.getUserInfo success执行', infoRes);

								resFn({
									type: 'success',
									msg: '成功',
									result: {
										/* 

										platform: 'AppWechatApplet',
										avatar: 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK3PJxkHAAHdsbn44qRD8J3ib8TS8l2ffkvFGufCgQOTpR3CaYyaRFfffuaqE90S6B8n2Z4CJw4wRQ/132',
										nickname: '........',
										area: '河北-邯郸',
										sex: 1,
										sharer: '',
										app_openid: 'oZ6jp6rpM0GU_pp_4uhg4DiGroZo',
										app_unionid: 'oTazX0SkF74_css74oKrcuIfAYgU',
										app_access_token: '40_lZREWsa-0LVyhMnPBKKppbmIJ6eb9v-W2gyF7mxPjLF_SJdV7y--ToLUFFSVioKY8y-8Ok6CiXZ8G0ETxTr_4mlBNTUg1z07R0vR3bK2CvU',
										 */

										platform: 'AppWechatApplet',
										avatar: infoRes.userInfo.avatarUrl,
										nickname: infoRes.userInfo.nickName,
										area: `${infoRes.userInfo.province}-${infoRes.userInfo.city}`,
										sex: infoRes.userInfo.gender,
										sharer: '',
										app_openid: loginRes.authResult.openid,
										app_unionid: loginRes.authResult.unionid,
										app_access_token: loginRes.authResult
											.access_token
									}
								});

								// console.log('uni.getUserInfo success 执行', infoRes);
							},
							fail(e) {
								resFn({
									type: 'error',
									msg: 'uni.getUserInfo fail 执行',
									result: e
								});
								// console.log('uni.getUserInfo fail 执行', e);
							}
						});
					},
					fail(e) {
						resFn({
							type: 'error',
							msg: 'uni.login fail 执行',
							result: e
						});
						// console.log('uni.login fail 执行', e);
					}
				});
			});
		},


		// 安卓 微信登录
		async androidWxLoginFn() {
			let that = this;
			let userInfoResult = await that.getLoginDataFn(); // 获取用户信息 开始登录


			if (userInfoResult.type == 'success') {
				console.log('登录需要的参数', userInfoResult.result);

				let result = await that.$request({
					loading: true,
					url: '/api/User/third',
					data: userInfoResult.result
				});
				console.log('用户登录时带的参数', userInfoResult.result, '\n', '返回的结果', result, '\n');




				if (result.statusCode == 200) {
					if (result.data.code == 200) {

						that.logOutFn(); // 先退出登录一下

						let token = assertObject(result.data.data).token;


						that.$store.commit('setToken', token)

						uni.setStorageSync('token', token);

						uni.hideLoading()
						uni.showLoading({})
						that.hasTokenGetUserInfo(() => {
							uni.hideLoading()
							uni.showToast({
								icon: 'success',
								title: '登录成功'
							})
							setTimeout(() => {
								that.toBackFn() // 正常返回上一页 如果没有上一页 就回首页
							}, 500)
						});
					} else {
						uni.showToast({
							icon: 'none',
							title: result.data.msg
						});
					}
				} else {
					uni.showToast({
						icon: 'none',
						title: that.$errorMsg
					});
				}


			} else {
				uni.showToast({
					icon: 'none',
					title: userInfoResult.msg
				});
			}


		},
		// #endif
		// 退出登录
		logOutFn() {
			let that = this;
			uni.setStorageSync('token', ''); // 清空token
			uni.setStorageSync('sharer', ''); // 清空分享上级的加密字符串

			that.$store.commit('setToken', '');
			that.$store.commit('setUserInfoAndPage', {


				userInfoAvatar: '', // 头像地址
				userInfoNickName: '', // 网名
				userInfoLv: 0, // 等级
				userInfoMoney: 0, // 余额
				userInfoCoupon: 0, // 优惠券数量
				userInfoMc: 0, // 商品券
				userInfoIntegral: 0, // 积分
				userInfoMobile: '', // 手机号
				userInfoEncrypt: '', // 加密字符串


				isVip: false, // 是否是vip用户
				vipName: '', // 会员名称   不是会员传的是 普通会员
				vipTes: '', // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
				vipEndTime: '', // 会员过期时间文字  此字段没提示就是空  直接用就行了


				laBaMsg: '', // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
				vipIcon: '', // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
				vipTitle: '', // V的图标后的标题文字 后端字段是 vip_eco
				vipBtnText: '', // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
				vipIconList: [], // 会员权益列表


				orderNumUn: 0, // 我的订单-待支付数量
				orderNumIng: 0, // 我的订单-进行中数量
				orderNumEd: 0, // 我的订单-待评价数量

				bannerList: [], // 个人中心轮播图数据

			})


		},
		/*
			@description
				查看大图
			@param
				imgList <Array>
					一个数组里面放的是一个又一个 图片的地址
				index 是数组索引 显示当前
		*/
		lookBigImgFn(imgList, index = 0) {
			uni.previewImage({
				current: index, //预览图片的下标
				urls: imgList //预览图片的地址，必须要数组形式，如果不是数组形式就转换成数组形式就可以
			})
		},
		/*
			@description
				检测 Session_key 是否过期 并返回code 
			@return <Promise>
		*/
		checkSessionFn() {
			return new Promise((resFn, rejFn) => {
				let resObj = {};
uni.login({
							success(loginInfo) {
								if (loginInfo.errMsg == 'login:ok') {
									resObj = {
										type: 'success',
										msg: '成功',
										result: {
											code: loginInfo.code,
										}
									}
								} else {
									resObj = {
										type: 'error',
										msg: '失败',
									}
								}
								resFn(resObj);
							},
						});
			});
		},
		// 微信小程序 获取用户手机号
		async wxGetTelFn(e) {
			let that = this;
			let checkSessionResult = await that.checkSessionFn();
		
			if (checkSessionResult.type != 'success') {
				uni.showToast({
					icon: 'none',
					title: '获取手机号失败'
				})
				return false;
			}
			let {
				code
			} = checkSessionResult.result;



			let result = await that.$request({
				method: 'post',
				url: '/api/User/BinMobile',
				data: {
					code,
					encryptedData: e.detail.encryptedData,
					iv: e.detail.iv
				},
			});
			console.log(
				'通过微信小程序授权获取用户手机号接口返回数据', result
			);

			uni.$emit('wxBindTel', result);



		},
		
		
		msg(title){
			uni.showToast({
				title:title,
				icon:'none'
			})		
		},
		
		
		
		
		// 隐藏所有 的 loading 动画  和  Toast 提示
		hideAllFn() {
			uni.hideLoading()
			uni.hideToast()
		},
		// #ifdef APP-PLUS || MP-TOUTIAO
		// app 跳转到小程序
		AppOpenMiniprogramFn(options) {
			let that = this;
			let {
				path,
			} = options
			let id = that.configInfo.originalid;
			plus.share.getServices(
				res => {
					var sweixin = null;
					for (var i = 0; i < res.length; i++) {
						var t = res[i];
						if (t.id == 'weixin') {
							sweixin = t;
						}
					}
					if (sweixin) {
						sweixin.launchMiniProgram({
							id,
							path,
							type: 0
						});
					}
				},
				res => {
					console.log('app 跳转到小程序 函数的回调结果', res);
				}
			);
		},
		// app 点在线客服跳转到小程序 的 客服
		appToMiniprogramFn(options) {
			let that = this;
			console.log('options,that.configInfo.service_url', options, that.configInfo.service_url);
			// 没有配置信息进入客服
			if (!options) {
				if (that.configInfo.service_url) {
					let kefuUrl = encodeURIComponent(that.configInfo.service_url);
					console.log(`uniapp跳转的url`, `/packageA/web-view/index?data=${kefuUrl}&title=客服`);
					that.navigateToFn({
						url: `/packageA/web-view/index?data=${kefuUrl}&title=客服`
					});
					return false;
				}
				uni.showModal({
					title: '在小程序里使用此功能',
					success(e) {
						if (e.confirm) {
							// 确认后的回调
							that.AppOpenMiniprogramFn({
								path: `packageA/kefu/kefu`
							});
						}
					}
				});
				return false;
			}

			options.title = options.title ? options.title : '在小程序里使用此功能';
			options.path = options.path ? options.path : 'pages/index/index';
			uni.showModal({
				title: options.title,
				success(e) {
					if (e.confirm) {
						// 确认后的回调
						that.AppOpenMiniprogramFn({
							path: options.path
						});
					}
				}
			});
		},
		// #endif
		// #ifdef H5
		// h5 点在线客服跳转到小程序 的 客服
		h5ToMiniprogramFn() {
			let that = this;
			if (that.configInfo.service_url) {
				location.href = that.configInfo.service_url;
				return false;
			}
			uni.showModal({
				title: '请使用小程序里使用此功能',
				success(e) {
					if (e.confirm) {
						// 确认后的回调
					}
				}
			});
		},
		// #endif
		/*
			@description 调起打电话功能
			@param 
				tel <String> <Number>
				电话号码
		*/
		telFn(tel) {
			uni.makePhoneCall({
				phoneNumber: tel
			});
		},
		// 轮播图点击跳转到对应的页面
		swiperClickFn(item) {
			let that = this;
			console.log('点击轮播图跳转的数据', item);
			/*
				轮播图类型  
					0：无跳转
					1：跳转到单个商品详情
					2：跳转到商品分类
					3：跳转到多个商品列表
					4：跳转到文章
					5：跳转到外部链接
					6：跳转到小程序
					7：跳转平台链接
					8：跳转吃什么详情
					9：跳转专题页面
			*/
			if (item.type == 1) {
				// 1：跳转到单个商品详情
				that.navigateToFn({
					url: `/packageB/goods-detail/goods-detail?goods_id=${item.content}`
				})
			} else if (item.type == 2) {
				// 2：跳转到商品分类
				let str = item.content;
				let idArr = str.split('_');
				let topClassId = idArr[0];
				let leftClassId = idArr[1];
				uni.setStorageSync('home2Class', {
					topClassId,
					leftClassId
				});
				that.navigateToFn({
					isTab: 1,
					url: `/pages/class/class`,
				});
			} else if (item.type == 3) {
				// 3：跳转到多个商品列表
				that.navigateToFn({
					url: `/pages/list-page/home-swiper?goodsIdList=${item.content}`
				});
			} else if (item.type == 4) {
				// 4：跳转到文章
				uni.setStorageSync('helpQuestionItem', {
					title: '',
					content: item.content,
				});
				that.navigateToFn({
					url: `/packageA/kefu/help-detail`
				});
			} else if (item.type == 5) {
				// 5：跳转到外部链接
				that.navigateToFn({
					url: `/packageA/web-view/index?data=${item.content}&title=${item.title}`
				});
			} else if (item.type == 6) {
				// 6：跳转到小程序
				let AppId,
					AppUrl;
				if (checkTypeFn(item.content) == 'String') {
					let info = JSON.parse(item.content)
					AppId = info.AppId;
					AppUrl = info.AppUrl;
				} else {
					AppId = item.content.appid;
					AppUrl = item.content.path;
				}

				uni.navigateToMiniProgram({
					appId: AppId,
					path: AppUrl,
				})
			} else if (item.type == 7) {
				// 7：跳转平台链接
				let tabBarList = [
					`pages/index/index`,
					`pages/class/class`,
					`pages/eat/eat`,
					`pages/cart/cart`,
					`pages/my/my`,
				];

				let navigateToOptions = {
					url: url2navigateToUrlFn(item.content),
				}
				if (tabBarList.includes(item.content)) {
					navigateToOptions.isTab = true;
				}
				that.navigateToFn(navigateToOptions);
			} else if (item.type == 8) {
				// 8：跳转吃什么详情
				that.navigateToFn({
					url: url2navigateToUrlFn(item.content),
				});
			} else if (item.type == 9) {
				that.navigateToFn({
					url: `/packageA/activity/activity?id=${item.content}`
				});
			} else {
				return false;
			}
		},
		// #ifdef APP-PLUS
		// 打开定位服务函数
		openLocationFn() {
			let that = this;
			if (that.appenv == ENVANDROID) { // 判断平台
				var main = plus.android.runtimeMainActivity();
				var Intent = plus.android.importClass('android.content.Intent');
				var Settings = plus.android.importClass('android.provider.Settings');
				var intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
				main.startActivity(intent); // 打开系统设置GPS服务页面
			} else if (that.appenv == ENVIOS) {
				var UIApplication = plus.ios.import('UIApplication');
				var application2 = UIApplication.sharedApplication();
				var NSURL2 = plus.ios.import('NSURL');
				// var setting2 = NSURL2.URLWithString("prefs:root=LOCATION_SERVICES");
				// var setting2 = NSURL2.URLWithString("App-Prefs:root=LOCATION_SERVICES");
				// var setting2 = NSURL2.URLWithString("app-settings");
				var setting2 = NSURL2.URLWithString('App-Prefs:root=Privacy&path=LOCATION');
				// var setting2 = NSURL2.URLWithString("App-Prefs:root=Privacy&path=LOCATION_SERVICES");
				application2.openURL(setting2);
				plus.ios.deleteObject(setting2);
				plus.ios.deleteObject(NSURL2);
				plus.ios.deleteObject(application2);
			}
		},
		/*
			检查是否打开GPS功能
				true 开定位
				false 没有开定位
		*/
		checkOpenGPSServiceByAndroid() {
			let that = this;
			if (that.appenv == ENVANDROID) { // 判断平台
				var context = plus.android.importClass("android.content.Context");
				var locationManager = plus.android.importClass("android.location.LocationManager");
				var main = plus.android.runtimeMainActivity();
				var mainSvr = main.getSystemService(context.LOCATION_SERVICE);
				return mainSvr.isProviderEnabled(locationManager.GPS_PROVIDER)
			} else if (that.appenv == ENVIOS) {
				var cllocationManger = plus.ios.import('CLLocationManager');
				var enable = cllocationManger.locationServicesEnabled();
				var status = cllocationManger.authorizationStatus();
				plus.ios.deleteObject(cllocationManger);
				if (enable && status != 2) {
					return true;
				} else {
					return false;
				}
			}
		},
		// 安卓打开应用信息设置
		openSettingAppFn() {
			let that = this;
			if (that.appenv == ENVANDROID) { // 判断平台
				console.log('我是安卓')
				/* 获取当前手机是否有通知权限 */
				let main = plus.android.runtimeMainActivity();

				let Intent = plus.android.importClass('android.content.Intent');
				let intent = '';
				let Settings = plus.android.importClass("android.provider.Settings");
				let Uri = plus.android.importClass("android.net.Uri");
				intent = new Intent();
				intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
				let uri = Uri.fromParts("package", main.getPackageName(), null);
				intent.setData(uri);
				main.startActivity(intent);
			} else if (that.appenv == ENVIOS) {
				plus.runtime.openURL("app-settings://");
			}
		},
		// #endif

		/*
			
			返回 多规格 获取默认选中的商品 信息
		*/
		getDefaultSpecFn(specFilter, specGoodsDetail) {

			let defaultSelectArr = [];
			specFilter.forEach((itme) => {
				defaultSelectArr.push(itme.itme[0].id);
			})
			specGoodsDetail.forEach(item => {
				defaultSelectArr.push(item.key.split('_').map(item => {
					return transNumFn(item);
				}))
			})
			return {

			}

		},




		/*
			@description
				给图片字符串添加host
			@param
				str <String>
					传入图片的路径字符串 /upload 。。。。。开头的绝对路径
			@return
				返回网络路径
		*/
		addimgPathHostFn(str) {
			let that = this;
			let imgPathStr = assertString(str);
			if (imgPathStr.includes('http://') || imgPathStr.includes('https://')) {
				return imgPathStr;
			} else {
				return `${that.configInfo.path}${imgPathStr}`;
			}
		},


	
	async getlikeComment(id) {
		let that = this;
		return new Promise(async (resFn) => {
			let result = await that.$request({			
				url: '/api/user/likeComment',
				data: {
					id: id,
				},
			})
			let resultObj = {};
	
			if (result.statusCode == 200) {
				if (result.data.code == 200) {	
					
						let backdata = assertObject(result.data); 
					resFn({
						type: 'success',
						msg: result.data.msg,
						result: {
							backdata
						},
					});
				} else {
					resultObj = {
						type: 'error',
						msg: result.data.msg,
						result,
					};
				}
			} else {
				resultObj = {
					type: 'error',
					msg: that.$errorMsg,
					result,
				};
			}
	
			resFn(resultObj);
		});
	},
	async flowgoods(id) {
		let that = this;
		return new Promise(async (resFn) => {
			let result = await that.$request({			
				url: '/api/user/likeGoods',
				data: {
					id: id,
				},
			})
			let resultObj = {};
	
			if (result.statusCode == 200) {
				if (result.data.code == 200) {	
					
						let backdata = assertObject(result.data); 
					resFn({
						type: 'success',
						msg: result.data.msg,
						result: {
							backdata
						},
					});
				} else {
					resultObj = {
						type: 'error',
						msg: result.data.msg,
						result,
					};
				}
			} else {
				resultObj = {
					type: 'error',
					msg: that.$errorMsg,
					result,
				};
			}
	
			resFn(resultObj);
		});
	},
		async flowUser(user_id) {
			let that = this;
			return new Promise(async (resFn) => {
				let result = await that.$request({			
					url: '/api/user/followUser',
					data: {
						user_id: user_id,
					},
				})
				let resultObj = {};

				if (result.statusCode == 200) {
					if (result.data.code == 200) {							
							let backdata = assertObject(result.data); 
						
						if (result.data.msg=='关注成功')
						{				
						var is_follow=true	
						}else{						
						var is_follow=false	
						}
						resFn({
							type: 'success',
							msg: result.data.msg,
							is_follow:is_follow,
							result: {
								backdata
							},
						});
					} else {
						resultObj = {
							type: 'error',
							msg: result.data.msg,
							result,
						};
					}
				} else {
					resultObj = {
						type: 'error',
						msg: that.$errorMsg,
						result,
					};
				}

				resFn(resultObj);
			});
		},
		// 提示更新最新版本
		getNewVersionFn() {
			let isCanIUse = uni.canIUse("getUpdateManager");

			console.log('当前微信版本是否 支持更新小程序代码, canIUse("getUpdateManager")返回结果', isCanIUse);
			if (isCanIUse) {

				const updateManager = uni.getUpdateManager()
				console.log('uni.getUpdateManager 更新详情对象 updateManager', updateManager);
				updateManager.onCheckForUpdate(res => {
					if (res.hasUpdate) {
						updateManager.onUpdateReady(() => {
							uni.showModal({
								title: '更新提示',
								content: '新版本已经准备好，是否重启应用？',
								success(res) {
									if (res.confirm) {
										updateManager.applyUpdate()
									}
								}
							})
						})
						updateManager.onUpdateFailed(() => {
							uni.showModal({
								title: '已经有新版本了哟~',
								content: '新版本已经上线啦~，请您删除当前小程序，重新搜索打开哟~'
							})
						})
					}
				})

			} else {
				uni.showModal({
					title: '提示',
					content: '当前微信版本过低，无法使用该功能，请升级到最新微信版本后重试。'
				})
			}
		},
		/*
			检测是否在配送距离内 
			locationStr <String> 传入字符串类型的坐标数据  经度在前 逗号分隔 纬度在后
		*/
		checkRangeFn(locationStr) {
			let that = this;
			return new Promise(async (resFn, rejFn) => {

				let locationArr = locationStr.split(',');

				let flag;

				if (locationArr[0] - 0 && locationArr[1] - 0) {
					flag = true;
				} else {
					flag = false;
				}

				if (!flag) {
					resFn({
						type: 'error',
						msg: '缺少坐标参数',
						result: locationStr,
					});
					return false;
				}
				let result = await that.$request({
					url: '/api/Address/delivery_range',
					data: {
						location: locationStr
					}
				});

				let resultObj = {};

				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						if (result.data.data) {
							resultObj.type = 'success';
							resultObj.msg = '在配送范围内';
							resultObj.result = result;
						} else {
							resultObj.type = 'error';
							resultObj.msg = '地址不在配送范围内';
							resultObj.result = result;
						}
					} else {
						resultObj.type = 'error';
						resultObj.msg = result.data.msg;
						resultObj.result = result;
					}
				} else {
					resultObj.type = 'error';
					resultObj.msg = that.$errorMsg;
					resultObj.result = result;
				}
				resFn(resultObj);
			});
		},
		// 获取经纬度信息
		getLocationInfoFn() {
			let that = this;
			// #ifdef H5
			/* 
			if (that.isWeixn()) {
				return new Promise(async resFn => {
					let result = await that.getGzhSignPackageFn();
					console.log('that.getGzhSignPackageFn', result);
					if (result.type == success) {
						let jweixin = result.result;

						jweixinModule.config({
							// debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
							appId: jweixin.appId, // 必填，公众号的唯一标识
							timestamp: jweixin.timestamp, // 必填，生成签名的时间戳
							nonceStr: jweixin.nonceStr, // 必填，生成签名的随机串
							signature: jweixin.signature, // 必填，签名
							jsApiList: [
								'getLocation',
								'updateAppMessageShareData'
							], // 必填，需要使用的JS接口列表
							success(res) {
								console.log('jweixinModule.config res', res);
								jweixinModule.getLocation({
									type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
									success(locationInfo) {
										console.log('locationInfo--jweixinModule',
											locationInfo);
										resFn({
											type: 'success',
											msg: '成功',
											result: locationInfo
										});
									},
								});

							}
						});
					} else {
						resFn({
							type: 'error',
							msg: e.msg,
							result
						});
					}

				});
			}
			*/
			// #endif
			return new Promise(resFn => {
				uni.getLocation({
					type: 'gcj02',
					success(locationInfo) {
						resFn({
							type: 'success',
							msg: '成功',
							result: locationInfo
						});
					},
					fail(e) {
						resFn({
							type: 'error',
							msg: '获取位置失败',
							result: e
						});
					}
				});
			});
		},
		/*
			@description
				传入当前设备的经纬度 返回 自提点 列表 数据
			@param
				lon <Number> { 经度 }
				lat <Number> { 纬度 }
		*/
		getDuozitidianFn(lon, lat) {
			let that = this;
			return new Promise(async resFn => {
				let resObj = {};
				let result = await that.$request({
					method: 'post',
					url: `/api/Orderbranch/spusList`,
					data: {
						lon,
						lat
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						let duozitidianList = assertArray(result.data.data).map(item => {
							return {
								id: item.id,
								zitidianName: item.name,
								zitidianAddressText: item.address,
								zitidianImage: item.img,
								zitidianTime: item.bh,
								zitidianDist: item.dist,
								isRange: item.is_range == 1
							};
						});
						resObj = {
							msg: result.data.msg,
							type: 'success',
							result: duozitidianList
						};
					} else {
						resObj = {
							msg: result.data.msg,
							type: 'error',
							result
						};
					}
				} else {
					resObj = {
						msg: that.$errorMsg,
						type: 'error',
						result
					};
				}
				resFn(resObj);
			});
		},
		// 订阅消息 传模板id
		requestSubscribeMessageFn(templateIdList) {
			return new Promise((resFn) => {
				let requestSubscribeMessageOptions = {
					tmplIds: templateIdList,
					success(res) {
						resFn({
							type: 'success',
							result: res,
						});
					},
					fail(e) {
						resFn({
							type: 'error',
							result: e,
						});
					},
					complete(e) {
						console.log('mixin模板消息 requestSubscribeMessageFn 接口返回的东西', e);
					}
				}
				console.log(requestSubscribeMessageOptions);
				uni.requestSubscribeMessage(requestSubscribeMessageOptions);
			});
		},
		/*
			@description
				rpx转px
			@param
				rpx <Number>
			@return <Number>
		*/
		rpxTopxFn(rpx) {
			return windowWidth * rpx / 750;
		},

		// 获取元素信息
		/* 
		getRect(selector) {
			return new Promise((resolve) => {
				let view = uni.createSelectorQuery().select(selector);
				view.fields({
					size: true,
					rect: true,
					scrollOffset: true
				}, (res) => {
					resolve(res);
				}).exec();
			})
		}
		*/
		// #ifdef H5
		isWeixn() {
			const ua = navigator.userAgent.toLowerCase();
			if (ua.match(/MicroMessenger/i) == "micromessenger") {
				return true;
			}
			return false;
		},
		// #endif
		
	
		
		// 使用腾讯地图sdk返回当前坐标对应的 地址信息
		getCurrentAddressInfo(locationInfo) {
			let that = this;
			return new Promise(async resFn => {
				// #ifdef H5
				let url = `https://apis.map.qq.com/ws/geocoder/v1/?key=${
					that.configInfo.tx_map_key
				}&output=jsonp&poi_options=address_format=short&location=${locationInfo.latitude},${
					locationInfo.longitude
				}`;
				try {
					let addressObject = await that.$jsonp(url);
					resFn({
						type: success,
						result: addressObject.result
					});
				} catch (e) {
					resFn({
						type: error,
						msg: 'err:mapSdk',
						result: e
					});
				}
				// #endif

				// #ifdef MP-WEIXIN || APP-PLUS || MP-TOUTIAO
				let qqmapsdk = new QQMapWX({
					key: that.configInfo.tx_map_key
				});
				qqmapsdk.reverseGeocoder({
					location: {
						latitude: locationInfo.latitude,
						longitude: locationInfo.longitude
					},
					poi_options: `address_format=short`,
					success(res) {
						resFn({
							type: success,
							result: res.result
						});
					},
					fail(e) {
						resFn({
							type: error,
							msg: 'err:mapSdk',
							result: e
						});
					},
					complete(e) {
						console.log('qqmapsdk.reverseGeocoder 函数运行完的结果', e);
					}
				});
				// #endif
			});
		},
		// 此方法只是单纯的 复制 啥也不提示 后续显示提示处理交给fn回调函数
		copyStrFn(copyStr, fn) {
			// #ifdef H5
			let inp = document.createElement('input');
			inp.type = "text"
			inp.value = copyStr;
			inp.style.opacity = 0;
			document.body.append(inp);
			inp.select();
			document.execCommand("Copy");
			inp.remove();

			fn && fn();

			// #endif
			// #ifdef MP-WEIXIN || APP-PLUS || MP-TOUTIAO
			uni.setClipboardData({
				data: copyStr,
				success() {
					fn && fn();
				}
			});
			// #endif
		},
		// 复制完提示用户复制成功
		copyFn(copyStr) {
			this.copyStrFn(copyStr, () => {
				uni.showToast({
					icon: 'success',
					title: '拷贝成功'
				});
			})
		},
		// #ifdef H5
		getGzhSignPackageFn() {
			let that = this;
			return new Promise(async resFn => {
				let purl = encodeURIComponent(location.href.split('#')[0]);
				let result = await that.$request({
					method: 'post',
					url: '/api/Index/SignPackage',
					data: {
						purl
					}
				});

				//数据返回后 处理方式  处理数据
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						let {
							jweixin
						} = assertObject(result.data.data);
						resFn({
							type: success,
							result: jweixin,
						})
					} else {
						resFn({
							type: error,
							msg: result.data.msg,
							result,
						})
					}
				} else {
					resFn({
						type: error,
						msg: that.$errorMsg,
						result,
					})
				}
			})
		},
		// #endif
		// 短震动
		vibrateFn() {
			// #ifdef APP-PLUS
			uni.vibrateLong();
			// #endif
			// #ifdef MP-WEIXIN
			uni.vibrateShort();
			// #endif
			// #ifdef H5
			uni.vibrateShort();
			// #endif
		},
		// 是否开启gps定位
		isOpenGps() {
			let systemInfo = uni.getSystemInfoSync();
			if (systemInfo.brand == 'devtools') {
				return true;
			}
			return systemInfo.locationEnabled
		},
	}, // <------methods 结束

	computed: {
		/* 
			@description 是否登录
			@return <Boolean>
				true 是已登录
				false 是未登录
		*/
	   userInfoEncrypt()
	   {	
		   return uni.getStorageSync('userInfoEncrypt');
	   },
		isLogin() {
		return uni.getStorageSync('token');	
		},
		
		globalToken() {				
			return uni.getStorageSync('token');
		},
		
		
		
		/*
			@description 当前用户是否绑定了手机号
			@return <Boolean>
				true 已绑定
				false 未绑定
		*/
		userIsBindMobile() {
			if (this.isLogin && `${this.userInfoMobile}`.length === 11) {
				return true;
			}
			return false;
		},


		/* 
			是否全角
				返回true是全角
				返回false是半角
		*/
		isAllAngle() {
			let that = this;
			return that.configInfo.btn_type == 1;
		},


		/*
			@description 后台是否开启 短信 功能 
			@return <Boolean>
				true 表示 后台有开启 短信服务
				false 表示 后台没开启 短信服务
		*/
		calcIsOpenSMFlag() {
			let that = this;
			/* 
				枚举映射对象 规则是
					 1 表示开启
					 0 表示关闭
			*/
			let mapEnumObj = {
				'1': true,
				'0': false,
			}
			let flag = that.configInfo.sm_status;
			return mapEnumObj[flag];
		},

		/*
			@return <Boolean>
			是否使用了优惠券背景图片
				返回true 使用了背景图片
				返回false 使用了背景颜色
		*/

		isUseCouponBgImg() {
			return this.configInfo.coupon_is_back == 2;
		},
		
		rancolor() {
		  let quotes = [			
		    'purple',			
		    'purplered',			
		    'bluepurple',			
		    'red',
			'aquablue',
			'orangered',
			'blue',			
			'orange',			
			'orangeyellow',
			'indigo',
			'cyan',
			'yellow',			
			'teal',			
			'lime',
			'green',
			'yellowgreen'		
		  ];		
			  const min = 0;
			  const max = 15;
			 let r= Math.round(Math.random() * (max - min)) + min;	
			return quotes[r];
		},
		
		/*
			@description
				全局的是否显示吃什么页面
			@return
				<Boolean>
				true 表示开启
				false 表示关闭
		*/
		isOpenEatPage() {
			let that = this;
			let configInfo = assertObject(that.configInfo)
			let tabBar = assertArray(configInfo.tabbar)
			let isOpenEatPageFlag = false;
			tabBar.forEach(item => {
				if (item.field == 'c') {
					if (item.xs == 1) {
						isOpenEatPageFlag = true;
					} else {
						isOpenEatPageFlag = false;
					}
				}
			})
			return isOpenEatPageFlag;
		},
	
		
		...mapState({
			configInfo: store => store.configInfo, // 全局的配置信息
			appStaticPath: store => store.appStaticPath, // 设置程序里使用的静态图片路径 (永远不换的图片)
			MenuList: store => store.MenuList, // tab-bar 的数据
			isiPhoneX: store => store.isiPhoneX, // 是否iphonx 
			globalToken: store => store.token, // 全局存的 token 串			
			isLogin: store => store.token, // 全局存的 token 串	
			backIconTop: store => store.backIconTop, 		
			isRunBindMobileFunc(store) {
				return transNumFn(assertObject(store.configInfo).manbintel) == 1 ? this.isLogin && this
					.userIsBindMobile : this.isLogin;
			},
			
		}),

	},
	// 全局的 filters 
	filters: {
		//  保留两位小数
		filterTransNum(number) {
			return toDoubleNumFn(transNumFn(number));
		},
		// 把规格字符串的;分好 替换成空格展示
		filterSpecName(specKeyName) {
			specKeyName = assertString(specKeyName);
			return `已选: ${specKeyName.replace(/;/ig,' ')}`;
		},
	},
	

	// 卸载页面时关闭登录框
	onUnload() {
		this.closeGlobalLoginFn(false);
	},
	// 切到其他页面时关闭登录框
	onHide() {
		this.closeGlobalLoginFn(false);
	},
	onShow() {
		uni.hideTabBar();
	
	},
	onLoad() {
		// #ifdef H5
		document.head.innerHTML += `
			<meta name="apple-mobile-web-app-capable" content="yes">
			<meta name="x5-fullscreen" content="true">
			<meta name="fullscreen" content="yes">  
			<meta name='360-fullscreen' content='true' />
		`;
		// #endif
	},
}

