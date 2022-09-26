<template>

	<view class="blogger__item">

		<view class="blogger__author tn-flex tn-flex-row-between tn-flex-col-center">
			<view class="justify__author__info">
				<view class="tn-flex tn-flex-row-center"
					@click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.user_id, checkLogin: false })">
					<view class="tn-flex tn-flex-row-center tn-flex-col-center">
						<view class="">
							<tn-avatar class="" shape="circle" :src="item.userAvatar" size="lg">
							</tn-avatar>
						</view>
						<view class="tn-padding-right tn-text-ellipsis">
							<view class="tn-padding-right tn-padding-left-sm tn-text-lg">
								<text class=" tn-text-bold">{{ item.userName }}</text>
								<text class="dk-lv">LV {{item.lv}}</text>
								<block v-for="(itemds,indexdd) in item.medal_list" :key="indexdd">
									<image :src="itemds.image" mode="heightFix" style="height: 25px;top: 6px;"></image>
								</block>
							</view>
							<view class="tn-padding-right tn-padding-left-sm tn-padding-top-xs tn-color-gray">
								{{ item.date }}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view v-if="item.manage ==1||item.ziji == 1" class="blogger__author__btn justify-content-item tn-flex-col-center tn-flex-row-center"
				@click="chaozuo(item)">
				<text class="tn-icon-more-vertical tn-color-gray tn-text-bold tn-text-xxl"></text>
			</view>
		</view>

		<view class="tn-flex tn-flex-row-left">
			<text style="padding: 0px 10px;
		font-size: 12px;
		height: 18px;
		margin: 5px 10px 5px 0;
		width: auto;" class="tn-main-gradient-yellow--reverse tn-icon-up-arrow tn-btn-class tn-btn tn-round tn-color-black"
				v-if="item.is_ding==1&&!index">
				置顶
			</text>
			<text style="padding: 0px 10px;
			font-size: 12px;
			height: 18px;
			margin: 5px 0 5px 0;
			width: auto;
			" class="tn-main-gradient-orangered--reverse tn-icon-praise tn-btn-class tn-color-white tn-round"
				v-if="item.is_tuijian==1">
				推荐
			</text>
		</view>
		<!-- 	<view class="tn-flex  tn-flex-row-left" v-if="item.label.length>0" @click="navigateToFn({ url: '/circlePages/details?id='+item.id, checkLogin: false })">				
			<view >
				<view v-for="(label_item,label_index) in item.label" :key="label_index"
					class="blogger__desc__label tn-float-left tn-margin-right tn-bg-gray--light tn-round tn-text-sm tn-text-bold">
					<text class="blogger__desc__label--prefix">#</text>
					<text class="tn-text-df">{{ label_item.title }}</text>
				</view>
			</view>
		</view> -->



		<!-- 内容太多疲劳了-->
		<view v-if="item.content" class="blogger__content dk-top-10 tn-text-content"		
			@click="navigateToFn({ url: '/circlePages/details?id='+item.id, checkLogin: false })">
			<view class="blogger__content__data tn-text-ellipsis-3" >
				<text v-for="(label_item,label_index) in item.label" :key="label_index"
					class="tn-text-bold tn-color-blue">
					#{{ label_item.title }}#</text>
				{{ item.content }}
				
			</view>

	
		</view>



		<block v-if="item.mainImage">
			<view v-if="[1,2,4].indexOf(item.mainImage.length) != -1" class="tn-padding-top-xs"
				@click="navigateToFn({ url: '/circlePages/details?id='+item.id, checkLogin: false })">
				<image v-for="(image_item,image_index) in item.mainImage" :key="image_index" class="blogger__main-image"
					:class="{
                  'blogger__main-image--1 tn-margin-bottom-sm': item.mainImage.length === 1,
                  'blogger__main-image--2 tn-margin-right-sm tn-margin-bottom-sm': item.mainImage.length === 2 || item.mainImage.length === 4
                }" :src="image_item" mode="aspectFill"></image>
			</view>
			<view v-else class="tn-padding-top-xs"
				@click="navigateToFn({ url: '/circlePages/details?id='+item.id, checkLogin: false })">
				<tn-grid hoverClass="none" :col="3">
					<block v-for="(image_item,image_index) in item.mainImage" :key="image_index">
						<!-- #ifndef MP-WEIXIN -->
						<tn-grid-item style="width: 30%;margin: 10rpx;">
							<image class="blogger__main-image blogger__main-image--3" :src="image_item"
								mode="aspectFill"></image>
						</tn-grid-item>
						<!-- #endif-->
						<!-- #ifdef MP-WEIXIN -->
						<tn-grid-item style="width: 30%;margin: 10rpx;">
							<image class="blogger__main-image blogger__main-image--3" :src="image_item"
								mode="aspectFill"></image>
						</tn-grid-item>
						<!-- #endif-->
					</block>
				</tn-grid>
			</view>
		</block>

		<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-top-xs">
			<view class="justify-content-item tn-color-gray tn-text-center">
				<view class="">
					<text class="blogger__count-icon tn-icon-footprint"></text>
					<text class="tn-padding-right">
						{{ $t.number.formatNumberAddPriceUnit(item.collectionCount) }}
					</text>
					<text class="blogger__count-icon tn-icon-message"></text>
					<text class="tn-padding-right">
						{{ $t.number.formatNumberAddPriceUnit(item.commentCount) }}
					</text>
					<text class="blogger__count-icon tn-icon-praise"></text>
					<text class="">
						{{ $t.number.formatNumberAddPriceUnit(item.likeCount) }}</text>
				</view>
			</view>
			<view class="justify-content-item tn-flex tn-flex-col-center">
				<view style="margin-right: 10rpx;margin-left: 20rpx;">
					<tn-avatar-group :lists="item.viewUser.latestUserAvatar" size="sm"></tn-avatar-group>
				</view>
				<text class="tn-color-gray">{{ item.likeCount }}人</text>
			</view>
		</view>
	</view>





