<template>
	<view class="template-hot tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
		<view slot="back" class='tn-custom-nav-bar__back' >
			<text class='icon tn-icon-left' @click="goBack"></text>
		 <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
		</view>
		</tn-nav-bar>
	  	<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">

		<view  class="tn-flex tn-margin-xs tn-padding-top-sm" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
		  <view class="tn-flex-1 tn-padding-sm tn-margin-xs tn-radius" @click="qiehuan(0)">
		    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
		      <view :class="[{'icon13__item--icon': type === 0},{'icon12__item--icon': type !== 0}]"    class="tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-main-gradient-purplered--light tn-color-purplered">
		        <view class="tn-icon-fire-fill tn-three"></view>
		      </view>  
		      <view class="tn-color-black tn-text-center">
		        <text class="tn-text-ellipsis">评论我的</text>
		      </view>
		    </view>
		  </view>
		  <view class="tn-flex-1 tn-padding-sm tn-margin-xs tn-radius" @click="qiehuan(1)">
		    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
		      <view :class="[{'icon13__item--icon': type === 1},{'icon12__item--icon': type !== 1}]"   class=" tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-main-gradient-indigo--light tn-color-indigo">
		        <view class="tn-icon-flower-fill tn-three"></view>
		      </view>  
		      <view class="tn-color-black tn-text-center">
		        <text class="tn-text-ellipsis">收到的赞</text>
		      </view>
		    </view>
		  </view>
		  <view class="tn-flex-1 tn-padding-sm tn-margin-xs tn-radius" @click="qiehuan(2)">
		    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
		      <view :class="[{'icon13__item--icon': type === 2},{'icon12__item--icon': type !== 2}]"  class=" tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-main-gradient-purple--light tn-color-purple">
		        <view class="tn-icon-identity-fill tn-three"></view>
		      </view>  
		      <view class="tn-color-black tn-text-center">
		        <text class="tn-text-ellipsis">系统通知</text>
		      </view>
		    </view>
		  </view>
		  <view class="tn-flex-1 tn-padding-sm tn-margin-xs tn-radius" @click="qiehuan(3)">
		    <view class="tn-flex tn-flex-direction-column tn-flex-row-center tn-flex-col-center">
		      <view :class="[{'icon13__item--icon': type === 3},{'icon12__item--icon': type !== 3}]"  class=" tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-main-gradient-orange--light tn-color-orange">
		        <view class="tn-icon-star-fill tn-three"></view>
		      </view>  
		      <view class="tn-color-black tn-text-center">
		        <text class="tn-text-ellipsis">关注我的</text>
		      </view>
		    </view>
		  </view>
		</view>
		
		

		  <tn-list-cell :unlined="true" v-for="(item, index) in content" :key="index">
		   
			<view class="message" @click="navigateToFn({ url: '/circlePages/details?id='+item.goods_id, checkLogin: false })" v-if="type==0">
		      <view class="message__left" style="">
		        <tn-avatar :src="item.avatar"></tn-avatar>
		      </view>
		      <view class="message__middle">				  
		        <view class="message__name">
				<text class="tn-text-bold" style="font-size: 14px;">{{ item.nickname }}</text>
				<text class="" style="font-size: 14px;margin-left: 8px;">对我的帖子发表了评论</text>
				</view>
		        <view class="message__content tn-text-ellipsis-2 tn-color-black">	
				说：{{ item.content }}
				</view>
				<view class="message__content tn-margin-top" >
				{{ item.create_time }}
				</view>
		      </view>
			 <view class="message__right" >
				 <image :src="item.goods_image[0]"  mode="widthFix" style="width: 40px;" v-if="item.goods_image.length>0"></image> 
			 </view>	 
						      
		    </view>
			
			<view class="message" @click="navigateToFn({ url: '/circlePages/details?id='+item.goods_id, checkLogin: false })" v-if="type==1">
			  <view class="message__left">
			    <tn-avatar :src="item.avatar"></tn-avatar>
			  </view>
			  <view class="message__middle">				  
			    <view class="message__name">
				<text class="tn-text-bold" style="font-size: 14px;">{{ item.nickname }}</text>
				<text class="" style="font-size: 14px;margin-left: 8px;">赞我的帖子</text>
				</view>			  
				<view class="message__content " >
				{{ item.create_time }}
				</view>
			  </view>	
					  <view class="message__right" >
					<image :src="item.goods_image[0]"  mode="widthFix" style="width: 40px;" v-if="item.goods_image.length>0"></image> 
					   </view>
			</view>
			
			
			
			
			<view class="message" @click="navigateToFn({ url: '/homePages/about?type=msg&id='+item.id, checkLogin: false })" v-if="type==2">
			  <view class="message__left ">
			 <view style="width: 30px;
    height: 30px;" class="icon12__item--icon tn-flex tn-flex-row-center tn-flex-col-center tn-shadow-blur tn-main-gradient-purplered--light tn-color-purplered">
			   <view class="tn-icon-message-fill tn-three"></view>
			 </view>
			  </view>
			  <view class="message__middle" style="width: 90%;">				  
			    <view class="message__name">
				<text class="tn-text-bold" style="font-size: 14px;">系统消息：</text>
				<text class="" style="font-size: 14px;margin-left: 8px;"></text>
				</view>			  
				<view class="message__content " >
				{{ item.title }}
				</view>
			  </view>	
					
			</view>
			
			
			<view class="message" @click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.id, checkLogin: false })" v-if="type==3">
			  <view class="message__left">
			    <tn-avatar :src="item.avatar"></tn-avatar>
			  </view>
			  <view class="message__middle" >				  
			    <view class="message__name">
				<text class="tn-text-bold" style="font-size: 14px;">{{ item.nickname }}</text>
				<text class="" style="font-size: 14px;margin-left: 8px;">关注了我</text>
				</view>			  
				<view class="message__content " >
				{{ item.create_time }}
				</view>
			  </view>	
					<view class="message__right" >
				
					 </view> 
			</view>
			
			
		  </tn-list-cell>
		

		

  	</mescroll-body>

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
				type:0,
				cardCur: 0,
				swiperList: [],
				content: [],
				planList: [{
					color: 'red',
				}, {
					color: 'cyan',
				}, {
					color: 'blue',
				}, {
					color: 'green',
				}, {
					color: 'orange',
				}, {
					color: 'purplered',
				}, {
					color: 'purple',
				}],
				news: [],
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
			
		},

		methods: {
		
		qiehuan(type){
			this.type=type
			this.mescroll.resetUpScroll();
		},
		/// 列表调用
		downCallback(mescroll) {
			mescroll.endSuccess();
			mescroll.resetUpScroll();
		},	
		async upCallback(mescroll) {
			let that = this;
			let url
			if (that.type==0){
				url='/api/user/commentMeList'
			}
			if (that.type==1){
				url='/api/user/likeMeList'
			}
			if (that.type==2){
				url='/api/user/getMessageList'
			}
			if (that.type==3){
				url='/api/index/fansList?user_id=0&page=1'
			}
			
			//getMessageList    commentMeList  likeMeList
			
			let result = await that.$request({
				loading: 1,
				method: 'post',
				url: url,
				data: {
					id:that.id,
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
		}
	}
</script>

<style lang="scss" scoped>
	.template-plan {}

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

	/* 图标容器12 start */
	.tn-three{
	    position: absolute;
	    top: 50%;
	    right: 50%;
	    bottom: 50%;
	    left: 50%;
	    transform: translate(-38rpx, -20rpx) rotateX(20deg) rotateY(10deg) rotateZ(-20deg);
	    text-shadow: -1rpx 2rpx 0 #f0f0f0, -2rpx 4rpx 0 #f0f0f0, -10rpx 20rpx 30rpx rgba(0, 0, 0, 0.2);
	}
	
	
	.icon13 {
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
	      width: 120rpx;
	      height: 120rpx;
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
	       
	
	          
	      }
	    }
	  }
	}
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
	      width: 80rpx;
	      height: 80rpx;
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
	       
	
	          
	      }
	    }
	  }
	}
	
	
	.message {
	  display: flex;
	  flex-direction: row;
	
	  justify-content: space-around;
	  
	  &__left {
	    width: 10%;
	  }
	  &__middle {
	    width: 70%;
	    padding-left: 20rpx;
	    padding-right: 40rpx;
	  }
	  &__right {
	    width: 20%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: center;
	  }
	  
	  &__name {
	    font-size: 32rpx;
	    margin-bottom: 8rpx;
	  }
	  &__content {
	    font-size: 26rpx;
	    color: #838383;
	  }
	  &__tips {
	    &__icon {
	      font-size: 36rpx;
	      color: #AAAAAA;
	    }
	  }
	}
</style>
