<template>
	<view class="template-create tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back'>
				<text class='icon tn-icon-left' @click="goBack"></text>
				<text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
			
			<view slot="right" @click="fabu()" style="margin-right: 10px;">
			<tn-button backgroundColor="#00FFC6"  width="80px" shadow fontBold>
				<!-- <text class="tn-icon-light tn-padding-right-xs tn-color-black"></text> -->
				<text class="tn-color-black">发布</text>
					     <text class="tn-icon-camera tn-padding-left-xs tn-color-black"></text>
								
			</tn-button>
			</view>
		</tn-nav-bar>

		<view class="tn-safe-area-inset-bottom" :style="{paddingTop: vuex_custom_bar_height + 'px'}">

			<view class="tn-margin tn-bg-gray--light" style="border-radius: 10rpx;padding: 20rpx 30rpx;">
				<input placeholder="请填写活动标题吖" name="input" v-model="title" placeholder-style="color:#AAAAAA"></input>
			</view>
			<view class="tn-margin tn-bg-gray--light tn-padding" style="border-radius: 10rpx;">
				<textarea maxlength="500" placeholder="请描述活动详情" v-model="detail"
					placeholder-style="color:#AAAAAA"></textarea>
			</view>

			<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin">
				<view class="tn-flex justify-content-item">
					<view class="tn-bg-black tn-color-white tn-text-center"
						style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
						<text class="tn-icon-image" style="font-size: 30rpx;"></text>
					</view>
					<view class="tn-text-lg tn-padding-right-xs tn-text-bold">活动图片</view>
						  <text class="tn-text-xs tn-padding-right-xs tn-color-grey">长按可拖拽排序</text>
				</view>
				<view class="justify-content-item tn-text-df tn-color-grey" @tap="clear">
					<text class="tn-padding-xs">清空上传</text>
					<text class="tn-icon-delete"></text>
				</view>
			</view>




			<view class="tn-margin-left tn-padding-top-xs">
				<tn-image-upload-drag ref="imageUpload" :action="action" :width="236" :height="236" :formData="formData"
					:fileList="fileList" :disabled="disabled" :autoUpload="autoUpload" :maxCount="maxCount"
					:showUploadList="showUploadList" :showProgress="showProgress" :deleteable="deleteable"
					:customBtn="customBtn" @sort-list="onSortList" @on-uploaded="onUploaded" />

			</view>

			<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin">
				<view class="tn-flex justify-content-item">
					<view class="tn-bg-black tn-color-white tn-text-center"
						style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
						<text class="tn-icon-time" style="font-size: 30rpx;"></text>
					</view>
					<view class="tn-text-lg tn-padding-right-xs tn-text-bold">活动时间</view>
				</view>
				<view class="justify-content-item tn-text-df tn-color-grey" @click="showCalendar">
					<text class="tn-padding-xs">{{times?times:'请选择时间'}}</text>
					<text class="tn-icon-right"></text>
				</view>
			</view>
			
			
			<tn-calendar
			  v-if="show"
			  v-model="show"
			  :mode="mode"
			  :showLunar="showLunar"
			  :activeBgColor="activeBgColor"
			  :activeColor="activeColor"
			  :rangeBgColor="rangeBgColor"
			  :rangeColor="rangeColor"
			  :btnColor="btnColor"
			  :lunarColor="lunarColor"
			  :startText="startText"
			  :endText="endText"
			  :toolTips="toolTips"
			  :changeYear="changeYear"
			  :changeMonth="changeMonth"
			  @change="onChange"
			></tn-calendar>
			
			
			
			
			
			
			
			

			<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin">
				<view class="tn-flex justify-content-item">
					<view class="tn-bg-black tn-color-white tn-text-center"
						style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
						<text class="tn-icon-location" style="font-size: 30rpx;"></text>
					</view>
					<view class="tn-text-lg tn-padding-right-xs tn-text-bold">活动地点</view>
				</view>
				<view class="justify-content-item tn-text-df tn-color-grey " @click="selectAddressFn()">
					<text class="tn-padding-xs">{{address?address:'请选择地点'}}</text>
					<text class="tn-icon-right"></text>
				</view>
			</view>


			<view class='tn-tabbar-height'></view>


		</view>

		<view class='tn-tabbar-height'></view>

	</view>
</template>

