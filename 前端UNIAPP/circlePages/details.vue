<template>
	<view class="template-details tn-safe-area-inset-bottom">
		<!-- 顶部自定义导航 -->
		<tn-nav-bar fixed alpha customBack>
			<view slot="back" class='tn-custom-nav-bar__back'>
				<text class='icon tn-icon-left' @click="goBack"></text>
				<text class='icon tn-icon-home-capsule-fill' @click="gohome"></text>
			</view>
		</tn-nav-bar>
		<mescroll-body ref="mescrollRef" @down="downCallback" @up="upCallback">
			<view class="" :style="{paddingTop: vuex_custom_bar_height + 'px'}">
				<!-- 图文信息 -->
				<block v-for="(item,index) in body" :key="index">
					<view class="blogger__item">
						<view class="blogger__author tn-flex tn-flex-row-between tn-flex-col-center">
							<view class="justify__author__info"
								@click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.user_id, checkLogin: false })">
								<view class="tn-flex tn-flex-row-center">
									<view class="tn-flex tn-flex-row-center tn-flex-col-center">
										<view class="">
											<tn-avatar class="" shape="circle" :src="item.userAvatar" size="lg">
											</tn-avatar>
										</view>
										<view class="tn-padding-right tn-text-ellipsis">
											<view class="tn-padding-right tn-padding-left-sm tn-text-bold tn-text-lg">
												{{ item.userName }}
												<text class="dk-lv">LV {{item.lv}}</text>
												<block v-for="(itemds,indexdd) in item.medal_list" :key="indexdd">
													<image :src="itemds.image" mode="heightFix"
														style="height: 25px;top: 6px;"></image>
												</block>
											</view>
											<view
												class="tn-padding-right tn-padding-left-sm tn-padding-top-xs tn-color-gray">
												{{ item.date }}
											</view>
										</view>
									</view>
								</view>
							</view>
							<view
								class="blogger__author__btn justify-content-item tn-flex-col-center tn-flex-row-center"
								@click="guanzhu(item.user_id)">
								<!-- 既然都点到详情里面了，加个关注按钮呗 -->
								<text class="tn-bg-gray--light tn-round tn-text-df tn-text-bold tn-color-black"
									style="padding: 10rpx 24rpx;" v-if="item.is_follow">已关注</text>
								<text class="tn-bg-yellow tn-round tn-text-df tn-text-bold tn-color-black"
									style="padding: 10rpx 24rpx;" v-else>+ 关注</text>




							</view>

						</view>
						<view class="tn-flex tn-margin-top tn-flex-row-left" v-if="item.label.length>0">
							<view>
								<view v-for="(label_item,label_index) in item.label" :key="label_index"
									class="blogger__desc__labeldd tn-float-left tn-margin-right tn-bg-gray--light tn-round tn-text-sm tn-text-bold"
									@click="navigateToFn({ url: '/circlePages/tags_list?id='+label_item.id, checkLogin: false })">
									<text class="blogger__desc__label--prefix">#</text>
									<text class="tn-text-df">{{ label_item.title }}</text>
								</view>
							</view>
						</view>










						<!-- 内容太多疲劳了-->
						<view v-if="item.content" class="blogger__content" :id="`blogger__content--${item.id}`">
							<view class="blogger__content__data">
								<tn-read-more :closeBtn="true" :showHeight="300">
									<rich-text :nodes="item.content"></rich-text>
								</tn-read-more>
							</view>

						</view>






						<block v-if="item.mainImage">
							<view v-if="[1,2,4].indexOf(item.mainImage.length) != -1" class="tn-padding-top-xs">
								<image v-for="(image_item,image_index) in item.mainImage" :key="image_index"
									class="blogger__main-image" :class="{
                  'blogger__main-image--1 tn-margin-bottom-sm': item.mainImage.length === 1,
                  'blogger__main-image--2 tn-margin-right-sm tn-margin-bottom-sm': item.mainImage.length === 2 || item.mainImage.length === 4
                }" :src="image_item" mode="aspectFill" @click="doPreviewImage(item.mainImage,image_index)"></image>
							</view>
							<view v-else class="tn-padding-top-xs">
								<tn-grid hoverClass="none" :col="3">
									<block v-for="(image_item,image_index) in item.mainImage" :key="image_index">
										<!-- #ifndef MP-WEIXIN -->
										<tn-grid-item style="width: 30%;margin: 10rpx;">
											<image class="blogger__main-image blogger__main-image--3" :src="image_item"
												mode="aspectFill" @click="doPreviewImage(item.mainImage,image_index)">
											</image>
										</tn-grid-item>
										<!-- #endif-->
										<!-- #ifdef MP-WEIXIN -->
										<tn-grid-item style="width: 30%;margin: 10rpx;">
											<image class="blogger__main-image blogger__main-image--3" :src="image_item"
												mode="aspectFill" @click="doPreviewImage(item.mainImage,image_index)">
											</image>
										</tn-grid-item>
										<!-- #endif-->
									</block>
								</tn-grid>
							</view>
						</block>






						<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-top-xs">

							<view class="justify-content-item tn-flex tn-flex-col-center">
								<view style="margin-right: 10rpx;">
									<tn-avatar-group :lists="item.viewUser.latestUserAvatar" size="sm">
									</tn-avatar-group>
								</view>
								<text class="tn-color-gray">{{ item.likeCount}}人</text>
							</view>
							<view class="justify-content-item tn-color-gray tn-text-center">
								<view class="">
									<text class="blogger__count-icon tn-icon-footprint"></text>
									<text class="tn-padding-right">
										{{ $t.number.formatNumberAddPriceUnit(item.collectionCount) }}
									</text>
									<text class="blogger__count-icon tn-icon-message"></text>
									<text class="tn-padding-right">{{ item.commentCount }}</text>
									<text class="blogger__count-icon tn-icon-praise"></text>
									<text class="">{{ item.likeCount }}</text>
								</view>
							</view>
						</view>
					</view>

					<!-- 边距间隔 -->
					<!-- <view class="tn-strip-bottom" v-if="index != content.length - 1"></view> -->


					<!-- 按钮-->
					<view class="tn-flex tn-flex-row-between" style="margin: 40rpx 0 60rpx 0;"
					>
						<view class="tn-flex-1 justify-content-item tn-margin-xs tn-text-center" @click="dianzantiezi(id)">
							<tn-button backgroundColor="#00FFC6" padding="40rpx 0" width="90%" shadow fontBold>
								<text class="tn-icon-praise-fill tn-padding-right-xs "
									:class="item.is_like?'':'tn-color-red'"></text>
								<text class="tn-color-black" v-if="item.is_like">取消点赞</text>
								<text class="tn-color-black" v-else>点 赞</text>
							</tn-button>
						</view>
						<view class="tn-flex-1 justify-content-item tn-margin-xs tn-text-center">
							<tn-button backgroundColor="#FFF00D" padding="40rpx 0" width="90%" shadow fontBold
								open-type="share">
								<text class="tn-icon-share-triangle tn-padding-right-xs tn-color-black"></text>
								<text class="tn-color-black">分 享</text>
							</tn-button>
						</view>
					</view>
				</block>

			</view>

			<view class="tn-flex tn-flex-row-between tn-margin-top">
				<view class="justify-content-item tn-margin tn-text-bold">
					最新评论 <text class="tn-padding-xs">({{commentCount}})</text>
				</view>
			</view>
			<!-- 评论 -->
			<view class="tn-margin" style="padding-bottom: 120rpx;" v-if="content.length>0">

				<view v-for="(item,pinglun) in content" :key="pinglun">
					<!-- 图标logo/头像 -->
					<view class="tn-flex tn-flex-row-between tn-flex-col-center tn-margin-top-xl">
						<view class="justify-content-item">
							<view class="tn-flex tn-flex-col-center tn-flex-row-left">
								<view class="logo-pic tn-shadow"
									@click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.user_id, checkLogin: false })">
									<view class="logo-image">
										<view class="tn-shadow-blur"
											:style="'background-image:url('+item.avatar+');width: 60rpx;height: 60rpx;background-size: cover;'">
										</view>
									</view>
								</view>
								<view class="tn-padding-right tn-padding-left-sm">
									<view class="tn-padding-right tn-text-df tn-text-bold tn-color-black" @click="navigateToFn({ url: '/circlePages/blogger_other?id='+item.user_id, checkLogin: false })">
									

	<text v-if="item.user_id==item.fa_user_id" class="tn-color-red">作者</text>
										{{item.nickname}}
									</view>
									<view class="tn-padding-right tn-text-ellipsis  tn-color-gray"
										style="padding-top: 5rpx;">										
										{{item.create_time}}
										
										<text @click="delcomment(item.id,'del',0,0,pinglun,0)"
											class=" tn-color-blue tn-margin-left"
											v-if="item.user_id==item.ziji_id||item.fa_user_id==item.ziji_id">
											删除
										</text>
										<text @click="top(item.id,'top',1,0,pinglun,0)"
											class=" tn-color-blue tn-margin-left"
											v-if="item.is_ding==0&&item.fa_user_id==item.ziji_id">
											置顶
										</text>
										<text @click="top(item.id,'top',0,0,pinglun,0)"
											class=" tn-color-blue tn-margin-left"
											v-if="item.is_ding==1&&item.fa_user_id==item.ziji_id">
											取消置顶
										</text>
									</view>
								</view>
							</view>
						</view>
						<view class="justify-content-item tn-flex-row-center tn-flex-col-center tn-color-gray"
							@click="likeComment(item.id,pinglun,0,0)">
							<view class="tn-text-center">
								<text class="tn-icon-praise-fill tn-padding-xs "
									:class="item.is_like?'tn-color-red':''"></text>
							</view>
							<view class="tn-text-center">
								<text class="">{{item.like_num}}</text>
							</view>
						</view>
					</view>

					<view class="" style="margin: 20rpx 30rpx 30rpx 80rpx;"
						@click="hiufu(item.nickname,item.id,pinglun)">
						<text v-if="item.is_ding" style="padding: 3px 10px;
							font-size: 12px;
							height: 18px;
							margin: 5px 10px 5px 0;
							width: auto;" class="tn-bg-gray--light tn-btn-class tn-btn tn-round tn-color-red">
							作者置顶
						</text>
						{{item.content}}

					</view>

					<view v-for="(itemhuifu,pinglunhuifu) in item.child" :key="pinglunhuifu"
						class="tn-bg-gray--light tn-padding-sm"
						style="margin: 8rpx 30rpx 8rpx 80rpx;border-radius: 10rpx;"
						>
						<view @click="hiufu(itemhuifu.nickname,item.id,pinglun)">
						<text class="tn-color-gray tn-padding-right-xs ">							
							<text v-if="itemhuifu.user_id==itemhuifu.fa_user_id" class="tn-color-red">作者</text>
							
							{{itemhuifu.nickname}}:
						</text>
						<text class="tn-text-bold " v-if="itemhuifu.to_name">回复/</text>
						<text class="tn-color-gray " v-if="itemhuifu.to_name">:{{itemhuifu.to_name}}</text>						
			           <text  class="" style="line-height: 40rpx;" >{{itemhuifu.content}}</text>	
					</view>
					
					
						<view class="tn-flex tn-flex-row-between tn-margin-top-xs">
							<view class="justify-content-item  tn-color-gray" style="padding-top: 5rpx;">
								<text @click="delcomment(itemhuifu.id,'del',0,pinglunhuifu,pinglun,1)" class=" tn-color-blue tn-margin-right"
									v-if="itemhuifu.user_id==itemhuifu.ziji_id||item.fa_user_id==itemhuifu.ziji_id">
									删除
								</text>
								
								{{itemhuifu.create_time}}

							</view>
							<view class="justify-content-item  tn-color-gray"
								@click="likeComment(itemhuifu.id,pinglun,pinglunhuifu,1)">
								<text class="tn-padding-xs">{{itemhuifu.like_num}}</text>
								<text class="tn-icon-praise-fill" :class="itemhuifu.is_like?'tn-color-red':''"></text>
							</view>
						</view>

						<view>


						</view>

					</view>
				</view>
			</view>



			<view class="tabbar footerfixed dd-glass">
				<view class="tn-flex tn-flex-row-between tn-flex-col-center">
					<view class="justify-content-item tn-margin-top">
						<view class="tn-flex tn-flex-row-center tn-flex-col-center">


							<!-- 	<view class="tn-flex tn-flex-row-center tn-padding-right tn-padding-left">
              <text class="tn-icon-emoji-good tn-text-xxl"></text>
    </view> -->

							<view	class="tn-flex tn-flex-row-center tn-flex-col-center tn-padding-right tn-padding-left-sm">
								<view class="avatar-all">
									<view v-if="userInfoAvatar" class="tn-shadow-blur"
										:style="'background-image:url('+userInfoAvatar+');width: 60rpx;height: 60rpx;background-size: cover;'">
									</view>
									<view v-else class="tn-shadow-blur"
										:style="'background-image:url('+configInfo.site_logo+');width: 60rpx;height: 60rpx;background-size: cover;'">
									</view>
								</view>
							</view>


							<view
								class="topic__info__item__input tn-flex tn-flex-direction-row tn-flex-nowrap tn-flex-col-center tn-flex-row-left">
								<view class="topic__info__item__input__left-icon">
									<view class="tn-icon-emoji-good"></view>
								</view>
								<view class="topic__info__item__input__content" @click="huifuzhuti()">
									<input maxlength="100" placeholder-class="input-placeholder" :cursor-spacing="18"
									@blur="lostfocus"  :adjust-position="true" v-model="sendmsgBoy" :placeholder="huifubody"
										:focus="is_focus" />
								</view>
							</view>
						</view>
								</view>
					<view class="justify-content-item tn-flex-row-center tn-flex-col-center tn-margin-top tn-margin-right">
						<view class="topic__info__item__sure">
							<view class="tn-flex-1 justify-content-item tn-text-center" @click="sendmsg()">
								<tn-button shape="round" backgroundColor="tn-main-gradient-yellow--reverse" width="100%"
									shadow>
									<text class="tn-color-black" hover-class="tn-hover" :hover-stay-time="150">
										发 送
									</text>
								</tn-button>
							</view>
						</view>
					</view>
				</view>
			</view>

			<!-- 登录框组件 -->
			<login-fn :is-show-login="loginBoxFlag" @loginSuccessCallback="refreshFn" @close="closeGlobalLoginFn">
			</login-fn>
		</mescroll-body>
	</view>
