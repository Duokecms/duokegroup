<template>
	
	<view class="page box-sizing">
		<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back'>
				<text class='icon tn-icon-left' @click="goBack"></text>
				<text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
		</tn-nav-bar>
		<view class="after-dom" :style="{ background: configInfo.web_site_color,marginTop: vuex_custom_bar_height + 'px' }" > 
			
		
		</view>

		<view class="title zIndex10">
			<view class="after" :style="{ background: configInfo.web_site_color }"></view>
			<view class="text">登录</view>
		</view>
		<view class="input-group-block zIndex10">
			<view class="input-item">
				<input class="input-dom" type="text" maxlength="11" v-model="telStr" placeholder="请输入手机号" />
			</view>
			<view class="input-item">
				<input class="input-dom" type="number" maxlength="4" v-model="coedStr" placeholder="请输入验证码" />
				<view class="text" :class="[sendIng ? 'sendIng' : '']" @click="sendSmFn">{{ calcTextStr }}</view>
			</view>
		</view>








	

	
		<button
			class="btn-dom flex-center border-radius clear-btn-style zIndex10"
			:class="[isAllAngle ? 'border-radius-style-all-arg' : 'border-radius-style-half-arg']"
			:style="{ background: configInfo.web_site_color }"
			@click="telLoginFn"
		>
			登录
		</button>
	

	

	
		<view class="reg-block" >
			
			
			<tn-checkbox-group  @change="checkboxGroupChange">
			  <tn-checkbox  name="同意" >同意</tn-checkbox>
			</tn-checkbox-group>
			
			
			
			
			
			<view class="description-text" @click="navigateToFn({ url: `/homePages/about?id=27` })">			
				<view class="text" :style="{ color: configInfo.web_site_color }">用户注册协议</view>
			</view>
			<view class="description-text" style="margin-left: 15px;" @click="navigateToFn({ url: `/homePages/about?id=31` })">			
				<view class="text" :style="{ color: configInfo.web_site_color }">隐私保护政策</view>
			</view>
		</view>
	
	</view>
