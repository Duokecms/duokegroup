import {
	host
} from './siteinfo.js'

// 检测类型
function checkTypeFn(item) {
	return Object.prototype.toString.call(item).slice(8, -1);
}


// 数据转数字
function transNumFn(item) {
	if (item) {
		let type = checkTypeFn(item);
		if (type == 'Number' || type == 'BigInt') {
			return item;
		} else if (type == 'String') {
			return transNumFn(item - 0);
		} else {
			return 1;
		}
	} else {
		return 0;
	}
}

// 断言 必须是对象
function assertObject(item) {
	if (checkTypeFn(item) == 'Object' && Object.keys(item).length > 0) {
		return item;
	}
	return {};
}
// 断言 必须是数组
function assertArray(item) {
	if (checkTypeFn(item) == 'Array' && item.length > 0) {
		return item;
	}
	return [];
}
// 断言 必须是字符串
function assertString(item) {
	if (checkTypeFn(item) == 'String' && item.length > 0) {
		return item;
	}
	return '';
}
// 断言 必须是数字
function assertNumber(item) {
	if (checkTypeFn(item) == 'Number' && item > 0) {
		return item;
	}
	return 0;
}




function bigPlus(a, b) { //a+b
	return Number(new bigJs(a).plus(b).toFixed(9))
}

function bigMinus(a, b) { //a-b
	return Number(new bigJs(a).minus(b).toFixed(9))
}

function bigTimes(a, b) { //a*b
	return Number(new bigJs(a).times(b).toFixed(9))
}

function bigDiv(a, b) { //a/b
	return Number(new bigJs(a).div(b).toFixed(9))
}


/*
	@description 获取保留两位小数的字符串数字
	@return <String> 带小数点的字符串数字
*/
function toDoubleNumFn(item, n = 2) {
	let pow = Math.pow(10, n),
		num = bigTimes(transNumFn(item), pow),
		flag = num < 0 ? '-' : '+',
		abs = Math.abs(num),
		floor = Math.floor(abs) / pow,
		result = `${flag}${floor}` - 0;
	return result.toFixed(n)
}

// 深度克隆一份对象
function cloneFn(item) {
	return JSON.parse(JSON.stringify(item))
}

// 补零
function num2zeroStr(item, n = 2) {
	let str = '';
	for (let i = 0; i < n + 1; i++) {
		str += 0;
	}
	return `${str}${transNumFn(item)}`.slice(-n)
}


// 把对象转查询字符串格式
function Object2QueryString(object) {
	object = assertObject(object)
	let queryStr = '';
	for (let k in object) {
		queryStr += `${k}=${object[k]}&`;
	}
	return queryStr.substring(0, queryStr.length - 1);
}

/* 
	版本字符串转纯数字
	传入必须是字符串 返回数字
*/
function getVersionFn(str) {
	str = `${str}`;
	let version = str.toLocaleUpperCase().replace(/V/ig, '').replace(/\./ig, '')
	let rr = version.split('');
	let nd = rr.findIndex(i => i > 0)
	return `0000${version}`.slice(-(rr.length - nd)) - 0
}


// 防抖
function debounce(fn,wait){
    var timer;
    return function(...arg){
    	timer && clearTimeout(timer);
        timer = setTimeout(()=>{
        	fn(...arg)
        },wait);
    }
}


// ↑↑↑↑↑↑↑↑ 通用工具方法






// 生成小时数据
function createHoursArr(to, off, runLen) {
	let toHoursBefore = transNumFn(to.split(':')[0]);
	let toHoursAfter = transNumFn(to.split(':')[1]);

	let offHoursBefore = transNumFn(off.split(':')[0]);
	let offHoursAfter = transNumFn(off.split(':')[1]);
	let arr = [];
	for (let i = toHoursBefore; i < offHoursBefore; i += runLen) {
		let lastOffHoursBefore = i + runLen >= offHoursBefore ? offHoursBefore : i + runLen;

		let lastOffHoursAfter = i + runLen >= offHoursBefore ? offHoursAfter : toHoursAfter;
		let textStr =
			`${num2zeroStr(i)}:${num2zeroStr(toHoursAfter)}~${num2zeroStr(lastOffHoursBefore)}:${num2zeroStr(
			lastOffHoursAfter
		)}`;
		arr.push({
			textStr,
			toHoursBefore: i,
			offHoursBefore: lastOffHoursBefore
		});
	}
	return arr;
}

