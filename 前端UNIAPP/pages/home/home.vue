<template>
	<view class="template-circle tn-safe-area-inset-bottom ">


		<!-- 顶部自定义导航 -->
		<tn-nav-bar :isBack="false" :bottomShadow="false" backgroundColor="tn-dynamic-bg-2">
			<view class="custom-nav tn-flex tn-flex-col-center tn-flex-row-left tn-shadow-blur">
				<view class="custom-nav__back" @click="tn('/homePages/search')">
					<view class="logo-pic tn-shadow-blur">
						<view class="tn-icon-search">
						</view>
					</view>
				</view>

				<view class="tn-text-center" style="margin-left:30rpx;">
					<tn-tabs :list="scrollList" :itemWidth="150" :activeItemStyle="activeItemStyle" :current="current"
						@change="tabChange" :isScroll="false" activeColor="#000000" :bold="true" :fontSize="36">
					</tn-tabs>
				</view>

			</view>

		</tn-nav-bar>
		<!-- 推荐 -->
		<view class="" v-if="current==1" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
			<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
				<view class="" style="padding: 5px 15px;">
					<tn-swiper :list="swiperList" imageMode="heightFix" @click="hpicto"></tn-swiper>
				</view>

				<view class="tn-flex tn-flex-row-between ">
					<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
						精选圈子
					</view>
					<view class="justify-content-item tn-margin tn-text-lg tn-color-grey"
						@click="tn('/circlePages/group_list')">
						<text class="tn-padding-xs">全部</text>
						<text class="tn-icon-search-menu"></text>
					</view>
				</view>

				<view class="tn-strip-bottom tn-skeleton">
					<!-- 方式16 start-->
					<view class="tn-flex tn-flex-wrap tn-margin-bottom">
						<block v-for="(item, indextuisjian) in bloggerList" :key="indextuisjian">
							<view class="" style="width: 33.3%;" @click="tn('/circlePages/group?id='+item.id)">
								<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center ">
									<view class="tn-radius tn-padding-sm tn-skeleton-circle">
										<view class="image-pic " :style="'background-image:url('+ item.image +')'"
											style="width: 80px; height: 80px;">
											<view class="image-circle">
											</view>
										</view>
										<view class="tn-text-center tn-text-bold tn-padding-top-xs">{{item.title}}
										</view>
										<view class="tn-text-center tn-text-xs tn-color-gray--dark tn-padding-top-xs">
											{{item.follow_num}}人关注
										</view>
									</view>
								</view>
							</view>
						</block>
					</view>
					<!-- 方式16 end-->
				</view>

				<view class="tn-flex tn-flex-direction-column tn-margin-top-sm tn-margin-bottom">

					<!-- 图文信息 -->
					<block v-for="(item,indexttuijian) in content" :key="indexttuijian">
						<quan-list :item="item" :index="true"></quan-list>
					</block>
				</view>

				<!--      <view class='tn-tabbar-height'></view> -->
			</mescroll-body>
		</view>



		<!-- 关注 -->
		<view class="" v-if="current==0" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
			<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">


				<view class="tn-flex tn-flex-row-between tn-margin-top">
					<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
						我的圈子
					</view>
					<view class="justify-content-item tn-margin tn-text-lg tn-color-grey"
						@click="tn('/minePages/my_group')">
						<text class="tn-padding-xs">全部</text>
						<text class="tn-icon-topics"></text>
					</view>
				</view>
				<view class="tn-strip-bottom">
					<!-- 方式16 start-->
					<view class="tn-flex tn-flex-wrap tn-margin-bottom">
						<block v-for="(item, indexmygroup) in mygrouplist" :key="indexmygroup" v-if="indexmygroup<7">
							<view class="" style="width: 33.3%;" @click="tn('/circlePages/group?id='+item.id)">
								<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center ">
									<view class="tn-radius tn-padding-sm">
										<view class="image-pic" :style="'background-image:url('+ item.image +')'"
											style="width: 80px; height: 80px;">
											<view class="image-circle">
											</view>
										</view>
										<view class="tn-text-center tn-text-bold tn-padding-top-xs">{{item.title}}
										</view>
										<view class="tn-text-center tn-text-xs tn-color-gray--dark tn-padding-top-xs">
											{{item.follow_num}}人关注
										</view>
									</view>
								</view>
							</view>
						</block>
					</view>
					<!-- 方式16 end-->
				</view>
				<view class="tn-flex tn-flex-direction-column tn-margin-top-sm tn-margin-bottom">

					<!-- 图文信息 -->
					<block v-for="(item,indextd) in content" :key="indextd">
						<quan-list :item="item" :index="true"></quan-list>
					</block>
				</view>
			</mescroll-body>
		</view>

		<!-- 关注 -->
		<view class="" v-if="current==2" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
			<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
				<view class="tn-flex tn-flex-row-between tn-margin-top">
					<view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
						热门圈子
					</view>
					<view class="justify-content-item tn-margin tn-text-lg tn-color-grey"
						@click="tn('/circlePages/group_list')">
						<text class="tn-padding-xs">全部</text>
						<text class="tn-icon-topics"></text>
					</view>
				</view>
				<view class="tn-strip-bottom">
					<!-- 方式16 start-->
					<view class="tn-flex tn-flex-wrap tn-margin-bottom">
						<block v-for="(item, indexhot) in bloggerhotList" :key="indexhot">
							<view class="" style="width: 33.3%;" @click="tn('/circlePages/group?id='+item.id)">
								<view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center ">
									<view class="tn-radius tn-padding-sm">
										<view class="image-pic" :style="'background-image:url('+ item.image +')'"
											style="width: 80px; height: 80px;">
											<view class="image-circle">
											</view>
										</view>
										<view class="tn-text-center tn-text-bold tn-padding-top-xs">{{item.title}}
										</view>
										<view class="tn-text-center tn-text-xs tn-color-gray--dark tn-padding-top-xs">
											{{item.follow_num}}人关注
										</view>
									</view>
								</view>
							</view>
						</block>
					</view>
					<!-- 方式16 end-->
				</view>
				<view class="tn-flex tn-flex-direction-column tn-margin-top-sm tn-margin-bottom">

					<!-- 图文信息 -->
					<block v-for="(item,indexgoods) in content" :key="indexgoods">
						<quan-list :item="item" :index="true"></quan-list>
					</block>
				</view>
			</mescroll-body>
		</view>

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
		name: '',
		mixins: [template_page_mixin, MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				activeItemStyle: {
					fontSize: `36rpx`
				},
				barStyle: {
					boxShadow: `12rpx 12rpx 16rpx #01BEFF`
				},
				show_fabu: false,
				loading: true,
				skeleton1: {
					avatarSize: '52px',
					row: 3,
					showTitle: true,
				},
				loginBoxFlag: false, // 登录框显示隐藏状态
				cardCur: 0,
				swiperList: [],
				current: 1,
				scrollList: [{
						name: '关注'
					},
					{
						name: '推荐',
					},
					{
						name: '热门'
					},
				],
				latestUserAvatar: [],
				bloggerList: [],
				// 内容默认隐藏显示的高度
				contentHideShowHeight: 0,
				content: [],
				adList: [],
				adAutoplay: false,
				mygrouplist: [],
				bloggerhotList:[]

			}
		},
		onShow() {
			console.log(3)
		},
		mounted() {
			let that = this;
			that.info('rec')
			that.initContentData()
			that.contentHideShowHeight = uni.upx2px(56) * 3
			that.adAutoplay = true

			uni.$off('setLoginBoxFlag_home');
			uni.$on('setLoginBoxFlag_home', loginBoxFlag => {
				that.loginBoxFlag = loginBoxFlag;
			});
			uni.$on('home', data => {
				that.mescroll.triggerUpScroll()
			});

			uni.$on('indexhome', data => {
				if (!uni.getStorageSync('token')) {
					that.loginBoxFlag = true
					return false;
				} else {
					//that.isLogin=true	
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
					url: '/api/index/index',
					data: {
						type: 1
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						that.swiperList = result.data.data.swiperList;
						that.bloggerhotList = result.data.data.bloggerhotList;
						that.bloggerList = result.data.data.bloggerList;
						that.loading = false
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
			async myinfo() {
				let that = this;
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/flowGroup',
					data: {
						num: 6
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						that.mygrouplist = result.data.data.data;
						that.loading = false
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
				let hot_tyoe = 1
				if (that.current == 0) {
					hot_tyoe = 1
				}
				if (that.current == 1) {
					hot_tyoe = 2
				}
				if (that.current == 2) {
					hot_tyoe = 3
				}
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/getGoodslist',
					data: {
						hot_type: hot_tyoe,
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




			// cardSwiper
			cardSwiper(e) {
				this.cardCur = e.detail.current
				for (let i = 0; i < this.swiperList.length; i++) {
					const videoContext = uni.createVideoContext(`video-${this.swiperList[i]['id']}`, this)
					if (i === this.cardCur) {
						// #ifdef H5
						videoContext.play()
						// #endif
						// #ifndef H5
						videoContext.play()
						// #endif

					} else {
						// #ifdef MP-WEIXIN
						videoContext.stop()
						// #endif
						// #ifndef MP-WEIXIN
						videoContext.pause()
						// #endif
					}
				}
			},
			// 暂停所有视频
			stopAllVideo() {
				this.current = 0
			},
			// tab选项卡切换
			tabChange(index) {
				 
				 this.content=[]
				if (index == 0) {
					if (!uni.getStorageSync('token')) {
						this.loginBoxFlag = true
						return false;
					}
					this.myinfo()
				}

				this.current = index
				this.mescroll.resetUpScroll()


			},
			// 跳转
			tn(e) {
				uni.navigateTo({
					url: e,
				});
			},

			// 震动跳转
			navCreate(e) {
				wx.vibrateLong();
				uni.navigateTo({
					url: '/circlePages/create'
				})
			},
			// 震动跳转
			navBuild(e) {
				wx.vibrateLong();
				uni.navigateTo({
					url: '/circlePages/build'
				})
			},
			// 处理内容，给内容添加对应的标识信息
			initContentData() {
				this.content.forEach((item, index) => {
					// 是否需要隐藏内容
					item.hideContent = false
					// 显示所有内容
					item.showAllContent = false
					// 内容容器的实际高度
					item.contentContainerHeight = 0
					// 内容容器是否初始化完成
					item.contentContainerInit = false
					this.$set(this.content, index, item)
				})
			},
			// 获取内容容器的信息
			getContentRectInfo() {
				let contentRect = {}
				const query = uni.createSelectorQuery().in(this)
				// 筛选出存在内容的数据
				this.content.forEach((item, index) => {
					if (item?.content) {
						query.select(`#blogger__content--${index}`).boundingClientRect()
						contentRect[index] = item
					}
				})
				// 获取所有内容的宽高信息
				query.exec(res => {
					if (!res) {
						setTimeout(() => {
							this.getContentRectInfo()
						}, 10)
						return
					}
					// console.log(res);
					res.map((item) => {
						// console.log(item.height, this.contentHideShowHeight);
						// 获取对应的标号
						const id = item.id
						const idIndex = /blogger__content--(\d)/.exec(id)[1]
						let contentItem = this.content[idIndex]
						contentItem.hideContent = item.height > this.contentHideShowHeight
						contentItem.showAllContent = false
						contentItem.contentContainerHeight = item.height
						contentItem.contentContainerInit = true
						this.$set(this.content, idIndex, contentItem)

						// console.log(/blogger__content--(\d)/.exec(id)[1]);
					})
				})
			},
			// 切换内容的显示与隐藏
			switchContentShowStatus(index) {
				const contentItem = this.content[index]
				contentItem.showAllContent = !contentItem.showAllContent
				this.$set(this.content, index, contentItem)
			},
			// 关闭压屏窗
			closeLandscape() {
				this.show_fabu = false
			},
			hpicto(index) {
				if (this.swiperList[index].url) {
					this.tn('/circlePages/details?id=' + this.swiperList[index].url + '')
				}
			},
			refreshFn(){
							
			},

		}
	}
</script>

<style lang="scss" scoped>
	.template-circle {
		max-height: 100vh;
	}

	.tn-tabbar-height {
		min-height: 120rpx;
		height: calc(140rpx + env(safe-area-inset-bottom) / 2);
	}

	/* 自定义导航栏内容 start */
	.custom-nav {
		height: 100%;
	//	background-image: repeating-linear-gradient(-45deg, #fbf7ac69, #fff20014);
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

	.logo-image {
		width: 60rpx;
		height: 60rpx;
		position: relative;
		margin-top: -15rpx;
	}

	.logo-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		border-radius: 50%;
	}

	/* 自定义导航栏内容 end */
	/* 博主头像 start*/
	.image-circle {
		// padding: 95rpx;
		width: 190rpx;
		height: 190rpx;
		font-size: 40rpx;
		font-weight: 300;
		position: relative;
	}

	.image-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		border-radius: 10rpx;
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

	/* 广告内容 start */
	.ad-image {
		width: 80rpx;
		height: 80rpx;
		position: relative;
	}

	.ad-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		border-radius: 20%;
	}

	/* 自定义导航栏内容 end */


	/* 全屏轮播  start*/

	/* 轮播视觉差 start */
	.card-swiper {
		height: 200rpx !important;
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

	.card-swiper swiper-item .swiper-item-text {
		margin-top: -260rpx;
		text-align: center;
		width: 100%;
		display: block;
		height: 50%;
		border-radius: 10rpx;
		transform: translate(100rpx, -60rpx) scale(0.9, 0.9);
		transition: all 0.6s ease 0s;
		overflow: hidden;
	}

	.card-swiper swiper-item.cur .swiper-item-text {
		margin-top: -320rpx;
		width: 100%;
		transform: translate(0rpx, 0rpx) scale(0.9, 0.9);
		transition: all 0.6s ease 0s;
	}

	.image-banner {
		border-radius: 10px !important;
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



	/* 悬浮 */
	.tnxuanfu {
		animation: suspension 3s ease-in-out infinite;
	}

	@keyframes suspension {

		0%,
		100% {
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
		/* bottom:200rpx;
      right: 20rpx; */
		left: 5rpx;
		top: 5rpx;
		z-index: 1001;
		border-radius: 100px;
		opacity: 0.9;
	}


	/* 按钮 */
	.edit {
		bottom: 300rpx;
		right: 75rpx;
		position: fixed;
		z-index: 9999;
	}


	.pa,
	.pa0 {
		position: absolute
	}

	.pa0 {
		left: 0;
		top: 0
	}


	.bg0 {
		width: 100rpx;
		height: 100rpx;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}

	.bg1 {
		width: 100%;
		height: 100%;
	}




	.hx-box {
		top: 50%;
		left: 50%;
		width: 100rpx;
		height: 100rpx;
		transform-style: preserve-3d;
		transform: translate(-50%, -50%) rotateY(75deg) rotateZ(10deg);
	}

	.hx-box .pr {
		width: 100rpx;
		height: 100rpx;
		transform-style: preserve-3d;
		animation: hxz 20s linear infinite;
	}

	@keyframes hxz {
		0% {
			transform: rotateX(0deg);
		}

		100% {
			transform: rotateX(-360deg);
		}
	}



	.hx-box .pr .pa0 {
		width: 100rpx;
		height: 100rpx;
		/* border: 4px solid #5ec0ff; */
		border-radius: 1000px;
	}

	.hx-box .pr .pa0 .span {
		display: block;
		width: 100%;
		height: 100%;
		background: url(https://tnuiimage.tnkjapp.com/cool_bg_image/arc4.png) no-repeat center center;
		background-size: 100% 100%;
		animation: hx 4s linear infinite;
	}

	@keyframes hx {
		to {
			transform: rotate(360deg);
		}
	}

	.hx-k1 {
		transform: rotateX(-60deg) rotateZ(-60deg)
	}

	.hx-k2 {
		transform: rotateX(-30deg) rotateZ(-30deg)
	}

	.hx-k3 {
		transform: rotateX(0deg) rotateZ(0deg)
	}

	.hx-k4 {
		transform: rotateX(30deg) rotateZ(30deg)
	}

	.hx-k5 {
		transform: rotateX(60deg) rotateZ(60deg)
	}

	.hx-k6 {
		transform: rotateX(90deg) rotateZ(90deg)
	}
</style>
