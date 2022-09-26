<template>
	<view class="template-hot tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
		<view slot="back" class='tn-custom-nav-bar__back' >
			<text class='icon tn-icon-left' @click="goBack"></text>
		 <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
		</view>
		</tn-nav-bar>
	  	<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">

		<view class="tn-margin-top-sm" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
			<view class="tn-flex tn-flex-row-between">
				<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
					热门圈子
				</view>
				
				<view class="tn-margin" style="font-size: 50rpx;">
					<text class="tn-icon-fire tn-color-red"></text>
				</view>
			</view>
		</view>
		<view class="tn-margin-left tn-text-sm tn-color-gray" style="margin-top: -25rpx;">
			<text>根据圈子热度实时排名</text>
		</view>
		<view class="">
			<block v-for="(item,index) in news" :key="index">
				<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin"
					@click="navigateToFn({ url: '/circlePages/group?id='+item.id, checkLogin: false })">
					<view class="justify-content-item tn-margin-top">
						<view class="tn-flex tn-flex-row-center tn-flex-col-center">
							<view class="tn-flex tn-flex-row-center tn-padding-right">
								<text class="tn-text-bold tn-text-xxl"
									:class="[`tn-color-${planList[index].color}`]">{{ index+1 }}</text>
							</view>
							<view class="tn-flex tn-flex-row-center tn-flex-col-center">
								<view class="tn-padding-right tn-text-ellipsis">
									<view class="tn-padding-right tn-padding-left-sm tn-text-bold tn-text-lg">
										{{ item.title }}
									</view>
									<view class="tn-padding-right tn-padding-left-sm tn-color-gray">
										<text>{{ item.title_sub }}</text>
									</view>
								</view>
							</view>
						</view>
					</view>
					<view class="justify-content-item tn-flex-row-center tn-margin-top tn-text-xl">
						<text class="tn-icon-up-arrow tn-text-bold"></text>
						<text class="tn-padding-left">{{ item.hot }}</text>
					</view>
				</view>
			</block>
		</view>




		<view class="" style="margin-top: 50rpx;">
			<view class="tn-flex tn-flex-row-between">
				<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
					所有圈子
				</view>
				<view class="tn-margin" style="font-size: 50rpx;">
					<text class="tn-icon-data"></text>
				</view>
			</view>
		</view>

		<view class="tn-margin-left tn-text-sm tn-color-gray" style="margin-top: -25rpx;">
			<text>你喜欢的圈子全在这里</text>
		</view>


		<!-- 不建议写时间，因为写了时间，你就要经常更新文章了鸭-->
		<view class="">
			<block v-for="(item, index) in content" :key="index">
				<view class="article-shadow tn-margin">
					<view class="tn-flex" @click="navigateToFn({ url: '/circlePages/group?id='+item.id, checkLogin: false })">
						<view class="image-pic tn-margin-sm" :style="'background-image:url(' + item.image + ')'">
							<view class="image-article">
							</view>
						</view>
						<view class="tn-margin-sm tn-padding-top-xs" style="width: 100%;" >
							<view class="tn-text-lg tn-text-bold clamp-text-1 tn-text-justify">
								{{ item.title }}
							</view>
							<view class="tn-padding-top-xs" style="min-height: 105rpx;">
								<text class="tn-text-df tn-color-gray clamp-text-2 tn-text-justify">
									{{ item.title_sub }}
								</text>
							</view>
							<view class="tn-flex tn-flex-row-between tn-flex-col-between">
								<view class="justify-content-item tn-color-gray tn-text-center tn-color-gray--disabled"
									style="padding-top: 5rpx;">
								
									<text class="tn-padding-right tn-text-df tn-color-gray">关注 {{ item.follow_num }}</text>

									<text class="tn-padding-right tn-text-df tn-color-gray">帖子 {{ item.goods_num }}</text>
								
									<text class="tn-padding-right tn-text-df tn-color-gray">热度 {{ item.hot }}</text>
								</view>
							</view>
						</view>
					</view>
				</view>
			</block>
		</view>

  	</mescroll-body>

	</view>
</template>