// 固定的字符串常量
const toDayStr = '今天';
const tomorrowStr = '明天';


// 小程序获取的字母地址转换 文字描述的地址信息
function en2ch(address) {
	let province = [{
			name: "beijing",
			cities: ["xicheng", "dongcheng", "chongwen", "xuanwu", "chaoyang", "haidian", "fengtai", "shijingshan",
				"mentougou",
				"fangshan", "tongzhou", "shunyi", "daxing", "changping", "pinggu", "huairou", "miyun", "yanqing"
			]
		},
		{
			name: "tianjin",
			cities: ["qingyang", "hedong", "hexi", "nankai", "hebei", "hongqiao", "tanggu", "hangu", "dagang",
				"dongli",
				"xiqing", "beichen", "jinnan", "wuqing", "baodi", "jinghai", "ninghe", "jixian", "kaifaqu"
			]
		},
		{
			name: "hebei",
			cities: ["shijiazhuang", "qinhuangdao", "langfang", "baoding", "handan", "tangshan", "xingtai",
				"hengshui",
				"zhangjiakou", "chengde", "cangzhou", "hengshui"
			]
		},
		{
			name: "shanxi",
			cities: ["taiyuan", "datong", "changzhi", "jinzhong", "yangquan", "shuozhou", "yuncheng", "linfen"]
		},
		{
			name: "namenggu",
			cities: ["huhehaote", "chifeng", "tongliao", "xilinguole", "xingan"]
		},
		{
			name: "liaoning",
			cities: ["dalian", "shenyang", "anshan", "fushun", "yingkou", "jinzhou", "dandong", "chaoyang",
				"liaoyang", "fuxin",
				"tieling", "panjin", "benxi", "huludao"
			]
		},
		{
			name: "jilin",
			cities: ["changchun", "jilin", "siping", "liaoyuan", "tonghua", "yanji", "baicheng", "liaoyuan",
				"songyuan",
				"linjiang", "huichun"
			]
		},
		{
			name: "heilongjiang",
			cities: ["haerbin", "qiqihaer", "daqing", "mudanjiang", "hegang", "jiamusi", "suihua"]
		},
		{
			name: "shanghai",
			cities: ["pudong", "yangpu", "xuhui", "jingan", "luwan", "huangpu", "putuo", "zhabei", "hongkou",
				"changning",
				"baoshan", "minxing", "jiading", "jinshan", "songjiang", "qingpu", "chongming", "fengxian",
				"nanhui"
			]
		},
		{
			name: "jiangsu",
			cities: ["nanjing", "suzhou", "wuxi", "changzhou", "yangzhou", "xuzhou", "nantong", "zhenjiang",
				"taizhou",
				"huaian", "lianyungang", "suqian", "yancheng", "huaiyin", "muyang", "zhangjiagang"
			]
		},
		{
			name: "zhejiang",
			cities: ["hangzhou", "jinhua", "ningbo", "wenzhou", "jiaxing", "shaoxing", "lishui", "huzhou",
				"taizhou",
				"zhoushan", "quzhou"
			]
		},
		{
			name: "anhui",
			cities: ["hefei", "maanshan", "bangbu", "huangshan", "wuhu", "huainan", "tongling", "fuyang",
				"xuancheng", "anqing"
			]
		},
		{
			name: "fujian",
			cities: ["fuzhou", "xiamen", "quanzhou", "zhangzhou", "nanping", "longyan", "putian", "sanming",
				"ningde"
			]
		},
		{
			name: "jiangxi",
			cities: ["nanchang", "jingdezhen", "shangrao", "pingxiang", "jiujiang", "jian", "yichun", "yingtan",
				"xinyu",
				"ganzhou"
			]
		},
		{
			name: "shandong",
			cities: ["qingdao", "jinan", "zibo", "yantai", "taian", "linyi", "rizhao", "dezhou", "weihai",
				"dongying", "heze",
				"jining", "weifang", "zaozhuang", "liaocheng"
			]
		},
		{
			name: "henan",
			cities: ["zhengzhou", "luoyang", "kaifeng", "pingdingshan", "puyang", "anyang", "xuchang", "nanyang",
				"xinyang",
				"zhoukou", "xinxiang", "jiaozuo", "sanmenxia", "shangqiu"
			]
		},
		{
			name: "hubei",
			cities: ["wuhan", "xiangfan", "xiaogan", "shiyan", "jingzhou", "huangshi", "yichang", "huanggang",
				"enshi", "ezhou",
				"jianghan", "suizao", "jingsha", "xianning"
			]
		},
		{
			name: "hunan",
			cities: ["changsha", "xiangtan", "yueyang", "zhuzhou", "huaihua", "yongzhou", "yiyang", "zhangjiajie",
				"changde",
				"hengyang", "xiangxi", "shaoyang", "loudi", "chenzhou"
			]
		},
		{
			name: "guangdong",
			cities: ["guangzhou", "shenzhen", "dongwan", "foshan", "zhuhai", "shantou", "shaoguan", "jiangmen",
				"meizhou",
				"jieyang", "zhongshan", "heyuan", "huizhou", "maoming", "zhanjiang", "yangjiang", "chaozhou",
				"yunfu", "shanwei",
				"chaoyang", "zhaoqing", "shunde", "qingyuan"
			]
		},
		{
			name: "guangxi",
			cities: ["nanning", "guilin", "liuzhou", "wuzhou", "laibin", "guigang", "yulin", "hezhou"]
		},
		{
			name: "hainan",
			cities: ["haikou", "sanya"]
		},
		{
			name: "zhongqing",
			cities: ["yuzhong", "dadukou", "jiangbei", "shapingba", "jiulongpo", "nanan", "beibei", "wansheng",
				"shuangqiao",
				"yubei", "banan", "wanzhou", "fuling", "qianjiang", "changshou"
			]
		},
		{
			name: "sichuan",
			cities: ["chengdou", "dazhou", "nanchong", "leshan", "mianyang", "deyang", "najiang", "suining",
				"yibin", "bazhong",
				"zigong", "kangding", "panzhihua"
			]
		},
		{
			name: "guizhou",
			cities: ["guiyang", "zunyi", "anshun", "qianxinan", "douyun"]
		},
		{
			name: "yunnan",
			cities: ["kunming", "lijiang", "zhaotong", "yuxi", "lincang", "wenshan", "honghe", "chuxiong", "dali"]
		},
		{
			name: "xicang",
			cities: ["lasa", "linzhi", "rikaze", "changdou"]
		},
		{
			name: "shanxi",
			cities: ["xian", "xianyang", "yanan", "hanzhong", "yulin", "shangnan", "lueyang", "yijun", "linyou",
				"baihe"
			]
		},
		{
			name: "gansu",
			cities: ["lanzhou", "jinchang", "tianshui", "wuwei", "zhangye", "pingliang", "jiuquan"]
		},
		{
			name: "qinghai",
			cities: ["huangnan", "hainan", "xining", "haidong", "haixi", "haibei", "guoluo", "yushu"]
		},
		{
			name: "ningxia",
			cities: ["yinchuan", "wuzhong"]
		},
		{
			name: "xinjiang",
			cities: ["wulumuqi", "hami", "kashi", "bayinguoleng", "changji", "yili", "aletai", "kelamayi",
				"boertala"
			]
		},
		{
			name: "xianggang",
			cities: ["zhongxiqu", "wanziqu", "dongqu", "nanqu", "jiulong-youjianwangqu", "jiulong-shenshuibuqu",
				"jiulong-jiulongchengqu", "jiulong-huangdaxianqu", "jiulong-guantangqu", "xinjie-beiqu",
				"xinjie-dapuqu",
				"xinjie-shatianqu", "xinjie-xigongqu", "xinjie-quanwanqu", "xinjie-tunmenqu",
				"xinjie-yuanlangqu",
				"xinjie-kuiqingqu", "xinjie-lidaoqu"
			]
		},
		{
			name: "aomen",
			cities: ["huadimatangqu", "shenganduonitangqu", "datangqu", "wangdetangqu", "fengshuntangqu",
				"jiamotangqu",
				"shengfangjigetangqu", "ludangcheng"
			]
		}
	];

	var province2 = [{
			name: "北京",
			cities: ["西城", "东城", "崇文", "宣武", "朝阳", "海淀", "丰台", "石景山", "门头沟", "房山", "通州", "顺义", "大兴", "昌平", "平谷",
				"怀柔", "密云",
				"延庆"
			]
		},
		{
			name: "天津",
			cities: ["青羊", "河东", "河西", "南开", "河北", "红桥", "塘沽", "汉沽", "大港", "东丽", "西青", "北辰", "津南", "武清", "宝坻", "静海",
				"宁河", "蓟县",
				"开发区"
			]
		},
		{
			name: "河北",
			cities: ["石家庄", "秦皇岛", "廊坊", "保定", "邯郸", "唐山", "邢台", "衡水", "张家口", "承德", "沧州", "衡水"]
		},
		{
			name: "山西",
			cities: ["太原", "大同", "长治", "晋中", "阳泉", "朔州", "运城", "临汾"]
		},
		{
			name: "内蒙古",
			cities: ["呼和浩特", "赤峰", "通辽", "锡林郭勒", "兴安"]
		},
		{
			name: "辽宁",
			cities: ["大连", "沈阳", "鞍山", "抚顺", "营口", "锦州", "丹东", "朝阳", "辽阳", "阜新", "铁岭", "盘锦", "本溪", "葫芦岛"]
		},
		{
			name: "吉林",
			cities: ["长春", "吉林", "四平", "辽源", "通化", "延吉", "白城", "辽源", "松原", "临江", "珲春"]
		},
		{
			name: "黑龙江",
			cities: ["哈尔滨", "齐齐哈尔", "大庆", "牡丹江", "鹤岗", "佳木斯", "绥化"]
		},
		{
			name: "上海",
			cities: ["浦东", "杨浦", "徐汇", "静安", "卢湾", "黄浦", "普陀", "闸北", "虹口", "长宁", "宝山", "闵行", "嘉定", "金山", "松江", "青浦",
				"崇明", "奉贤",
				"南汇"
			]
		},
		{
			name: "江苏",
			cities: ["南京", "苏州", "无锡", "常州", "扬州", "徐州", "南通", "镇江", "泰州", "淮安", "连云港", "宿迁", "盐城", "淮阴", "沐阳",
				"张家港"
			]
		},
		{
			name: "浙江",
			cities: ["杭州", "金华", "宁波", "温州", "嘉兴", "绍兴", "丽水", "湖州", "台州", "舟山", "衢州"]
		},
		{
			name: "安徽",
			cities: ["合肥", "马鞍山", "蚌埠", "黄山", "芜湖", "淮南", "铜陵", "阜阳", "宣城", "安庆"]
		},
		{
			name: "福建",
			cities: ["福州", "厦门", "泉州", "漳州", "南平", "龙岩", "莆田", "三明", "宁德"]
		},
		{
			name: "江西",
			cities: ["南昌", "景德镇", "上饶", "萍乡", "九江", "吉安", "宜春", "鹰潭", "新余", "赣州"]
		},
		{
			name: "山东",
			cities: ["青岛", "济南", "淄博", "烟台", "泰安", "临沂", "日照", "德州", "威海", "东营", "荷泽", "济宁", "潍坊", "枣庄", "聊城"]
		},
		{
			name: "河南",
			cities: ["郑州", "洛阳", "开封", "平顶山", "濮阳", "安阳", "许昌", "南阳", "信阳", "周口", "新乡", "焦作", "三门峡", "商丘"]
		},
		{
			name: "湖北",
			cities: ["武汉", "襄樊", "孝感", "十堰", "荆州", "黄石", "宜昌", "黄冈", "恩施", "鄂州", "江汉", "随枣", "荆沙", "咸宁"]
		},
		{
			name: "湖南",
			cities: ["长沙", "湘潭", "岳阳", "株洲", "怀化", "永州", "益阳", "张家界", "常德", "衡阳", "湘西", "邵阳", "娄底", "郴州"]
		},
		{
			name: "广东",
			cities: ["广州", "深圳", "东莞", "佛山", "珠海", "汕头", "韶关", "江门", "梅州", "揭阳", "中山", "河源", "惠州", "茂名", "湛江", "阳江",
				"潮州", "云浮",
				"汕尾", "潮阳", "肇庆", "顺德", "清远"
			]
		},
		{
			name: "广西",
			cities: ["南宁", "桂林", "柳州", "梧州", "来宾", "贵港", "玉林", "贺州"]
		},
		{
			name: "海南",
			cities: ["海口", "三亚"]
		},
		{
			name: "重庆",
			cities: ["渝中", "大渡口", "江北", "沙坪坝", "九龙坡", "南岸", "北碚", "万盛", "双桥", "渝北", "巴南", "万州", "涪陵", "黔江", "长寿"]
		},
		{
			name: "四川",
			cities: ["成都", "达州", "南充", "乐山", "绵阳", "德阳", "内江", "遂宁", "宜宾", "巴中", "自贡", "康定", "攀枝花"]
		},
		{
			name: "贵州",
			cities: ["贵阳", "遵义", "安顺", "黔西南", "都匀"]
		},
		{
			name: "云南",
			cities: ["昆明", "丽江", "昭通", "玉溪", "临沧", "文山", "红河", "楚雄", "大理"]
		},
		{
			name: "西藏",
			cities: ["拉萨", "林芝", "日喀则", "昌都"]
		},
		{
			name: "陕西",
			cities: ["西安", "咸阳", "延安", "汉中", "榆林", "商南", "略阳", "宜君", "麟游", "白河"]
		},
		{
			name: "甘肃",
			cities: ["兰州", "金昌", "天水", "武威", "张掖", "平凉", "酒泉"]
		},
		{
			name: "青海",
			cities: ["黄南", "海南", "西宁", "海东", "海西", "海北", "果洛", "玉树"]
		},
		{
			name: "宁夏",
			cities: ["银川", "吴忠"]
		},
		{
			name: "新疆",
			cities: ["乌鲁木齐", "哈密", "喀什", "巴音郭楞", "昌吉", "伊犁", "阿勒泰", "克拉玛依", "博尔塔拉"]
		},
		{
			name: "香港",
			cities: ["中西区", "湾仔区", "东区", "南区", "九龙-油尖旺区", "九龙-深水埗区", "九龙-九龙城区", "九龙-黄大仙区", "九龙-观塘区", "新界-北区",
				"新界-大埔区",
				"新界-沙田区", "新界-西贡区", "新界-荃湾区", "新界-屯门区", "新界-元朗区", "新界-葵青区", "新界-离岛区"
			]
		},
		{
			name: "澳门",
			cities: ["花地玛堂区", "圣安多尼堂区", "大堂区", "望德堂区", "风顺堂区", "嘉模堂区", "圣方济各堂区", "路氹城"]
		}
	];

	var getChina = strs => {
		const str = strs.toLowerCase();
		for (var i = 0; i < province.length; i++) {
			if (str == province[i].name) {
				return province2[i].name;
				// break;
			}
			for (var u = 0; u < province[i].cities.length; u++) {
				if (str == province[i].cities[u]) {
					return province2[i].cities[u];
					// break;
				}
			}
		}
		return '未知';
	}
	return getChina(address);
}
// 电话号码正则(手机号正则)
let checkTelReg = /^[0-9]{11}$/;

