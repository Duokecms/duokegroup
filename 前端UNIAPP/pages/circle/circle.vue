<template>
	<view class="template-plan tn-safe-area-inset-bottom">

		<tn-nav-bar	 fixed :isBack="false">圈子广场</tn-nav-bar>
		<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
		
			<view class="tn-margin-top-sm" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
				<view class="tn-flex tn-flex-row-between tn-bg-yellow  tn-round tn-padding-xs tn-margin">
					<view class="justify-content-item tn-text-center tn-flex" style="padding: 25rpx 30rpx">

						<text class="tn-padding-xs">共有<text class="tn-text-xl">{{ $t.number.formatNumberAddPriceUnit(count.allUser) }}</text>圈友</text>
					</view>
					<view class="justify-content-item tn-text-right tn-padding-top-sm">
						<view class="tn-text-bold">
							圈子<text class="tn-text-xl">{{ $t.number.formatNumberAddPriceUnit(count.category) }}</text>个/
							帖子<text class="tn-text-xl">{{ $t.number.formatNumberAddPriceUnit(count.goods) }}</text>个
						</view>
						<view class="tn-text-xs tn-color-gray--dark tn-padding-top-xs">						
							点赞<text style="font-size: 14px;">{{ $t.number.formatNumberAddPriceUnit(count.goodsLike) }}</text>
							  评论<text style="font-size: 14px;">{{ $t.number.formatNumberAddPriceUnit(count.goodsComment) }}</text>
							  阅读<text style="font-size: 14px">{{ $t.number.formatNumberAddPriceUnit(count.goodsView) }}</text>
						</view>
					</view>
					<view class="justify-content-item tn-text-right tn-margin-right tn-padding-top-lg">
					
					</view>
				</view>
			</view>


			<view class="tn-margin-top-sm">
				<view class="tn-flex tn-flex-row-between">
					<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
						热门博主
					</view>

				</view>
			</view>

			<tn-scroll-list>
				<view class="tn-flex tn-margin-sm">
					<block v-for="(item, indexhot) in user" :key="indexhot">
						<view class="tn-flex-1 tn-padding-sm tn-margin-xs tn-radius"
							@click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.id, checkLogin: false })">
							<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">

								<tn-avatar class="" shape="circle" :src="item.avatar" size="lg">
								</tn-avatar>

								<view class="tn-color-black tn-text-lg tn-text-center">
									<text class="tn-text-ellipsis">{{item.nickname}}</text>
								</view>
							</view>
						</view>
					</block>
				</view>
			</tn-scroll-list>



			<view class="" style="margin-top: -20rpx;">
				<view class="tn-flex tn-flex-row-between">
					<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
						热门话题
					</view>
					<!-- <view class="tn-margin" style="font-size: 50rpx;">
          <text class="tn-icon-data"></text>
        </view> -->
				</view>
			</view>

			<view class="tn-margin-left tn-text-sm tn-color-gray" style="margin-top: -25rpx;">
				<text>这是今日热门话题，请查收吖</text>
			</view>

			<view class="">
				<view class="tn-plan-content tn-margin tn-text-justify">
					<view v-for="(item,indexhuati) in tags" :key="indexhuati"
						class="tn-plan-content__item tn-margin-right tn-round tn-text-sm tn-text-bold tn-color-white"
						:class="['tn-main-gradient-' + rancolor+ '']"
						@click="navigateToFn({ url: '/circlePages/tags_list?id='+item.id, checkLogin: false })">
						<text class="tn-plan-content__item--prefix">#</text> {{item.title}}
					</view>
				</view>
			</view>

			<view class="tn-margin-top">
				<view class="nav_title--wrap">
					<view class="nav_title tn-cool-bg-color-5">
						<text class="tn-icon-copy tn-padding-right-sm"></text>
						最 / 新 / 发 / 布
						<text class="tn-icon-copy tn-padding-left-sm"></text>
					</view>
				</view>
			</view>

			<!-- 了鸭-->
			<block v-for="(item,index) in content" :key="index">
				<quan-list :item="item"></quan-list>
			</block>

		</mescroll-body>


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
				loginBoxFlag: false, // 登录框显示隐藏状态
				show_fabu: false,
				cardCur: 0,
				user: [],
				tags: [],
				count:[],
				content: [],
				planList: [],

			}
		},

	

		mounted() {
			let that = this
			uni.$off('setLoginBoxFlag_indexcircle');
			uni.$on('setLoginBoxFlag_indexcircle', loginBoxFlag => {
				console.log('登录返回')
				that.loginBoxFlag = loginBoxFlag;
			});
			this.info()
			uni.$on('indexcircle', data => {
				if (!uni.getStorageSync('token')) {
					that.loginBoxFlag = true
					return false;
				} else {
					that.show_fabu = true
				}

			});


		},


		methods: {

			async info() {
				let that = this;
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/guangChang',
					data: {

					}
				});

				if (result.statusCode == 200) {
					if (result.data.code == 200) {						
						that.count = result.data.data.count;
						that.tags = result.data.data.tags;
						that.user = result.data.data.user;


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
				mescroll.endSuccess();
				mescroll.resetUpScroll();
			},
			async upCallback(mescroll) {
				let that = this;
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/getGoodslist',
					data: {
						page: mescroll.num
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {

						if (mescroll.num == 1) {
							that.content = result.data.data.data;
						} else {
							that.content = that.content.concat(result.data.data.data);
						}
						mescroll.endSuccess(result.data.data.data.length, result.data.data.data.length >= mescroll
							.size);

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
			// 关闭压屏窗
			closeLandscape() {
				this.show_fabu = false
			},
			refreshFn() {

			},

		}
	}
</script>

<style lang="scss" scoped>
	.template-plan {
	max-height: 100vh;
	}

	/* 自定义导航栏内容 start */
	.custom-nav {
		height: 100%;
		background-image: repeating-linear-gradient(-45deg, #fbf7ac69, #fff20014);
		color: #080808;


		&__back {
			margin: auto 5rpx;
			font-size: 40rpx;
			margin-right: 10rpx;
			margin-left: 30rpx;
			flex-basis: 5%;
		}

		&__search {
			flex-basis: 60%;
			width: 100%;
			height: 100%;

			&__box {
				width: 100%;
				height: 70%;
				padding: 10rpx 0;
				margin: 0 30rpx;
				border-radius: 60rpx 60rpx 0 60rpx;
				font-size: 24rpx;
			}

			&__icon {
				padding-right: 10rpx;
				margin-left: 20rpx;
				font-size: 30rpx;
			}

			&__text {
				color: #AAAAAA;
			}
		}
	}
	.icon5__item--icon {
		width: 50px;
		height: 50px;
		border-radius: 50%;
		margin-bottom: 9px;
		position: relative;
		z-index: 1;
	}

	/* 胶囊*/
	.tn-custom-nav-bar__back {
		width: 100%;
		height: 100%;
		position: relative;
		display: flex;
		justify-content: space-evenly;
		align-items: center;
		box-sizing: border-box;
		background-color: rgba(0, 0, 0, 0.15);
		border-radius: 1000rpx;
		border: 1rpx solid rgba(255, 255, 255, 0.5);
		color: #FFFFFF;
		font-size: 18px;

		.icon {
			display: block;
			flex: 1;
			margin: auto;
			text-align: center;
		}

		&:before {
			content: " ";
			width: 1rpx;
			height: 110%;
			position: absolute;
			top: 22.5%;
			left: 0;
			right: 0;
			margin: auto;
			transform: scale(0.5);
			transform-origin: 0 0;
			pointer-events: none;
			box-sizing: border-box;
			opacity: 0.7;
			background-color: #FFFFFF;
		}
	}

	/* 轮播 start*/
	/* 轮播视觉差 start */

	/* 商家 start */
	.card-swiper {
		height: 260rpx !important;
		overflow: hidden;
		// background-color: #00C3FF;
	}

	.card-swiper swiper-item {
		width: 632rpx !important;
		left: -10rpx;
		box-sizing: border-box;
		overflow: initial;
		padding: 0 0rpx 40rpx 0;
	}

	.card-swiper swiper-item .swiper-item {
		width: 100%;
		display: block;
		height: 100%;
		transform: scale(1);
		transition: all 0.2s ease-in 0s;
	}

	.card-swiper swiper-item.cur .swiper-item {
		transform: none;
		transition: all 0.2s ease-in 0s;
	}

	.card-swiper swiper-item .swiper-item-text {
		margin-top: -210rpx;
		width: 100%;
		display: block;
		height: 100%;
		border-radius: 10rpx;
		transform: translate(30rpx, -80rpx) scale(0.8, 0.8);
		transition: all 0.6s ease 0s;
		overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item-text {
		margin-top: -270rpx;
		width: 100%;
		transform: translate(20rpx, 0rpx) scale(0.9, 0.9);
		transition: all 0.6s ease 0s;
	}



	/* 计划内容 start*/
	.tn-plan-content {
		&__item {
			display: inline-block;
			line-height: 45rpx;
			padding: 10rpx 30rpx;
			margin: 20rpx 20rpx 5rpx 0rpx;

			&--prefix {
				padding-right: 10rpx;
			}
		}
	}

	.tn-plan-content2 {
		&__item {
			line-height: 45rpx;
			padding: 15rpx 30rpx;
			margin: 30rpx 0rpx 10rpx 0rpx;

			&--prefix {
				padding-right: 10rpx;
			}
		}
	}

	/* 计划内容 end*/

	/* 资讯主图 start*/
	.image-article {
		border-radius: 8rpx;
		border: 1rpx solid #F8F7F8;
		width: 200rpx;
		height: 200rpx;
		position: relative;
	}

	.image-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		border-radius: 10rpx;
	}

	.article-shadow {
		border-radius: 15rpx;
		box-shadow: 0rpx 0rpx 50rpx 0rpx rgba(0, 0, 0, 0.07);
	}

	/* 文字截取*/
	.clamp-text-1 {
		-webkit-line-clamp: 1;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		text-overflow: ellipsis;
		overflow: hidden;
	}

	.clamp-text-2 {
		-webkit-line-clamp: 2;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		text-overflow: ellipsis;
		overflow: hidden;
	}

	/* 标签内容 start*/
	.tn-tag-content {
		&__item {
			display: inline-block;
			line-height: 35rpx;
			padding: 5rpx 25rpx;

			&--prefix {
				padding-right: 10rpx;
			}
		}
	}


	/* 标题 start */
	.nav_title {
		-webkit-background-clip: text;
		color: transparent;

		&--wrap {
			position: relative;
			display: flex;
			height: 120rpx;
			font-size: 46rpx;
			align-items: center;
			justify-content: center;
			font-weight: bold;
			background-image: url(https://tnuiimage.tnkjapp.com/title_bg/title00.png);
			background-size: cover;
		}
	}

	/* 标题 end */
</style>
