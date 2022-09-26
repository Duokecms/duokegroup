<template>
	<view class="login-tips-block" v-if="isShow" @touchmove.stop="catchTouchMove">
		<view class="login-tips border-radius20">
			<view class="icon-top-play"><image :src="getConfigImg('dls')" mode=""></image></view>
			<view class="h4">授权获取手机号</view>
			<view class="h5">
				<text>为了完整体验,需要您的授权</text>
				<text>授权后可享受更多优质服务</text>
			</view>
			<button
				:class="['login-btn', isAllAngle ? 'border-radius-style-all-arg' : 'border-radius-style-half-arg']"
				open-type="getPhoneNumber"
				@getphonenumber="wxGetTelFn"
				:style="{ background: configInfo.web_site_color }"
			>
				确认授权
			</button>

			<text class="say-no" @click="closeFn" :style="{ color: configInfo.web_site_color }">关闭</text>
		</view>
	</view>
</template>

<script>
// 工具库 相关
import { checkTypeFn } from '@/tools/tools';

export default {
	props: {
		isShow: {
			type: Boolean,
			required: true,
			default: false
		}
	},
	mounted() {
		let that = this;
		console.log('获取手机号-模态框 mounted 函数执行', '\n');

		uni.$off('wxBindTel');
		uni.$on('wxBindTel', result => {
			that.wxBindTelEndFn(result);
		});
	},
	methods: {
		// 通过 微信提供的 授权 获取到手机号之后
		wxBindTelEndFn(result) {
			let that = this;
			if (result.statusCode == 200) {
				if (result.data.code == 200) {
					uni.showToast({
						icon: 'success',
						title: result.data.msg
					});
					that.$emit('callback')
					that.closeFn();
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

		// 关闭 授权手机号 模态框
		closeFn() {
			this.$emit('close');
		}
	}
};
</script>

<style lang="scss">
.login-tips-block {
	position: fixed;
	z-index: 1980;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.3);

	.login-tips {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		margin: auto;
		width: 600rpx;
		height: 600rpx;
		background: #ffffff;

		.icon-top-play {
			image {
				position: absolute;
				left: 50%;
				transform: translateX(-50%) translateY(-50%);
				width: 280rpx;
				height: 280rpx;
			}
		}

		.h4 {
			margin-top: 175rpx;
			text-align: center;
			font-weight: 600;
			color: $grey1-color;
			font-size: 36rpx;
		}

		.h5 {
			margin-top: 40rpx;
			color: $grey1-color;
			font-size: 30rpx;
			text-align: center;

			text {
				display: block;
				line-height: 50rpx;
			}
		}

		.say-no,
		.login-btn {
			display: flex;
			justify-content: center;
			align-items: center;
			margin: 35rpx auto 0;
			width: 536rpx;
			height: 88rpx;
			color: #ffffff;
			font-size: 30rpx;
		}

		.say-no {
			margin-top: 10rpx;
			background: transparent;
			text-decoration: underline;
		}
	}
}
</style>