</template>

<script>
	export default {
		props: ['item', 'index'],
		
		created() {
			
		}
		,
		
		methods: {
			chaozuo(item) {
				let that = this	
				if ( !uni.getStorageSync('token')){					
					that.msg('请登陆')
				}				
				let list = []
				if (item.ziji == 1 &&uni.getStorageSync('token')) {
					list = ['删除帖子'];
				}
				if (item.manage == 1) {
					list = ['删除帖子', '推荐贴子', '置顶帖子'];
				}
				uni.showActionSheet({
					itemList: list,
					success: function(res) {
						if (res.tapIndex == 0) {
							that.edieGoods(item.id,1)
						}
						if (res.tapIndex == 1) {
							that.edieGoods(item.id,2)
						}
						
						if (res.tapIndex == 2) {
							that.edieGoods(item.id,3)
						}
						

					},
					fail: function(res) {
						console.log(res.errMsg);
					}
				});


			},

			async edieGoods(id,type) {
				console.log(3)
				let that = this;
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/edieGoods',
		 		data: {
						id: id,
						type:type
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						that.msg(result.data.msg)
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
	};
</script>


<style scoped lang="scss">
	.xunzhang {
		width: 20px;
	}

	.blogger__desc__label--prefix {
		color: #00FFC8;
		padding-right: 5px;
	}

	.blogger__desc__label {
		height: 24px;
		padding: 4px 6px;
		margin: 5px 9px 0 0;
	}

	.blogger__item {
		padding: 15px;
	}

	.blogger__main-image--2 {
		max-width: 130px;
		max-height: 130px;
	}

	.blogger__main-image--3 {
		height: 106px;
		width: 100%;
	}

	.blogger__main-image {
		border-radius: 8px;
	}

	.blogger__main-image--1 {
		max-width: 80%;
		max-height: 150px;
	}
</style>
