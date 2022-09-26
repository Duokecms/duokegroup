<template>
	<view class="template-mine tn-safe-area-inset-bottom">

		<tn-nav-bar :isBack="false" :bottomShadow="false" backgroundColor="none">
			<view class="custom-nav tn-flex tn-flex-col-center tn-flex-row-left">
				<!-- 图标logo -->
				<view class="custom-nav__back" @click="navigateToFn({ url: '/minePages/set', checkLogin: true })">
					<view class="tn-icon-set tn-color-white tn-text-shadow-brown" style="font-size: 50rpx;">
					</view>
				</view>

			</view>






		</tn-nav-bar>


		<view class="top-backgroup">
			<image :src='body.bg_img' mode='widthFix' class='backgroud-image'></image>
		</view>


		<view class="about__wrap">

			<view class="meng">
				<!-- 图标logo/头像 -->
				<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-bottom"
					@click="navigateToFn({ url: '/minePages/set', checkLogin: true })">
					<view class="justify-content-item">
						<view class="tn-flex tn-flex-col-center tn-flex-row-left">
							<view class="logo-pic tn-shadow">
								<view class="logo-image">
									<view class="tn-shadow-blur"
										:style="'background-image:url('+body.avatar+');width: 110rpx;height: 110rpx;background-size: cover;'">
									</view>
								</view>
							</view>
							<view class="tn-padding-right">
								<view class="tn-padding-right tn-padding-left-sm tn-text-xl tn-text-bold">
									<text class="tn-color-white">{{body.nickname}}</text>
									<text class="dk-lv">LV {{body.lv}}</text>
									<block v-for="(item,indexdd) in body.medal_list" :key="indexdd">
										<image :src="item.image" mode="heightFix" style="height: 30px;top: 10px;"
											@click="navigateToFn({ url: '/circlePages/medal?id='+id, checkLogin: false })">

										</image>
									</block>

								</view>
								<view class="tn-padding-right tn-padding-top-xs tn-padding-left-sm tn-text-ellipsis">
									<text class="tn-color-white" style="font-size:12px;">IP属地:{{body.city}}
									</text>
								</view>
							</view>
						</view>
					</view>
				</view>
				<view class="tn-margin-left tn-text-sm tn-color-gray" style="margin-top: -25rpx;">
					<text class="tn-color-white tn-text-bold">{{body.dec}}</text>
				</view>





				<view class="blogger-tips-data__info tn-flex">
					<view class="tn-flex-1 tn-padding-sm tn-margin-xs" @click="tofans('follow')">
						<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
							<view class="">
								<view class="tn-text-xl tn-color-white">{{body.guanzhu}}</view>
							</view>
							<view class="tn-margin-top-xs tn-color-gray tn-text-df tn-text-center">
								<text class="tn-padding-left-xs tn-color-white" style="font-size: 12px;">我关注的</text>
							</view>
						</view>
					</view>
					<view class="tn-flex-1 tn-padding-sm tn-margin-xs" @click="tofans('fans')">
						<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
							<view class="">
								<view class="tn-text-xl tn-color-white">{{body.fansi}}</view>
							</view>
							<view class="tn-margin-top-xs tn-color-gray tn-text-df tn-text-center">

								<text class="tn-padding-left-xs tn-color-white" style="font-size: 12px;">我的粉丝</text>
							</view>
						</view>
					</view>
					<view class="tn-flex-1 tn-padding-sm tn-margin-xs">
						<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
							<view class="">
								<view class="tn-text-xl tn-color-white">{{body.zhan}}</view>
							</view>
							<view class="tn-margin-top-xs tn-color-gray tn-text-df tn-text-center">

								<text class="tn-color-white tn-color-white " style="font-size: 12px;">我的获赞</text>
							</view>
						</view>
					</view>



				</view>
			</view>



			<!-- 帖子列表 -->

			<!-- 更多信息-->
			<view class="about-shadow tn-margin-top-xl tn-padding-top-sm tn-padding-bottom-sm tn-bg-white">


				<view class="adver-wrap tn-bg-white">
					<view class="tn-flex tn-flex-row-between tn-padding-top-lg">
						<view class="tn-flex-3 tn-padding tn-margin-left-sm">
							<view class="tn-flex">
								<view class="tn-flex tn-flex-row-center tn-flex-col-center">
									<view class="tn-padding-right tn-text-ellipsis tn-text-left">
										<view class="tn-padding-right tn-color-black tn-text-bold tn-text-xxl">
											会员中心
										</view>
										<view class="tn-padding-right tn-padding-top tn-text-df">{{configInfo.slogan}}
										</view>
									</view>
								</view>
							</view>
						</view>

						<view class="tn-flex-1 justify-content-item tn-padding tn-text-center"
							@click="navigateToFn({ url: '/homePages/search', checkLogin: false })">
							<view class="">
								<text class="tn-icon-search" style="font-size: 70rpx;"></text>
							</view>
							<view class=" tn-padding-top-xs">
								探 索
							</view>
						</view>
					</view>
				</view>


				<!-- 更多信息-->
				<view class="about-shadow tn-margin-top-xl tn-padding-top-sm tn-padding-bottom-sm tn-bg-white">
					<!-- 方式12 start-->
					<view class="tn-flex tn-flex-row-center tn-radius tn-padding-top">
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/minePages/my_group', checkLogin: true })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-moments" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">我的圈子</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/minePages/my_msg', checkLogin: true })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-sound" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">消息通知</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/circlePages/blogger_other', checkLogin: true })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-ticket" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-home">我的主页</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/minePages/my_star', checkLogin: true })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-like" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">我点赞的</text>
								</view>
							</view>
						</view>
					</view>
					<view class="tn-flex tn-flex-row-center tn-radius tn-padding-top">
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/homePages/about?id=25', checkLogin: false })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-computer" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">关于我们</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/homePages/about?id=32', checkLogin: false })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-help" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">帮助中心</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/homePages/about?id=31', checkLogin: false })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-map" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">隐私政策</text>
								</view>
							</view>
						</view>
						<view class="tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/homePages/about?id=26', checkLogin: false })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
								<view
									class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-bg-orange">
									<view class="tn-icon-service" style="color: #080808;"></view>
								</view>
								<view class="tn-text-center">
									<text class="tn-text-ellipsis">联系我们</text>
								</view>
							</view>
						</view>
					</view>
					<!-- 方式12 end-->
				</view>


				<view class="tn-flex" @click="out()" v-if="loginis">
					<view class="tn-flex-1 justify-content-item tn-margin-sm tn-text-center">
						<tn-button backgroundColor="#cfcfcf" padding="40rpx 0" width="60%" shadow fontBold>
							<!-- <text class="tn-icon-light tn-padding-right-xs tn-color-black"></text> -->
							<text class="tn-color-black">退出登录</text>

						</tn-button>
					</view>
				</view>

			</view>




		</view>

		<view class='tn-tabbar-height'></view>


		<!-- 登录框组件 -->
		<login-fn :is-show-login="loginBoxFlag" @loginSuccessCallback="refreshFn" @close="closeGlobalLoginFn">
		</login-fn>


		<!-- 压屏窗-->
		<tn-landscape :show="show_fabu" @close="closeLandscape" closePosition="bottom" :closeSize="60">
			<!-- 方式9 start-->
			<view class="tn-flex" style="margin-bottom: 100rpx;padding-top: 46vh;">
				<view class="tn-flex-1 tn-margin-sm tn-radius"
					@click="navigateToFn({ url: '/circlePages/edit?id=', checkLogin: true })">
					<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
						<view
							class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-red tn-color-white">
							<view class="tn-icon-camera-fill"></view>
						</view>
						<view class="tn-color-white tn-text-sm tn-text-center">
							<text class="tn-text-ellipsis">发布动态</text>
						</view>
					</view>
				</view>
				<view class="tn-flex-1 tn-margin-sm tn-radius"
					@click="navigateToFn({ url: '/circlePages/create?id=', checkLogin: true })">
					<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
						<view
							class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-cyan tn-color-white">
							<view class="tn-icon-flag-fill"></view>
						</view>
						<view class="tn-color-white tn-text-sm tn-text-center">
							<text class="tn-text-ellipsis">发起活动</text>
						</view>
					</view>
				</view>
				<view class="tn-flex-1 tn-margin-sm tn-radius"
					@click="navigateToFn({ url: '/circlePages/build?id=', checkLogin: true })">
					<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
						<view
							class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-blue tn-color-white">
							<view class="tn-icon-topics-fill"></view>
						</view>
						<view class="tn-color-white tn-text-sm tn-text-center">
							<text class="tn-text-ellipsis">创建圈子</text>
						</view>
					</view>
				</view>
			</view>
		</tn-landscape>


	</view>
