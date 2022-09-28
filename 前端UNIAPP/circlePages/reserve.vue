<template>
  <view class="template-reserve tn-safe-area-inset-bottom">
    <!-- 顶部自定义导航 -->
    <tn-nav-bar fixed alpha customBack>
  <view slot="back" class='tn-custom-nav-bar__back' >
  	<text class='icon tn-icon-left' @click="goBack"></text>
   <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
  </view>
    </tn-nav-bar>
    

    <!-- 页面内容 -->
    <view class="slideshow">
	   <block v-for="(item, index) in images" :key="index">
      <view class="slideshow-image" :style="'background-image: url('+ item +')'"></view>
</block>
    </view>
    
    <view class="reserve tn-safe-area-inset-bottom" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
      <view class="reserve-content tn-padding tn-color-black tn-text-lg dd-glass2" style="margin:31vh 30rpx 20vh 30rpx">
        <view class="tn-text-center tn-text-bold tn-padding-top tn-padding-bottom">
           {{body.title}}
        </view>
        <view class="">
          
          <view class="blogger__desc tn-margin-top-sm tn-margin-bottom-sm tn-text-justify tn-flex-col-center tn-flex-row-left">
       
            <!-- 不用限制长度了，因为发布的时候限制长度了-->
            <text class="blogger__desc__content tn-flex-1 tn-text-justify tn-text-df">
               {{body.detail}}
            </text>  
          </view>
          

        </view>
        
        <view class="tn-padding-top-lg">
          举办时间：{{body.times}}
        </view>
        
       <view class="tn-margin-top tn-color-black tn-bg-white tn-radius" @click="openLocation()">
          <view class="tn-flex tn-flex-row-between tn-flex-col-center">
            <view class="justify-content-item">
              <view class="tn-flex tn-flex-col-center tn-flex-row-left">
                <view class="tn-padding tn-color-black">
                  <view class="tn-padding-right-sm tn-text-lg tn-text-bold clamp-text-1">
                    {{body.address}}
                  </view>
                </view>
              </view>
            </view>
            <view class="tn-flex justify-content-item tn-flex-row-center tn-padding-right-xs">
              <view class="tn-bg-gray--light tn-padding-xs tn-margin-sm tn-color-black tn-round">
                <text class="tn-icon-location-fill" style="font-size: 50rpx;"></text>
              </view>
            </view>
          </view>
        </view>
        
        <view class="tn-text-center tn-text-bold tn-padding-top-xl">
          活动参与者
        </view>
        
    
          <view class="tn-flex tn-flex-wrap tn-margin-top-xl">
            <block v-for="(item, index) in groupList" :key="index">
              <view class="tn-padding-bottom tn-padding-left" style="width: 20%;">
                <view class="tn-flex tn-flex-row-left tn-flex-col-center" style="">
                  <view class="user-pic">
                    <view class="user-image">
                      <view class="tn-shadow-blur" :style="'background-image:url('+ item.src +');width: 70rpx;height: 70rpx;background-size: cover;'">
                      </view>
                    </view>
                  </view>
                </view>
              </view>
            </block>
          </view>

     
        
        
      </view>
      
      
	  
	  <view class='tn-tabbar-height'></view>
	  
	  <!-- 悬浮按钮-->
	  <view class="tn-flex tn-footerfixed" @click="follow()">
	  	<view class="tn-flex-1 justify-content-item tn-margin-sm tn-text-center">
	  		<tn-button backgroundColor="#a1a1a1" padding="40rpx 0" width="60%" shadow fontBold v-if="body.is_follow">
	  			<!-- <text class="tn-icon-light tn-padding-right-xs tn-color-black"></text> -->
	  			<text class="tn-color-black">已报名，取消参加</text>
	  			<text class="tn-icon-flag tn-padding-left-xs tn-color-black"></text>
	  		</tn-button>
			<tn-button backgroundColor="#00FFC6" padding="40rpx 0" width="60%" shadow fontBold v-else>
				<!-- <text class="tn-icon-light tn-padding-right-xs tn-color-black"></text> -->
				<text class="tn-color-black">参与活动</text>
				<text class="tn-icon-flag tn-padding-left-xs tn-color-black"></text>
			</tn-button>
	  	</view>
	  </view>
	  
	  
 
      
      
    </view>
    
    <login-fn :is-show-login="loginBoxFlag"  @close="closeGlobalLoginFn">
    </login-fn>
    
    
    
  </view>
</template>