// 普通路径转换成navigateToFn 函数可以调用的 (在路径前加 / )

function url2navigateToUrlFn(url) {
	return url[0] == '/' ? url : `/${url}`;
}

// 给规格项添加默认选中的 属性
function addSpecFilterItemActAttrFn(specFilterItem) {
	let cloneSpecFilterItem = cloneFn(specFilterItem);
	cloneSpecFilterItem.forEach(item => {
		item.item.forEach((i, k) => {
			if (k == 0) {
				i.active = true;
			} else {
				i.active = false;
			}
		})
	})
	return cloneSpecFilterItem;
}





/*
	@description
		检测头像图片路径是否正常 如果不带域名加上 siteInfo 里的host return 出去
	@param
		avatar <String>
	@return <String>
		返回正常的用户头像地址
*/
function checkAvatarPath(avatar) {
	avatar = assertString(avatar);
	let result = avatar.includes('http://') || avatar.includes('https://')
	if (result) {
		return avatar;
	} else {
		return `${host}${avatar}`;
	}
}

// 网络地址转临时路径
function url2temPath(url) {
	return new Promise((resFn, rejFn) => {
		uni.getImageInfo({
			src: url,
			success(res) {
				resFn({
					result: res.path,
					type: 'success',
					msg: '成功',
					url
				});
			},
			fail() {
				rejFn({
					result: '获取图片信息错误',
					msg: '获取图片信息错误',
					type: 'error',
					url
				});
			}
		});
	});
}