<script>
	import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
	import MescrollBody from '@/components/mescroll-uni/mescroll-body.vue';
	import MescrollUni from '@/components/mescroll-uni/mescroll-uni.vue';
	import MescrollMixin from '@/components/mescroll-uni/mescroll-mixins.js';
	export default {
		name: 'TemplateGroup',
		mixins: [template_page_mixin,MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				cardCur: 0,
				swiperList: [],
				content: [],
				planList: [{
					color: 'red',
				}, {
					color: 'cyan',
				}, {
					color: 'blue',
				}, {
					color: 'green',
				}, {
					color: 'orange',
				}, {
					color: 'purplered',
				}, {
					color: 'purple',
				}],
				news: [],
			}
		},


		onLoad(option) {
			let that = this
			uni.$off('setLoginBoxFlag');
			uni.$on('setLoginBoxFlag', loginBoxFlag => {
				that.loginBoxFlag = loginBoxFlag;
			});
			if (option.id) {
				this.id = option.id
			}
			
		},

		methods: {
		
		
		/// 列表调用
		downCallback(mescroll) {
			mescroll.endSuccess();
			mescroll.resetUpScroll();
		},	
		async upCallback(mescroll) {
			let that = this;
			let result = await that.$request({
				loading: 1,
				method: 'post',
				url: '/api/Category/GetCategoryList',
				data: {
					id:that.id,
					page: mescroll.num
				}
			});
			if (result.statusCode == 200) {
				if (result.data.code == 200) {					
				if (mescroll.num == 1) {
					that.news = result.data.data.hot;		
					that.content = result.data.data.all.data;
				} else {
					that.content = that.content.concat(result.data.data.all.data);
				}
				mescroll.endSuccess(result.data.data.all.data.length,result.data.data.all.data.length >= mescroll.size);	
								
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
		
		
		







			// cardSwiper
			cardSwiper(e) {
				this.cardCur = e.detail.current
			},
			// 跳转
			tn(e) {
				uni.navigateTo({
					url: e,
				});
			},
		}
	}
</script>

<style lang="scss" scoped>
	.template-plan {}

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
	.card-swiper {
		height: 570rpx !important;
	}

	.card-swiper swiper-item {
		width: 450rpx !important;
		left: 30rpx;
		box-sizing: border-box;
		padding: 0rpx 0rpx 80rpx 0rpx;
		overflow: initial;
	}

	.card-swiper swiper-item .swiper-item {
		width: 100%;
		display: block;
		height: 100%;
		border-radius: 10rpx;
		transform: scale(0.7) translate(0rpx, -104rpx);
		transition: all 0.3s ease-in 0s;
		// overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item {
		transform: none;
		transition: all 0.3s ease-in 0s;
	}

	.card-swiper swiper-item .swiper-item-text {
		margin-top: -100rpx;
		width: 100%;
		display: block;
		height: 50%;
		border-radius: 10rpx;
		transform: translate(20rpx, -30rpx) scale(0.7, 0.7);
		transition: all 0.4s ease 0s;
		overflow: hidden;
		color: #000000;
		// background-image: linear-gradient(rgba(255, 255, 255, 0), rgba(0, 0, 0, 0));
		height: 140rpx;
	}

	.card-swiper swiper-item.cur .swiper-item-text {
		margin-top: -150rpx;
		padding-left: 30rpx;
		width: 500rpx !important;
		transform: translate(-25rpx, 20rpx) scale(0.9, 0.9);
		transition: all 0.4s ease 0s;
		color: #FFFFFF;
		text-shadow: 0rpx 10rpx 20rpx rgba(0, 0, 0, 0.1);
		// background-image: linear-gradient(rgba(255, 255, 255, 0.01), rgba(0, 0, 0, 0.4));
		height: 137rpx;
	}

	.image-banner {
		display: flex;
		align-items: center;
		justify-content: center;
		// border: 1rpx solid red;
	}

	.image-banner image {
		width: 100%;
		height: 100%;
	}

	/* 轮播指示点 start*/
	.indication {
		z-index: 9999;
		width: 100%;
		height: 36rpx;
		position: absolute;
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
	}

	.spot {
		background-color: #000;
		opacity: 0.4;
		width: 10rpx;
		height: 10rpx;
		border-radius: 20rpx;
		margin: 0 8rpx !important;
		right: -270rpx;
		top: -100rpx;
		position: relative;
	}

	.spot.active {
		opacity: 1;
		width: 10rpx;
		background-color: #000;
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
</style>
