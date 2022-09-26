<template>
	<view class="template-group tn-safe-area-inset-bottom">
	<tn-nav-bar fixed alpha customBack>
	   <view slot="back" class='tn-custom-nav-bar__back' >
	   	<text class='icon tn-icon-left' @click="goBack"></text>
	    <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
	   </view>
	  </tn-nav-bar>
		
		<swiper class="card-swiper" :class="[`tn-cool-bg-color-${body.bg}`]" :circular="true" :autoplay="true" duration="500" interval="28000"
			@change="cardSwiper">
			<swiper-item v-for="(item,indexflash) in swiperList" :key="indexflash.id" >
				<view class="swiper-item image-banner" >
					<image :src="item" mode="aspectFill"></image>
				</view>
			</swiper-item>
		</swiper>
		<!-- 头部start-->
		<view class="shop-function tn-margin-bottom-xl" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
			<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin">
				<view class="justify-content-item">
					<view class="tn-flex tn-flex-col-center tn-flex-row-left">
						<view class="logo-pic tn-shadow-blur" :style='"background-image:url("+body.image+")"'>
							<view class="logo-image">
							</view>
						</view>
						<view class="tn-color-white" style="width: 50vw;">
							<view class="tn-padding-right tn-padding-left-sm tn-text-xl tn-text-bold">
								{{body.title}}
							</view>
							<view
								class="tn-padding-right tn-padding-top-xs tn-text-ellipsis tn-padding-left-sm tn-text-sm">
								<text> {{body.title_sub}}</text>
							</view>						
						</view>
					</view>
				</view>
				<view class="justify-content-item tn-flex-row-center" @click="navigateToFn({ url: '/circlePages/group_fans?id='+id, checkLogin: false })">
					
					<view class="tn-padding-xs tn-color-white tn-round tn-shadow-blur">
						<text>{{body.follow_num}}人关注</text>
						<text class="tn-icon-right-double tn-padding-xs"></text>
					</view>
				</view>
			</view>
		</view>
	

		<view class="group-wrap tn-bg-white" id="page_tips">