</template>

<script>
	import MescrollBody from '@/components/mescroll-uni/mescroll-body.vue';
	import MescrollUni from '@/components/mescroll-uni/mescroll-uni.vue';
	import MescrollMixin from '@/components/mescroll-uni/mescroll-mixins.js';
	import template_page_mixin from '@/libs/mixin/template_page_mixin.js'
	import {
		mapState
	} from 'vuex';
	export default {
		name: 'TemplateDetails',
		mixins: [template_page_mixin, MescrollMixin],
		components: {
			MescrollBody
		},
		data() {
			return {
				is_focus: false,
				commentCount: 0,
				huifuindex: 0,
				pid: 0,
				loginBoxFlag: false, // 登录框显示隐藏状态
				sendmsgBoy: '',
				sendmsgBoy_huifuname: '',
				content: [],
				loginBoxFlag: false, // 登录框显示隐藏状态
				id: 290,
				body: [],
				userInfoAvatar_no: '/static/navigation.png',
				huifubody: '说点啥吧'
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
		computed: {
			...mapState({
				userInfoAvatar: store => store.userInfo.userInfoAvatar // 头像地址		
			})
		},

		methods: {
			
			lostfocus(){
			this.is_focus = false	
			},
			
			huifuzhuti(){				
				if (this.is_focus==false){
				this.callerhuifu()
				}
			},

			callerhuifu() {
				this.huifubody = '说点啥吧'
				this.sendmsgBoy_huifuname = ''
				this.huifuindex = 0
				this.sendmsgBoy = ''
				this.pid = 0	
				this.is_focus = false	
			
					
			},

			hiufu(name, pid, index) {		
		 	this.huifubody = '回复：' + name
				this.sendmsgBoy_huifuname = name
				this.huifuindex = index
				this.pid = pid
				this.is_focus = true
			},
			async info() {
				let that = this;
				let result = await that.$request({
					loading: 0,
					method: 'post',
					url: '/api/index/goodsdetail',
					data: {
						id: that.id
					}
				});


				if (result.statusCode == 200) {
					if (result.data.code == 200) {

						if (result.data.data.total == 0) {
							uni.showModal({
								title: '提示',
								content: '帖子已删除',
								confirmText: '知道了',
								showCancel: false,
								success: function(res) {
									if (res.confirm) {
										uni.navigateBack()
									} else if (res.cancel) {
										console.log('用户点击取消');
									}
								}
							});
							return
						}

						that.body = result.data.data.data;
						that.commentCount = result.data.data.data[0].commentCount


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
					loading: 0,
					method: 'post',
					url: '/api/index/goodsCommentList',
					data: {
						id: that.id,
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





			refreshFn() {
				this.info()
			},




			async guanzhu(id) {
				if (!this.isLogin) {
					this.loginBoxFlag = true
					return false;
				}
				let result = await this.flowUser(id)
				this.body[0].is_follow = result.is_follow
				this.msg(result.msg)
			},

			async likeComment(id, index, cindex, type) {
				if (!this.isLogin) {
					this.loginBoxFlag = true
					return false;
				}
				let result = await this.getlikeComment(id)
				if (type == 0) {
					if (result.msg == '点赞成功') {
						this.content[index].is_like = true
						this.content[index].like_num += 1

					} else {
						this.content[index].is_like = false
						this.content[index].like_num -= 1
					}
				} else {
					if (result.msg == '点赞成功') {
						this.content[index].child[cindex].is_like = true
						this.content[index].child[cindex].like_num += 1

					} else {
						this.content[index].child[cindex].like_num -= 1
						this.content[index].child[cindex].is_like = false
					}

				}

				this.msg(result.msg)
			},


			async dianzantiezi(id) {
				if (!this.isLogin) {
					this.loginBoxFlag = true
					return false;
				}
				let result = await this.flowgoods(id)
				if (result.msg == '点赞成功') {
					this.body[0].is_like = true
				} else {
					this.body[0].is_like = false
				}


				this.msg(result.msg)
			},

			async sendmsg() {


				let that = this;
				if (!this.isLogin) {
					this.loginBoxFlag = true
					return false;
				}
				if (that.sendmsgBoy == '') {
					that.is_focus=true
					that.msg('说点啥呗')
					return
				}
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/addGoodsComment',
					data: {
						goods_id: that.id,
						content: that.sendmsgBoy,
						pid: that.pid,
						to_name: that.sendmsgBoy_huifuname
					}
				});
				if (result.statusCode == 200) {
					if (result.data.code == 200) {
						if (that.content.length == 0) {
							that.mescroll.endSuccess()
						}
						if (that.pid == 0) {
							that.content = result.data.data.concat(that.content);
						} else {
							that.content[that.huifuindex].child = result.data.data.concat(that.content[that.huifuindex]
								.child);
						}



						that.commentCount++
						that.callerhuifu()
						uni.showToast({
							icon: 'none',
							title: '评论成功'
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
			
			
			top(id,type,num,ziindex,index,is_zi) {
				
				let typename=''				
				if (num==0){
				typename='取消'	
				}
				let that=this
				uni.showModal({
					title: '提示',
					content: '确定要'+typename+'置顶该条评论吗？',	
					success: function(res) {
						if (res.confirm) {
							that.editcommet(id,type,num,ziindex,index,is_zi)
						} else if (res.cancel) {
						
						}
					}
				});
			},
			 delcomment(id,type,num,ziindex,index,is_zi) {
				 
	
				 
				let that=this
				uni.showModal({
					title: '提示',
					content: '确定要删除该条评论吗？',	
					success: function(res) {
						if (res.confirm) {
							that.editcommet(id,type,num,ziindex,index,is_zi)
						} else if (res.cancel) {
						
						}
					}
				});
			},
			
			async editcommet(id,type,num,ziindex,index,is_zi) {			
				let that = this;
				let result = await that.$request({
					loading: 1,
					method: 'post',
					url: '/api/user/editcomment',
					data: {
						id: id,
						type:type,
						num:num,
						goods_id:that.id
					}
				});


				if (result.statusCode == 200) {
					
					if (type=='del'&&is_zi==0){
					that.content.splice(index,1);
						that.commentCount--
						//删除主评论
					}
					if (type=='del'&&is_zi==1){
					that.commentCount--	
						//删除回复
					that.content[index].child.splice(ziindex,1);					
					}
					if (type=='top'){
						//操作置顶			
					that.content[index].is_ding =num	
					}
					
					uni.showToast({
						icon: 'none',
						title: result.data.msg
					});
				} else {
					uni.showToast({
						icon: 'none',
						title: that.$errorMsg
					});
				}


			},



			// 切换内容的显示与隐藏
			switchContentShowStatus(index) {
				const contentItem = this.content[index]
				contentItem.showAllContent = !contentItem.showAllContent
				this.$set(this.content, index, contentItem)
			},
			doPreviewImage(url, index) {
				console.log(url)
				uni.previewImage({
					current: index,
					urls: url,
					index
				})

			},



		}
	}
</script>

<style lang="scss" scoped>
	/* 胶囊*/
	.blogger__desc__label--prefix {
		color: #00FFC8;
		padding-right: 5px;
	}

	.blogger__desc__labeldd {
		margin-top: 5px;
		height: 24px;
		padding: 4px 6px;
		margin: 5px 9px 0 0;
	}

	/* 文章内容 start*/
	.blogger {
		&__item {
			padding: 30rpx;
		}

		&__author {
			&__btn {
				margin-right: -12rpx;
				padding: 0 20rpx;
			}
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

			&__content {}
		}

		&__content {
			margin-top: 18rpx;
			padding-right: 18rpx;

			&__data {
				line-height: 46rpx;
				text-align: justify;
				overflow: hidden;
				transition: all 0.25s ease-in-out;

			}

			&__status {
				margin-top: 10rpx;
				font-size: 26rpx;
				color: #82B2FF;
			}
		}

		&__main-image {
			border-radius: 16rpx;

			&--1 {
				max-width: 80%;
				max-height: 300rpx;
			}

			&--2 {
				max-width: 260rpx;
				max-height: 260rpx;
			}

			&--3 {
				height: 212rpx;
				width: 100%;
			}
		}

		&__count-icon {
			font-size: 40rpx;
			padding-right: 5rpx;
		}

		&__ad {
			width: 100%;
			height: 500rpx;
			transform: translate3d(0px, 0px, 0px) !important;

			::v-deep .uni-swiper-slide-frame {
				transform: translate3d(0px, 0px, 0px) !important;
			}

			.uni-swiper-slide-frame {
				transform: translate3d(0px, 0px, 0px) !important;
			}

			&__item {
				position: absolute;
				width: 100%;
				height: 100%;
				transform-origin: left center;
				transform: translate3d(100%, 0px, 0px) scale(1) !important;
				transition: transform 0.25s ease-in-out;
				z-index: 1;

				&--0 {
					transform: translate3d(0%, 0px, 0px) scale(1) !important;
					z-index: 4;
				}

				&--1 {
					transform: translate3d(13%, 0px, 0px) scale(0.9) !important;
					z-index: 3;
				}

				&--2 {
					transform: translate3d(26%, 0px, 0px) scale(0.8) !important;
					z-index: 2;
				}
			}

			&__content {
				border-radius: 40rpx;
				width: 640rpx;
				height: 500rpx;
				overflow: hidden;
			}

			&__image {
				width: 100%;
				height: 100%;
			}
		}
	}

	/* 文章内容 end*/

	/* 间隔线 start*/
	.tn-strip-bottom {
		width: 100%;
		border-bottom: 20rpx solid rgba(241, 241, 241, 0.8);
	}

	/* 间隔线 end*/

	/* 头像 start */
	.logo-image {
		width: 60rpx;
		height: 60rpx;
		position: relative;
	}

	.logo-pic {
		background-size: cover;
		background-repeat: no-repeat;
		// background-attachment:fixed;
		background-position: top;
		box-shadow: 0rpx 0rpx 80rpx 0rpx rgba(0, 0, 0, 0.15);
		border-radius: 50%;
		overflow: hidden;
		// background-color: #FFFFFF;
	}


	/* 底部 start*/
	.footerfixed {
		position: fixed;
		width: 100%;
		bottom: 0;
		z-index: 999;
		background-color: #ffffff;
		box-shadow: 0rpx 0rpx 30rpx 0rpx rgba(0, 0, 0, 0.07);
	}

	.tabbar {
		align-items: center;
		min-height: 130rpx;
		padding: 0;
		height: calc(130rpx + env(safe-area-inset-bottom) / 2);
		padding-bottom: calc(30rpx + env(safe-area-inset-bottom) / 2);
		padding-left: 10rpx;
		padding-right: 10rpx;
	}

	/* 毛玻璃*/
	.dd-glass {
		width: 100%;
		backdrop-filter: blur(20rpx);
		-webkit-backdrop-filter: blur(20rpx);
	}

	/* 头像*/
	.avatar-all {
		width: 60rpx;
		height: 60rpx;
		border: 4rpx solid rgba(255, 255, 255, 0.05);
		border-radius: 50%;
		overflow: hidden;
		box-shadow: 0rpx 0rpx 80rpx 0rpx rgba(0, 0, 0, 0.15);
	}

	/* 内容*/
	.topic {
		position: relative;
		height: 100%;
		z-index: 1;
		margin-bottom: 120rpx;


		/* 表单信息 start */
		&__info {
			margin: 0 50rpx;
			margin-top: 105rpx;
			padding: 30rpx 51rpx;
			border-radius: 20rpx;
			background-color: rgba(255, 255, 255, 1);
			border: 2rpx solid rgba(255, 255, 255, 0.1);
			box-shadow: 0rpx 10rpx 50rpx 0rpx rgba(0, 3, 72, 0.1);

			&__item {

				&__input {
					width: 400rpx;
					height: 60rpx;
					border: 1rpx solid #C6D1D8;
					border-radius: 39rpx;

					&__left-icon {
						width: 10%;
						font-size: 44rpx;
						margin-left: 20rpx;
						margin-right: 5rpx;
						color: #C6D1D8;
					}

					&__content {
						width: 80%;
						padding-left: 10rpx;

						&--verify-code {
							width: 56%;
						}

						input {
							font-size: 30rpx;
							color: #78909C;
							// letter-spacing: 0.1em;
						}
					}

					&__right-icon {
						width: 10%;
						font-size: 34rpx;
						margin-right: 20rpx;
						color: #78909C;
					}

					&__right-verify-code {
						width: 34%;
						margin-right: 20rpx;
					}
				}

				&__button {
					width: 100%;
					height: 60rpx;
					text-align: center;
					font-size: 31rpx;
					font-weight: bold;
					line-height: 77rpx;
					// text-indent: 1em;
					border-radius: 100rpx;
					color: #FFFFFF;
					background-color: rgba(255, 255, 255, 0.2);
					// border: 2rpx solid #FFFFFF;
				}

				&__sure {
					height: 60rpx;
					width: 140rpx;
				}

			}
		}

		/* 表单信息 end */

		/* 内容 end */

	}

	/deep/.input-placeholder {
		font-size: 30rpx;
		color: #C6D1D8;
	}
</style>
