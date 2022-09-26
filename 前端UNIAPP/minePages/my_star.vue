<template>
  <view class="template-mine tn-safe-area-inset-bottom">

  <tn-nav-bar fixed alpha customBack>
      <view slot="back" class='tn-custom-nav-bar__back'
        >
        <text class='icon tn-icon-left' @click="goBack"></text>
        <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
      </view>
    </tn-nav-bar>
    
    <mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
    <view class="top-backgroup">
      <image :src='body.bg_img' mode='widthFix' class='backgroud-image'></image>
    </view>
	

    <view class="about__wrap">

      <!-- 更多信息-->
      <view v-if="content.length>0"
	  class="about-shadow tn-margin-top-xl tn-padding-top-sm tn-padding-bottom-sm tn-bg-white">
      <block v-for="(item,index) in content" :key="index">
      <quan-list :item="item" ></quan-list>	
      </block>
      </view>


    

    </view>

    <view class='tn-tabbar-height'></view>
</mescroll-body>
		<login-fn :is-show-login="loginBoxFlag" @loginSuccessCallback="refreshFn" @close="closeGlobalLoginFn">
		</login-fn>

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
		  id: 1,
		  body: [],
		  content: []
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
 
 async guanzhu(id){
	
 	if (!this.isLogin) {
 		this.loginBoxFlag = true					
 		return false;
 	}
 	let result = await this.flowUser(id)	
	this.body.is_follow=result.is_follow	
 	this.msg(result.msg) 
			
			
 	},	
	
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
 		url: '/api/user/myLikeGoodsList',
 		data: {
 			to_id:that.id,
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
 
			tofans(type){
				
				if (this.body.is_see_follow==1&&type=='guanzhu'){
					this.msg('博主设置不可见')
					return
				}
				
				if (this.body.is_see_fans==1&&type=='fans'){
					this.msg('博主设置不可见')
					return
				}
				
				this.navigateToFn({ url: '/circlePages/fans?type='+type+'&user_id='+this.id, checkLogin: false })
								
				
			}
 
 
 
    }
  }
</script>

