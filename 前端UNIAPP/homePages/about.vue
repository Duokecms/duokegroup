<template>
	<view class="template-advertise">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back'>
				<text class='icon tn-icon-left' @click="goBack"></text>
				<text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
		</tn-nav-bar>
		<!-- <view :style="{paddingTop: `${topInfo.height}px`}"></view> -->

		<view class="banner tn-navbg" style="height: 170px;" >


		</view>


		<view class="adver-wrap tn-bg-white" >
			<view class="tn-flex tn-flex-row-between tn-padding-top-lg" >
				<view class="tn-padding">
					<view class="tn-text-bold tn-text-xl tn-padding-top-sm">
						{{title}}
					</view>
					<view class="tn-padding-top-sm">
						<text class="tn-color-black tn-text-bold">{{configInfo.shoname}}</text>
						<text class="tn-color-grey tn-padding-left-sm"></text>
						<text class="tn-padding-left tn-color-indigo--dark">发布</text>
					</view>
				</view>

			</view>

			<view class="detail-img tn-padding">	
				<mp-html :content="body" />
			</view>

		</view>



	</view>
</template>

<script>
	import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
	export default {
		name: 'templateAdvertise',
		mixins: [template_page_mixin],
		data() {
			return {
				title: '',
				id: 0,
				body: '',
				type:'pages',
			}
		},
		onLoad(option) {

			if (option.id) {
				this.id = option.id
			}
			if (option.type) {
				this.type = option.type
			}
			this.info()

		},

		methods: {

			async info() {
				let that = this;
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/index/page',
					data: {
						id: that.id,
						type:that.type
					}
				});


				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						that.title = result.data.data.title
						that.body = result.data.data.detail;
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
	@keyframes gradientBG {
		0% {
			background-position: 0% 50%;
		}

		50% {
			background-position: 100% 50%;
		}

		100% {
			background-position: 0% 50%;
		}
	}

	/* 内容 */
	.adver-wrap {
		position: relative;
		z-index: 1;
		// padding: 20rpx 30rpx;
		margin-top: 160rpx;
		border-radius: 80rpx 80rpx 0 0;
	}


	.dd-glass {
		width: 100%;
		backdrop-filter: blur(20rpx);
		-webkit-backdrop-filter: blur(20rpx);
	}




	.banner {
		position: fixed;
		top: 0;
		width: 100%;
		transition: all 0.25s ease-out;
		z-index: -1;
	}
</style>