<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
			<!-- 悬浮按钮-->
			<view class="tn-flex tn-flex-row-between" style="padding: 10rpx 0 10rpx 0;">
				<view class="tn-flex-1 justify-content-item tn-margin-xs tn-text-center" @click="flow()">
					
					
					<tn-button backgroundColor="#cfcfcf" padding="40rpx 0" width="90%" shadow fontBold v-if="body.is_follow">
						<text class="tn-icon-close tn-padding-right-xs tn-color-black"></text>
						<text class="tn-color-black">取消关注</text>
					</tn-button>
					<tn-button backgroundColor="#00FFC6" padding="40rpx 0" width="90%" shadow fontBold v-else>
						<text class="tn-icon-add tn-padding-right-xs tn-color-black"></text>
						<text class="tn-color-black">关 注</text>
					</tn-button>
					
					
				</view>
				<view class="tn-flex-1 justify-content-item tn-margin-xs tn-text-center" >
					<tn-button backgroundColor="#FFF00D" padding="40rpx 0" width="90%" shadow fontBold
						open-type="share">
						<text class="tn-icon-share-triangle tn-padding-right-xs tn-color-black"></text>
						<text class="tn-color-black">分 享</text>
					</tn-button>
				</view>
			</view>

			<view class="">
				<!-- 帖子列表 -->
				<block v-for="(item, indexzhiding) in body.goods" :key="indexzhiding.id">
				  <view class="tn-margin-sm" @click="navigateToFn({ url: '/circlePages/details?id='+item.id, checkLogin: false })">
				    <view class="tn-flex">      
				      <view class=" " style="width: 100%;">
				        <view class="dk-text-over tn-text-justify">				         
						 <text class="tn-tag-class tn-tag tn-color-white tn-tag--fillet-right" :class="[`tn-cool-bg-color-${body.bg}`]"
						 style="padding: 10px 10px; font-size: 10px; height: 18px; margin: 5px 10px 5px 0px; width: auto;">
							置顶
							 </text>
						 
						 {{ item.content }}
				        </view>      
				      </view>
				    </view>
				  </view>
				</block>
				
				<block v-for="(item,indexad) in content" :key="indexad">
				<quan-list :item="item" ></quan-list>	
				</block>
				
			</view>
	</mescroll-body>
		</view>
		<!-- 登录框组件 -->
		<login-fn :is-show-login="loginBoxFlag" @loginSuccessCallback="refreshFn" @close="closeGlobalLoginFn">
		</login-fn>

    <view class="edit tnxuanfu " @click="navigateToFn({ url: '/circlePages/edit?id='+body.id+'&title='+body.title, checkLogin: true })">
      <view class="bg0 pa button-shop " :class="[`tn-cool-bg-color-${body.bg}`]">
        <view class="bg1 tn-icon-add ">
         
        </view>
      </view>      
    </view>


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
				loginBoxFlag: false, // 登录框显示隐藏状态
				id: 1294,
				body: {
					"title":'',
					"title_sub":'',
					"follow_num":0,
				},
				show1: false,
				cardCur: 0,
				swiperList: [],
				content: [],			
				activeBgAnimation: {}
			}
		},

		onLoad(option) {
		let that=this
		uni.$off('setLoginBoxFlag');
		uni.$on('setLoginBoxFlag', loginBoxFlag => {
			that.loginBoxFlag = loginBoxFlag;
		});			
		
			if (option.id) {
				this.id = option.id
			}
			this.info()					
					
		},
		
		
		
		
		
		
		
		methods: {
			
			async info() {
				let that = this;		
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/Category/GetCategory',
					data: {
						id: this.id
					}
				});		
				
				
				if (result.statusCode == 200) {
					if (result.data.code == 200) {			
						that.body = result.data.data;
						that.swiperList = result.data.data.banner;

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
			refreshFn(){
					this.info()		
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
						cate_id:that.id,
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
					mescroll.endSuccess(result.data.data.data.length,result.data.data.data.length >= mescroll.size);	
									
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



			async flow() {
				
			
			if (!this.isLogin) {
				this.loginBoxFlag = true					
				return false;
			}
			
			
			let that = this;
			let result = await that.$request({
				loading: 1,
				method: 'post',
				url: '/api/user/followgroup',
				data: {
					id: that.id
				}
			});
			if (result.statusCode == 200) {
				if (result.data.code == 200){					
				if (result.data.msg=='取消成功'){
					that.body.is_follow=false					
				}	
				else{
					that.body.is_follow=true
				}					
				uni.showToast({
					icon: 'none',
					title:result.data.msg
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

			// 弹出模态框
			showModal(event) {
				this.openModal()
			},
			// 打开模态框
			openModal() {
				this.show1 = true
			},
			// 初始化导航栏信息
			async initNavBarRectInfo() {
				const navBarRectInfo = await this._tGetRect('#navbar')
				const pageTipsRectInfo = await this._tGetRect('#page_tips')
				// console.log(navBarRectInfo, pageTipsRectInfo, navBarRectInfo?.top, pageTipsRectInfo?.top);
				if (!navBarRectInfo.hasOwnProperty('top') || !pageTipsRectInfo.hasOwnProperty('top')) {
					setTimeout(() => {
						this.initNavBarRectInfo()
					}, 10)
					return
				}
				this.navBarRectInfo = {
					top: navBarRectInfo.top
				}
				this.navBarChangebaseLineHeight = pageTipsRectInfo.top - navBarRectInfo.top
			},
			// 更新导航栏信息
			updateNavBarRectInfo() {
				this._tGetRect('#page_tips').then((res) => {
					const top = res?.top || 0
					if (!top) {
						return
					}
					const differHeight = top - this.navBarRectInfo.top
					const opacity = differHeight / this.navBarChangebaseLineHeight
					if (opacity < 0) {
						// this.navBarStyle.opacity = 1
						// this.navBarStyle.display = 'flex'
						this.navBarStyle.color = 'rgba(0, 0, 0, ${opacity})'
						this.navBarStyle2.color = 'rgba(0, 0, 0, ${opacity})'
						this.navBarBackgroundColor = `rgba(255, 255, 255, 1)`
					} else {
						// this.navBarStyle.opacity = 1 - opacity
						// this.navBarStyle.display = 'flex'
						this.navBarStyle.color = 'rgba(255, 255, 255, 1)'
						this.navBarStyle2.color = 'rgba(255, 255, 255, 0)'
						this.navBarBackgroundColor = `rgba(255, 255, 255, ${1 - opacity})`
					}

					// console.log(top, differHeight, opacity);
				})
			},
			previewQRCodeImage() {
			  wx.previewImage({
			    urls: [this.body.image]
			  })
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
		background-color: rgba(0, 0, 0, 0.03);
		border-radius: 1000rpx;
		border: 1rpx solid rgba(255, 255, 255, 0.5);
		// color: #FFFFFF;
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
			opacity: 0.05;
			background-color: #000000;
		}
	}


	/* 轮播视觉差 start */
	.card-swiper {
		height: 500rpx !important;
	}

	.card-swiper swiper-item {
		width: 750rpx !important;
		left: 0rpx;
		box-sizing: border-box;
		// padding: 0rpx 30rpx 90rpx 30rpx;
		overflow: initial;
	}

	.card-swiper swiper-item .swiper-item {
		width: 100%;
		display: block;
		height: 100%;
		transform: scale(1);
		transition: all 0.2s ease-in 0s;
		overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item {
		transform: none;
		transition: all 0.2s ease-in 0s;
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
		opacity: 0;
	}

	.spot {
		background-color: #FFFFFF;
		opacity: 0.6;
		width: 10rpx;
		height: 10rpx;
		border-radius: 20rpx;
		top: -60rpx;
		margin: 0 8rpx !important;
		position: relative;
	}

	.spot.active {
		opacity: 1;
		width: 30rpx;
		background-color: #FFFFFF;
	}

	/* 顶部店铺 */
	.shop-function {
		position: relative;
		z-index: 1;
		margin-top: -450rpx;
		padding-bottom: 110rpx;
		background-image: linear-gradient(rgba(255, 255, 255, 0.01), rgba(0, 0, 0, 0.4));
	}

	/* 阴影 start*/
	.group-shadow {
		border-radius: 15rpx;
		box-shadow: 0rpx 0rpx 50rpx 0rpx rgba(0, 0, 0, 0.07);
	}

	/* 头像 start */
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
		box-shadow: 0rpx 0rpx 80rpx 0rpx rgba(0, 0, 0, 0.15);
		border-radius: 10px;
		overflow: hidden;
		// background-color: #FFFFFF;
	}

	/* 内容*/
	.group-wrap {
		position: relative;
		z-index: 1;
		// padding: 20rpx 30rpx;
		margin-top: -130rpx;
		margin-bottom: 40rpx;
		border-radius: 30rpx 30rpx 0 0;
	}

	/* 文章内容 start*/
	.blogger {
		&__item {
			padding: 30rpx;
		}

		&__author {
			&__btn {
				margin-right: -12rpx;
				opacity: 0.5;
			}
		}

		&__desc {
			line-height: 55rpx;

			&__label {
				padding: 0 20rpx;
				margin: 0rpx 18rpx 0 0;

				&--prefix {
					color: #00FFC8;
					padding-right: 10rpx;
				}
			}

			&__content {}
		}

		&__content {
			margin-top: 18rpx;
			padding-right: 18rpx;

			&__data {
				line-height: 46rpx;
				text-align: justify;
				overflow: hidden;
				transition: all 0.25s ease-in-out;

			}

			&__status {
				margin-top: 10rpx;
				font-size: 26rpx;
				color: #82B2FF;
			}
		}

		&__main-image {
			border-radius: 16rpx;

			&--1 {
				max-width: 80%;
				max-height: 300rpx;
			}

			&--2 {
				max-width: 260rpx;
				max-height: 260rpx;
			}

			&--3 {
				height: 212rpx;
				width: 100%;
			}
		}

		&__count-icon {
			font-size: 40rpx;
			padding-right: 5rpx;
		}

		&__ad {
			width: 100%;
			height: 500rpx;
			transform: translate3d(0px, 0px, 0px) !important;

			::v-deep .uni-swiper-slide-frame {
				transform: translate3d(0px, 0px, 0px) !important;
			}

			.uni-swiper-slide-frame {
				transform: translate3d(0px, 0px, 0px) !important;
			}

			&__item {
				position: absolute;
				width: 100%;
				height: 100%;
				transform-origin: left center;
				transform: translate3d(100%, 0px, 0px) scale(1) !important;
				transition: transform 0.25s ease-in-out;
				z-index: 1;

				&--0 {
					transform: translate3d(0%, 0px, 0px) scale(1) !important;
					z-index: 4;
				}

				&--1 {
					transform: translate3d(13%, 0px, 0px) scale(0.9) !important;
					z-index: 3;
				}

				&--2 {
					transform: translate3d(26%, 0px, 0px) scale(0.8) !important;
					z-index: 2;
				}
			}

			&__content {
				border-radius: 40rpx;
				width: 640rpx;
				height: 500rpx;
				overflow: hidden;
			}

			&__image {
				width: 100%;
				height: 100%;
			}
		}
	}

	/* 文章内容 end*/

	/* 间隔线 start*/
	.tn-strip-bottom {
		width: 100%;
		border-bottom: 20rpx solid rgba(241, 241, 241, 0.8);
	}
	

	/* 间隔线 end*/
	
	
	/* 悬浮 */
	.tnxuanfu{
	  animation: suspension 3s ease-in-out infinite;
	}
	
	@keyframes suspension {
	  0%, 100% {
	    transform: translateY(0);
	  }
	  50% {
	    transform: translateY(-0.8rem);
	  }
	}
	/* 悬浮按钮 */
	.button-shop {
	  width: 90rpx;
	  height: 90rpx;
	  display: flex;
	  flex-direction: row;
	  position: fixed;
	  left: 5rpx;
	  top: 5rpx;
	  z-index: 1001;
	  border-radius: 100px;
	  opacity: 0.9;
	}
	
	
	/* 按钮 */
	.edit {
	  bottom: 300rpx;
	  right: 125rpx;
	  position: fixed;
	  z-index: 9999;
	}
	

	.bg1 {
	margin-top: 8px;
		font-size: 30px;
		color: #ffffff;
	  width: 100%;
	  height: 100%;
	}
	
	
</style>
