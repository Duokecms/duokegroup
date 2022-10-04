<template>
	<view class="template-create tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
	<tn-nav-bar fixed :isBack="true">
		资料修改			
		</tn-nav-bar>


		<view class="tn-safe-area-inset-bottom " :style="{paddingTop: vuex_custom_bar_height + 'px'}">

			<view class="tn-flex tn-flex-row-between tn-flex-col-center  tn-margin ">
				<view class="tn-flex justify-content-item">
					<view class="tn-bg-black tn-color-white tn-text-center"
						style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
						<text class="tn-icon-image" style="font-size: 30rpx;"></text>
					</view>
					<view class="tn-text-lg tn-padding-right-xs tn-text-bold">编辑我的资料</view>
				</view>
				<view class="" @click="send()">
				<tn-button backgroundColor="#00FFC6" padding="40rpx 0" width="80px" shadow fontBold>
					<!-- <text class="tn-icon-light tn-padding-right-xs tn-color-black"></text> -->
					<text class="tn-color-black">保存</text>
									
				</tn-button>
				</view>
				
				
			</view>
		
			
			
			<tn-cropper  v-show="show"
			  :imageUrl="imageUrl"
			  :isRound="isRound"			
			  @cropper="cropperFinish"
			  @closecopper="close"
			></tn-cropper>
					
			<view class="user-info__container tn-flex tn-flex-direction-column tn-flex-col-center tn-flex-row-center" @click="chooseImage()">
			  <view class="user-info__avatar  tn-flex tn-flex-col-center tn-flex-row-center" style="position: relative;">
			  <view class="logo-pic tn-shadow">
			  	<view class="logo-image">
			  		<view class="tn-shadow-blur"
			  			:style="'background-image:url('+avatar+');width: 210rpx;height: 210rpx;background-size: cover;'">
			  		</view>
					
			  	</view>
			  </view>
			  	<view class="tn-icon-camera-fill tn-color-red" style="left: 80px;
    position: absolute;
    top: 80px;
    font-size: 40px;"></view>
			  </view>
		
			</view> 	
				

			<view class=" tn-text-bold  clamp-text-1 tn-text-justify tn-margin " >
				昵称<text class="tn-color-red">*</text>
			</view>
			<view class="tn-margin tn-bg-gray--light" style="border-radius: 10rpx;padding: 20rpx 30rpx;">
				<input placeholder="给自己取号好听的名字吧"   maxlength="10" v-model="title"
					placeholder-style="color:#AAAAAA"></input>
			</view>
			<view class=" tn-text-bold  clamp-text-1 tn-text-justify tn-margin ">
				签名<text class="tn-color-red">*</text>
			</view>
			<view class="tn-margin tn-bg-gray--light tn-padding" style="border-radius: 10rpx;">
				<textarea maxlength="100" placeholder="写点有意思的签名吧(100字以内)" v-model="dec"
					placeholder-style="color:#AAAAAA"></textarea>
			</view>

		</view>



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
				truehead:'',
				isRound: true,
				imageUrl:'',
				show:false,
				avatar:'',
				body:[],
				action: '',	
				title:'',
				dec:'',
			
			}
		},
		onLoad(option) {
			let that = this		
			that.action = host + '/api/user/up_img'		
				 that.info()	
				
		},
		methods: {
	
   // 选择图片
   close(){
	  this.show=false 
   },
   
      chooseImage() {
        uni.chooseImage({
          count: 1,
          sizeType: ['original', 'compressed'],
          sourceType: ['album','camera'],
          success: (res) => {
            const tempFilePaths = res.tempFilePaths[0]
            this.imageUrl = tempFilePaths
			 this.show=true
          }
        })
      },
		// 裁剪完成
		cropperFinish(res) {		
		  if (res.url) {
		    this.cropperImageUrl = res.url
		  }
		  if (res.base64) {
		    this.cropperImageUrl = `${res.base64}`
		  }
		  this.avatar=this.cropperImageUrl
		  this.show=false
		  
		},
		
		async info() {
			let that = this;		
			let result = await that.$request({
				loading: 1,
				method: 'post',
				url: '/api/index/GetUser',
				data: { 		
				}
			});		
			
			
			if (result.statusCode == 200) {
				if (result.data.code == 200) {			
					that.body = result.data.data.userinfo;
					that.title=that.body.nickname
					that.dec=that.body.dec
					that.avatar=that.body.avatar
					that.truehead=that.body.truehead
								
					
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
		
		
			uploadSuccess() {
				uni.showToast({
					title: '上传成功'
				})	
					uni.uploadFile({
					url: this.action, //仅为示例，非真实的接口地址
					filePath: this.cropperImageUrl,
					name: 'file',
					formData: {
						'token': uni.getStorageSync('token'),
						'user': 'test'
					},
					success: (uploadFileRes) => {						
						let data=JSON.parse(uploadFileRes.data)
						this.avatar=host+data.data.file
						this.truehead=data.data.file	
						this.post()
					}
				});
		
				
			},


			send(){
				if (this.title == '') {
					this.msg('请输入昵称')
					return
				}	
				 
				 if (this.cropperImageUrl){
					 this.uploadSuccess()
				 }else{
					 this.post()
				 }
				
				
			},

			async post() {


				let that = this;					

				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/set',
					data: {
						nickname: that.title,
						dec: that.dec,
						avatar: that.truehead						
					}
				});

				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						uni.hideLoading()					
						that.msg('修改成功')
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
/* 用户头像 start */
	.logo-image {
		width: 210rpx;
		height: 210rpx;
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
	.bg-flex-shadow {
		background-color: #00C3FF;
		z-index: 9999;
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

	.tn-shadow-blurddd {
		border: 2px solid black;
	}



	/* 标签内容 end*/
</style>