<script>
  import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
  export default {
    name: 'TemplateReserve',
    mixins: [template_page_mixin],
    data(){
      return {
		  loginBoxFlag:false,
		  id:0,
		  images:[],
		  body:[],
        groupList: []
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
				loading: 1,
				method: 'post',
				url: '/api/index/Active_detail',
				data: {
					id: that.id
				}
			});
			if (result.statusCode == 200) {
				if (result.data.code == 200) {
					that.body = result.data.data;	
				that.images=result.data.data.images;
					that.groupList = result.data.data.viewUser.latestUserAvatar;
						console.log(that.groupList)
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
		
		
      openLocation() {
		  
		  if (this.body.lng){
        uni.openLocation({
          longitude: Number(this.body.lng),
          latitude: Number(this.body.lat),
          name: '活动举办地',
          address:this.body.address
        })
		}
		else{
			this.msg('未标注地图')
		}
		
      },
	  
	  
	  async follow() {
	  if (!this.isLogin) {
	  	this.loginBoxFlag = true					
	  	return false;
	  }
	  let that = this;
	  let result = await that.$request({
	  	loading: 1,
	  	method: 'post',
	  	url: '/api/user/followactive',
	  	data: {
	  		id: that.id
	  	}
	  });
	  if (result.statusCode == 200) {
	  	if (result.data.code == 200){					
	  	if (result.data.msg=='报名成功'){
			that.info()
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
    }
  }
</script>

<style lang="scss" scoped>
  .template-reserve {
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
  
  /* 内容*/
  .reserve{
    position: relative;
    z-index: 99;
  }
  
  .reserve-content{
    background-color: rgba(255,255,255,0.7);
    border-radius: 30rpx;
  }
  
  
  /* 标签 */
    .blogger {
      &__item {
        padding: 30rpx;
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
      }
  
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
  
  /* 毛玻璃*/
  .dd-glass {
     width: 100%;
     backdrop-filter: blur(20rpx);
    -webkit-backdrop-filter: blur(20rpx);
  }
  
  /* 毛玻璃*/
  .dd-glass2 {
    // width: 100%;
     backdrop-filter: blur(8rpx);
    -webkit-backdrop-filter: blur(8rpx);
  }
  
  /* 用户头像 start */
  .user-image {
    width: 70rpx;
    height: 70rpx;
    position: relative;
  }
  
  .user-pic {
    background-size: cover;
    background-repeat: no-repeat;
    // background-attachment:fixed;
    background-position: top;
    border-radius: 100rpx;
    overflow: hidden;
    background-color: #FFFFFF;
  }
  
  /* 底部悬浮按钮 start*/
  .tn-tabbar-height {
  	min-height: 120rpx;
  	height: calc(140rpx + env(safe-area-inset-bottom) / 2);
  }
  .tn-footerfixed {
    position: fixed;

    bottom: 0;
    width: 100%;
    transition: all 0.25s ease-out;
    z-index: 100;
  }
  

  /* 相册 start*/
  .slideshow {
    top: 0;
    position: fixed;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    z-index: 0;
  }
  
  .slideshow-image {
    position: absolute;
    width: 100%;
    height: 100%;
    background: no-repeat 50% 50%;
    background-size: cover;
    -webkit-animation-name: kenburns;
            animation-name: kenburns;
    -webkit-animation-timing-function: linear;
            animation-timing-function: linear;
    -webkit-animation-iteration-count: infinite;
            animation-iteration-count: infinite;
    -webkit-animation-duration: 16s;
            animation-duration: 16s;
    opacity: 1;
    transform: scale(1.2);
  }
  .slideshow-image:nth-child(1) {
    -webkit-animation-name: kenburns-1;
            animation-name: kenburns-1;
    z-index: 3;
  }

  
  @-webkit-keyframes kenburns-1 {
    0% {
      opacity: 1;
      transform: scale(1.2);
    }
    1.5625% {
      opacity: 1;
    }
    23.4375% {
      opacity: 1;
    }
    26.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
    98.4375% {
      opacity: 0;
      transform: scale(1.2117647059);
    }
    100% {
      opacity: 1;
    }
  }
  
  @keyframes kenburns-1 {
    0% {
      opacity: 1;
      transform: scale(1.2);
    }
    1.5625% {
      opacity: 1;
    }
    23.4375% {
      opacity: 1;
    }
    26.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
    98.4375% {
      opacity: 0;
      transform: scale(1.2117647059);
    }
    100% {
      opacity: 1;
    }
  }
  @-webkit-keyframes kenburns-2 {
    23.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    26.5625% {
      opacity: 1;
    }
    48.4375% {
      opacity: 1;
    }
    51.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
  }
  @keyframes kenburns-2 {
    23.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    26.5625% {
      opacity: 1;
    }
    48.4375% {
      opacity: 1;
    }
    51.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
  }
  @-webkit-keyframes kenburns-3 {
    48.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    51.5625% {
      opacity: 1;
    }
    73.4375% {
      opacity: 1;
    }
    76.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
  }
  @keyframes kenburns-3 {
    48.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    51.5625% {
      opacity: 1;
    }
    73.4375% {
      opacity: 1;
    }
    76.5625% {
      opacity: 0;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(1.2);
    }
  }
  @-webkit-keyframes kenburns-4 {
    73.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    76.5625% {
      opacity: 1;
    }
    98.4375% {
      opacity: 1;
    }
    100% {
      opacity: 0;
      transform: scale(1);
    }
  }
  @keyframes kenburns-4 {
    73.4375% {
      opacity: 1;
      transform: scale(1.2);
    }
    76.5625% {
      opacity: 1;
    }
    98.4375% {
      opacity: 1;
    }
    100% {
      opacity: 0;
      transform: scale(1);
    }
  }
    /* 相册 end*/
</style>
