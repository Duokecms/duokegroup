<template>
	<view class="template-edit tn-safe-area-inset-bottom">
    <!-- 顶部自定义导航 -->
    <tn-nav-bar fixed alpha customBack>
      <view slot="back" class='tn-custom-nav-bar__back'
        @click="goBack">
        <text class='icon tn-icon-left'></text>
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
      
      <view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top tn-margin">
        <view class="tn-flex justify-content-item">
          <view class="tn-bg-black tn-color-white tn-text-center" style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
            <text class="tn-icon-topics" style="font-size: 30rpx;"></text>
          </view>
          <view class="tn-text-lg tn-padding-right-xs tn-text-bold">想说点什么</view>
        </view>
        <view class="justify-content-item tn-text-df tn-color-grey">
          <text class="tn-padding-xs">500字内</text>
          <text class="tn-icon-keyboard-circle"></text>
        </view>
      </view>
      
      <!-- <view class="tn-margin tn-bg-gray--light" style="border-radius: 10rpx;padding: 20rpx 30rpx;">
      	<input placeholder="写下一句简短的标题" name="input" placeholder-style="color:#AAAAAA" ></input>
      </view> -->
      <view class="tn-margin tn-bg-gray--light tn-padding" style="border-radius: 10rpx;">
        <textarea maxlength="500" v-model="content" placeholder="说点什么 , 万一火了呢"
          placeholder-style="color:#AAAAAA"></textarea>
      </view>
      
      <view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin">
        <view class="tn-flex justify-content-item">
          <view class="tn-bg-black tn-color-white tn-text-center" style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
            <text class="tn-icon-image" style="font-size: 30rpx;"></text>
          </view>
          <view class="tn-text-lg tn-padding-right-xs tn-text-bold">发点什么图咧
		    <text class="tn-text-xs tn-padding-right-xs tn-color-gray">长按可拖拽排序</text>
		  </view>
		
        </view>
        <view class="justify-content-item tn-text-df tn-color-grey" @tap="clear">
          <text class="tn-padding-xs">清空上传</text>
          <text class="tn-icon-delete"></text>
        </view>
      </view>
      
      
      
      
      <view class="tn-margin-left tn-padding-top-xs" >
    <tn-image-upload-drag
      ref="imageUpload"
      :action="action"
      :width="236"
      :height="236"
      :formData="formData"
      :fileList="fileList"
      :disabled="disabled"
      :autoUpload="autoUpload"
      :maxCount="maxCount"
      :showUploadList="showUploadList"
      :showProgress="showProgress"
      :deleteable="deleteable"
      :customBtn="customBtn"
      @sort-list="onSortList"
	  @on-uploaded="onUploaded"
    />
    
      </view>
	  
      <view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin" v-if="cate_id==0">
        <view class="tn-flex justify-content-item">
          <view class="tn-bg-black tn-color-white tn-text-center" style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
            <text class="tn-icon-moments" style="font-size: 30rpx;"></text>
          </view>
          <view class="tn-text-lg tn-padding-right-xs tn-text-bold">同步到圈子</view>
        </view>
        <view class="justify-content-item tn-text-df tn-color-grey" @click="navigateToFn({ url: '/circlePages/edit_quan?id=', checkLogin: false })">
          <text class="tn-padding-xs">{{quan_title}}</text>  
      				  <text class="tn-icon-right-double" ></text>
        </view>
      </view>
	  
      <view class="tn-flex tn-flex-row-between tn-flex-col-center tn-padding-top-xl tn-margin">
        <view class="tn-flex justify-content-item">
          <view class="tn-bg-black tn-color-white tn-text-center" style="border-radius: 100rpx;margin-right: 8rpx;width: 45rpx;height: 45rpx;line-height: 45rpx;">
            <text class="tn-icon-topic" style="font-size: 30rpx;"></text>
          </view>
          <view class="tn-text-lg tn-padding-right-xs tn-text-bold">话题标签</view>
        </view>
        <view class="justify-content-item tn-text-df tn-color-grey">
          <text class="tn-padding-xs">{{tags_title}}</text>  
				  <text class="tn-icon-delete" @click="huatidel()"></text>
        </view>
      </view>
      
      <view class="tn-tag-content tn-margin tn-text-justify tn-padding-bottom">
        <view v-for="(item, index) in tagList" :key="index"
		 class="tn-tag-content__item tn-margin-right tn-round tn-text-sm tn-text-bold tn-bg-orange--light tn-color-black"
		 @click="huati(item.id,item.title)"
		 >
          <text class="tn-tag-content__item--prefix">#</text> {{ item.title }}
        </view>
      </view>  

	  
	
      
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
    name: 'TemplateEdit',
    mixins: [template_page_mixin],
		data() {
			return {
				cate_id:0,
				content:'',
				quan_title:'选择圈子',
				tags_title:'请选择下面的话题',
				tags_id:0,
				tagList: [],
				quan:[],
				//图片上传参数
				action: '',			
				formData: {
				  apiType: 'this,ali',
				  token: uni.getStorageSync('token'),
				  image: null
				},
				fileList: [],
				okpiclist:'',//上传完毕的图片字符逗号隔开
				showUploadList: true,
				customBtn: false,
				autoUpload: false,
				showProgress: true,
				deleteable: true,
				customStyle: false,
				maxCount: 9,
				disabled: false				
				//
				
			}
		},
	onLoad(option) {
	let that=this
	uni.$off('setLoginBoxFlag');
	uni.$on('setLoginBoxFlag', loginBoxFlag => {
		that.loginBoxFlag = loginBoxFlag;
	});	
	uni.$on('quan', loginBoxFlag => {
		that.quan = loginBoxFlag
		that.quan_title= loginBoxFlag.title
	});	
		that.action=host+'/api/user/up_img'
	
		if (option.id) {
			this.quan.id = option.id
			this.cate_id = option.id			
			this.quan_title = option.title			
		}
		
	
		this.info()			
	},
		methods: {
			

			    delImage(done) {
			      uni.showModal({
			        content: '是否删除?',
			        success: (res) => {
			          if(res.confirm) {
			            // 执行 done() 删除
			            done()
			          }
			        }
			      })
			    },
			
			
			
			
			
			
			huatidel(){
				this.tags_title='请选择下面的话题'
				this.tags_id=0
			},
			huati(id,title){
				this.tags_title=title
				this.tags_id=id
			},			
			async info() {
				let that = this;		
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/guangChang',
					data: {
						
					}
				});		
								
				if (result.statusCode == 200) {
					if (result.data.code == 200) {			
						that.tagList = result.data.data.tags;			
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
      // 跳转
      tn(e) {
      	uni.navigateTo({
      		url: e,
      	});
      },
  
   
      // 手动清空列表
      clear() {
        this.$refs.imageUpload.clear()
      },
      // 图片拖拽重新排序
      onSortList(list) {    
      },
	  // 图片
	  onUploaded(list) {
		  
		  uni.showLoading({
		  	title:'发布中，请稍后'
		  })
		  
		if (list.length>0){
		let imageList =list.map(i => i.response.data.file).join(',');	
			this.okpiclist=imageList
			this.send()
		}
		else{
			this.send()
		} 
	  },
	  
	  
	  
	  fabu(){		  
		 if (this.content==''){
			 this.msg('说点啥呀')
			 return
		 } 		 
		 if (!this.quan.id){
		 			 this.msg('请选择圈子')
		 			 return
		  } 
		  
	  this.$refs.imageUpload.upload()  
	  },
	  
	  async send() {
		  
		  
	  	let that = this;		
	  	let result = await that.$request({
	  		loading: 1,
	  		method: 'post',
	  		url: '/api/user/addNewGoods',
	  		data: {
	  		content:that.content,
			tags_ids:that.tags_id,
			cate_id:that.quan.id,
			images:that.okpiclist
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
			
				uni.$emit('fabu_ok',result.data.code)
						
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
	.template-edit{
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
  /* 标签内容 end*/
</style>