</template>
<script>
import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
import { assertObject, assertString } from '@/tools/tools.js';
import { host } from '@/tools/siteinfo.js';
let timer;
	export default {
		name: 'TemplateDetails',
		mixins: [template_page_mixin]
		,
	data() {
		return {
			fruit:'',
			is_geree:'',
			// 是否在发送中的状态
			sendIng: false,
			// 用户发送验证码的次数
			sendSmCont: 0,
			// 双向绑定 手机号
			telStr: '',
			// 双向绑定 验证码
			coedStr: '',
			// 间隔一分钟 后可以再次发送
			intervalTime: 60,
			// 显示在页面上的倒计时
			showIntervalStr: 0
		};
	},
	onLoad(options) {
		let that = this;		
	},
	onUnload() {
		clearInterval(timer);
	},
	methods: {
		checkboxGroupChange(event) {
		  this.fruit = event		  
		},
		
		
		text1(){
			let that=this
			// 先退出登录一下
			that.logOutFn();
			let token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOjF9.VQtQaEk7rvMOGHV5dBlNjWpWtBL-gFNpKBMNXTX3_ns';
			that.$store.commit('setToken', token);
			uni.setStorageSync('token', token);			
			uni.hideLoading();
			uni.showLoading({});
			that.hasTokenGetUserInfo(() => {
				uni.hideLoading();
				uni.showToast({
					icon: 'success',
					title: '登录成功'
				});
				setTimeout(() => {
					that.toBackFn();
				}, 500);
			});	
		},

		// 开启倒计时
		startIntervalFn() {
			let that = this;
			that.showIntervalStr = that.intervalTime;
			clearInterval(timer);
			timer = setInterval(() => {
				that.showIntervalStr--;
				if (that.showIntervalStr <= 0) {
					that.sendIng = false;
				}
			}, 1000);
		},
		// 发送验证码
		async sendSmFn() {
			let that = this;			
			if (that.sendIng) {
				return false;
			}
			if (!that.regTel(that.telStr)) {
				uni.showToast({
					icon: 'none',
					title: '手机号码格式错误'
				});
				return false;
			}
			that.sendSmCont++;
			that.sendIng = true;

			that.startIntervalFn();
			let result = await that.$request({
				method: 'post',
				url: `/api/login/sendsms`,
				data: {
					mobile: that.telStr,
					event: 'mobilelogin'
				}
			});

			if (result.statusCode == 200) {
				if (result.data.code == 200) {
					
					if (result.data.data.sms_is==0){
						
						that.coedStr=result.data.data.code
						
						
						uni.showModal({
							title: '提示',
							showCancel:false,
							content: '未开启短信发送,系统自动填写验证码,直接登录即可',
							success: function (res) {
								if (res.confirm) {
							
								} else if (res.cancel) {
								
								}
							}
						});
						
					
						
					}else{
						uni.showToast({
							icon: 'none',
							title: '发送成功，请查收'
						});
					}
					
					
				} else {
					uni.showToast({
						icon: 'none',
						title: result.data.msg
					});
					that.sendIng = false;
				}
			} else {
				uni.showToast({
					icon: 'none',
					title: that.$errorMsg
				});
				that.sendIng = false;
			}
		},
		// 开始登录
		async telLoginFn() {
			let that = this;
			
			if (that.fruit[0]!="同意") {
				uni.showToast({
					icon: 'none',
					title: '请先同意协议和政策'
				});
				return false;
			}
			
			
			if (that.telStr.length <= 0) {
				uni.showToast({
					icon: 'none',
					title: '手机号码不能为空'
				});
				return false;
			}

			if (that.coedStr.length <= 0) {
				uni.showToast({
					icon: 'none',
					title: '验证码不能为空'
				});
				return false;
			}

			let loginData = {};
			// #ifdef MP-WEIXIN
			loginData = await that.getLoginData();
			if (loginData.type != 'success') {
				return false;
			}
			console.log('手机号登录时 的微信', loginData.result, '\n');
			// #endif

			let platformObj = {};

			// #ifdef H5
			platformObj.platform = 'H5';
			// #endif

			// #ifdef APP-PLUS
			platformObj.platform = 'App';
			// #endif

			// #ifdef MP-WEIXIN
			platformObj.platform = '微信';
			// #endif

			let data = {
				// #ifdef MP-WEIXIN
				...loginData.result,
				// #endif
				mobile: that.telStr,
				code: that.coedStr,
				...platformObj
			};
	

			let result = await that.$request({
				loading: true,
				method: 'post',
				url: `/api/login/mobileLogin`,
				data
			});



			if (result.statusCode == 200) {
				if (result.data.code == 200) {
					// 先退出登录一下
					that.logOutFn();
					let token = assertObject(result.data.data).login_token;
					that.$store.commit('setToken', token);
					uni.setStorageSync('token', token);
					uni.hideLoading();
					uni.showLoading({});
					that.hasTokenGetUserInfo(() => {
						uni.hideLoading();
						uni.showToast({
							icon: 'success',
							title: '登录成功'
						});				
												
						that.$emit('loginok',true);
						setTimeout(() => {					
							that.toBackFn();
						}, 500);
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
		},
	
		
	},
	// ↑↑↑↑↑ methods 结束
	computed: {
		// 发送验证码 按钮的文字
		calcTextStr() {
			let that = this;
			// 第一次发送验证码 - 获取验证码
			// 第多次发送验证码 - 重新获取验证码
			let str = ``;
			if (that.sendSmCont <= 0) {
				if (that.sendIng) {
					str = `重新获取(${that.showIntervalStr})`;
				} else {
					str = `获取验证码`;
				}
			} else {
				if (that.sendIng) {
					str = `重新获取(${that.showIntervalStr})`;
				} else {
					str = `获取验证码`;
				}
			}
			return str;
		}
	}
};
</script>

<style lang="scss" scoped>
.page {
	display: block;
	position: relative;
	width: 100%;
	height: 100vh;
	background: #ffffff;
	overflow: hidden;
	.after-dom {
		content: '';
		display: block;
		position: absolute;
		z-index: 5;
		bottom: -520rpx;
		left: 146rpx;
		width: 1200rpx;
		height: 1200rpx;
		border-radius: 100000rpx;
		opacity: 0.2;
	}
	.title {
		position: relative;
		margin-top: 84rpx;
		.text {
			position: relative;
			z-index: 10;
			padding-left: 112rpx;
			font-size: 60rpx;
			font-weight: bold;
			color: #000000;
			line-height: 66rpx;
		}
		.after {
			position: absolute;
			left: 0;
			bottom: 0;
			width: 246rpx;
			height: 16rpx;
		}
	}
	.input-group-block {
		margin-top: 126rpx;
		padding: 0 110rpx;
		.input-item {
			display: flex;
			padding-top: 46rpx;
			padding-left: 0.2em;
			border-bottom: 1px solid #c2c2c2;
			.input-dom {
				flex: 1;
				font-size: 28rpx;
				height: 70rpx;
				padding-left: 0.2em;
				padding-right: 1em;
			}
			.text {
				font-size: 30rpx;
				color: #2c2c2c;
			}
		}
	}
	.btn-dom {
		margin: 66rpx 56rpx;
		text-align: center !important;
		height: 113rpx;
		line-height: 113rpx !important;
		color: #ffffff;
		border-radius: 1000px !important;
	}
	.zIndex10 {
		position: relative;
		z-index: 10;
	}
	.login-third {
		display: flex;
		align-items: center;
		justify-content: center;
		.weixin-login-btn {
			display: flex;
			flex-direction: column;
			align-items: center;
			.icon-blcok {
				width: 80rpx;
				height: 80rpx;
				background: #28c445;
				border-radius: 1000rpx;
				image {
					width: 100%;
					height: 100%;
				}
			}
			.text {
				font-size: 24rpx;
				color: #848484;
				line-height: 2;
			}
		}
	}
	.reg-block {
		display: flex;
		align-items: center;
		justify-content: center;
		position: absolute;
		z-index: 10;
		bottom: 100rpx;
		width: 100vw;
		.description-text {
			font-size: 26rpx;
			color: #686a68;
			.text {
				display: inline-block;
				text-decoration: underline;
			}
		}
	}
}
</style>