/* 
	传入 js格式(毫秒为单位)的时间戳 换算成 xx天 小于1天 返回 xx小时
*/
function calcOverTime(timeStamp) {
	let day = Math.floor(timeStamp / 86400000);
	if (day > 0) {
		return `${day}天`;
	}
	let hours = Math.floor(timeStamp / 1000 / 60 / 60);
	return `${hours}小时`;
}


// 商品详情 里富文本字符串 图片 百分比显示
function goodsDetailWidthFn(str) {
	if (typeof(str) != 'string') {
		return '';
	}
	
	


	
	str = str.replace(/src="\/uploads/ig,`src="${host}/uploads`);
	
	// 把行间 style="xxx替换  data-style="xxx
	let REGaddDataHead_style = /style="/ig;
	let str0 = str.replace(REGaddDataHead_style, 'data-style="');



	// 把行间 width="100" 替换  data-width="100" 
	let REGaddDataHead = /width="/ig;
	let str2 = str0.replace(REGaddDataHead, 'data-width="');


	// 把style 里的  width: 100px  替换  width: 100%
	let reg = /img src/ig;
	let str3 = str2.replace(reg, 'img style="width:100%;display:block;" src');
	return str3;
}



/* 
	obj.draw_time,
	obj.number_type,
	obj.number,
	计算结束时间
 */
function calcEndTime(obj) {
	let timeStamp;
	if (obj.number_type == 1) { //分钟
		timeStamp = ((obj.draw_time - 0) * 1000) + ((obj.number - 0) * 60) * 1000
	} else if (obj.number_type == 2) { //小时
		timeStamp = ((obj.draw_time - 0) * 1000) + ((obj.number - 0) * 3600) * 1000
	} else if (obj.number_type == 3) { //天数
		timeStamp = ((obj.draw_time - 0) * 1000) + ((obj.number - 0) * 86400) * 1000
	} else if (obj.number_type == 4) { //月数
		timeStamp = ((obj.draw_time - 0) * 1000) + ((obj.number - 0) * 2592000) * 1000
	} else if (obj.number_type == 5) { //年数
		timeStamp = ((obj.draw_time - 0) * 1000) + ((obj.number - 0) * 31536000) * 1000
	} else {
		console.log('参数错误 致命错误')
		return;
	}
	timeStamp = Math.floor(timeStamp / 1000)
	return {
		timeStamp
	}
}


/*
	判断是否过期 返回true / false
	在有效期内 true
	不在有效期内 false

	obj.time_bar
	obj.use_end_time
	obj.use_start_time

	obj.draw_time,
	obj.number_type,
	obj.number,
*/
function checkIsValid(obj) {
	/*
	 	1--领取后算时间  2--平台限制
	*/
	let curtData = Math.floor(+new Date() / 1000)

	// 2--平台限制
	if (obj.time_bar == 2) {

		/*
				结束
				obj.use_end_time
		 		obj.use_start_time
		 		开始

		 */
		if (obj.use_start_time < curtData && obj.use_end_time > curtData) {
			return true;
		} else {
			return false
		}

		// 1--领取后算时间
	} else {

		let res = calcEndTime({
			draw_time: obj.draw_time,
			number_type: obj.number_type,
			number: obj.number,
		})


		if (obj.draw_time < curtData && res.timeStamp > curtData) {
			return true;
		} else {
			return false;
		}
	}
}

// 时间字符串转数组
function timeStr2Arr(str) {
	if (!str) {
		return false;
	}

	function fn2(n) {
		let str = n + '';
		return str.padStart(2, '0');
	}

	let date = new Date(),
		strHours = str.split(':')[0] - 0,
		strMinutes = str.split(':')[1] - 1,
		newHours = date.getHours(),
		newMinutes = date.getMinutes(),
		newT = newHours * 60 + newMinutes,
		endT = strHours * 60 + strMinutes;

	let resHoure = Math.floor((endT - newT) / 60);
	let resMinutes = (endT - newT) % 60;
	let resSeconds = 60 - date.getSeconds();
	let resMilliseconds = 1000 - date.getMilliseconds();

	let resArr;
	if ((endT + 1) - newT > 0) {
		resArr = [fn2(resHoure), fn2(resMinutes), fn2(resSeconds), resMilliseconds]
	} else {
		resArr = [fn2(0), fn2(0), fn2(0), fn2(0)]
	}
	return resArr
}



/* 
	@description
		传时间戳返回时间描述文字
			传
				1609161226410
			返回
				'2020年12月28日21时13分46秒'
		@param
			timeStamp <Number> 时间戳数字 单位是毫秒
		@return
			文字描述的时间字符串
*/
function timeStamp2textFn(timeStamp) {
	let date = new Date(timeStamp)
	return `${date.getFullYear()}年${date.getMonth()+1}月${date.getDate()}日${date.getHours()}时${date.getMinutes()}分${date.getSeconds()}秒`
}


/* 
	@description
		传时间数据库的时间字符串 返回 年月日
			传
				2021-03-04 12:30:00
			返回
				{
					year: 2021,
					month:3,
					day:4,
					hours:12,
					minutes:30,
				}
				'2020年12月28日21时13分46秒'
		@param
			timeStamp <Number> 时间戳数字 单位是毫秒
		@return
			文字描述的时间字符串
*/
function timeStr2timeObj(str) {
	let strs = `${str}`.replace(/\-/g, '/');
	let date = new Date(strs),
		year = date.getFullYear,
		month = num2zeroStr(date.getMonth() + 1),
		day = num2zeroStr(date.getDate()),
		hours = num2zeroStr(date.getHours()),
		minutes = num2zeroStr(date.getMinutes());
	return {
		year,
		month,
		day,
		hours,
		minutes
	}

}

/*
	@description
		获取可以循环的数据结构,传入后台的not_reason字符串
		服务器反的数据格式
			not_reason1: "商品金额差**元可用__61.1",
			not_reason2: "没有符合条件的商品",
			not_reason3: "",
	@param
		str <String>
	@return <Object>

*/
function getNotReasonObj(str) {
	let arrSplit = assertString(str).split('__');
	if (arrSplit.length == 2) {
		let arr = assertString(arrSplit[0]).split('**');
		return [{
				redColor: false,
				text: arr[0],
			},
			{
				redColor: true,
				text: arrSplit[1],
			},
			{
				redColor: false,
				text: arr[1],
			}
		];
	}
	return [{
		redColor: false,
		text: arrSplit[0],
	}];
}




// 时间戳(js毫秒级) 转 时间文字描述 (目前只用在拼团首页 和 拼团详情)
function timeStamp2timeText(s) {
	let resStr = '';
	let tian = Math.floor(s / 86400000)
	if (tian) {
		resStr += `${tian}天`;
	}

	let shi = Math.floor(s / 3600000) % 24;
	if (shi) {
		let s1 = `000${shi}`.slice(-2);
		resStr += `${s1}时`;
	} else {
		if (resStr) {
			resStr += `00时`;
		}
	}
	let fen = Math.floor(s / 60000) % 60;
	if (fen) {
		let s1 = `000${fen}`.slice(-2);
		resStr += `${s1}分`;
	}
	/* let miao =Math.floor(s/1000)%1000 ;
	if(miao){
		let s1 = `000${fen}`.slice(-2);
		resStr +=`${s1}秒`;
	} */
	return resStr;
}


// 


/*
	@description 判断固定格式字符串 (例如 名字 手机号等) 是否符合要求
		校验通过 返回 true
		校验失败 返回 页面提示信息
*/
let validateFn = {
	name(title,str){
		if(str.length > 0 && str.length <= 20){
			return {
				validate:true
			}
		}
		return {
			validate: false,
			msg:`${title}长度是1~20`
		}
	},
	tel(tel){
		if(checkTelReg.test(tel)){
			return {
				validate:true
			}
		}
		return {
			validate: false,
			msg:`请检查手机号格式`
		}
	}
}




export {
	checkTypeFn,
	transNumFn,
	assertObject,
	assertArray,
	assertString,
	assertNumber,
	bigPlus,
	bigMinus,
	bigTimes,
	bigDiv,
	toDoubleNumFn,
	cloneFn,
	num2zeroStr,
	getVersionFn,
	createHoursArr,
	toDayStr,
	tomorrowStr,
	en2ch,
	checkTelReg,
	addSpecFilterItemActAttrFn,
	url2navigateToUrlFn,
	checkAvatarPath,
	url2temPath,
	calcOverTime,
	goodsDetailWidthFn,
	calcEndTime,
	checkIsValid,
	timeStr2Arr,
	timeStamp2textFn,
	timeStr2timeObj,
	getNotReasonObj,
	Object2QueryString,
	timeStamp2timeText,
	debounce,
	validateFn
}








