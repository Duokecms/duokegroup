

import Vue from 'vue'
import Vuex from 'vuex'


import {
	checkTypeFn,
	assertObject,
	cloneFn
} from '@/tools/tools'


// 站点域名
import {
	host,
} from '@/tools/siteinfo.js'
import userInfo from './user-info';

///原始//


let lifeData = {}

// 尝试获取本地是否存在lifeData变量，第一次启动时不存在
try {
  lifeData = uni.getStorageSync('lifeData')
} catch(e) {
  
}

// 标记需要永久存储的变量，在每次启动时取出，在state中的变量名
let saveStateKeys = ['vuex_user']

// 保存变量到本地存储
const saveLifeData = function(key, value) {
  // 判断变量是否在存储数组中
  if (saveStateKeys.indexOf(key) != -1) {
    // 获取本地存储的lifeData对象，将变量添加到对象中
    let tmpLifeData = uni.getStorageSync('lifeData')
    // 第一次启动时不存在，则放一个空对象
    tmpLifeData = tmpLifeData ? tmpLifeData : {},
    tmpLifeData[key] = value
    // 将变量再次放回本地存储中
    uni.setStorageSync('lifeData', tmpLifeData)
  }
}
////




Vue.use(Vuex);
const store = new Vuex.Store({
	modules: {	
		userInfo
	},
	state: {

		appStaticPath: '', // 设置程序里使用的静态图片路径 (永远不换的图片)
		configInfo: {}, // 全局的设置数据
		MenuList: [], // tab-bar 的数据
		isiPhoneX: false, // 是否iphonx 
		homeTemplateIdList: [], // 首页的模板消息id字符串 数组
		homeTemplateIdSettingFlag: true, // 设置过 允许并且 不再提示
		globalMainSwitch: false, // 小程序设置里 允许发送发送模板消息的 设置
		defaultHomeToastModalStatus: true, // 默认首页 弹出 确认 权限的 模态框
		isUserCloneFlag: false, // 是否是 用户 手动关闭的
		token: '', // 全局的token
		refreshCurrentPage: false, // 登录返回后重新刷新页面
		backIconTop: 26, // 详情页返回上一页的左上角图标距离顶部的位置
		// #ifdef H5
		browserIsWx: false, // 当前环境是否是基于公众号微信浏览器 是微信浏览器 true;   不是微信浏览器 false
		// #endif

		// #ifdef APP-PLUS
		appenv: '', // 当前运行环境 安卓 or 苹果
		// #endif
		
		// 如果上面从本地获取的lifeData对象下有对应的属性，就赋值给state中对应的变量
		// 加上vuex_前缀，是防止变量名冲突，也让人一目了然
		vuex_user: lifeData.vuex_user ? lifeData.vuex_user : {name: '图鸟'},
		
		// 如果vuex_version无需保存到本地永久存储，无需lifeData.vuex_version方式
		// app版本
		vuex_version: "1.0.0",
		// 是否使用自定义导航栏
		vuex_custom_nav_bar: true,
		// 状态栏高度
		vuex_status_bar_height: 0,
		// 自定义导航栏的高度
		vuex_custom_bar_height: 0
		
		
	},
	mutations: {
		$tStore(state, payload) {
		      // 判断是否多层调用，state中为对象存在的情况，例如user.info.score = 1
		      let nameArr = payload.name.split('.')
		      let saveKey = ''
		      let len = nameArr.length
		      if (len >= 2) {
		        let obj = state[nameArr[0]]
		        for (let i= 1; i < len - 1; i++) {
		          obj = obj[nameArr[i]]
		        }
		        obj[nameArr[len - 1]] = payload.value
		        saveKey = nameArr[0]
		      } else {
		        // 单层级变量
		        state[payload.name] = payload.value
		        saveKey = payload.name
		      }
		      
		      // 保存变量到本地中
		      saveLifeData(saveKey, state[saveKey])
		    },
			
		// 赋值 给token 值
		setToken(store, tokenStr) {

			store.token = tokenStr;
		},
		// 设置程序里使用的静态图片路径 (永远不换的图片)
		setAppStaticPath(store) {
			store.appStaticPath = `${host}/wx-image`;
		},


		// 赋值 全局的设置数据
		setConfigInfo(store, configInfo) {

			store.configInfo = configInfo
		},

		// 赋值 tab-bar 的数据
		setMenuList(store, arg) {
			store.MenuList = arg;
		},

		// 赋值 是否iphonx 
		setIsiPhoneX(store, bool) {
			store.isiPhoneX = bool;
		},

		// 设置发送优惠券模板id 数组
		setHomeTemplateIdList(store, list) {
			store.homeTemplateIdList = list;
		},
		// 设置首页模板消息id 是否被永久 允许了
		setHomeTemplateIdSettingFlag(store, bool) {
			store.homeTemplateIdSettingFlag = bool;
		},
		// 赋值 小程序设置里 允许发送发送模板消息的 设置
		setGlobalMainSwitch(store, bool) {
			store.globalMainSwitch = bool;
		},
		// 赋值 首页弹框状态
		setDefaultHomeToastModalStatus(store, bool) {
			store.defaultHomeToastModalStatus = bool;
		},

		// 赋值 是否是用户手动关闭的状态
		setIsUserCloneFlag(store, bool) {
			store.isUserCloneFlag = bool;
		},

		// 赋值当前页面是否需要刷新
		setRefreshCurrentPage(store, bool) {
			store.refreshCurrentPage = bool;
		},
		// 赋值 详情页返回上一页的左上角图标距离顶部的距离
		setBackIconTop(store, height) {
			store.backIconTop = height
		},
		// #ifdef H5
		// 赋值 当前环境是否是基于公众号微信浏览器
		setBrowserIsWx(store, flag) {
			store.browserIsWx = flag
		},
		// #endif
		// 赋值 平台的购买记录数据
		setBuyHistoryList(store, list) {
			store.buyHistoryList = list
		},

		// #ifdef APP-PLUS
		// 赋值 给当前运行环境 安卓 or 苹果
		setAppenv(store, envStr) {
			store.appenv = envStr
		},
		// #endif
		
		
	},
	actions: {

	},
	getters: {
		
		

		/* 
			返回是否 审核状态
			true 在审核
			false 不审核
		*/
		miniProgrameCheck(state) {
			return state.configInfo.mini_program_check == 1;
		},
		/*
			@description 是否开启了会员功能
			@return <Boolean>
				true 表示开启了vip功能
				false 表示关闭了vip功能
		 */
		isOpenVipFunc(state) {
			return state.configInfo.user_vip_card == 1 ? true : false
		},

		/* 
			
			@description 是否打开 全栈搜索功能
			@return <Boolean>
				true 表示开启了全栈搜索功能
				false 表示关闭了全栈搜索功能
		*/
		isOpenHomeSearchFunc(state) {
			return assertObject(state.configInfo).search_is_show == 1 ? true : false
		}


	}
})

export default store;
