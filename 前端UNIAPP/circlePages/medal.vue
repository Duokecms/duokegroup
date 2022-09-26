<template>
  <view class="template-suspended">
    <!-- 顶部自定义导航 -->
	<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back'>
				<text class='icon tn-icon-left' @click="goBack"></text>
				<text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
		</tn-nav-bar> 
    

	
		<view class=" tn-flex-row-center "   :style="{paddingTop: vuex_custom_bar_height + 'px'}"> 
	
	
	
	
	<view class="meng tn-margin" >
		<!-- 图标logo/头像 -->
		<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-bottom">
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
							<block v-for="(item,indexdd) in body.medal_list" :key="indexdd" >
								<image :src="item.image" mode="heightFix" style="height: 30px;top: 10px;" @click="navigateToFn({ url: '/circlePages/medal?id='+body.id, checkLogin: false })">
									
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

	
	<view class="tn-margin-top-sm" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
		<view class="tn-flex tn-flex-row-between">
			<view class="justify-content-item tn-margin tn-text-bold tn-text-xl tn-color-white">
				TA的勋章
			</view>
			
			<view class="tn-margin" style="font-size: 50rpx;">
				<text class="tn-icon-trophy-fill tn-color-white"></text>
			</view>
		</view>
	</view>
	<view class="tn-margin-left tn-text-sm tn-color-gray tn-color-white" style="margin-top: -25rpx;">
		<text>已佩戴的勋章</text>
	</view>
	
	
	
	<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-bottom"  style="margin: 20px;" v-for="(item,indexdd) in body.medal_list" :key="indexdd" >
		<view class="justify-content-item">
			<view class="tn-flex tn-flex-col-center tn-flex-row-left">
				<view class="logo-pic tn-shadow">
					<view class="logo-image1">
						<view class="tn-shadow-blur"
							:style="'background-image:url('+item.image+');width: 80rpx;height: 80rpx;background-size: cover;'">
						</view>
					</view>
				</view>
				<view class="tn-padding-right">
					<view class="tn-padding-right tn-padding-left-sm  tn-text-bold">
						<text class="tn-color-white">{{item.title}}</text>						
	
					</view>
					<view class="tn-padding-right tn-padding-top-xs tn-padding-left-sm tn-text-ellipsis">
						<text class="tn-color-white" style="font-size:12px;">
							{{item.type}}到达{{item.meet_num}}获得
						</text>
					</view>
				</view>
			</view>
		</view>
	</view>


	 
	

	
			
		
			</view>

		</view>	
    
  </view>
</template>

<script>
  import template_page_mixin from '@/libs/mixin/template_page_mixin.js'

  export default {
    name: 'TemplateSuspended',
    mixins: [template_page_mixin],
    components: {  },
   data() {
   	return {
   		loginBoxFlag: false, // 登录框显示隐藏状态
   		id: 1,
   		body: [],
   		content: []
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
   	this.info()
   
   },
    methods: {
		
		async info() {
			let that = this;
			let result = await that.$request({
				loading: 1,
				method: 'post',
				url: '/api/index/GetUser',
				data: {
					user_id: this.id
				}
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
		
      // 跳转到
      navTuniaoUI(e) {
        wx.vibrateShort();
        uni.navigateTo({
          url: '/pages/index/index'
        })
      },
    }
  }
</script>

<style lang="scss" scoped>

  .template-suspended{
    background-image: linear-gradient(to top, #4C3FAE 20%, #6E26BA 80%);
    width: 100vw;
    height: 100vh;
  }  
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
    /* bottom:200rpx;
      right: 20rpx; */
    left: 5rpx;
    top: 5rpx;
    z-index: 1001;
    border-radius: 100px;
    opacity: 0.9;
  }
  
  
  /* 按钮 */
  .wechat {
    bottom: 300rpx;
    right: 75rpx;
    position: fixed;
    z-index: 9999;
  }
  
  
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
</style>