</template>

<script>
	import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
	import MescrollBody from '@/components/mescroll-uni/mescroll-body.vue';
	import MescrollUni from '@/components/mescroll-uni/mescroll-uni.vue';
	import MescrollMixin from '@/components/mescroll-uni/mescroll-mixins.js';
	export default {
		name: 'TemplateGroup',
		mixins: [template_page_mixin, MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				loginis: '',
				show_fabu: false,
				loading: true,
				loginBoxFlag: false, // 登录框显示隐藏状态
				id: 0,
				body: {
				"nickname":'',
				"lv":0,
				"dec":0,
				"city":0,
				"bg_img":'',
				},
				content: []
			}
		},
		mounted() {

			let that = this
			that.loginis = uni.getStorageSync('token')
			uni.$off('setLoginBoxFlag_indexmine');
			uni.$on('setLoginBoxFlag_indexmine', loginBoxFlag => {
				that.infobody()
				that.loginBoxFlag = loginBoxFlag;

			});
			uni.$on('indexmine', data => {
				if (!uni.getStorageSync('token')) {
					that.loginBoxFlag = true
					return false;
				} else {
					that.loginis = uni.getStorageSync('token')
					that.show_fabu = true
				}
			});
			uni.$on('loginok', data => {
				if (!uni.getStorageSync('token')) {
					that.loginBoxFlag = true
					return false;
				} else {
					that.loginis = uni.getStorageSync('token')				
					that.infobody()
				}
			});

			that.infobody()

		},
		methods: {
			refreshFn() {
				this.infobody()
			},

			out() {
				let that = this
				uni.showModal({
					title: '提示',
					content: '确认退出账号吗?',
					confirmText: '确定',
					success: function(res) {
						if (res.confirm) {
							that.logOutFn();
							uni.reLaunch({
								url: '/pages/index'
							})
						} else if (res.cancel) {
							console.log('用户点击取消');
						}
					}
				});




			},







			infobody() {
				let that = this
				if (!uni.getStorageSync('token')) {
					that.info()
					that.loginBoxFlag = true
					return false;
				} else {
					that.info()
				}
			},


			async guanzhu(id) {

				if (!uni.getStorageSync('token')) {
					this.loginBoxFlag = true
					return false;
				}
				let result = await this.flowUser(id)
				this.body.is_follow = result.is_follow
				this.msg(result.msg)


			},

			async info() {
				let that = this;
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/GetUser',
					data: {}
				});


				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						that.body = result.data.data.userinfo;
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




			/// 列表调用
			downCallback(mescroll) {
				this.info()
			},


			tofans(type) {
				if (!uni.getStorageSync('token')) {
					this.loginBoxFlag = true
					return false;
				}

				this.navigateToFn({
					url: '/circlePages/fans?type=' + type + '&user_id=' + this.id,
					checkLogin: false
				})


			},
			// 关闭压屏窗
			closeLandscape() {
				this.show_fabu = false
			}



		}
	}
