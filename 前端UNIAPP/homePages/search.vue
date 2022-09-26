<template>
  <view class="template-search tn-safe-area-inset-bottom">
    
   
      <!-- 顶部自定义导航 -->
    <tn-nav-bar fixed alpha customBack>
      <view slot="back" class='tn-custom-nav-bar__back'
        >
        <text class='icon tn-icon-left' @click="goBack"></text>
       <text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
      </view>
	  搜索
    </tn-nav-bar>
      
      

    

    
    <view class="tn-search-fixed">
      <view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin" :style="{marginTop: vuex_custom_bar_height + 'px'}">
        <view class="justify-content-item align-content-item">
          <view class="tn-bg-gray--light tn-flex tn-flex-col-center" style="border-radius: 100rpx;padding: 10rpx 20rpx 10rpx 20rpx;width: 100%;">
            <text class="tn-icon-search justify-content-item tn-padding-right-xs tn-color-gray tn-text-lg"></text>
            <input class="justify-content-item" placeholder="想搜点什么咧" v-model="searchKey" placeholder-style="color:#AAAAAA" ></input>
          </view>
        </view>
        
        <view class="align-content-item">
          <view class="justify-content-item tn-text-center" @click="sousuo()">
            <tn-button fontColor="#000000" :shadow="true" backgroundColor="tn-main-gradient-yellow--reverse"   shape="round" padding="20rpx 20rpx" width="150rpx" shadow fontBold >
              <text >{{title}}</text>
            </tn-button>
			
          </view>
        </view>
      </view>
    </view>
    
	
	
	
	
	<mescroll-body ref="mescrollRef"  @down="downCallback" @up="upCallback">
			
	
	<view  class="" style="margin-top: 160rpx;" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
	  <view class="tn-flex tn-flex-row-between tn-margin" >
	    <view class="justify-content-item tn-text-bold">
	      <text class="tn-text-df tn-color-black">大家都在搜</text>
	    </view>	   
	  </view>
	</view>
	
	<view class="">
	  <view class="tn-tag-search tn-margin tn-text-justify">
	    <view v-for="(item, index) in configInfo.sitekey" :key="index" 
		@click="hisBtnTxtFn(item)"
		class="tn-tag-search__item tn-margin-right tn-round tn-text-sm tn-text-bold tn-bg-orangered--light tn-color-orangered">
	      <text class="tn-tag-search__item--prefix">#</text> {{ item }}
	    </view>
	  </view>
	</view>
	
    <view  class="" >
      <view class="tn-flex tn-flex-row-between tn-margin" >
        <view class="justify-content-item tn-text-bold">
          <text class="tn-text-df tn-color-black">搜索记录</text>
        </view>
        <view class="justify-content-item tn-text-df tn-color-grey" @click="delHistoryKeyFn" >
          <text class="tn-padding-xs">删除</text>
          <text class="tn-icon-delete"></text>
        </view>
      </view>
    </view>
    
    <view class="">
      <view class="tn-tag-search tn-margin tn-text-justify">
        <view v-for="(item, index) in searchKeyList" :key="index" 
		@click="hisBtnTxtFn(item)"
		class="tn-tag-search__item tn-margin-right tn-round tn-text-sm tn-bg-gray--light tn-color-gray">
          <text class="tn-tag-search__item--prefix">#</text> {{ item }}
        </view>
      </view>
    </view>
    
    <view class="tn-flex tn-flex-row-between tn-padding-top-xl tn-margin tn-padding-bottom" v-if="content.length>0" >
      <view class="justify-content-item tn-text-bold">
        <text class="tn-text-df tn-color-black">搜索结果</text>
      </view>
     <!-- <view class="justify-content-item tn-text-df tn-color-grey">
        <text class="tn-padding-xs">筛选</text>
        <text class="tn-icon-filter"></text>
      </view> -->
    </view>
    
	<view class="tn-flex tn-flex-direction-column tn-margin-top-sm tn-margin-bottom">
	
		<!-- 图文信息 -->
		<block v-for="(item,indextd) in content" :key="indextd">
			<quan-list :item="item"></quan-list>
		</block>
	</view>
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
    data(){
      return {
		showListFlag:false,
        searchKey: '',        
        searchKeyList: [],
        content: [],
		title:'搜 索'
      }
    },
	
	onLoad() {
		let searchKeyList = uni.getStorageSync('homeSearchKeyList');	
		let tem;
		if (searchKeyList) {
			tem = JSON.parse(searchKeyList);
		} else {
			tem = [];
		}
		this.searchKeyList = tem;	
	},	
	
    methods: {
		downCallback(mescroll) {
			mescroll.endSuccess();
			mescroll.resetUpScroll();
		},
		
		
		hisBtnTxtFn(title){
			this.searchKey=title
			 this.showListFlag=true		
			this.mescroll.resetUpScroll();
		},
		
		
		
	  async upCallback(mescroll) {
	  	let that = this;	 
			
			if (!that.searchKey){
			mescroll.endErr()
				return
			}
		
	
		
	  	let result = await that.$request({
	  		loading: 0,
	  		method: 'post',
	  		url: '/api/index/getGoodslist',
	  		data: {
	  			key: that.searchKey,
	  			page: mescroll.num
	  		}
	  	});
	  	if (result.statusCode == 200) {
	  		if (result.data.code == 200) {
				if (that.searchKey==''){
				that.mescroll.endErr()
					return
				}
	  
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
	  
	  
	  
	  
	  
	  sousuo(){
		  let that = this;
		  
		  if (that.searchKey==''){
			that.msg('写点啥呗')
			return
		  }
		  
		  if (!that.searchKey || that.searchKey.length <= 0) {
		  	that.searchKey = that.configInfo.search_default_text;
		  }
		  let searchKeyList = uni.getStorageSync('homeSearchKeyList');
		  let tem;
		  if (searchKeyList) {
		  	tem = JSON.parse(searchKeyList);
		  } else {
		  	tem = [];
		  }
		  if (!tem.includes(that.searchKey)) {
		  	tem.push(that.searchKey);
		  	that.searchKeyList.push(that.searchKey);
		  }
	
		  uni.setStorageSync('homeSearchKeyList', JSON.stringify(tem));		  
		  that.mescroll.resetUpScroll()
		  that.showListFlag=true
		 
	  },
	  
	  delHistoryKeyFn() {
	  	let that = this;
	  	uni.showModal({
	  		title: '提示',
	  		content: '删除历史记录',
	  		success(e) {
	  			if (e.confirm) {
	  				uni.setStorageSync('homeSearchKeyList', '');
	  				that.searchKeyList.splice(0, that.searchKeyList.length);
	  			}
	  		}
	  	});
	  },
	  
	  
	  
      tn(e) {
      	uni.navigateTo({
      		url: e,
      	});
      },
    }
  }
</script>

<style lang="scss" scoped>
  .tn-search-fixed{
    position: fixed;
    top: 50rpx;
    width: 100%;
    transition: all 0.25s ease-out;
    z-index: 1;
  }
 
  
  /* 顶部渐变*/
  .tn-navbg {
     // background: linear-gradient(-120deg, #F15BB5, #9A5CE5, #01BEFF, #00F5D4);
      /* background: linear-gradient(-120deg,  #9A5CE5, #01BEFF, #00F5D4, #43e97b); */
      /* background: linear-gradient(-120deg,#c471f5, #ec008c, #ff4e50,#f9d423); */
       background: linear-gradient(-120deg, #f956b6, #ea7e0a); 
      background-size: 500% 500%; 
      animation: gradientBG 15s ease infinite; 
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 100;
  } 
   
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
  
  /* 搜索标签 start*/
  .tn-tag-search {
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
  
  /* 标题 start */
  .nav_title {
    -webkit-background-clip: text;
    color: transparent;
    
    &--wrap {
      position: relative;
      display: flex;
      height: 120rpx;
      font-size: 42rpx;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      background-image: url(https://tnuiimage.tnkjapp.com/title_bg/title00.png);
      background-size: cover;
    }
  }
  /* 标题 end */
  
  /* 富文本图示意 start */
  .news-img {
    z-index: -1;
    padding-bottom: 40rpx;
  
    image {
      width: 100%;
      margin: 20rpx 0;
      // height: 3373rpx;
      // z-index: -1;
    }
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
      padding: 7rpx 25rpx 5rpx 25rpx;
  
      &--prefix {
        padding-right: 10rpx;
      }
    }
  }
  
  /* 标签内容 end*/
</style>
