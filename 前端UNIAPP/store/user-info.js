//  个人中心的数据

import {
	checkAvatarPath
} from '@/tools/tools'

const store = {
	state: {


		userInfoAvatar: '', // 头像地址
		userInfoNickName: '', // 网名
		userInfoLv: 0, // 等级
		userInfoMoney: 0, // 余额
		userInfoCoupon: 0, // 优惠券数量
		userInfoMc: 0, // 商品券
		userInfoIntegral: 0, // 积分
		userInfoMobile: '', // 手机号
		userInfoEncrypt: '', // 加密字符串


		isVip: false, // 是否是vip用户
		vipName: '', // 会员名称   不是会员传的是 普通会员
		vipTes: '', // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
		vipEndTime: '', // 会员过期时间文字  此字段没提示就是空  直接用就行了


		laBaMsg: '', // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
		vipIcon: '', // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
		vipTitle: '', // V的图标后的标题文字 后端字段是 vip_eco
		vipBtnText: '', // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
		vipIconList: [], // 会员权益列表


		orderNumUn: 0, // 我的订单-待支付数量
		orderNumIng: 0, // 我的订单-进行中数量
		orderNumEd: 0, // 我的订单-待评价数量

		bannerList: [], // 个人中心轮播图数据

	},
	mutations: {
		// 没有登录 传页面信息
		setPage(state, arg) {

			let {
				laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
				vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
				vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
				vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
				vipIconList, // 会员权益列表

				bannerList, // 个人中心轮播图数据
			} = arg;
			state.RobFoodmarket = arg


			state.laBaMsg = laBaMsg; // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
			state.vipIcon = vipIcon; // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
			state.vipTitle = vipTitle; // V的图标后的标题文字 后端字段是 vip_eco
			state.vipBtnText = vipBtnText; // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
			state.vipIconList = vipIconList; // 会员权益列表

			state.bannerList = bannerList; // 个人中心轮播图数据


		},
		// 有登陆状态 页面信息+用户信息
		setUserInfoAndPage(state, arg) {
			let {
				userInfoAvatar, // 头像地址
				userInfoNickName, // 网名
				userInfoLv, // 等级
				userInfoMoney, // 余额
				userInfoCoupon, // 优惠券数量
				userInfoMc, // 商品券
				userInfoIntegral, // 积分
				userInfoMobile, // 手机号
				userInfoEncrypt, // 加密字符串


				isVip, // 是否是vip用户
				vipName, // 会员名称   不是会员传的是 普通会员
				vipTes, // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
				vipEndTime, // 会员过期时间文字  此字段没提示就是空  直接用就行了


				laBaMsg, // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
				vipIcon, // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
				vipTitle, // V的图标后的标题文字 后端字段是 vip_eco
				vipBtnText, // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
				vipIconList, // 会员权益列表
				orderNumUn, // 我的订单-待支付数量
				orderNumIng, // 我的订单-进行中数量
				orderNumEd, // 我的订单-待评价数量
				bannerList, // 个人中心轮播图数据

			} = arg;
			state.userInfoAvatar = checkAvatarPath(userInfoAvatar); // 头像地址
			state.userInfoNickName = userInfoNickName; // 网名
			state.userInfoLv = userInfoLv; // 等级
			state.userInfoMoney = userInfoMoney; // 余额
			state.userInfoCoupon = userInfoCoupon; // 优惠券数量
			state.userInfoMc = userInfoMc; // 商品券
			state.userInfoIntegral = userInfoIntegral; // 积分
			state.userInfoMobile = userInfoMobile; // 手机号
			state.userInfoEncrypt = userInfoEncrypt; // 加密字符串
			state.isVip = isVip; // 是否是vip用户
			state.vipName = vipName; // 会员名称   不是会员传的是 普通会员
			state.vipTes = vipTes; // 是否是体验卡 如果此字段是空表示什么都没有 不是空就显示在优享会员后面
			state.vipEndTime = vipEndTime; // 会员过期时间文字  此字段没提示就是空  直接用就行了
			state.laBaMsg = laBaMsg; // 小喇叭 图标后的消息文字   后端字段是 user_vip_card_cue
			state.vipIcon = vipIcon; // 会员图标网络路径（就是那个V的图标）  后端字段是 user_vip_card_icon
			state.vipTitle = vipTitle; // V的图标后的标题文字 后端字段是 vip_eco
			state.vipBtnText = vipBtnText; // V的图标后的标题文字 后的按钮文字 后端字段是 vip_button
			state.vipIconList = vipIconList; // 会员权益列表
			state.orderNumUn = orderNumUn; // 我的订单-待支付数量
			state.orderNumIng = orderNumIng; // 我的订单-进行中数量
			state.orderNumEd = orderNumEd; // 我的订单-待评价数量
			state.bannerList = bannerList; // 个人中心轮播图数据
		}
	},
	actions: {},
	getters: {},
};

export default store;
