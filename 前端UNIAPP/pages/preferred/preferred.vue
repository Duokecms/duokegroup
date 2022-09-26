<template>
  <view class="template-preferred tn-safe-area-inset-bottom">
	<tn-nav-bar	 fixed :isBack="false">圈子广场</tn-nav-bar>
    <mescroll-body ref="mescrollRef"  @down="downCallback" @up="upCallback">
	<view class="" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
	  <swiper class="card-swiper tn-margin-top-sm" :circular="true"
	    :autoplay="true" duration="500" interval="5000" previous-margin="75rpx" next-margin="75rpx" @change="cardSwiper"> 
	    <swiper-item v-for="(item,index) in swiperList" :key="index" :class="cardCur==index?'cur':''">
	      <!-- <view class="swiper-item image-banner">
	        <image :src="item.url" mode="aspectFill" v-if="item.type=='image'"></image>
	      </view> -->
	      
	      <view class="swiper-item image-banner tn-shadow-blur" :style="'background-image:url('+ item.image + ');background-size: cover;border-radius: 15rpx;'">
	      </view>

	    </swiper-item>
	  </swiper>
	  <view class="indication">
	      <block v-for="(item,indexhuati) in swiperList" :key="indexhuati">
	          <view class="spot" :class="cardCur==indexhuati?'active':''"></view>
	      </block>
	  </view>
	  
	</view>
	 <view class="tn-bg-white tn-safe-area-inset-bottom" style="border-radius: 50rpx 50rpx 0 0;">
 <view class="" style="margin-top: -20rpx;">
      <view class="tn-flex tn-flex-row-between">
        <view class="justify-content-item tn-margin tn-text-bold tn-text-xl">
          活动报名
        </view>
        <view class="tn-margin" style="font-size: 50rpx;">
          <text class="tn-icon-data"></text>
        </view>
      </view>
    </view>
    
    <view class="tn-margin-left tn-text-sm tn-color-gray" style="margin-top: -25rpx;">
      <text>参与下线活动和小伙伴一起嗨皮！</text>
    </view>
	
    <view class="tn-margin-bottom-lg" >
      <block v-for="(item, indexhuodong) in content" :key="indexhuodong">
        <view class="article-shadow tn-margin" @click="tn('/circlePages/reserve?id='+item.id)">
          <view class="tn-flex">
            <view class="image-pic tn-margin-sm" :style="'background-image:url(' + item.logo + ')'">
              <view class="image-article">
              </view>
            </view>
            <view class="tn-margin-sm tn-padding-top-xs" style="width: 100%;">
              <view class="tn-text-lg tn-text-bold clamp-text-1 tn-text-justify">
                {{ item.title }}
              </view>
              <view class="tn-flex tn-flex-row-between tn-flex-col-between tn-padding-top-xs" style="min-height: 105rpx;">
            
                <view class="justify-content-item tn-flex tn-flex-col-center">
                  <tn-avatar-group :lists="item.viewUser.latestUserAvatar" size="sm"></tn-avatar-group>
                </view>
                <view class="justify-content-item tn-flex tn-flex-col-center">
                  <text class="tn-color-gray">{{ item.viewUser.viewUserCount }} 人参与</text>
                </view>
              </view>
              <view class="tn-flex tn-flex-row-between tn-flex-col-between">
              
                <view class="justify-content-item tn-color-gray tn-text-center tn-color-gray" style="padding-top: 5rpx;">
                  <text class="tn-padding-right tn-text-df">{{ item.times }}</text>
				  <text class="tn-icon-eye tn-padding-right-xs tn-text-lg"></text>
                  <text class="tn-padding-right tn-text-df">{{ item.view_num }}</text>
                  <text class="tn-icon-fire tn-padding-right-xs tn-text-lg"></text>
                  <text class="tn-text-df">{{ item.viewUser.viewUserCount }}</text>
                </view>
              </view>
            </view>
          </view>
        </view>
      </block>
    </view>
     </view>
    <view class='tn-tabbar-height'></view>
    
	
	
	
	
	
	
	<!-- 登录框组件 -->
	<login-fn :is-show-login="loginBoxFlag"  @close="closeGlobalLoginFn">
	</login-fn>
	
	
	<!-- 压屏窗-->
	<tn-landscape :show="show_fabu" @close="closeLandscape" closePosition="bottom" :closeSize="60">
	<!-- 方式9 start-->
	<view class="tn-flex" style="margin-bottom: 100rpx;padding-top: 46vh;">
	  <view class="tn-flex-1 tn-margin-sm tn-radius" @click="navigateToFn({ url: '/circlePages/edit?id=', checkLogin: true })">
	    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
	      <view class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-red tn-color-white">
	        <view class="tn-icon-camera-fill"></view>
	      </view>  
	      <view class="tn-color-white tn-text-sm tn-text-center">
	        <text class="tn-text-ellipsis">发布动态</text>
	      </view>
	    </view>
	  </view>
	  <view class="tn-flex-1 tn-margin-sm tn-radius" @click="navigateToFn({ url: '/circlePages/create?id=', checkLogin: true })">
	    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
	      <view class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-cyan tn-color-white">
	        <view class="tn-icon-flag-fill"></view>
	      </view>  
	      <view class="tn-color-white tn-text-sm tn-text-center">
	        <text class="tn-text-ellipsis">发起活动</text>
	      </view>
	    </view>
	  </view>
	  <view class="tn-flex-1 tn-margin-sm tn-radius" @click="navigateToFn({ url: '/circlePages/build?id=', checkLogin: true })">
	    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
	      <view class="icon9__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-bg-blue tn-color-white">
	        <view class="tn-icon-topics-fill"></view>
	      </view>  
	      <view class="tn-color-white tn-text-sm tn-text-center">
	        <text class="tn-text-ellipsis">创建圈子</text>
	      </view>
	    </view>
	  </view>
	</view>		
	</tn-landscape>
	
	
	
			</mescroll-body>
	
	<view class="edit tnxuanfu " @click="navigateToFn({ url: '/circlePages/create', checkLogin: true })">
	  <view class="bg0 pa button-shop tn-cool-bg-color-16">
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
		mixins: [template_page_mixin, MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				loginBoxFlag: false, // 登录框显示隐藏状态
				show_fabu: false,
        cardCur: 0,
		swiperList: [],
       content: [ ]
      }
    },
    mounted() {
		
	let that = this
			uni.$off('setLoginBoxFlag_preferred');
			uni.$on('setLoginBoxFlag_preferred', loginBoxFlag => {
					console.log('登录返回')
					
				that.loginBoxFlag = loginBoxFlag;
			});		
			uni.$on('indexpreferred', data => {
				if (!uni.getStorageSync('token')) {
					that.loginBoxFlag = true
					return false;
				} else {
					that.show_fabu = true
				}

			});
			uni.$on('fabuhuodng_ok', data => {
					that.info()				
			});
			
			
			
			that.info()	
			
    },

    methods: {
		async info() {
			let that = this;
			let result = await that.$request({
				loading: 0,
				method: 'post',
				url: '/api/index/index',
				data: {
					type: 2
				}
			});
			if (result.statusCode == 200) {
				if (result.data.code == 200) {
					that.swiperList = result.data.data.swiperList;			
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
		
		async upCallback(mescroll) {
			let that = this;	 
					
				if (that.searchKey==''){
				that.mescroll.endErr()
					return
				}
			let result = await that.$request({
				loading: 0,
				method: 'post',
				url: '/api/index/allActiveList',
				data: {
					key: that.searchKey,
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
      },
      // tab选项卡切换
      tabChange(index) {
        this.current = index
      },
      // 跳转
      tn(e) {
      	uni.navigateTo({
      		url: e,
      	});
      },
 
      // 瀑布流加载完毕事件
      handleWaterFallFinish() {
        this.loadStatus = 'loadmore'
      },
      // 获取价格整数和小数部分
      getPrice(price) {
        const priceStr = String(price)
        if (priceStr.indexOf('.') !== -1) {
          return priceStr.split('.')
        } else {
          return [priceStr, '00']
        }
      },
  // 关闭压屏窗
      closeLandscape() {
        this.show_fabu = false
      }
    }
  }
</script>

<style lang="scss" scoped>
  .template-preferred {
    // background-color: $tn-bg-gray-color;
    max-height: 100vh;
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
  
  .image-banner{
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .image-banner image{
    width: 100%;
    height: 100%;
  }
  
  
  /* 移动背景部分 start*/
  .bg-contaniner {
    position: fixed;
    top: -0rpx;
    left: -300rpx;
    --text-color: hsl(0 95% 60%);
    --bg-color: hsl(0 0% 100%);
    --bg-size: 200px;
    height: 100%;
    display: grid;
    place-items: center;
    place-content: center;
    overflow: hidden;
    background-color: var(--bg-color);
    z-index: -1;
  }
  
  .bg-contaniner::before {
    --size: 150vmax;
    content: "";
    inline-size: var(--size);
    block-size: var(--size);
    background-image: url("https://tnuiimage.tnkjapp.com/animate/animate3.png");
    background-size: var(--bg-size);
    background-repeat: repeat;
    transform: rotate(45deg);
    opacity: 0.25;
    animation: bg 6s linear infinite;
  }
  
  @media (prefers-reduced-motion: reduce) {
    .bg-contaniner::before {
      animation-duration: 0s;
    }
  }
  
  @keyframes bg {
    to {
      background-position: 0 calc(var(--bg-size) * -1);
    }
  }
  /* 移动背景部分 end*/
  
  
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

