<template>
	<view class="template-business tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back' >
				<text class='icon tn-icon-left' @click="goBack"></text>
			 <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
		</tn-nav-bar>
	
		<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
		<view class='nav-list tn-margin-bottom tn-margin-top'  :style="{paddingTop: vuex_custom_bar_height + 'px'}">

		  
		   


			<block v-for="(item, index) in content" :key="index" >
				<view class="nav-list-item tn-shadow-blur tn-cool-bg-image"
					:class="['tn-main-gradient-' + item.color + '--light']" @click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.id, checkLogin: false })">
					<view class="nav-link">
						<view class='title tn-text-bold' style="color: #080808;">{{ item.nickname }}</view>
						<view class='join tn-color-grey tn-text-sm clamp-text-2'>{{ item.dec }}</view>
					</view>
					<view class="icon tn-shadow-blur" :class="['tn-bg-' + item.color]" style="opacity: 0.5;">
						<!-- <view class="" :class="['tn-icon-' + item.icon]"></view> -->
					</view>
					<view class="icon17__item--icon icon tn-flex tn-flex-row-center tn-flex-col-center"
						:style="'background-image:url('+ item.avatar + ');background-size:100% 100%;'">
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
		mixins: [template_page_mixin, MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				user_id:0,
				type: '',
				content: [],
				content: [],				
			}
		},
		onLoad(option) {
			if (option.user_id) {
				this.user_id = option.user_id
			}
			if (option.type) {
				this.type = option.type
			}	
			
		},
		methods: {
	
			
			downCallback(mescroll) {
				mescroll.endSuccess();
				mescroll.resetUpScroll();
			},
			async upCallback(mescroll) {
				let that = this;
				
				let url
				if (that.type=='fans'){
					url='/api/index/fansList'
				}
				if (that.type=='follow'){
					url='/api/index/followList'
				}
				
				let result = await that.$request({
					loading: 1,
					method: 'get',
					url: url,
					data: {
						user_id:that.user_id,
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

		}
	}
</script>
<style lang="scss" scoped>
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

	/* 轮播视觉差 start */
	.card-swiper {
		height: 400rpx !important;
	}

	.card-swiper swiper-item {
		width: 600rpx !important;
		box-sizing: border-box;
		padding: 0rpx 0rpx 40rpx 0rpx;
		overflow: initial;
	}

	.card-swiper swiper-item .swiper-item {
		width: 100%;
		display: block;
		height: 100%;
		border-radius: 10rpx;
		transform: scale(0.85);
		transition: all 0.2s ease-in 0s;
		// 图片背景阴影形式不能要这个
		// overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item {
		transform: none;
		transition: all 0.2s ease-in 0s;
	}

	.card-swiper swiper-item .swiper-item-text {
		text-align: center;
		margin-top: -220rpx;
		width: 100%;
		display: block;
		height: 70%;
		border-radius: 10rpx;
		transform: translate(0rpx, -60rpx) scale(0.8);
		transition: all 0.6s ease 0s;
		overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item-text {
		text-align: center;
		margin-top: -280rpx;
		width: 100%;
		transform: translate(0rpx, 0rpx) scale(0.9, 0.9);
		transition: all 0.6s ease 0s;
	}

	.image-banner {
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.image-banner image {
		width: 100%;
		height: 100%;
	}

	/* banner start */
	.banner-image {
		height: 500rpx;
		position: relative;
	}

	.banner-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		box-shadow: 0rpx 0rpx 80rpx 0rpx rgba(0, 0, 0, 0.15);
		overflow: hidden;
		// background-color: #FFFFFF;
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
		background-color: #E6E6E6;
		opacity: 0.6;
		width: 10rpx;
		height: 10rpx;
		border-radius: 20rpx;
		top: -20rpx;
		margin: 0 8rpx !important;
		position: relative;
	}

	.spot.active {
		opacity: 1;
		width: 30rpx;
		background-color: #FFA726;
	}


	/* 图标容器5 start */
	.icon5 {
		&__item {
			// width: 30%;
			background-color: #FFFFFF;
			border-radius: 10rpx;
			padding: 0rpx;
			margin: 0rpx;
			transform: scale(1);
			transition: transform 0.3s linear;
			transform-origin: center center;

			&--icon {
				width: 100rpx;
				height: 100rpx;
				border-radius: 50%;
				margin-bottom: 18rpx;
				position: relative;
				z-index: 1;
			}
		}
	}

	/* 图标容器5 start */
	.icon17 {
		&__item {
			// width: 30%;
			background-color: #FFFFFF;
			border-radius: 10rpx;
			padding: 0rpx;
			margin: 0rpx;
			transform: scale(1);
			transition: transform 0.3s linear;
			transform-origin: center center;

			&--icon {
				width: 90rpx;
				height: 90rpx;
				border-radius: 50%;
				margin-bottom: 18rpx;
				position: relative;
				z-index: 1;
			}
		}
	}

	/* 组件导航列表 start*/
	.nav-list {
		display: flex;
		flex-wrap: wrap;
		padding: 0rpx 12rpx 0rpx;
		justify-content: space-between;

		/* 列表元素 start */
		.nav-list-item {
			padding: 95rpx 30rpx 5rpx 30rpx;
			border-radius: 12rpx;
			width: 45%;
			margin: 0 18rpx 40rpx;
			background-size: cover;
			background-position: center;
			position: relative;
			z-index: 99;

			/* 元素标题 start */
			.nav-link {
				font-size: 32rpx;
				text-transform: capitalize;
				padding: 0 0 10rpx 0;
				position: relative;

				.title {
					color: #FFFFFF;
					margin-top: 80rpx;
					text-align: center;
				}

				.join {
					color: #FFFFFF;
					margin-top: 30rpx;
					margin-bottom: 40rpx;
					padding: 10rpx;
					text-align: center;
				}
			}

			/* 元素标题 end */

			/* 元素图标 start */
			.icon {
				font-variant: small-caps;
				position: absolute;
				top: 60rpx;
				right: 50rpx;
				left: 37%;
				width: 90rpx;
				height: 90rpx;
				line-height: 90rpx;
				margin: 0;
				padding: 0;
				display: inline-flex;
				text-align: center;
				justify-content: center;
				vertical-align: middle;
				font-size: 50rpx;
				color: #FFFFFF;
				white-space: nowrap;
				opacity: 0.9;
				background-color: rgba(0, 0, 0, 0.05);
				background-size: cover;
				background-position: 50%;
				border-radius: 5000rpx;

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
					background-image: url(https://tnuiimage.tnkjapp.com/cool_bg_image/icon_bg2.png);
				}
			}

			/* 元素图标 end */
		}

		/* 列表元素 end */
	}

	/* 组件导航列表 end*/


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

	/* 重力*/
	.item {
		&__1 {
			position: absolute;
			top: 210rpx;
			left: 84rpx;
			width: 100%;
			// height: 100%;
			z-index: 5;
		}

		&__2 {
			position: absolute;
			top: 885rpx;
			left: 84rpx;
			width: 100%;
			// height: 100%;
			z-index: 4;
		}

		&__3 {
			position: absolute;
			top: 138rpx;
			left: 88rpx;
			width: 100%;
			// height: 100%;
			z-index: 3;
		}

		&__4 {
			position: absolute;
			top: 390rpx;
			left: 84rpx;
			width: 100%;
			// height: 100%;
			z-index: 2;
		}

		&__animation {
			transition: transform 0.6s ease;
		}
	}
</style>
