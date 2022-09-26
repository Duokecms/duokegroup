<template>
	<view class="start-index">
		<view v-if="tabberPageLoadFlag[0]" :style="{display: currentIndex === 0 ? '' : 'none'}">
			<scroll-view class="custom-tabbar-page" scroll-y enable-back-to-top @scrolltolower="tabbarPageScrollLower">
				<home ref="home"></home>
			</scroll-view>
		</view>
		<view v-if="tabberPageLoadFlag[1]" :style="{display: currentIndex === 1 ? '' : 'none'}">
			<scroll-view class="custom-tabbar-page" scroll-y enable-back-to-top @scrolltolower="tabbarPageScrollLower">
				<circle-page ref="circleRef"></circle-page>
			</scroll-view>
		</view>

		<view v-if="tabberPageLoadFlag[3]" :style="{display: currentIndex === 3 ? '' : 'none'}">
			<scroll-view class="custom-tabbar-page" scroll-y enable-back-to-top @scrolltolower="tabbarPageScrollLower">
				<preferred ref="preferredRef"></preferred>
			</scroll-view>
		</view>
		<view v-if="tabberPageLoadFlag[4]" :style="{display: currentIndex === 4 ? '' : 'none'}">
			<scroll-view class="custom-tabbar-page" scroll-y enable-back-to-top @scrolltolower="tabbarPageScrollLower">
				<mine ref="mine"></mine>
			</scroll-view>
		</view>

		<tn-tabbar v-model="currentIndex" :list="tabbarList" activeColor="#838383" inactiveColor="#AAAAAA"
			activeIconColor="#FBBD12" :animation="true" :safeAreaInsetBottom="true" @change="switchTabbar"></tn-tabbar>


	</view>
</template>

<script>
	import Home from './home/home.vue'
	import CirclePage from './circle/circle.vue'
	import Activity from './activity/activity.vue'
	import Preferred from './preferred/preferred.vue'
	import Mine from './mine/mine.vue'

	export default {
		components: {
			Home,
			CirclePage,
			Activity,
			Preferred,
			Mine
		},
		data() {
			return {
				loginBoxFlag: false, // 登录框显示隐藏状态
				// 底部tabbar菜单数据
				/* 压屏窗*/
				show2: false,
				maskCloseable: true,
				tabbarList: [{
						title: '首页',
						activeIcon: '/static/tabbar/home_tnnew.png',
						inactiveIcon: '/static/tabbar/home_tn.png'
					},
					{
						title: '广场',
						activeIcon: '/static/tabbar/circle_tnnew.png',
						inactiveIcon: '/static/tabbar/circle_tn.png'
					},
					{
						title: '发布',
						activeIcon: 'menu-circle',
						inactiveIcon: 'rocket',
						activeIconColor: '#FFFFFF',
						inactiveIconColor: '#FFFFFF',
						iconSize: 50,
						out: true
					},
					{
						title: '活动',
						activeIcon: '/static/tabbar/preferred_tnnew.png',
						inactiveIcon: '/static/tabbar/preferred_tn.png',
					},
					{
						title: '我的',
						activeIcon: '/static/tabbar/mine_tnnew.png',
						inactiveIcon: '/static/tabbar/mine_tn.png'
					}
				],
				// tabbar当前被选中的序号
				currentIndex: 0,
				// 自定义底栏对应页面的加载情况
				tabberPageLoadFlag: []
			}
		},
		onLoad(options) {
			let that = this;
			const index = Number(options.index || 0)
			// 根据底部tabbar菜单列表设置对应页面的加载情况
			this.tabberPageLoadFlag = this.tabbarList.map((item, tabbar_index) => {
				return index === tabbar_index
			})



			this.switchTabbar(index)
		},
		methods: {

			guanbi() {
				this.loginBoxFlag = false;
			},
			// 切换导航
			switchTabbar(index) {

				if (index !== 1) {
					// this.$refs?.circleRef?.stopAllVideo()
				}

				if (index == 2) {

					if (this.currentIndex == 0) {
						uni.$emit('indexhome', true)
					}
					if (this.currentIndex == 1) {
						uni.$emit('indexcircle', true)
					}
					if (this.currentIndex == 3) {
						uni.$emit('indexpreferred', true)
					}
					if (this.currentIndex == 4) {
						uni.$emit('indexmine', true)
					}


					return
				}

				if (index == 4) {
					uni.$emit('loginok', true)					
					}

				this._switchTabbarPage(index)



			},


			// 导航页面滚动到底部
			tabbarPageScrollLower(e) {
				if (this.currentIndex === 4) {
					uni.$emit('mine', true)
				}
				if (this.currentIndex === 0) {
					uni.$emit('home', true)
				}

			},

			// 切换导航页面
			_switchTabbarPage(index) {
				const selectPageFlag = this.tabberPageLoadFlag[index]
				if (selectPageFlag === undefined) {
					return
				}
				if (selectPageFlag === false) {
					this.tabberPageLoadFlag[index] = true
				}
				this.currentIndex = index
			},
			// 关闭压屏窗
			closeLandscape() {
				this.show2 = false
			}




		}
	}
</script>


<style lang="scss" scoped>

</style>