<style lang="scss" scoped>
	
	.meng{

	}
	
	
	
	
  .template-mine {
    max-height: 100vh;
  }
  .tn-tabbar-height {
  	min-height: 120rpx;
  	height: calc(140rpx + env(safe-area-inset-bottom) / 2);
  }
  
  /* 自定义导航栏内容 start */
  .custom-nav {
    height: 100%;
    
    &__back {
      margin: auto 5rpx;
      font-size: 40rpx;
      margin-right: 10rpx;
      flex-basis: 5%;
      width: 100rpx;
      position: absolute;
    }
  }
  /* 自定义导航栏内容 end */

  /* 顶部背景图 start */
  .top-backgroup {
			

    height: 550rpx;
    z-index: -1;

    .backgroud-image {
      width: 100%;
      height: 250rpx;
      // z-index: -1;
    }
  }

  /* 顶部背景图 end */
  
  /* 标题 start */
  .nav_title {
    -webkit-background-clip: text;
    color: #0E122A;
    
    
    &--wrap {
      position: relative;
      display: flex;
      height: 120rpx;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      background-image: url(https://tnuiimage.tnkjapp.com/title_bg/title44.png);
      background-size: cover;
    }
  }
  /* 标题 end */

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
    border: 8rpx solid rgba(255,255,255,0.05);
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

  .about {

    &__wrap {
      position: relative;
      z-index: 1;
      margin: 20rpx 30rpx;
      margin-top: -230rpx;
    }
  }

  /* 页面 end*/
  
  /* 图标容器12 start */
  .tn-three{
      position: absolute;
      top: 50%;
      right: 50%;
      bottom: 50%;
      left: 50%;
      transform: translate(-38rpx, -16rpx) rotateX(30deg) rotateY(20deg) rotateZ(-30deg);
      text-shadow: -1rpx 2rpx 0 #f0f0f0, -2rpx 4rpx 0 #f0f0f0, -10rpx 20rpx 30rpx rgba(0, 0, 0, 0.2);
  }
  .icon20 {
    &__item {
      width: 30%;
      background-color: #FFFFFF;
      border-radius: 10rpx;
      padding: 30rpx;
      margin: 20rpx 10rpx;
      transform: scale(1);
      transition: transform 0.3s linear;
      transform-origin: center center;
      
      &--icon {
        width: 100rpx;
        height: 100rpx;
        font-size: 60rpx;
        border-radius: 50%;
        margin-bottom: 18rpx;
        position: relative;
        z-index: 1;
        
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
          background-image: url(https://tnuiimage.tnkjapp.com/cool_bg_image/icon_bg.png);
        }
      }
    }
  }

  /* 图标容器12 start */
  .icon12 {
    &__item {
      width: 30%;
      background-color: #FFFFFF;
      border-radius: 10rpx;
      padding: 30rpx;
      margin: 20rpx 10rpx;
      transform: scale(1);
      transition: transform 0.3s linear;
      transform-origin: center center;

      &--icon {
        width: 15rpx;
        height: 15rpx;
        font-size: 50rpx;
        border-radius: 50%;
        margin-bottom: 38rpx;
        position: relative;
        z-index: 1;
        
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
            
        }
      }
    }
  }
  
  /* 图标容器1 start */
  .icon1 {
    &__item {
      // width: 30%;
      background-color: #FFFFFF;
      border-radius: 10rpx;
      padding: 30rpx;
      margin: 20rpx 10rpx;
      transform: scale(1);
      transition: transform 0.3s linear;
      transform-origin: center center;
  
      &--icon {
        width: 40rpx;
        height: 40rpx;
        font-size: 28rpx;
        border-radius: 50%;
        position: relative;
        z-index: 1;
  
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
          background-image: url(https://tnuiimage.tnkjapp.com/cool_bg_image/icon_bg.png);
        }
      }
    }
  }
  
  /* 图标容器1 end */
  
  /* 大嘴鸟*/
  .dong {
  	z-index: 9999;
  	position: fixed;
  	top: -40px;
  	right: -80px;
  	transform: scale(0.24);
  	-webkit-transform: scale(0.24);
  	-moz-transform: scale(0.24);
  
  }
  
  .monster {
  	transform: rotate(-50deg);
  	-ms-transform: rotate(-50deg);
  	/* IE 9 */
  	-moz-transform: rotate(-50deg);
  	/* Firefox */
  	-webkit-transform: rotate(-50deg);
  	/* Safari 和 Chrome */
  	-o-transform: rotate(-50deg);
  	/* Opera */
  	display: flex;
  	justify-content: center;
  	position: relative;
  	width: 170px;
  	height: 400px;
  	border-top-left-radius: 200px;
  	border-top-right-radius: 200px;
  	background-color: #3C47D7;
  	box-shadow: 20px 20px 60px #4650E5;
  }
  
  .monster__face {
  	display: flex;
  	justify-content: center;
  	align-items: center;
  	flex-direction: column;
  	position: absolute;
  	top: 14%;
  	width: 75%;
  	height: 160px;
  }
  
  .monster__noses {
  	top: 50%;
  	display: flex;
  	justify-content: space-between;
  	width: 28%;
  	height: auto;
  	margin-bottom: 10px;
  }
  
  .monster__nose {
  	width: 8px;
  	height: 12px;
  	border-radius: 20px;
  	background: rgba(0, 0, 0, 0.5);
  	box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.1);
  }
  
  .monster__mouth {
  	display: flex;
  	justify-content: center;
  	align-items: center;
  	position: relative;
  	width: 100%;
  	height: 0%;
  	overflow: hidden;
  	border: 25px solid #FFC333;
  	border-radius: 100px;
  	background-color: #810332;
  	animation: mouth 1.75s infinite;
  	box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.2);
  	box-sizing: border-box;
  }
  
  .monster__mouth::before {
  	content: '';
  	position: absolute;
  	width: 150px;
  	height: 80px;
  	border-radius: 100px;
  	background-color: #400018;
  }
  
  .monster__mouth::after {
  	content: '';
  	position: absolute;
  	bottom: -80px;
  	width: 160px;
  	height: 80px;
  	border-top-left-radius: 50%;
  	border-top-right-radius: 50%;
  	background-color: #DC1B50;
  	animation: tongue 1.75s infinite;
  }
  
  .monster__top {
  	position: absolute;
  	top: -30px;
  	width: 170px;
  	height: 30px;
  	border-bottom-left-radius: 10px;
  	border-bottom-right-radius: 10px;
  	background-color: #ffffff;
  	z-index: 100;
  	animation: t 1.75s infinite;
  }
  
  .monster__bottom {
  	position: absolute;
  	bottom: 0;
  	width: 100px;
  	height: 30px;
  	border-top-left-radius: 10px;
  	border-top-right-radius: 10px;
  	background-color: #ffffff;
  	z-index: 100;
  	animation: b 1.75s infinite;
  }
  
  
  .avatar-eye {
  	position: absolute;
  	top: -10%;
  	width: 65px;
  	height: 65px;
  	background: linear-gradient(105deg, white, #cb87f4);
  	border-radius: 100%;
  	box-shadow: 4px 8px 5px rgba(0, 0, 0, 0.2);
  	margin: 3px;
  	-webkit-transform: translateX(-50%);
  	transform: translateX(-50%);
  }
  
  
  .avatar-eye--green {
  	background: linear-gradient(to bottom, #fdfdfd, #c3efea);
  }
  
  .avatar-eye--violet {
  	background: linear-gradient(to bottom, #fdfdfd, #e6d6f6);
  }
  
  
  .eye--left {
  	left: 10%;
  }
  
  .eye--right {
  	left: 85%;
  }
  
  .eye--center {
  	left: 45%;
  	top: 10%;
  }
  
  .avatar-eye-pupil {
  	position: absolute;
  	width: 55%;
  	height: 55%;
  	left: 50%;
  	top: 25%;
  	-webkit-transform: translate(-50%);
  	transform: translate(-50%);
  	z-index: 100;
  	border-radius: 100%;
  }
  
  
  .pupil--green {
  	background: linear-gradient(135deg, rgba(188, 248, 177, 0.7), #2fa38c 75%);
  }
  
  .pupil--pink {
  	background: linear-gradient(135deg, #f1a183, #8535cd);
  }
  
  
  .avatar-eye-pupil-blackThing {
  	position: absolute;
  	width: 55%;
  	height: 55%;
  	left: 50%;
  	top: 25%;
  	background: #2c2f32;
  	-webkit-transform: translate(-50%);
  	transform: translate(-50%);
  	border-radius: 100%;
  	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
  }
  
  .avatar-eye-pupil-lightReflection {
  	position: absolute;
  	width: 7px;
  	height: 7px;
  	left: 25%;
  	top: 10%;
  	background: #ebebeb;
  	-webkit-transform: translate(-50%);
  	transform: translate(-50%);
  	border-radius: 100%;
  	box-shadow: 10px 10px 10px rgba(255, 255, 255, 0.2);
  }
  

</style>