</script>

<style lang="scss" scoped>
	.meng {}




	.template-mine {
		max-height: 100vh;
	}

	.tn-tabbar-height {
		min-height: 120rpx;
		height: calc(140rpx + env(safe-area-inset-bottom) / 2);
	}

	/* 自定义导航栏内容 start */
	.custom-nav {
		height: 100%;

		&__back {
			margin: auto 5rpx;
			font-size: 40rpx;
			margin-right: 10rpx;
			flex-basis: 5%;
			width: 100rpx;
			position: absolute;
		}
	}

	/* 自定义导航栏内容 end */

	/* 顶部背景图 start */
	.top-backgroup {


		height: 450rpx;
		z-index: -1;

		.backgroud-image {
			width: 100%;
			height: 250rpx;
			// z-index: -1;
		}
	}

	/* 顶部背景图 end */

	/* 标题 start */
	.nav_title {
		-webkit-background-clip: text;
		color: #0E122A;


		&--wrap {
			position: relative;
			display: flex;
			height: 120rpx;
			align-items: center;
			justify-content: center;
			font-weight: bold;
			background-image: url(https://tnuiimage.tnkjapp.com/title_bg/title44.png);
			background-size: cover;
		}
	}

	/* 标题 end */

	/* 用户头像 start */
	.logo-image {
		width: 110rpx;
		height: 110rpx;
		position: relative;
	}

	.logo-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		border: 8rpx solid rgba(255, 255, 255, 0.05);
		box-shadow: 0rpx 0rpx 80rpx 0rpx rgba(0, 0, 0, 0.15);
		border-radius: 50%;
		overflow: hidden;
		// background-color: #FFFFFF;
	}

	/* 页面 start*/
	.about-shadow {
		border-radius: 15rpx;
		box-shadow: 0rpx 0rpx 50rpx 0rpx rgba(0, 0, 0, 0.07);
	}

	.about {

		&__wrap {
			position: relative;
			z-index: 1;
			margin: 20rpx 30rpx;
			margin-top: -230rpx;
		}
	}

	/* 页面 end*/

	/* 图标容器12 start */
	.tn-three {
		position: absolute;
		top: 50%;
		right: 50%;
		bottom: 50%;
		left: 50%;
		transform: translate(-38rpx, -16rpx) rotateX(30deg) rotateY(20deg) rotateZ(-30deg);
		text-shadow: -1rpx 2rpx 0 #f0f0f0, -2rpx 4rpx 0 #f0f0f0, -10rpx 20rpx 30rpx rgba(0, 0, 0, 0.2);
	}

	.icon20 {
		&__item {
			width: 30%;
			background-color: #FFFFFF;
			border-radius: 10rpx;
			padding: 30rpx;
			margin: 20rpx 10rpx;
			transform: scale(1);
			transition: transform 0.3s linear;
			transform-origin: center center;

			&--icon {
				width: 100rpx;
				height: 100rpx;
				font-size: 60rpx;
				border-radius: 50%;
				margin-bottom: 18rpx;
				position: relative;
				z-index: 1;

				&::after {
					content: " ";
					position: absolute;
					z-index: -1;
					width: 100%;
					height: 100%;
					left: 0;
					bottom: 0;
					border-radius: inherit;
					opacity: 1;
					transform: scale(1, 1);
					background-size: 100% 100%;
					background-image: url(https://tnuiimage.tnkjapp.com/cool_bg_image/icon_bg.png);
				}
			}
		}
	}

	/* 图标容器12 start */
	.icon12 {
		&__item {
			width: 30%;
			background-color: #FFFFFF;
			border-radius: 10rpx;
			padding: 30rpx;
			margin: 20rpx 10rpx;
			transform: scale(1);
			transition: transform 0.3s linear;
			transform-origin: center center;

			&--icon {
				width: 15rpx;
				height: 15rpx;
				font-size: 50rpx;
				border-radius: 50%;
				margin-bottom: 38rpx;
				position: relative;
				z-index: 1;

				&::after {
					content: " ";
					position: absolute;
					z-index: -1;
					width: 100%;
					height: 100%;
					left: 0;
					bottom: 0;
					border-radius: inherit;
					opacity: 1;
					transform: scale(1, 1);
					background-size: 100% 100%;

				}
			}
		}
	}

	/* 图标容器1 start */
	.icon1 {
		&__item {
			// width: 30%;
			background-color: #FFFFFF;
			border-radius: 10rpx;
			padding: 30rpx;
			margin: 20rpx 10rpx;
			transform: scale(1);
			transition: transform 0.3s linear;
			transform-origin: center center;

			&--icon {
				width: 40rpx;
				height: 40rpx;
				font-size: 28rpx;
				border-radius: 50%;
				position: relative;
				z-index: 1;

				&::after {
					content: " ";
					position: absolute;
					z-index: -1;
					width: 100%;
					height: 100%;
					left: 0;
					bottom: 0;
					border-radius: inherit;
					opacity: 1;
					transform: scale(1, 1);
					background-size: 100% 100%;
					background-image: url(https://tnuiimage.tnkjapp.com/cool_bg_image/icon_bg.png);
				}
			}
		}
	}

	/* 图标容器1 end */

	/* 大嘴鸟*/
	.dong {
		z-index: 9999;
		position: fixed;
		top: -40px;
		right: -80px;
		transform: scale(0.24);
		-webkit-transform: scale(0.24);
		-moz-transform: scale(0.24);

	}

	.monster {
		transform: rotate(-50deg);
		-ms-transform: rotate(-50deg);
		/* IE 9 */
		-moz-transform: rotate(-50deg);
		/* Firefox */
		-webkit-transform: rotate(-50deg);
		/* Safari 和 Chrome */
		-o-transform: rotate(-50deg);
		/* Opera */
		display: flex;
		justify-content: center;
		position: relative;
		width: 170px;
		height: 400px;
		border-top-left-radius: 200px;
		border-top-right-radius: 200px;
		background-color: #3C47D7;
		box-shadow: 20px 20px 60px #4650E5;
	}

	.monster__face {
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		position: absolute;
		top: 14%;
		width: 75%;
		height: 160px;
	}

	.monster__noses {
		top: 50%;
		display: flex;
		justify-content: space-between;
		width: 28%;
		height: auto;
		margin-bottom: 10px;
	}

	.monster__nose {
		width: 8px;
		height: 12px;
		border-radius: 20px;
		background: rgba(0, 0, 0, 0.5);
		box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.1);
	}

	.monster__mouth {
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
		width: 100%;
		height: 0%;
		overflow: hidden;
		border: 25px solid #FFC333;
		border-radius: 100px;
		background-color: #810332;
		animation: mouth 1.75s infinite;
		box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.2);
		box-sizing: border-box;
	}

	.monster__mouth::before {
		content: '';
		position: absolute;
		width: 150px;
		height: 80px;
		border-radius: 100px;
		background-color: #400018;
	}

	.monster__mouth::after {
		content: '';
		position: absolute;
		bottom: -80px;
		width: 160px;
		height: 80px;
		border-top-left-radius: 50%;
		border-top-right-radius: 50%;
		background-color: #DC1B50;
		animation: tongue 1.75s infinite;
	}

	.monster__top {
		position: absolute;
		top: -30px;
		width: 170px;
		height: 30px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
		background-color: #ffffff;
		z-index: 100;
		animation: t 1.75s infinite;
	}

	.monster__bottom {
		position: absolute;
		bottom: 0;
		width: 100px;
		height: 30px;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		background-color: #ffffff;
		z-index: 100;
		animation: b 1.75s infinite;
	}


	.avatar-eye {
		position: absolute;
		top: -10%;
		width: 65px;
		height: 65px;
		background: linear-gradient(105deg, white, #cb87f4);
		border-radius: 100%;
		box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.2);
		margin: 3px;
		-webkit-transform: translateX(-50%);
		transform: translateX(-50%);
	}


	.avatar-eye--green {
		background: linear-gradient(to bottom, #fdfdfd, #c3efea);
	}

	.avatar-eye--violet {
		background: linear-gradient(to bottom, #fdfdfd, #e6d6f6);
	}


	.eye--left {
		left: 10%;
	}

	.eye--right {
		left: 85%;
	}

	.eye--center {
		left: 45%;
		top: 10%;
	}

	.avatar-eye-pupil {
		position: absolute;
		width: 55%;
		height: 55%;
		left: 50%;
		top: 25%;
		-webkit-transform: translate(-50%);
		transform: translate(-50%);
		z-index: 100;
		border-radius: 100%;
	}


	.pupil--green {
		background: linear-gradient(135deg, rgba(188, 248, 177, 0.7), #2fa38c 75%);
	}

	.pupil--pink {
		background: linear-gradient(135deg, #f1a183, #8535cd);
	}


	.avatar-eye-pupil-blackThing {
		position: absolute;
		width: 55%;
		height: 55%;
		left: 50%;
		top: 25%;
		background: #2c2f32;
		-webkit-transform: translate(-50%);
		transform: translate(-50%);
		border-radius: 100%;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	}

	.avatar-eye-pupil-lightReflection {
		position: absolute;
		width: 7px;
		height: 7px;
		left: 25%;
		top: 10%;
		background: #ebebeb;
		-webkit-transform: translate(-50%);
		transform: translate(-50%);
		border-radius: 100%;
		box-shadow: 10px 10px 10px rgba(255, 255, 255, 0.2);
	}
</style>