<script>

	import {
		host
	} from '@/tools/siteinfo.js'
	import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
	export default {
		name: 'TemplateCreate',
		mixins: [template_page_mixin],
		data() {
			return {
				show: false,
				mode: 'date',
				showLunar: true,
				activeBgColor: '#01BEFF',
				activeColor: '#FFFFFF',
				rangeBgColor: '#E6E6E655',
				rangeColor: '#01BEFF',
				btnColor: '#01BEFF',
				lunarColor: '#AAAAAA',
				startText: '开始',
				endText: '结束',
				toolTips: '请选择日期',
				changeYear: true,
				changeMonth: true,
				result: '',
				//、
				title: '',
				detail: '',
				images: '',
				address: '',
				lat: '',
				lng: '',
				times: '',
				//
				tagList: [],
				action: '',
				formData: {
					apiType: 'this,ali',
					token: uni.getStorageSync('token'),				
					image: null
				},
				fileList: [],
				showUploadList: true,
				customBtn: false,
				autoUpload: false,
				showProgress: false,
				deleteable: true,
				customStyle: false,
				maxCount: 9,
				disabled: false,
			}
		},
		onLoad(option) {
			let that = this
			uni.$off('setLoginBoxFlag');
			uni.$on('setLoginBoxFlag', loginBoxFlag => {
				that.loginBoxFlag = loginBoxFlag;
			});
			uni.$on('quan', loginBoxFlag => {
				that.quan = loginBoxFlag
				that.quan_title = loginBoxFlag.title
			});
			that.action = host + '/api/user/up_img'

			if (option.id) {
				this.id = option.id
			}
			//this.info()			
		},
		methods: {
			// 跳转
			tn(e) {
				uni.navigateTo({
					url: e,
				});
			},
 showCalendar() {
         this.show = true
      },
	  // 日历日期有改变
	  onChange(event) {
	    if (this.mode === 'date') {
	      this.times = event.date
	    }
	   
	    
	  },
	  
	  selectAddressFn() {
	  	let that = this;
				
		
	  	uni.chooseLocation({
	  		async success(e) {
	  			console.log(e);
	  			let str, longitude, latitude;
	  			if (e.errMsg == 'chooseLocation:ok' && e.address) {
	  				str = `${e.name}`;
	  				longitude = e.longitude;
	  				latitude = e.latitude;
	  			} else {
	  				str = '点击选择地址';
	  				longitude = '';
	  				latitude = '';
	  			}
	  			that.address = str;
	  			that.lng = longitude;
	  			that.lat = latitude;
	  		},
	  		fail(e) {
	  			console.log('失败', e);
	  			uni.showModal({
	  				showCancel: false, //不显示取消按钮
	  				title: '允许系统获取位置信息',
	  				success(e) {
	  					//确认后的回调
	  					uni.openSetting();
	  				}
	  			});
	  		}
	  	});
	  },
	  
 onSortList(){
 	
 },
			// 手动清空列表
			clear() {
				this.$refs.imageUpload.clear()
			},
			// 图片
			onUploaded(list) {

				uni.showLoading({
					title: '发布中，请稍后'
				})

				if (list.length > 0) {
					let imageList = list.map(i => i.response.data.file).join(',');
					this.okpiclist = imageList
					this.send()
				} else {
					this.send()
				}
			},



			fabu() {
				
				if (this.title == '') {
					this.msg('请输入活动标题')
					return
				}
				if (this.detail == '') {
					this.msg('请输入活动详情')
					return
				}
				if (this.times == '') {
					this.msg('选择活动时间')
					return
				}
				if (this.address == '') {
					this.msg('选择活动地点')
					return
				}

				this.$refs.imageUpload.upload()
			},

			async send() {


				let that = this;
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/addActive',
					data: {
						title:that.title,
						detail: that.detail,
						images:that.okpiclist,
						address:that.address,
						lat: that.lat,
						lng: that.lng,
						times:that.times,
					}
				});

				if (result.statusCode == 200) {
					if (result.data.code == 200) {

						uni.hideLoading()
				uni.showModal({
					title: '提示',
					content: result.data.msg,
					confirmText:'知道了',
					showCancel:false,
					success: function (res) {
						if (res.confirm) {
							uni.navigateBack()
						} else if (res.cancel) {
							console.log('用户点击取消');
						}
					}
				});
						
						uni.$emit('fabuhuodng_ok', result.data.code)

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
	.template-edit {}

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

	/* 底部悬浮按钮 start*/
	.tn-tabbar-height {
		min-height: 100rpx;
		height: calc(120rpx + env(safe-area-inset-bottom) / 2);
	}

	.tn-footerfixed {
		position: fixed;
		width: 100%;
		bottom: calc(30rpx + env(safe-area-inset-bottom));
		z-index: 1024;
		box-shadow: 0 1rpx 6rpx rgba(0, 0, 0, 0);

	}

	/* 底部悬浮按钮 end*/

	/* 标签内容 start*/
	.tn-tag-content {
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

	/* 标签内容 end*/
</style>
