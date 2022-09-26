/*
Navicat MySQL Data Transfer

Source Server         : 123123
Source Server Version : 50651
Source Host           : localhost:3306
Source Database       : install_xcx

Target Server Type    : MYSQL
Target Server Version : 50651
File Encoding         : 65001

Date: 2022-08-30 22:11:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xn_address`
-- ----------------------------
DROP TABLE IF EXISTS `xn_address`;
CREATE TABLE `xn_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `name` varchar(32) DEFAULT '',
  `area` varchar(64) DEFAULT '',
  `address` varchar(125) DEFAULT '',
  `mobile` varchar(16) DEFAULT '',
  `default` enum('Y','N') DEFAULT 'N',
  `create_time` int(10) DEFAULT NULL,
  `coordinate` varchar(255) DEFAULT '',
  `housenumber` varchar(50) DEFAULT '',
  `sex` varchar(20) DEFAULT '',
  `status` varchar(20) DEFAULT '',
  `tag` varchar(10) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8295 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_address
-- ----------------------------
INSERT INTO `xn_address` VALUES ('8293', '100000125', '娄先生', '西宁市', '青海省西宁市城北区朝阳东路 朝阳新村(北区)', '13776319138', 'N', null, '101.76916435938266,36.65689284500416', '28', '女', '', '1');
INSERT INTO `xn_address` VALUES ('8294', '100000126', '刘贵民', '大兴安岭地区', '黑龙江省大兴安岭地区漠河市环城北街 古莲市场', '15170100017', 'N', null, '122.35008,52.95402', '棚户区3号楼302', '男', '', '1');

-- ----------------------------
-- Table structure for `xn_address_tag`
-- ----------------------------
DROP TABLE IF EXISTS `xn_address_tag`;
CREATE TABLE `xn_address_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1474 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_address_tag
-- ----------------------------
INSERT INTO `xn_address_tag` VALUES ('1', '家');
INSERT INTO `xn_address_tag` VALUES ('2', '公司');
INSERT INTO `xn_address_tag` VALUES ('3', '学校');
INSERT INTO `xn_address_tag` VALUES ('4', '父母家');
INSERT INTO `xn_address_tag` VALUES ('5', '其他');

-- ----------------------------
-- Table structure for `xn_adinfo`
-- ----------------------------
DROP TABLE IF EXISTS `xn_adinfo`;
CREATE TABLE `xn_adinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `url` varchar(255) DEFAULT '',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `type` tinyint(1) DEFAULT '1' COMMENT '类别:1首页幻灯',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_adinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_admin`
-- ----------------------------
DROP TABLE IF EXISTS `xn_admin`;
CREATE TABLE `xn_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；mb_password加密',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `email_code` varchar(60) DEFAULT NULL COMMENT '激活码',
  `phone` bigint(11) unsigned DEFAULT NULL COMMENT '手机号',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `register_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `remark` varchar(100) DEFAULT NULL,
  `hot` int(10) DEFAULT '10' COMMENT '默认的火爆数字',
  `xcx_title` varchar(50) DEFAULT '' COMMENT '小程序名称',
  `xcx_appid` varchar(50) DEFAULT '' COMMENT '小程序appid',
  `xcx_secret` varchar(50) DEFAULT '' COMMENT '小程序secret',
  `xcx_original_id` varchar(50) DEFAULT '' COMMENT '小程序原始ID',
  `pay_shanghu` varchar(50) DEFAULT '' COMMENT '支付商户号',
  `pay_scret` varchar(50) DEFAULT '' COMMENT '支付密钥',
  `wxhao` varchar(100) DEFAULT '' COMMENT '支付密钥',
  `wximg` varchar(100) DEFAULT '' COMMENT '支付密钥',
  `tuikuan` text COMMENT '支付密钥',
  `pay_cert` text COMMENT '支付密钥',
  `pay_key` text COMMENT '支付密钥',
  `qiandao_jifen` int(10) DEFAULT '0',
  `tixian_jine` int(10) DEFAULT '0',
  `tixian_shouxu` decimal(10,2) DEFAULT '0.00',
  `gonggao` varchar(225) DEFAULT '' COMMENT '支付密钥',
  `introduct` varchar(255) DEFAULT '' COMMENT '简介',
  `view_once` int(10) DEFAULT '0' COMMENT '浏览一次送积分',
  `view_once_max` int(10) DEFAULT '0' COMMENT '每天上限积分',
  `invite_score` int(10) DEFAULT '0' COMMENT '邀请会员得积分',
  `tuijian_score` int(10) DEFAULT '0' COMMENT '推荐一位送积分',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_admin
-- ----------------------------
INSERT INTO `xn_admin` VALUES ('20', '123456', '24026eee8538c996f677ee775d316013', '', '', null, '13550515067', '1', '0', '', '0', null, '10', '', '', '', '', '', '', '123123', 'http://7niudukeyouxuan.51duoke.cn/20211215/f0a21ed6b5b6662bd55f2750d676e41f.png', '', null, null, '0', '0', '0.00', '', '', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `xn_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `xn_admin_log`;
CREATE TABLE `xn_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `url` varchar(512) DEFAULT '',
  `remark` varchar(512) DEFAULT NULL,
  `ip` char(15) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `method` varchar(10) DEFAULT NULL,
  `param` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1885 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_admin_log
-- ----------------------------
INSERT INTO `xn_admin_log` VALUES ('278', '1', 'http://myadmin.com/admin/AdminLog/clear.html', '清除日志', '127.0.0.1', '1639047904', 'GET', '[]');
INSERT INTO `xn_admin_log` VALUES ('1884', '1', 'https://mc.xcx.51duoke.cn/admin/login/index.html', '后台登录', '36.100.218.50', '1661646735', 'POST', '{\"username\":\"admin\",\"password\":\"123456\",\"vercode\":\"\"}');

-- ----------------------------
-- Table structure for `xn_apply_cate`
-- ----------------------------
DROP TABLE IF EXISTS `xn_apply_cate`;
CREATE TABLE `xn_apply_cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `image` varchar(200) DEFAULT '',
  `status` tinyint(1) DEFAULT '1',
  `sort` int(10) DEFAULT '0',
  `url` varchar(200) DEFAULT '',
  `lei` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_apply_cate
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_apply_chong`
-- ----------------------------
DROP TABLE IF EXISTS `xn_apply_chong`;
CREATE TABLE `xn_apply_chong` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sort` int(10) DEFAULT '0',
  `money` decimal(10,2) DEFAULT '0.00',
  `song` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_apply_chong
-- ----------------------------
INSERT INTO `xn_apply_chong` VALUES ('35', '6', '2000.00', '230.00');
INSERT INTO `xn_apply_chong` VALUES ('37', '2', '500.00', '80.00');
INSERT INTO `xn_apply_chong` VALUES ('34', '5', '1000.00', '100.00');
INSERT INTO `xn_apply_chong` VALUES ('36', '1', '300.00', '35.00');
INSERT INTO `xn_apply_chong` VALUES ('38', '3', '100.00', '10.00');
INSERT INTO `xn_apply_chong` VALUES ('39', '4', '200.00', '25.00');

-- ----------------------------
-- Table structure for `xn_apply_peisong`
-- ----------------------------
DROP TABLE IF EXISTS `xn_apply_peisong`;
CREATE TABLE `xn_apply_peisong` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_time` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `end_time` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`start_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_apply_peisong
-- ----------------------------
INSERT INTO `xn_apply_peisong` VALUES ('32', '08:00', '09:00');
INSERT INTO `xn_apply_peisong` VALUES ('33', '13:00', '14:00');
INSERT INTO `xn_apply_peisong` VALUES ('34', '07:00', '08:00');
INSERT INTO `xn_apply_peisong` VALUES ('35', '09:00', '10:00');
INSERT INTO `xn_apply_peisong` VALUES ('36', '10:00', '11:00');
INSERT INTO `xn_apply_peisong` VALUES ('37', '11:00', '12:00');
INSERT INTO `xn_apply_peisong` VALUES ('38', '12:00', '13:00');
INSERT INTO `xn_apply_peisong` VALUES ('39', '14:00', '15:00');
INSERT INTO `xn_apply_peisong` VALUES ('40', '15:00', '16:00');
INSERT INTO `xn_apply_peisong` VALUES ('41', '16:00', '17:00');
INSERT INTO `xn_apply_peisong` VALUES ('42', '17:00', '18:00');
INSERT INTO `xn_apply_peisong` VALUES ('43', '18:00', '19:00');
INSERT INTO `xn_apply_peisong` VALUES ('44', '19:00', '20:00');

-- ----------------------------
-- Table structure for `xn_area`
-- ----------------------------
DROP TABLE IF EXISTS `xn_area`;
CREATE TABLE `xn_area` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_area
-- ----------------------------
INSERT INTO `xn_area` VALUES ('25', '东坡区', '/uploads/file/20211210/f6f61c642983feea788530cc803b0378.png', '2', '1', '0', '1');
INSERT INTO `xn_area` VALUES ('26', '岷东新区', '', '2', '1', '0', '1');
INSERT INTO `xn_area` VALUES ('27', '闽东新区', '', '2', '1', '0', '1');
INSERT INTO `xn_area` VALUES ('31', '时令尝鲜', '', '5', '1', '0', '0');
INSERT INTO `xn_area` VALUES ('32', '隐私政策', '', '1', '1', '1651045864', '1');
INSERT INTO `xn_area` VALUES ('33', '234', '', '4', '1', '1651045876', '1');

-- ----------------------------
-- Table structure for `xn_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `xn_auth_group`;
CREATE TABLE `xn_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text COMMENT '规则id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of xn_auth_group
-- ----------------------------
INSERT INTO `xn_auth_group` VALUES ('1', '超级管理员', '1', '14,14,15,15,1,2,3,4,5,6,7,8,9,10,11,12,13,21,16,17,22,18,19,20,20');
INSERT INTO `xn_auth_group` VALUES ('2', '一般管理员', '1', '14,14,15,15,16,17,18,18,19,20,20');
INSERT INTO `xn_auth_group` VALUES ('7', '运营商', '1', '14,14,20,20,24,25,26,27,28,29,30,31,51,54,52,53,55,56,65,66,67,68,32,32,33,34,35,36,36,37,37,57,57,58,59,60,61,61,62,63,64,69,69,70,71,72');

-- ----------------------------
-- Table structure for `xn_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `xn_auth_group_access`;
CREATE TABLE `xn_auth_group_access` (
  `admin_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`admin_id`,`group_id`),
  KEY `uid` (`admin_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of xn_auth_group_access
-- ----------------------------
INSERT INTO `xn_auth_group_access` VALUES ('1', '1');
INSERT INTO `xn_auth_group_access` VALUES ('20', '7');

-- ----------------------------
-- Table structure for `xn_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `xn_auth_rule`;
CREATE TABLE `xn_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT '0' COMMENT '父级id',
  `name` char(80) DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `is_menu` tinyint(1) unsigned DEFAULT '0' COMMENT '菜单显示',
  `condition` char(100) DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `type` tinyint(1) DEFAULT '1',
  `sort` int(5) DEFAULT '999',
  `icon` varchar(40) DEFAULT '',
  `color` varchar(20) DEFAULT '' COMMENT '颜色e',
  `title_sub` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of xn_auth_rule
-- ----------------------------
INSERT INTO `xn_auth_rule` VALUES ('1', '15', 'admin/auth/index', '菜单管理', '1', '1', '', '1', '50', 'layui-icon-auz', '', '');
INSERT INTO `xn_auth_rule` VALUES ('2', '0', 'admin/auth/index', '菜单管理', '1', '0', '', '1', '2', 'layui-icon-shrink-right', '', '');
INSERT INTO `xn_auth_rule` VALUES ('3', '2', 'admin/auth/add', '添加', '1', '0', '', '1', '2', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('4', '2', 'admin/auth/edit', '编辑', '1', '0', '', '1', '3', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('5', '2', 'admin/auth/delete', '删除', '1', '0', '', '1', '4', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('6', '15', 'admin/AuthGroup/index', '用户组管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('7', '6', 'admin/AuthGroup/add', '添加', '1', '0', '', '1', '999', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('8', '6', 'admin/AuthGroup/edit', '编辑', '1', '0', '', '1', '999', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('9', '6', 'admin/AuthGroup/delete', '删除', '1', '0', '', '1', '39', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('10', '15', 'admin/admin/index', '管理员管理', '1', '1', '', '1', '3', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('11', '10', 'admin/admin/add', '添加', '1', '0', '', '1', '999', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('12', '10', 'admin/admin/edit', '编辑', '1', '0', '', '1', '999', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('13', '10', 'admin/admin/delete', '删除', '1', '0', '', '1', '999', null, '', '');
INSERT INTO `xn_auth_rule` VALUES ('14', '0', 'admin/index/home', '管理首页', '1', '1', '', '1', '1', 'layui-icon-home', '', '');
INSERT INTO `xn_auth_rule` VALUES ('15', '0', 'admin/config/base', '系统管理', '1', '1', '', '1', '2', 'layui-icon-set', '', '');
INSERT INTO `xn_auth_rule` VALUES ('16', '21', 'admin/config/base', '基本设置', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('17', '21', 'admin/config/upload', '上传配置', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('18', '0', 'admin/upload_files/index', '上传管理', '1', '1', '', '1', '5', 'layui-icon-picture', '', '');
INSERT INTO `xn_auth_rule` VALUES ('19', '18', 'admin/upload_files/delete', '删除文件', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('20', '0', '', '站点设置', '1', '1', '', '1', '6', 'layui-icon-face-surprised', '', '');
INSERT INTO `xn_auth_rule` VALUES ('21', '0', 'admin/config/index', '配置管理', '1', '1', '', '1', '3', 'layui-icon-set', '', '');
INSERT INTO `xn_auth_rule` VALUES ('22', '21', 'admin/AdminLog/index', '日志管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('24', '20', 'admin/category/index', '分类管理', '1', '1', '', '1', '2', 'layui-icon-note', '', '');
INSERT INTO `xn_auth_rule` VALUES ('25', '24', 'admin/category/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('26', '24', 'admin/category/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('27', '24', 'admin/category/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('32', '0', 'admin/menu/index', '菜谱管理', '1', '1', '', '1', '10', 'layui-icon-app', '', '');
INSERT INTO `xn_auth_rule` VALUES ('90', '89', 'admin/mini/news', '滚动新闻', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('89', '20', 'admin/mini/setting', '首页管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('36', '0', 'admin/goods/index', '产品管理', '1', '1', '', '1', '11', 'layui-icon-cart', '', '');
INSERT INTO `xn_auth_rule` VALUES ('37', '0', 'admin/order/index', '订单管理', '1', '1', '', '1', '12', 'layui-icon-tabs', '', '');
INSERT INTO `xn_auth_rule` VALUES ('55', '20', 'admin/test/index', '演示demo', '1', '0', '', '1', '999', 'layui-icon-template-1', '', '');
INSERT INTO `xn_auth_rule` VALUES ('56', '20', 'admin/admin/info', '基本设置', '1', '0', '', '1', '1', 'layui-icon-template-1', '', '');
INSERT INTO `xn_auth_rule` VALUES ('57', '0', 'admin/user/index', '会员管理', '1', '1', '', '1', '7', 'layui-icon-username', '', '');
INSERT INTO `xn_auth_rule` VALUES ('58', '57', 'admin/user/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('59', '57', 'admin/user/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('60', '57', 'admin/user/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('94', '92', 'admin/apply/category', '菜单管理', '1', '0', '', '1', '999', 'layui-icon-menu-fill', '#6a4e16', '首页菜单管理');
INSERT INTO `xn_auth_rule` VALUES ('61', '92', 'admin/Coupon/index', '优惠券', '1', '0', '', '1', '7', 'layui-icon-flag', '', '');
INSERT INTO `xn_auth_rule` VALUES ('65', '89', 'admin/adinfo/index', '广告管理', '1', '1', '', '1', '5', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('66', '65', 'admin/adinfo/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('67', '65', 'admin/adinfo/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('68', '65', 'admin/adinfo/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('69', '89', 'admin/active/index', '首页活动', '1', '1', '', '1', '6', 'layui-icon-dollar', '', '');
INSERT INTO `xn_auth_rule` VALUES ('73', '57', 'admin/user/index', '会员列表', '1', '1', '', '1', '777', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('78', '37', 'admin/order/index', '配送订单', '1', '1', '', '1', '1', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('79', '37', 'admin/order/tuikuan', '退款订单', '1', '1', '', '1', '4', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('93', '92', 'admin/apply/chong', '充值管理', '1', '0', '', '1', '999', 'layui-icon-face-surprised', '#c41313', '充值活动');
INSERT INTO `xn_auth_rule` VALUES ('92', '0', 'admin/apply/index', '应用', '1', '1', '', '1', '999', 'layui-icon-windows', '', '');
INSERT INTO `xn_auth_rule` VALUES ('81', '0', 'admin/fenxiao/index', '分销中心', '1', '1', '', '1', '6', 'layui-icon-flag', '', '');
INSERT INTO `xn_auth_rule` VALUES ('82', '81', 'admin/fenxiao/tuiguang', '推广明细', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('83', '81', 'admin/fenxiao/tixian', '佣金提现', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('84', '32', 'admin/menu/category', '菜谱分类', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('85', '32', 'admin/menu/index', '菜谱列表', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('86', '37', 'admin/order/yuyue', '预约查询', '1', '1', '', '1', '2', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('87', '81', 'admin/user/fenxiao', '分销员管理', '1', '1', '', '1', '888', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('88', '89', 'admin/tags/index', '营销标签', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('91', '89', 'admin/mini/tags', '首页标签', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('95', '92', 'admin/apply/peisong', '配送时间', '1', '0', '', '1', '999', 'layui-icon-username', '#f80606', '');
INSERT INTO `xn_auth_rule` VALUES ('96', '20', 'admin/pages/index', '单页管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('97', '0', 'admin/peisong/index', '骑手管理', '1', '1', '', '1', '999', 'layui-icon-username', '', '');
INSERT INTO `xn_auth_rule` VALUES ('98', '97', 'admin/peisong/index', '骑手列表', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('99', '97', 'admin/peisong/tixian', '佣金提现', '1', '1', '', '1', '999', '', '', '');

-- ----------------------------
-- Table structure for `xn_auth_rule_biz`
-- ----------------------------
DROP TABLE IF EXISTS `xn_auth_rule_biz`;
CREATE TABLE `xn_auth_rule_biz` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT '0' COMMENT '父级id',
  `name` char(80) DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `is_menu` tinyint(1) unsigned DEFAULT '0' COMMENT '菜单显示',
  `condition` char(100) DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `type` tinyint(1) DEFAULT '1',
  `sort` int(5) DEFAULT '999',
  `icon` varchar(40) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of xn_auth_rule_biz
-- ----------------------------
INSERT INTO `xn_auth_rule_biz` VALUES ('1', '15', 'admin/auth/index', '权限控制', '1', '1', '', '1', '50', 'layui-icon-auz');
INSERT INTO `xn_auth_rule_biz` VALUES ('2', '0', 'admin/auth/index', '菜单管理', '1', '1', '', '1', '1', 'layui-icon-shrink-right');
INSERT INTO `xn_auth_rule_biz` VALUES ('3', '2', 'admin/auth/add', '添加', '1', '0', '', '1', '2', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('4', '2', 'admin/auth/edit', '编辑', '1', '0', '', '1', '3', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('5', '2', 'admin/auth/delete', '删除', '1', '0', '', '1', '4', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('6', '1', 'admin/AuthGroup/index', '用户组管理', '1', '1', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('7', '6', 'admin/AuthGroup/add', '添加', '1', '0', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('8', '6', 'admin/AuthGroup/edit', '编辑', '1', '0', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('9', '6', 'admin/AuthGroup/delete', '删除', '1', '0', '', '1', '39', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('10', '1', 'admin/admin/index', '运营商管理', '1', '1', '', '1', '3', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('11', '10', 'admin/admin/add', '添加', '1', '0', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('12', '10', 'admin/admin/edit', '编辑', '1', '0', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('13', '10', 'admin/admin/delete', '删除', '1', '0', '', '1', '999', null);
INSERT INTO `xn_auth_rule_biz` VALUES ('14', '0', 'admin/index/home', '管理首页', '1', '1', '', '1', '4', 'layui-icon-home');
INSERT INTO `xn_auth_rule_biz` VALUES ('15', '0', 'admin/config/base', '系统管理', '1', '1', '', '1', '2', 'layui-icon-set');
INSERT INTO `xn_auth_rule_biz` VALUES ('16', '21', 'admin/config/base', '基本设置', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('17', '21', 'admin/config/upload', '上传配置', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('18', '0', 'admin/upload_files/index', '上传管理', '1', '1', '', '1', '5', 'layui-icon-picture');
INSERT INTO `xn_auth_rule_biz` VALUES ('19', '18', 'admin/upload_files/delete', '删除文件', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('20', '0', '', '站点设置', '1', '1', '', '1', '6', 'layui-icon-face-surprised');
INSERT INTO `xn_auth_rule_biz` VALUES ('21', '0', 'admin/config/index', '配置管理', '1', '1', '', '1', '3', 'layui-icon-set');
INSERT INTO `xn_auth_rule_biz` VALUES ('22', '21', 'admin/AdminLog/index', '日志管理', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('24', '20', 'admin/category/index', '分类管理', '1', '1', '', '1', '2', 'layui-icon-note');
INSERT INTO `xn_auth_rule_biz` VALUES ('25', '24', 'admin/category/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('26', '24', 'admin/category/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('27', '24', 'admin/category/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('32', '0', 'admin/partner/index', '商户管理', '1', '1', '', '1', '10', 'layui-icon-app');
INSERT INTO `xn_auth_rule_biz` VALUES ('33', '32', 'admin/partner/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('34', '32', 'admin/partner/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('35', '32', 'admin/partner/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('36', '0', 'admin/goods/index', '产品管理', '1', '1', '', '1', '11', 'layui-icon-cart');
INSERT INTO `xn_auth_rule_biz` VALUES ('37', '0', 'admin/order/index', '订单管理', '1', '1', '', '1', '12', 'layui-icon-tabs');
INSERT INTO `xn_auth_rule_biz` VALUES ('55', '20', 'admin/test/index', '演示demo', '1', '1', '', '1', '999', 'layui-icon-template-1');
INSERT INTO `xn_auth_rule_biz` VALUES ('56', '20', 'admin/admin/info', '基本设置', '1', '1', '', '1', '1', 'layui-icon-template-1');
INSERT INTO `xn_auth_rule_biz` VALUES ('57', '0', 'admin/user/index', '会员管理', '1', '1', '', '1', '7', 'layui-icon-username');
INSERT INTO `xn_auth_rule_biz` VALUES ('58', '57', 'admin/user/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('59', '57', 'admin/user/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('60', '57', 'admin/user/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('80', '0', 'admin/market/index', '营销中心', '1', '0', '', '1', '6', 'layui-icon-note');
INSERT INTO `xn_auth_rule_biz` VALUES ('61', '80', 'admin/Person/index', '分销管理', '1', '1', '', '1', '7', 'layui-icon-flag');
INSERT INTO `xn_auth_rule_biz` VALUES ('65', '20', 'admin/adinfo/index', '广告管理', '1', '1', '', '1', '5', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('66', '65', 'admin/adinfo/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('67', '65', 'admin/adinfo/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('68', '65', 'admin/adinfo/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('69', '80', 'admin/coupon/index', '红包管理', '1', '1', '', '1', '6', 'layui-icon-dollar');
INSERT INTO `xn_auth_rule_biz` VALUES ('70', '69', 'admin/coupon/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('71', '69', 'admin/coupon/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('72', '69', 'admin/coupon/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('73', '57', 'admin/user/index', '会员列表', '1', '1', '', '1', '777', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('78', '37', 'admin/order/index', '物流订单', '1', '1', '', '1', '1', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('79', '37', 'admin/order/tuikuan', '退款订单', '1', '1', '', '1', '4', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('62', '61', 'admin/Person/add', '添加', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('63', '61', 'admin/Person/edit', '编辑', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('64', '61', 'admin/Person/delete', '删除', '1', '0', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('81', '0', 'admin/fenxiao/index', '分销中心', '1', '1', '', '1', '6', 'layui-icon-flag');
INSERT INTO `xn_auth_rule_biz` VALUES ('82', '81', 'admin/fenxiao/tuiguang', '推广明细', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('83', '81', 'admin/fenxiao/tixian', '佣金提现', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('84', '32', 'admin/partner/index', '商户列表', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('85', '32', 'admin/partner/tixian', '商户提现', '1', '1', '', '1', '999', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('86', '37', 'admin/order/ziti', '自提订单', '1', '1', '', '1', '2', '');
INSERT INTO `xn_auth_rule_biz` VALUES ('87', '81', 'admin/user/fenxiao', '分销员管理', '1', '1', '', '1', '888', '');

-- ----------------------------
-- Table structure for `xn_cart`
-- ----------------------------
DROP TABLE IF EXISTS `xn_cart`;
CREATE TABLE `xn_cart` (
  `cart_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `cart_num` int(10) DEFAULT '1' COMMENT '数量',
  `spec_id` int(10) DEFAULT '0' COMMENT '规格id',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '是否选中',
  PRIMARY KEY (`cart_id`),
  KEY `user_login_key` (`goods_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=294 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_cart
-- ----------------------------
INSERT INTO `xn_cart` VALUES ('254', '117', '100000112', '1', '0', '1');

-- ----------------------------
-- Table structure for `xn_category`
-- ----------------------------
DROP TABLE IF EXISTS `xn_category`;
CREATE TABLE `xn_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '1' COMMENT '管理员ID',
  `fid` int(10) DEFAULT '0' COMMENT '父级ID',
  `banner` varchar(255) DEFAULT '' COMMENT '幻灯',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1496 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_category
-- ----------------------------
INSERT INTO `xn_category` VALUES ('1293', '时令水果', '/uploads/1/file/20220418/c99dfeef7ce26523d386840abd4d7809.png', '13', '0', '1641282534', '1', '0', '/uploads/1/file/20220422/c0a2beb273649f4250db0a7e5147d345.jpg,/uploads/1/file/20220422/e0a958952719a560285dcc4693e2835e.png');
INSERT INTO `xn_category` VALUES ('1312', '时令鲜蔬', '/uploads/1/file/20220412/9a767750b0f1c4e94a922f68a4823836.png', '1', '1', '1641282534', '1', '1293', '');
INSERT INTO `xn_category` VALUES ('1314', '蔬菜', '/uploads/1/file/20220619/432ffeed6bc172f9bd0597bedb7b4090.jpg', '188', '1', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1294', '速食熟食', '/uploads/1/file/20220418/3796307b0166d13d922438e76ec58472.png', '11', '0', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1295', '干货调味', '/uploads/1/file/20220418/ff0506cb9ed5dc062edbd35ea036cd54.png', '23', '1', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1462', '日常用品', '/uploads/1/file/20220413/bd13be0fff4aded820ea76eec0d9139f.png', '3', '0', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1309', '冲调饮品', '/uploads/1/file/20220418/6b7d17263c0d0f61510d022c50f56924.png', '4', '0', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1310', '米面粮油', '/uploads/1/file/20220418/c9ecf627e4a7caba327d37bed70d43d3.png', '28', '1', '1641282534', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1491', '火锅食材', '', '1', '1', '0', '1', '1474', '');
INSERT INTO `xn_category` VALUES ('1463', '葡萄', '', '666', '1', '0', '1', '1293', '');
INSERT INTO `xn_category` VALUES ('1492', '速冻系列', '', '2', '1', '0', '1', '1474', '');
INSERT INTO `xn_category` VALUES ('1468', '水产海鲜', '/uploads/1/file/20220501/ff1702f0622649e0bb772a82fdf7454c.jpg', '175', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1467', '水果', '/uploads/1/file/20220501/27b5a73df411ede75ac9de586162a781.png', '19', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1475', '茄果类', '/uploads/1/file/20220502/ed3fbd1b5ddd52d0f372c8d20e485a84.png', '123', '1', '0', '1', '1314', '');
INSERT INTO `xn_category` VALUES ('1469', '菌菇', '/uploads/1/file/20220501/4a82741fa9ab6a3b7f47e7a50b787745.jpg', '180', '1', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1470', '禽蛋肉', '/uploads/1/file/20220501/099379b2c9ed45e5ffcf1caecec48c0a.jpg', '186', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1471', '根茎类蔬菜', '/uploads/1/file/20220501/59b76b846f7fe3a6da81c273551c6bc6.jpg', '187', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1472', '豆制品', '/uploads/1/file/20220501/49a70e68d7fab862da3e977dc8c1c8fb.jpg', '172', '1', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1473', '日用百货', '/uploads/1/file/20220501/b1d98c59f45b5b6e43e52e3072acbdd9.jpg', '20', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1474', '速冻火锅食材', '/uploads/1/file/20220501/b1a3f60703087367d57a7ea6f9129626.jpg', '1', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1476', '叶菜', '/uploads/1/file/20220502/7a0eecec2085a4fc298bec2376dfbaaf.png', '2', '1', '0', '1', '1314', '');
INSERT INTO `xn_category` VALUES ('1477', '热卖', '/uploads/1/file/20220502/37bb8facdb120c8fd1d222aebff32100.png', '3', '1', '0', '1', '1314', '');
INSERT INTO `xn_category` VALUES ('1478', '冷冻海鲜', '/uploads/1/file/20220502/43fc22d92761864a54c3372a0719335e.png', '1', '1', '0', '1', '1468', '');
INSERT INTO `xn_category` VALUES ('1479', '鲜活河鲜', '/uploads/1/file/20220502/f02c6ce2f82c0b2c4e0b3c32ad576e85.png', '2', '1', '0', '1', '1468', '');
INSERT INTO `xn_category` VALUES ('1480', '进口精品海鲜', '/uploads/1/file/20220502/03e897d92bc99bbd92d42dbf97700684.png', '3', '0', '0', '1', '0', '');
INSERT INTO `xn_category` VALUES ('1481', '热卖水产', '/uploads/1/file/20220502/23c186ae7ab3e9ed79e4191d23a526c8.png', '4', '1', '0', '1', '1468', '');
INSERT INTO `xn_category` VALUES ('1482', '禽蛋', '/uploads/1/file/20220502/3571ac60fa93ae7457aba75a011f8578.png', '1', '1', '0', '1', '1470', '');
INSERT INTO `xn_category` VALUES ('1483', '禽类', '/uploads/1/file/20220502/863a05e703caa274003a0eb9b7d16999.png', '2', '1', '0', '1', '1470', '');
INSERT INTO `xn_category` VALUES ('1484', '冰鲜猪肉', '/uploads/1/file/20220502/5ab154fcf1a352b98598f4cb1bfd9947.png', '2', '1', '0', '1', '1470', '');
INSERT INTO `xn_category` VALUES ('1485', '牛羊肉', '/uploads/1/file/20220502/d220bc2ca60e4d2721b3826d2dd03d97.png', '4', '1', '0', '1', '1470', '');
INSERT INTO `xn_category` VALUES ('1486', '特价热卖', '/uploads/1/file/20220502/c4e8e45e337b732e1a159da8a2f11b55.png', '5', '1', '0', '1', '1470', '');
INSERT INTO `xn_category` VALUES ('1487', '纸制品', '', '1', '1', '0', '1', '1462', '');
INSERT INTO `xn_category` VALUES ('1488', '卫生用品', '', '2', '1', '0', '1', '1462', '');
INSERT INTO `xn_category` VALUES ('1489', '一次性纸杯', '', '3', '1', '0', '1', '1462', '');
INSERT INTO `xn_category` VALUES ('1490', '洗涤用品', '', '88', '1', '0', '1', '1462', '');
INSERT INTO `xn_category` VALUES ('1493', '根茎类', '', '9', '1', '0', '1', '1314', '');
INSERT INTO `xn_category` VALUES ('1494', '姜蒜类', '', '8', '1', '0', '1', '1314', '');
INSERT INTO `xn_category` VALUES ('1495', '辣椒类', '', '10', '1', '0', '1', '1314', '');

-- ----------------------------
-- Table structure for `xn_category_menu`
-- ----------------------------
DROP TABLE IF EXISTS `xn_category_menu`;
CREATE TABLE `xn_category_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '1' COMMENT '管理员ID',
  `fid` int(10) DEFAULT '0' COMMENT '父级ID',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1474 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_category_menu
-- ----------------------------
INSERT INTO `xn_category_menu` VALUES ('1293', '热门分类', '', '10', '1', '1641282534', '1', '0');
INSERT INTO `xn_category_menu` VALUES ('1312', '韩式', '/uploads/1/file/20220418/f2c3017300692375d535c0e7f0314889.jpg', '1', '1', '1641282534', '1', '1293');
INSERT INTO `xn_category_menu` VALUES ('1314', '美食达人', '', '9', '1', '1641282534', '1', '0');
INSERT INTO `xn_category_menu` VALUES ('1294', '菜系', '', '8', '1', '1641282534', '1', '0');
INSERT INTO `xn_category_menu` VALUES ('1295', '一日三餐', '', '7', '1', '1641282534', '1', '0');
INSERT INTO `xn_category_menu` VALUES ('1462', '功效', '', '6', '1', '1641282534', '1', '0');
INSERT INTO `xn_category_menu` VALUES ('1464', '养生', '/uploads/1/file/20220418/f351f820c8edbd6c627cfc6755717201.jpg', '5', '1', '0', '1', '1293');
INSERT INTO `xn_category_menu` VALUES ('1463', '家常菜', '/uploads/1/file/20220418/71905b64c76bde2f1b606b7741ed353e.jpg', '666', '1', '0', '1', '1293');
INSERT INTO `xn_category_menu` VALUES ('1465', '烘焙', '/uploads/1/file/20220418/97d7677f79e6eb675024c590fb5f9017.jpg', '66', '1', '0', '1', '1314');
INSERT INTO `xn_category_menu` VALUES ('1466', '韩系', '/uploads/1/file/20220418/6e269bfb0fe211d0529641932a2ac3aa.jpg', '12', '1', '0', '1', '1294');
INSERT INTO `xn_category_menu` VALUES ('1467', '泰式', '/uploads/1/file/20220418/517761b8a08eca3c9a5c8a9241af8a53.jpg', '3', '1', '0', '1', '1294');
INSERT INTO `xn_category_menu` VALUES ('1468', '西餐', '/uploads/1/file/20220418/f0822ffeb20f145cadab4b59d64e586f.jpg', '2', '1', '0', '1', '1294');
INSERT INTO `xn_category_menu` VALUES ('1469', '早餐', '/uploads/1/file/20220418/8f0b2acd633afd40cb39d07b7b2d56d0.jpg', '4', '1', '0', '1', '1295');
INSERT INTO `xn_category_menu` VALUES ('1470', '午餐', '/uploads/1/file/20220418/52a7edc234607785cdf977417f6dd2ca.jpg', '5', '1', '0', '1', '1295');
INSERT INTO `xn_category_menu` VALUES ('1471', '美白', '/uploads/1/file/20220418/b2374eae7a69bc6e99a3380d0579c336.png', '5', '1', '0', '1', '1462');
INSERT INTO `xn_category_menu` VALUES ('1472', '开胃', '/uploads/1/file/20220418/f0e0a070d242a193d4e9e476129a8d2b.jpg', '6', '1', '0', '1', '1462');
INSERT INTO `xn_category_menu` VALUES ('1473', '滋补', '/uploads/1/file/20220418/41c3b031334a3f9239966608d849d420.jpg', '8', '1', '0', '1', '1462');

-- ----------------------------
-- Table structure for `xn_collect`
-- ----------------------------
DROP TABLE IF EXISTS `xn_collect`;
CREATE TABLE `xn_collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`goods_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_collect
-- ----------------------------
INSERT INTO `xn_collect` VALUES ('45', '10036', '2121923', '1642609670');
INSERT INTO `xn_collect` VALUES ('46', '11383', '2121923', '1642959425');
INSERT INTO `xn_collect` VALUES ('47', '11441', '2121923', '1644977283');

-- ----------------------------
-- Table structure for `xn_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `xn_coupon`;
CREATE TABLE `xn_coupon` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券',
  `title` varchar(50) DEFAULT '' COMMENT '优惠券标题',
  `type` tinyint(2) unsigned DEFAULT '0' COMMENT '0普通抵用券，1满减券，2免单券',
  `score` decimal(11,2) DEFAULT '0.00',
  `money` decimal(11,2) DEFAULT '0.00' COMMENT '金额',
  `meet_price` int(11) DEFAULT '0' COMMENT '满xx可用,0不限制',
  `is_use` tinyint(1) DEFAULT '0' COMMENT '0未用,1已用',
  `status` tinyint(1) DEFAULT '1' COMMENT '1可用,2 冻结',
  `begin_time` int(14) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(14) DEFAULT '0' COMMENT '结束时间',
  `create_time` int(14) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(14) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of xn_coupon
-- ----------------------------
INSERT INTO `xn_coupon` VALUES ('71', '新人优惠券', '0', '0.00', '5.00', '50', '0', '1', '1650988800', '1714147200', '1651049953', '0');
INSERT INTO `xn_coupon` VALUES ('72', '新人优惠券2', '0', '0.00', '8.00', '80', '0', '1', '1650988800', '1682524800', '1651049975', '0');
INSERT INTO `xn_coupon` VALUES ('73', '新人优惠券', '0', '0.00', '10.00', '200', '0', '1', '1650988800', '1714147200', '1651050101', '0');
INSERT INTO `xn_coupon` VALUES ('74', '积分红包', '0', '200.00', '50.00', '100', '0', '1', '1651852800', '1653926400', '1651917639', '0');

-- ----------------------------
-- Table structure for `xn_coupon_list`
-- ----------------------------
DROP TABLE IF EXISTS `xn_coupon_list`;
CREATE TABLE `xn_coupon_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券',
  `coupon_name` varchar(50) DEFAULT '' COMMENT '优惠券标题',
  `type` tinyint(2) unsigned DEFAULT '0' COMMENT '0普通抵用券，1满减券，2免单券',
  `coupon_id` int(10) DEFAULT '0' COMMENT '优惠券ID',
  `coupon_user_id` int(11) DEFAULT '0' COMMENT '用户',
  `money` decimal(11,2) DEFAULT '0.00' COMMENT '金额',
  `meet_price` int(11) DEFAULT '0' COMMENT '满xx可用,0不限制',
  `order_id` int(11) unsigned DEFAULT '0' COMMENT '使用订单号',
  `is_use` tinyint(1) DEFAULT '0' COMMENT '0未用,1已用',
  `begin_time` int(14) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(14) DEFAULT '0' COMMENT '结束时间',
  `create_time` int(14) DEFAULT '0' COMMENT '创建时间',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '使用订单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of xn_coupon_list
-- ----------------------------
INSERT INTO `xn_coupon_list` VALUES ('69', '新人福利', '0', '69', '1', '50.00', '100', '0', '0', '1650556800', '1651248000', '1650979234', '1');
INSERT INTO `xn_coupon_list` VALUES ('72', '新人优惠券', '0', '71', '1', '5.00', '50', '0', '0', '1650988800', '1714147200', '1651050123', '1');

-- ----------------------------
-- Table structure for `xn_fenxiao_order`
-- ----------------------------
DROP TABLE IF EXISTS `xn_fenxiao_order`;
CREATE TABLE `xn_fenxiao_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utoken` varchar(50) NOT NULL DEFAULT '' COMMENT '用户 id',
  `order_no` varchar(50) DEFAULT '' COMMENT '订单号',
  `real_price` decimal(10,2) DEFAULT '0.00' COMMENT '订单金额',
  `rake_back_percentage` decimal(10,2) DEFAULT '0.00' COMMENT '佣金比例',
  `rake_back_price` decimal(10,2) DEFAULT '0.00' COMMENT '分销佣金',
  `status` tinyint(1) DEFAULT '0' COMMENT '0未结算 1 已结算',
  `phone` varchar(15) DEFAULT '' COMMENT '分销 手机',
  `rake_back_integral` decimal(10,2) DEFAULT '0.00' COMMENT '分销佣金积分',
  `remark` varchar(100) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of xn_fenxiao_order
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_fenxiao_user_tixian`
-- ----------------------------
DROP TABLE IF EXISTS `xn_fenxiao_user_tixian`;
CREATE TABLE `xn_fenxiao_user_tixian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL DEFAULT '' COMMENT '用户 id',
  `create_time` datetime DEFAULT NULL,
  `is_check` tinyint(1) DEFAULT '0' COMMENT '0:未处理 1：已处理 ， 2已驳回',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  `phone` varchar(15) DEFAULT '' COMMENT '电话',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员id',
  `update_time` datetime DEFAULT NULL COMMENT '处理',
  `type` tinyint(1) DEFAULT '1' COMMENT '1余额 2微信',
  `bank` varchar(15) DEFAULT '' COMMENT '账号',
  `pay_money` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7115 DEFAULT CHARSET=utf8 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of xn_fenxiao_user_tixian
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_goods`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods`;
CREATE TABLE `xn_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `status` tinyint(1) DEFAULT '1' COMMENT '1通过 .2 审核',
  `detail` text COMMENT '商户详情',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `delete_time` int(10) DEFAULT '0' COMMENT '是否删除',
  `limit_num` int(10) DEFAULT '0' COMMENT '限购',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `admin_id` int(10) DEFAULT '0',
  `goods_name` varchar(225) DEFAULT '' COMMENT '商品名称',
  `begin_time` int(10) DEFAULT '0' COMMENT '开始日期',
  `end_time` int(10) DEFAULT '0' COMMENT '结束日期',
  `video_url` varchar(255) DEFAULT '',
  `images` text COMMENT '多图',
  `old_price` decimal(10,2) DEFAULT '0.00' COMMENT '原价',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '售价',
  `vip_price` decimal(10,2) DEFAULT '0.00' COMMENT '会员价',
  `kucun` int(10) DEFAULT '0' COMMENT '库存',
  `is_zhuan` tinyint(1) DEFAULT '0' COMMENT '是否可转增',
  `yongjin` decimal(10,2) DEFAULT '0.00' COMMENT '佣金',
  `partner_id` int(10) DEFAULT '0' COMMENT '商户ID',
  `area_ids` varchar(255) DEFAULT '',
  `cate_id` int(10) DEFAULT '0' COMMENT '分类ID',
  `tags_ids` varchar(50) DEFAULT '',
  `buy_konw` text COMMENT '购买须知',
  `content` longtext COMMENT '详情',
  `buy_no` int(10) DEFAULT '0' COMMENT '销量',
  `share_no` int(10) DEFAULT '0' COMMENT '分享人数',
  `duotaocan` tinyint(1) DEFAULT '0' COMMENT '是否多套餐:0否 1是',
  `yongjin_money` double(10,2) DEFAULT '0.00' COMMENT '佣金',
  `daren_money` double(10,2) DEFAULT '0.00' COMMENT '达人分享佣金',
  `goods_remark` varchar(225) DEFAULT '' COMMENT '商品名称',
  `unit` varchar(50) DEFAULT '份' COMMENT '单位',
  `cate_id2` int(10) DEFAULT '0' COMMENT '分类ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=268 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods
-- ----------------------------
INSERT INTO `xn_goods` VALUES ('265', '0', '1', null, '1657877727', '0', '0', '0', '0', '1', '青杭椒', '0', '0', '', '/uploads/1/file/20220715/9d1b1a315e92b7eeba8bb6656dcf8c5c.jpg,/uploads/1/file/20220715/d953d3f38ad765ea10304152c9414a66.jpg,/uploads/1/file/20220715/5981395404945ae8613f6aae91556cac.jpg', '9.00', '8.50', '8.50', '1000', '0', '0.00', '0', ',,', '1314', ',25,', null, '', '0', '0', '1', '0.00', '1.00', '自营', '份500g', '1495');
INSERT INTO `xn_goods` VALUES ('266', '0', '1', null, '1657878105', '1657882941', '0', '0', '0', '1', '海北花雪莲花菜籽油20L', '0', '0', '', '/uploads/1/file/20220715/24f1c8f72d7cdb2d70392a922eecd772.jpg', '252.00', '240.00', '240.00', '1000', '0', '0.00', '0', ',,', '1310', ',25,', null, '', '0', '0', '0', '0.00', '1.00', '自营', '桶', '0');
INSERT INTO `xn_goods` VALUES ('267', '0', '1', null, '1657878173', '1657882869', '0', '0', '0', '1', '田禄菜籽油20L', '0', '0', '', '/uploads/1/file/20220715/3efd12c21bcff22148471b8db1633387.jpg,/uploads/1/file/20220715/11352f394d9f78a07e6bcab542967d82.jpg', '252.00', '245.00', '245.00', '100', '0', '0.00', '0', ',,', '1310', ',25,', null, '', '0', '0', '0', '0.00', '1.00', '自营', '桶', '0');

-- ----------------------------
-- Table structure for `xn_goods_logo_image`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_logo_image`;
CREATE TABLE `xn_goods_logo_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `status` tinyint(1) DEFAULT '1' COMMENT '1通过 .2 审核',
  `type` tinyint(1) DEFAULT '0' COMMENT '商品类型：0实物 ，1电子券',
  `product_uuid` varchar(50) DEFAULT '' COMMENT '产品uuid',
  `wuliu_type` tinyint(1) DEFAULT '2' COMMENT '物流方式：0快递，1自提，2所有',
  `logo` varchar(255) DEFAULT '' COMMENT '主图',
  `detail` text COMMENT '商户详情',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `delete_time` int(10) DEFAULT '0' COMMENT '是否删除',
  `limit_num` int(10) DEFAULT '0' COMMENT '限购',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `admin_id` int(10) DEFAULT '1',
  `title` varchar(225) DEFAULT '' COMMENT '商品名称',
  `video_url` varchar(255) DEFAULT '',
  `images` text COMMENT '多图',
  `old_price` decimal(10,2) DEFAULT '0.00' COMMENT '原价',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '售价',
  `vip_price` decimal(10,2) DEFAULT '0.00' COMMENT '会员价',
  `kucun` int(10) DEFAULT '0' COMMENT '库存',
  `partner_id` int(10) DEFAULT '0' COMMENT '商户ID',
  `area_ids` varchar(255) DEFAULT '',
  `cate_ids` varchar(255) DEFAULT '' COMMENT '分类ID',
  `tags_ids` varchar(50) DEFAULT '',
  `buy_konw` text COMMENT '购买须知',
  `content` longtext COMMENT '详情',
  `buy_no` int(10) DEFAULT '0' COMMENT '销量',
  `share_no` int(10) DEFAULT '0' COMMENT '分享人数',
  `duotaocan` tinyint(1) DEFAULT '0' COMMENT '是否多套餐:0否 1是',
  `jiesuanjia` decimal(10,2) DEFAULT '0.00',
  `duoguige` tinyint(1) DEFAULT '0' COMMENT '多规格 0否 1是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11442 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods_logo_image
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_goods_often`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_often`;
CREATE TABLE `xn_goods_often` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `cate_id` int(10) DEFAULT '0',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`team_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_goods_often
-- ----------------------------
INSERT INTO `xn_goods_often` VALUES ('62', '87', '1312', '1', '1650439169');
INSERT INTO `xn_goods_often` VALUES ('66', '86', '1463', '1', '1651042574');
INSERT INTO `xn_goods_often` VALUES ('67', '236', '0', '100000101', '1657454045');
INSERT INTO `xn_goods_often` VALUES ('68', '118', '1476', '100000101', '1657852633');

-- ----------------------------
-- Table structure for `xn_goods_old_data`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_old_data`;
CREATE TABLE `xn_goods_old_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `status` tinyint(1) DEFAULT '1' COMMENT '1通过 .2 审核',
  `type` tinyint(1) DEFAULT '0' COMMENT '商品类型：0实物 ，1电子券',
  `product_uuid` varchar(50) DEFAULT '' COMMENT '产品uuid',
  `wuliu_type` tinyint(1) DEFAULT '2' COMMENT '物流方式：0快递，1自提，2所有',
  `logo` varchar(255) DEFAULT '' COMMENT '主图',
  `detail` text COMMENT '商户详情',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `delete_time` int(10) DEFAULT '0' COMMENT '是否删除',
  `limit_num` int(10) DEFAULT '0' COMMENT '限购',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `admin_id` int(10) DEFAULT '1',
  `title` varchar(225) DEFAULT '' COMMENT '商品名称',
  `video_url` varchar(255) DEFAULT '',
  `images` text COMMENT '多图',
  `old_price` decimal(10,2) DEFAULT '0.00' COMMENT '原价',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '售价',
  `vip_price` decimal(10,2) DEFAULT '0.00' COMMENT '会员价',
  `kucun` int(10) DEFAULT '0' COMMENT '库存',
  `partner_id` int(10) DEFAULT '0' COMMENT '商户ID',
  `area_ids` varchar(255) DEFAULT '',
  `cate_ids` varchar(255) DEFAULT '' COMMENT '分类ID',
  `tags_ids` varchar(50) DEFAULT '',
  `buy_konw` text COMMENT '购买须知',
  `content` longtext COMMENT '详情',
  `buy_no` int(10) DEFAULT '0' COMMENT '销量',
  `share_no` int(10) DEFAULT '0' COMMENT '分享人数',
  `duotaocan` tinyint(1) DEFAULT '0' COMMENT '是否多套餐:0否 1是',
  `jiesuanjia` decimal(10,2) DEFAULT '0.00',
  `duoguige` tinyint(1) DEFAULT '0' COMMENT '多规格 0否 1是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11442 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods_old_data
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_goods_spec_base`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_spec_base`;
CREATE TABLE `xn_goods_spec_base` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售价格',
  `inventory` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
  `weight` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '重量（kg） ',
  `coding` char(80) NOT NULL DEFAULT '' COMMENT '编码',
  `barcode` char(80) NOT NULL DEFAULT '' COMMENT '条形码',
  `original_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原价',
  `extends` longtext COMMENT '扩展数据(json格式存储)',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1625 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods_spec_base
-- ----------------------------
INSERT INTO `xn_goods_spec_base` VALUES ('1616', '12', '200.00', '0', '3.00', '12', '13', '673.00', '{\"plugins_wholesale_newbuy_rules_5\":\"s|190\",\"plugins_wholesale_newbuy_rules_10\":\"s|160\",\"plugins_wholesale_newbuy_rules_20\":\"s|130\",\"plugins_wholesale_newbuy_rules_50\":\"s|100\",\"plugins_wholesale_newbuy_rules_100\":\"r|0.5\",\"plugins_wholesale_repurchase_rules_10_3000\":\"130\",\"plugins_wholesale_repurchase_rules_20_6000\":\"s|120\",\"plugins_wholesale_repurchase_rules_50_10000\":\"r|0.5\",\"plugins_wholesale_repurchase_rules_100_20000\":\"r|0.3\"}', '1640920178');
INSERT INTO `xn_goods_spec_base` VALUES ('1613', '12', '0.01', '0', '1.00', '12', '13', '1.00', '{\"plugins_distribution_rules_1\":\"\",\"plugins_distribution_down_rules_1\":\"\",\"plugins_distribution_self_buy_rules_1\":\"\",\"plugins_distribution_force_current_user_rules_1\":\"\"}', '1640920178');
INSERT INTO `xn_goods_spec_base` VALUES ('1614', '12', '5.00', '0', '2.00', '12', '13', '10.00', null, '1640920178');
INSERT INTO `xn_goods_spec_base` VALUES ('1615', '12', '10.00', '0', '3.00', '12', '13', '30.00', '{\"plugins_wholesale_newbuy_rules_5\":\"9\",\"plugins_wholesale_newbuy_rules_10\":\"\",\"plugins_wholesale_newbuy_rules_20\":\"8\",\"plugins_wholesale_newbuy_rules_50\":\"7.8\",\"plugins_wholesale_newbuy_rules_100\":\"r|0.35\",\"plugins_wholesale_repurchase_rules_10_3000\":\"9\",\"plugins_wholesale_repurchase_rules_20_6000\":\"8\",\"plugins_wholesale_repurchase_rules_50_10000\":\"7\",\"plugins_wholesale_repurchase_rules_100_20000\":\"r|0.2\"}', '1640920178');
INSERT INTO `xn_goods_spec_base` VALUES ('1617', '12', '300.00', '0', '500.00', '123', '321', '888.00', null, '1640920178');
INSERT INTO `xn_goods_spec_base` VALUES ('1623', '91', '2.00', '0', '3.00', '4', '5', '5.00', null, '1640920757');
INSERT INTO `xn_goods_spec_base` VALUES ('1622', '91', '1.00', '0', '2.00', '3', '3', '3.00', null, '1640920757');
INSERT INTO `xn_goods_spec_base` VALUES ('1624', '11441', '2.00', '0', '3.00', '3', '3', '3.00', null, '1641284893');

-- ----------------------------
-- Table structure for `xn_goods_spec_type`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_spec_type`;
CREATE TABLE `xn_goods_spec_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `value` text NOT NULL COMMENT '类型值（json字符串存储）',
  `name` char(230) NOT NULL DEFAULT '' COMMENT '类型名称',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=559 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods_spec_type
-- ----------------------------
INSERT INTO `xn_goods_spec_type` VALUES ('553', '12', '[{\"name\":\"粉色1\",\"images\":\"\"},{\"name\":\"白色\",\"images\":\"\"},{\"name\":\"白色2\",\"images\":\"\"},{\"name\":\"绿色\",\"images\":\"\"}]', '颜色', '1640920178');
INSERT INTO `xn_goods_spec_type` VALUES ('554', '12', '[{\"name\":\"S+S1\",\"images\":\"\"},{\"name\":\"M+M1\",\"images\":\"\"},{\"name\":\"S+S\",\"images\":\"\"},{\"name\":\"M+M\",\"images\":\"\"},{\"name\":\"M+S\",\"images\":\"\"}]', '尺码', '1640920178');
INSERT INTO `xn_goods_spec_type` VALUES ('558', '91', '[{\"name\":\"尺码2\",\"images\":\"\"},{\"name\":\"尺码3\",\"images\":\"\"}]', '尺码', '1640920757');

-- ----------------------------
-- Table structure for `xn_goods_spec_value`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_spec_value`;
CREATE TABLE `xn_goods_spec_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_spec_base_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品规格基础id',
  `value` char(230) NOT NULL DEFAULT '' COMMENT '规格值',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3173 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods_spec_value
-- ----------------------------
INSERT INTO `xn_goods_spec_value` VALUES ('3163', '12', '1616', 'M+M', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3162', '12', '1616', '白色2', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3161', '12', '1615', 'S+S', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3160', '12', '1615', '白色', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3159', '12', '1614', 'M+M1', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3158', '12', '1614', '粉色1', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3157', '12', '1613', 'S+S1', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3156', '12', '1613', '粉色1', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3164', '12', '1617', '绿色', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3165', '12', '1617', 'M+S', '1640920178');
INSERT INTO `xn_goods_spec_value` VALUES ('3172', '91', '1623', '尺码3', '1640920757');
INSERT INTO `xn_goods_spec_value` VALUES ('3171', '91', '1622', '尺码2', '1640920757');

-- ----------------------------
-- Table structure for `xn_goods_taocan`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_taocan`;
CREATE TABLE `xn_goods_taocan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `title` varchar(50) DEFAULT '' COMMENT '套餐名',
  `old_price` decimal(10,2) DEFAULT '0.00' COMMENT '原价',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '售价',
  `vip_price` decimal(10,2) DEFAULT '0.00' COMMENT '会员价',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `kucun` int(10) DEFAULT '0' COMMENT '库存',
  `limit_num` int(10) DEFAULT '0' COMMENT '限制购买',
  `yongjin_money` decimal(10,2) DEFAULT '0.00' COMMENT '佣金',
  `daren_money` decimal(10,2) DEFAULT '0.00' COMMENT '达人佣金',
  `unit` varchar(50) DEFAULT '份' COMMENT '单位',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`goods_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_goods_taocan
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_menu`
-- ----------------------------
DROP TABLE IF EXISTS `xn_menu`;
CREATE TABLE `xn_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `images` varchar(255) DEFAULT '' COMMENT '排序',
  `zhizuo_time` varchar(50) DEFAULT '' COMMENT '制作时长',
  `nandu` varchar(50) DEFAULT '初级' COMMENT '难度 初级 中级 高级 大神',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_id` int(10) DEFAULT '1',
  `zan` int(10) DEFAULT '0' COMMENT '点赞数',
  `collect` int(10) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `detail` text,
  `keywords` varchar(50) DEFAULT '' COMMENT '关键字',
  `cate_id` int(10) DEFAULT '0' COMMENT '类别ID',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_menu
-- ----------------------------
INSERT INTO `xn_menu` VALUES ('28', '鱼片粥', '/uploads/1/file/20220418/a5cf3096fb2b558b63225214f78732ed.jpg', '10', '初级', '1', '1666666666', '1', '10', '1', '<h2 class=\"title_s1\" style=\"margin: 20px 0px 0px; padding: 20px 0px; border: 0px; outline: 0px; font-size: 24px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; height: 32px; color: rgb(34, 34, 34); line-height: 32px;\">鱼片粥的做法</h2><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">1</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848609276923.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">准备好材料</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">2</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848609453596.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">大米加水洗净</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">3</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848609770068.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">将米放入电压力锅</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">4</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848610013693.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">熬成粥</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">5</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848610286281.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">鱼片加入适量食盐、料酒、淀粉、花椒粉，腌制十分钟（实际用不了这么多鱼片哦）</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">6</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848610402158.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">粥中加入生姜碎</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">7</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848610700416.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">放入适量鱼片</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">8</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848610967572.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">小火煮至鱼片熟透</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">9</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848611206421.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">加入适量香葱碎</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">10</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848611594212.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">加入适量食盐，搅拌均匀即可</p><p><span style=\"margin: 17px 0px 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 20px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 22px; display: block;\">步骤</span><span style=\"margin: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-weight: 600; text-align: right; line-height: 14px; display: block;\">step</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 20px 0px 0px; border: 0px; outline: 0px; font-size: 36px; vertical-align: baseline; background: transparent; text-align: right; font-weight: 600; line-height: 70px;\">11</p><p><img src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848611656123.jpg\" title=\"鱼片粥的步骤\" alt=\"鱼片粥的步骤\" class=\"stepimg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 2px 0px 20px; border: 0px; outline: 0px; font-size: 18px; vertical-align: baseline; background: transparent; color: rgb(34, 34, 34); line-height: 28px; font-weight: 600;\">一年之计在于春，狠粮精米是关键</p><h2 class=\"title_s1\" style=\"margin: 20px 0px 0px; padding: 20px 0px; border: 0px; outline: 0px; font-size: 24px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; height: 32px; color: rgb(34, 34, 34); line-height: 32px;\">鱼片粥的成品图</h2><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848612761233.jpg\"/></p><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848611990508.jpg\"/></p><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848612168746.jpg\"/></p><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848612376093.jpg\"/></p><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848612563255.jpg\"/></p><p><img title=\"鱼片粥成品图\" alt=\"鱼片粥成品图\" src=\"https://st-cn.meishij.net/rs/92/193/9360842/n9360842_158848612761233.jpg\"/></p><p><br/></p>', '鱼,甜椒', '1468');

-- ----------------------------
-- Table structure for `xn_menu_collect`
-- ----------------------------
DROP TABLE IF EXISTS `xn_menu_collect`;
CREATE TABLE `xn_menu_collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`team_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_menu_collect
-- ----------------------------
INSERT INTO `xn_menu_collect` VALUES ('62', '28', '1', '1650439169');

-- ----------------------------
-- Table structure for `xn_menu_like`
-- ----------------------------
DROP TABLE IF EXISTS `xn_menu_like`;
CREATE TABLE `xn_menu_like` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`team_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='区域';

-- ----------------------------
-- Records of xn_menu_like
-- ----------------------------
INSERT INTO `xn_menu_like` VALUES ('63', '28', '1', '1651182208');
INSERT INTO `xn_menu_like` VALUES ('65', '28', '100000127', '1658827988');

-- ----------------------------
-- Table structure for `xn_mini_active`
-- ----------------------------
DROP TABLE IF EXISTS `xn_mini_active`;
CREATE TABLE `xn_mini_active` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `brief` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `text_color` varchar(20) DEFAULT '',
  `is_background` tinyint(1) DEFAULT '1' COMMENT '主题颜色     背景颜色     背景图标',
  `background_color` varchar(20) DEFAULT '',
  `background_icon` varchar(128) DEFAULT '',
  `is_more_btn` tinyint(1) DEFAULT '1',
  `goods_ids` varchar(255) DEFAULT '',
  `is_show` tinyint(1) DEFAULT '1',
  `image_bc` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1465 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_mini_active
-- ----------------------------
INSERT INTO `xn_mini_active` VALUES ('1464', '热销排行榜', '1', '0', '限量尝鲜 抢完为止', '/uploads/1/file/20220415/e41a01ec8d225e634e65aad24e0279e1.png', '#1d4b6d', '2', '#00070d', '', '1', ',86,87,', '1', '');

-- ----------------------------
-- Table structure for `xn_mini_news`
-- ----------------------------
DROP TABLE IF EXISTS `xn_mini_news`;
CREATE TABLE `xn_mini_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`content`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1464 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_mini_news
-- ----------------------------
INSERT INTO `xn_mini_news` VALUES ('1293', '新店营业，欢迎选购！', '1', '1641282534');

-- ----------------------------
-- Table structure for `xn_mini_tags`
-- ----------------------------
DROP TABLE IF EXISTS `xn_mini_tags`;
CREATE TABLE `xn_mini_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`content`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1464 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_mini_tags
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_order`
-- ----------------------------
DROP TABLE IF EXISTS `xn_order`;
CREATE TABLE `xn_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) DEFAULT '' COMMENT '分类名称',
  `partner_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `utoken` varchar(50) DEFAULT '' COMMENT '用户ID md5',
  `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '总金额',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品金额',
  `ps_price` decimal(10,2) DEFAULT '0.00' COMMENT '配送fei',
  `coupon_id` int(10) DEFAULT '0',
  `coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '优惠价格',
  `pay_price` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `state` tinyint(1) DEFAULT '1' COMMENT '订单状态:1待付款 2待接单 3配送中 4已完成 5已评价 6已退款 7退款中',
  `create_time` int(10) DEFAULT '0',
  `province` varchar(50) DEFAULT '' COMMENT '省市',
  `city` varchar(50) DEFAULT '' COMMENT '城市',
  `county` varchar(50) DEFAULT '' COMMENT '区县',
  `address` varchar(200) DEFAULT '' COMMENT '详细地址',
  `name` varchar(50) DEFAULT '' COMMENT '收货姓名',
  `mobile` varchar(20) DEFAULT '' COMMENT '收货电话',
  `remarks` varchar(200) DEFAULT '' COMMENT '备注',
  `mall_remarks` varchar(200) DEFAULT '' COMMENT '后台备注',
  `order_type` tinyint(1) DEFAULT '0',
  `is_ziti` tinyint(1) DEFAULT '0' COMMENT '是否自提:0 物流，1自提',
  `payment_type` tinyint(1) DEFAULT '1' COMMENT '支付方式：1微信',
  `second` text COMMENT '商品信息',
  `pingjia_time` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_qs_star` int(1) DEFAULT '1' COMMENT '打分',
  `pingjia_star` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_content` text COMMENT '套餐id',
  `pingjia_images` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `pingjia_biaoqian` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `yunfei` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `pay_no` varchar(50) DEFAULT '' COMMENT '微信返回订单号',
  `pay_type` varchar(50) DEFAULT 'wxpay' COMMENT '支付方式',
  `yu_money` decimal(10,2) DEFAULT '0.00' COMMENT '余额支付金额',
  `pay_status` int(10) DEFAULT '0' COMMENT '是否支付',
  `pay_time` int(10) DEFAULT '0' COMMENT '支付时间',
  `tuikuan` int(10) DEFAULT '0' COMMENT '1，退款中，2已退款，3拒绝退款',
  `hongbao_id` int(10) DEFAULT '0',
  `hongbao` double(10,2) DEFAULT '0.00',
  `partner_shouru` double(10,2) DEFAULT '0.00' COMMENT '商户收入',
  `kuaidi_name` varchar(50) DEFAULT '' COMMENT '快递公司',
  `kuaidi_no` varchar(30) DEFAULT '' COMMENT '快递单号',
  `kuaidi_time` int(10) DEFAULT '0',
  `shouhuo_time` varchar(50) DEFAULT '',
  `tuikuan_time` int(10) DEFAULT '0',
  `daren_id` int(10) DEFAULT '0' COMMENT '达人 id',
  `hexiao_time` int(10) DEFAULT '0' COMMENT '核销时间',
  `zhifu_money` double(10,2) DEFAULT '0.00' COMMENT '在先线支付de金额 ',
  `shou_time` int(10) DEFAULT '0' COMMENT '确认收货时间',
  `peisong_id` int(10) DEFAULT '0' COMMENT '配送ID',
  `peisong` varchar(10) DEFAULT 'N',
  `lat` varchar(120) DEFAULT '',
  `lng` varchar(120) DEFAULT '',
  `peisong_yongjin` decimal(10,2) DEFAULT '0.00',
  `w_time` int(10) DEFAULT '0',
  `vip` tinyint(1) DEFAULT '0',
  `daren_money` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=996 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of xn_order
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_order_chong`
-- ----------------------------
DROP TABLE IF EXISTS `xn_order_chong`;
CREATE TABLE `xn_order_chong` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) DEFAULT '' COMMENT '分类名称',
  `partner_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `utoken` varchar(50) DEFAULT '' COMMENT '用户ID md5',
  `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '总金额',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品金额',
  `ps_price` decimal(10,2) DEFAULT '0.00' COMMENT '配送fei',
  `coupon_id` int(10) DEFAULT '0',
  `coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '优惠价格',
  `pay_price` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `state` tinyint(1) DEFAULT '1' COMMENT '订单状态:1待付款 2待自提 3待发货 4已发货 5已完成 6 已关闭 7退款中 10 已评价 ',
  `create_time` int(10) DEFAULT '0',
  `province` varchar(50) DEFAULT '' COMMENT '省市',
  `city` varchar(50) DEFAULT '' COMMENT '城市',
  `county` varchar(50) DEFAULT '' COMMENT '区县',
  `address` varchar(200) DEFAULT '' COMMENT '详细地址',
  `name` varchar(50) DEFAULT '' COMMENT '收货姓名',
  `mobile` varchar(20) DEFAULT '' COMMENT '收货电话',
  `remarks` varchar(200) DEFAULT '' COMMENT '备注',
  `mall_remarks` varchar(200) DEFAULT '' COMMENT '后台备注',
  `order_type` tinyint(1) DEFAULT '0',
  `is_ziti` tinyint(1) DEFAULT '0' COMMENT '是否自提:0 物流，1自提',
  `payment_type` tinyint(1) DEFAULT '1' COMMENT '支付方式：1微信',
  `second` text COMMENT '商品信息',
  `pingjia_time` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_star` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_content` text COMMENT '套餐id',
  `pingjia_images` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `pingjia_biaoqian` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `yunfei` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `pay_no` varchar(225) DEFAULT '' COMMENT '微信返回订单号',
  `pay_type` varchar(50) DEFAULT 'wxpay' COMMENT '支付方式',
  `yu_money` decimal(10,2) DEFAULT '0.00' COMMENT '余额支付金额',
  `pay_status` int(10) DEFAULT '0' COMMENT '是否支付',
  `pay_time` int(10) DEFAULT '0' COMMENT '支付时间',
  `tuikuan` int(10) DEFAULT '0' COMMENT '1，退款中，2已退款，3拒绝退款',
  `hongbao_id` int(10) DEFAULT '0',
  `hongbao` double(10,2) DEFAULT '0.00',
  `partner_shouru` double(10,2) DEFAULT '0.00' COMMENT '商户收入',
  `kuaidi_name` varchar(50) DEFAULT '' COMMENT '快递公司',
  `kuaidi_no` varchar(30) DEFAULT '' COMMENT '快递单号',
  `kuaidi_time` int(10) DEFAULT '0',
  `shouhuo_time` int(10) DEFAULT '0',
  `tuikuan_time` int(10) DEFAULT '0',
  `daren_id` int(10) DEFAULT '0' COMMENT '达人 id',
  `hexiao_time` int(10) DEFAULT '0' COMMENT '核销时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=927 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of xn_order_chong
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_order_tags`
-- ----------------------------
DROP TABLE IF EXISTS `xn_order_tags`;
CREATE TABLE `xn_order_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_order_tags
-- ----------------------------
INSERT INTO `xn_order_tags` VALUES ('25', '货品完好', '2', '1');
INSERT INTO `xn_order_tags` VALUES ('26', '佩戴口罩', '3', '1');
INSERT INTO `xn_order_tags` VALUES ('27', '快速准时', '4', '1');
INSERT INTO `xn_order_tags` VALUES ('28', '穿戴工服', '5', '1');
INSERT INTO `xn_order_tags` VALUES ('29', '仪表整洁', '6', '1');
INSERT INTO `xn_order_tags` VALUES ('30', '风雨无阻', '7', '1');
INSERT INTO `xn_order_tags` VALUES ('31', '热情礼貌', '7', '1');

-- ----------------------------
-- Table structure for `xn_order_vip`
-- ----------------------------
DROP TABLE IF EXISTS `xn_order_vip`;
CREATE TABLE `xn_order_vip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) DEFAULT '' COMMENT '分类名称',
  `tian` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `utoken` varchar(50) DEFAULT '' COMMENT '用户ID md5',
  `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '总金额',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品金额',
  `ps_price` decimal(10,2) DEFAULT '0.00' COMMENT '配送fei',
  `coupon_id` int(10) DEFAULT '0',
  `coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '优惠价格',
  `pay_price` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `state` tinyint(1) DEFAULT '1' COMMENT '订单状态:1待付款 2待自提 3待发货 4已发货 5已完成 6 已关闭 7退款中 10 已评价 ',
  `create_time` int(10) DEFAULT '0',
  `province` varchar(50) DEFAULT '' COMMENT '省市',
  `city` varchar(50) DEFAULT '' COMMENT '城市',
  `county` varchar(50) DEFAULT '' COMMENT '区县',
  `address` varchar(200) DEFAULT '' COMMENT '详细地址',
  `name` varchar(50) DEFAULT '' COMMENT '收货姓名',
  `mobile` varchar(20) DEFAULT '' COMMENT '收货电话',
  `remarks` varchar(200) DEFAULT '' COMMENT '备注',
  `mall_remarks` varchar(200) DEFAULT '' COMMENT '后台备注',
  `order_type` tinyint(1) DEFAULT '0',
  `is_ziti` tinyint(1) DEFAULT '0' COMMENT '是否自提:0 物流，1自提',
  `payment_type` tinyint(1) DEFAULT '1' COMMENT '支付方式：1微信',
  `second` text COMMENT '商品信息',
  `pingjia_time` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_star` int(13) DEFAULT '0' COMMENT '套餐id',
  `pingjia_content` text COMMENT '套餐id',
  `pingjia_images` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `pingjia_biaoqian` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `yunfei` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `pay_no` varchar(225) DEFAULT '' COMMENT '微信返回订单号',
  `pay_type` varchar(50) DEFAULT 'wxpay' COMMENT '支付方式',
  `yu_money` decimal(10,2) DEFAULT '0.00' COMMENT '余额支付金额',
  `pay_status` int(10) DEFAULT '0' COMMENT '是否支付',
  `pay_time` int(10) DEFAULT '0' COMMENT '支付时间',
  `tuikuan` int(10) DEFAULT '0' COMMENT '1，退款中，2已退款，3拒绝退款',
  `hongbao_id` int(10) DEFAULT '0',
  `hongbao` double(10,2) DEFAULT '0.00',
  `partner_shouru` double(10,2) DEFAULT '0.00' COMMENT '商户收入',
  `kuaidi_name` varchar(50) DEFAULT '' COMMENT '快递公司',
  `kuaidi_no` varchar(30) DEFAULT '' COMMENT '快递单号',
  `kuaidi_time` int(10) DEFAULT '0',
  `shouhuo_time` int(10) DEFAULT '0',
  `tuikuan_time` int(10) DEFAULT '0',
  `daren_id` int(10) DEFAULT '0' COMMENT '达人 id',
  `hexiao_time` int(10) DEFAULT '0' COMMENT '核销时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=916 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of xn_order_vip
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_pages`
-- ----------------------------
DROP TABLE IF EXISTS `xn_pages`;
CREATE TABLE `xn_pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '名称',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `detail` text COMMENT '详情',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='单页';

-- ----------------------------
-- Records of xn_pages
-- ----------------------------
INSERT INTO `xn_pages` VALUES ('25', '关于我们', '/uploads/file/20211210/f6f61c642983feea788530cc803b0378.png', '2', '1', '<p>发送到发斯蒂芬</p>', '0', '1');
INSERT INTO `xn_pages` VALUES ('26', '联系我们', '', '2', '1', '', '0', '1');
INSERT INTO `xn_pages` VALUES ('27', '用户协议', '', '2', '1', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">【注意】欢迎申请使用</span></strong>青羚鲜生<strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">提供的服务。</span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">请您（下列简称为“用户”）仔细阅读以下全部内容</span><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">（特别是粗体下划线标注的内容）</span></span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">。如用户不同意本服务条款任意内容，请勿注册或使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务。如用户通过进入注册程序并勾选“我同意服务条款”，即表示用户与</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">公司已达成协议，自愿接受本服务条款的所有内容。此后，用户不得以未阅读本服务条款内容作任何形式的抗辩。</span></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">1.服务条款的确认和接纳</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务涉及到的产品的所有权以及相关软件的知识产权归</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">所有。</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">所提供的服务必须按照其发布的公司章程，服务条款和操作规则严格执行。本服务条款的效力范围及于将</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号作为登录帐号的</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">产品和服务（以下简称“</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">各单项服务”），用户在享受</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">各单项服务时，应当受本服务条款的约束。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">当用户使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">各单项服务时，用户同意以单项服务要求的方式同意该单项服务的服务条款以及</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">在该单项服务中发出的各类公告（下列简称为“单项条款”），在此情况下单项条款与本服务条款同时对用户产生效力。若单项条款与本服务条款存在同类条款的冲突，则在单项条款约束范围内应以单项条款为准。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2.</span></strong>青羚鲜生<strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号服务简介</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">本服务条款所称的“</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号”是指用户以手机号码作为帐号注册的合法、有效的帐号，</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号注册成功后帐号即为手机号。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">运用自己的操作系统通过国际互联网络为用户提供各项服务。用户必须：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）提供设备，如个人电脑、手机或其他上网设备。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）个人上网和支付与此服务有关的费用。</span></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">3.</span></strong>青羚鲜生<strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号注册规则</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号注册资料包括但不限于：用户的手机号码、密码及注册</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号或更新</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号注册资料时输入的所有信息或更新手机帐号时输入的所有信息以及用户使用各单项服务时输入的名称、头像等所有信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户在注册</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号时承诺遵守法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等七条底线，不得在</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号注册资料中出现违法和不良信息，且用户保证其在注册和使用帐号时，不得有以下情形：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）违反宪法或法律法规规定的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）损害国家荣誉和利益的，损害公共利益的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（4）煽动民族仇恨、民族歧视，破坏民族团结的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（5）破坏国家宗教政策，宣扬邪教和封建迷信的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（6）散布谣言，扰乱社会秩序，破坏社会稳定的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（8）侮辱或者诽谤他人，侵害他人合法权益的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（9）含有法律、行政法规禁止的其他内容的。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">若用户提供给</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的帐号注册资料不准确，不真实，含有违法或不良信息的，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有权不予注册，并保留终止用户使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">各项服务的权利。若用户以虚假信息骗取帐号注册或帐号头像、个人简介等注册资料存在违法和不良信息的，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有权采取通知限期改正、暂停使用、注销登记等措施。对于冒用关联机构或社会名人注册帐号名称的，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有权注销该帐号，并向政府主管部门进行报告。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">根据相关法律、法规规定以及考虑到</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">产品服务的重要性，用户同意：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）在注册</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号时提交个人有效身份信息进行实名认证；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）提供及时、详尽及准确的帐户注册资料；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）不断更新注册资料，符合及时、详尽准确的要求，对注册</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">手机帐号时填写的身份证件信息不能更新。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">用户同意，其提供的真实、准确、合法的</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号注册资料作为认定用户与其</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号的关联性以及用户身份的唯一证据。用户在享用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">各项服务的同时，同意接受</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">提供的各类信息服务。</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">提醒用户，用户注册</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号或更新注册信息时填写的证件号码，在注册</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号成功或补充填写后将无法进行修改，请用户慎重填写各类注册信息。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">用户同意，在用户通过</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">公布的线上渠道或通过客服申诉并提交</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">要求的身份认证信息材料的，则该用户原</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号下的所有使用记录及充值数据可以转移到该用户提供的，未注册过</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号的新手机号关联的新</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号并自行承担因此等转移可能产生的后果。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">为使用户及时、全面了解</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">提供的各项服务，用户同意，</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">可以多次、长期向用户发送各类商业性短信息而无需另行获得用户的同意。用户同意与注册、使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号相关的一切资料、数据和记录，包括但不限于手机帐号、注册信息、所有登录、消费记录和相关的使用统计数字等归</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">所有。发生争议时，用户同意以</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的系统数据为准，</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">保证该数据的真实性。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">尽管有前述约定，对于用户使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">手机帐号享受</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">旗下单项服务（如游戏产品、</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">支付产品等）时产生的一切数据，包括但不限于产品登录记录、消费记录及其他产品日志、产品客户服务记录、用户在产品中创造的社会网络内容等，归具体产品运营主体所有。发生争议时，用户同意以具体产品运营主体的系统数据为准。但是如果单项条款存在与前述不同的约定，则以单项条款约定为准。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">4.服务条款的修改</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有权在必要时通过在网页上发出公告等合理方式修改本服务条款以及各单项服务的相关条款。用户在享受各项服务时，应当及时查阅了解修改的内容，并自觉遵守本服务条款以及该单项服务的相关条款。用户如继续使用本服务条款涉及的服务，则视为对修改内容的同意，当发生有关争议时，以最新的服务条款为准；用户在不同意修改内容的情况下，有权停止使用本服务条款涉及的服务。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">5.服务的变更或中止</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">始终在不断变更和改进服务。</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">可能会增加或删除功能，也可能暂停或彻底停止某项服务。用户同意</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有权行使上述权利且不需对用户或第三方承担任何责任。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">6.用户隐私制度</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">尊重用户隐私是</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的一项基本政策。</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">将按照</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">网站上公布的隐私政策</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">，</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">收集、存储、使用、披露和保护您的个人信息。请您完整阅读上述隐私权政策，以帮助您更好地保护您的个人信息。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">7</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">.不可抗力条款</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">对不可抗力导致的损失不承担责任。本服务条款所指不可抗力包括：天灾、法律法规或政府指令的变更，因网络服务特性而特有的原因，例如境内外基础电信运营商的故障、计算机或互联网相关技术缺陷、互联网覆盖范围限制、计算机病毒、黑客攻击等因素，及其他合法范围内的不能预见、不能避免并不能克服的客观情况。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">8</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">.禁止服务的商业化</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">用户承诺，非经</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">同意，用户不能利用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">各项服务进行销售或其他商业用途。如用户有需要将服务用于商业用途，应书面通知</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">并获得</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的明确授权。</span></span></strong></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">9</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">.用户管理</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户独立承担其发布内容的责任。用户对服务的使用必须遵守所有适用于服务的地方法律、国家法律和国际法律。用户承诺：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）用户在</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的网页上发布信息或者利用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的服务时必须符合中国有关法规，不得在</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的网页上或者利用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的服务制作、复制、发布、传播以下信息：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(a) 违反宪法确定的基本原则的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(b) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(c) 损害国家荣誉和利益的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(d) 煽动民族仇恨、民族歧视，破坏民族团结的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(e) 破坏国家宗教政策，宣扬邪教和封建迷信的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(f) 散布谣言，扰乱社会秩序，破坏社会稳定的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(g) 散布淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(h) 侮辱或者诽谤他人，侵害他人合法权益的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(i) 煽动非法集会、结社、游行、示威、聚众扰乱社会秩序的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(j) 以非法民间组织名义活动的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(k) 含有法律、行政法规禁止的其他内容的。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）用户在</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的网页上发布信息或者利用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的服务时还必须符合其他有关国家和地区的法律规定以及国际法的有关规定。用户需遵守法律法规的规定使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">微、博客服务。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）用户不得利用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的服务从事以下活动：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(a) 未经允许，进入计算机信息网络或者使用计算机信息网络资源的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(b) 未经允许，对计算机信息网络功能进行删除、修改或者增加的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(c) 未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(d) 故意制作、传播计算机病毒等破坏性程序的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">(e) 其他危害计算机信息网络安全的行为。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（4）用户不得以任何方式干扰</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的服务。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（5）用户不得滥用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务，包括但不限于：利用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务进行侵害他人知识产权或者合法利益的其他行为。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（6）用户应遵守</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的所有其他规定和程序。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户须对自己在使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于：对受到侵害者进行赔偿，以及在</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">首先承担了因用户行为导致的行政处罚或侵权损害赔偿责任后，用户应给予</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">等额的赔偿。若用户违反以上规定，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有权作出独立判断立即暂停或终止对用户提供部分或全部服务，包括冻结、取消用户服务帐号等措施。用户理解，如果</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">发现其网站传输的信息明显属于上段第(1)条所列内容之一，依据中国法律，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有义务立即停止传输，保存有关记录，向国家有关机关报告，并且删除含有该内容的地址、目录或关闭服务器。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">电子公告服务，包括电子布告牌、电子白板、电子论坛、网络聊天室和留言等以交互形式为上网用户提供信息发布条件的行为，也须遵守本条的规定以及</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">将专门发布的电子公告服务规则，上段中描述的法律后果和法律责任同样适用于电子公告服务的用户。</span></p><p><span style=\"font-family: Calibri; font-size: 14px;\">&nbsp;</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">11.保障</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户同意保障和维护</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有限公司</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">全体成员的利益，承担由用户违反服务条款的损害补偿费用，其它人使用用户的电脑、手机、帐号而产生的费用。用户或者使用用户帐号的其他人在进行游戏过程中侵犯第三方知识产权及其他权利而导致被侵权人索赔的，由用户承担责任。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">如用户或其它网络服务提供者利用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">有限公司</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的服务侵害他人民事权益的，应当承担侵权等法律责任。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">如用户利用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;', '0', '1');
INSERT INTO `xn_pages` VALUES ('31', '隐私政策', '', '3', '1', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; text-align: center; line-height: 27px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 18px;\">隐私</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 18px;\">权</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 18px;\">政策</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; text-align: center; line-height: 27px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 18px;\">前言</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">一向庄严承诺保护使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的产品和服务之用户</span><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">（以下统称“用户”或“您”）</span></span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的隐私。您在使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时，我们可能会收集和使用您的相关信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">本《隐私政策》适用于我们提供的一切</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务。当您使用我们任何单项服务时，您同意接受本《隐私政策》以及我们在该单项服务中发出的特定隐私信息类政策条款（下列称“特定条款”）的保护，在此情况下特定条款与本政策条款同时对您产生效力。例如：使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">在线服务的用户，同时适用本《隐私政策》以及《网络游戏用户隐私权保护和个人信息利用政策》（见附件一）；又如，使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">支付的用户，同时适用本《隐私政策》以及《</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">支付隐私政策》（见附件二）。如特定条款与本《隐私政策》条款存在同类条款的不一致约定，则在特定条款约束范围内应以特定条款为准。如我们提供的某一单项服务不适用本《隐私政策》的，该服务中会以适当方式明示排除适用本《隐私政策》。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">请注意我们不时地会检查我们的政策，因此有关的措施会随之变化。我们恳请您定期光顾本页面，以确保对我们《隐私政策》最新版本始终保持了解</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">您使用或继续使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务，都表示您同意我们按照本《隐私政策》收集、使用、储存和分享您的信息。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; text-align: center; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">目录</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">一、我们可能收集的信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">二、我们如何收集和使用信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">三、我们可能分享、转让和披露的信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">四、我们如何保留、储存和保护信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">五、如何管理您的信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">六、第三方服务</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">七、年龄限制</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">八、通知和修订</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">九、如何联系我们</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">一、我们可能收集的信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（一）与个人身份无关的信息：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">当您使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时，我们可能收集和汇总诸如用户的来源途径、访问顺序等信息，例如记录使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的每个用户的来源途径、浏览器软件等。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（二）有关个人身份的信息：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">当您使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时，我们可能收集和汇总或要求您提供有关个人身份的信息，例如个人身份证明（包括身份证、护照、驾驶证等）；生日、籍贯、性别、兴趣爱好、个人电话号码、面部特征；网络身份标识信息（包括系统账号、IP地址、电子邮箱地址及与前述有关的密码、口令、口令保护答案等）；个人财产信息（交易记录、余额、优惠券、游戏类兑换码、银行卡信息等）；通讯信息；个人上网记录和日志信息（包括网站浏览记录、软件使用记录、点击记录、操作日志等）；设备信息（包括设备型号、设备MAC地址、操作系统类型、设备设置）；软件列表唯一设备识别码（如IMEI/android ID/IDFA/OPENUDID/GUID、SIM卡IMSI信息等在内的描述个人常用设备基本情况的信息）；位置信息（包括行程信息、精准定位信息、住宿信息、经纬度等）。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们收集您的信息主要是为了您和其他用户能够更容易和更满意地使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务。</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的目标是向所有的互联网用户提供安全、刺激、有趣及有教益的上网经历。而这些信息有助于我们实现这一目标。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">请注意，如您在</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务中其他用户可见的公开区域内上传或发布的信息中、您对其他人上传或发布的信息作出的回应中公开您的个人信息，该等信息可能会被他人收集并加以使用。当您发现</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的用户不正当地收集或使用您或他人的信息时，请联系</span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">我们</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">二、我们如何收集和使用信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（一）我们将通过以下途径收集和获得您的信息：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">1、您提供的信息。</span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">例如：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）您在注册</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的帐号或使用服务时，向我们提供的信息；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）您通过</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务向其他方提供的共享信息，以及您使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时所储存的信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2、其他方分享的您的信息。</span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">亦即其他方使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时所提供有关您的共享信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">3、我们获取的您的信息。</span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">您在使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时，我们收集、汇总、记录的信息，例如日志信息、位置信息、设备信息等。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">二</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">）我们会出于以下目的，收集和使用您的信息：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">1、帮助您完成注册</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">为便于我们为您提供服务，您需要提供基本注册信息，例如手机号码、电子邮箱地址等，并创建您的用户名和密码。在部分单项服务中，如果您仅需使用浏览、搜索等基本服务，您不需要注册成为</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户及提供上述信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2、向您提供商品或服务</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们所收集和使用的信息是为您提供</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的必要条件，如缺少相关信息，我们将无法为您提供</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的核心内容，例如：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）在部分服务项目中，为便于向您交付商品或服务，您需提供收货人个人身份信息、姓名、收货地址、邮政编码、收货人、联系电话、支付状态等信息。如果您拒绝提供此类信息，我们将无法完成相关交付服务。如您通过</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务为其他人订购商品或服务，您需要提供该实际订购人的前述信息。</span><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">向我们提供该实际订购人的前述信息之前，您需确保您已经取得其授权同意。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）为展示您账户的订单信息，我们会收集您在使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务过程中产生的订单信息用于向您展示及便于您对订单进行管理；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）当您与我们联系时，我们可能会保存您的通信/通话记录和内容或您留下的联系方式等信息，以便与您联系或帮助您解决问题，或记录相关问题的处理方案及结果。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（4）为确认交易状态及为您提供售后与争议解决服务，我们会通过您基于交易所选择的交易对象、支付机构、物流公司等收集与交易进度相关的您的交易、支付、物流信息，或将您的交易信息共享给上述服务提供者。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">3、向您推送消息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">为您展示和推送商品或服务。我们可能使用您的信息，您的浏览及搜索记录、设备信息、位置信息、订单信息，提取您的浏览、搜索偏好、行为习惯、位置信息等特征，并基于特征标签通过电子邮件、短信或其他方式向您发送营销信息，提供或推广我们或第三方的如下商品和服务：</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们的商品和服务，包括但不限于：即时通讯服务、网上媒体服务、互动娱乐服务、社交网络服务、支付服务、互联网搜索服务、位置和地图服务、应用软件和服务、数据管理软件和服务、网上广告服务、互联网金融及其他社交媒体、娱乐、网络游戏、电子商务、资讯及通讯软件和服务（“互联网服务”）；及</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">第三方商品和服务，包括但不限于：互联网服务、食物和餐饮、体育、音乐、电影、电视、现场表演和其他艺术和娱乐、书册、杂志和其他刊物、服装和配饰、珠宝、化妆品、个人健康和卫生、电子、收藏品、家用器皿、电器、家居装饰和摆设、宠物、汽车、酒店、交通和旅游、银行、保险及金融服务、积分和奖励计划，以及我们认为可能与您相关的其他商品和服务。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">4</span></strong><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">、改进我们的服务</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们可能将通过某一项</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务所收集的信息，用于我们的其他服务。例如，在您使用某一项</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时所收集的您的信息，可能在另一项</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务中用于向您提供特定内容或向您展示与您相关的、而非普遍推送的信息；我们可能让您参与有关</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的调查，帮助我们改善现有服务或设计新服务；同时，我们可能将您的信息用于软件更新。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">您了解并同意，在收集您的信息后，我们将通过技术手段对数据进行去标识化处理，去标识化处理的信息将无法识别您的身份，在此情况下我们有权使用已经去标识化的信息，对用户数据库进行分析并予以商业化的利用。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">如果我们将您的信息用于本《隐私政策》中未载明的其他用途，会事先征求您同意。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">6、征得授权同意的例外</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">根据相关法律法规规定，以下情形中收集您的信息无需征得您的授权同意：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）与国家安全、国防安全有关的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）与公共安全、公共卫生、重大公共利益有关的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）与犯罪侦查、起诉、审判和判决执行等有关的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（4）出于维护信息主体或其他个人的生命、财产等重大合法权益但又很难得到您本人同意的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（5）所收集的信息是您自行向社会公众公开的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（6）从合法公开披露的信息中收集信息的，如合法的新闻报道、政府信息公开等渠道；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（7）根据您的要求签订合同所必需的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（8）用于维护</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务的安全稳定运行所必需的，例如发现、处置产品或服务的故障；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（9）为合法的新闻报道所必需的；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（10）学术研究机构基于公共利益开展统计或学术研究所必要，且对外提供学术研究或描述的结果时，对结果中所包含的信息进行去标识化处理的；（11）法律法规规定的其他情形。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">三、我们可能分享、转让或披露的信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（一）分享</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">除以下情形外，未经您同意，我们不会与</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">之外的任何第三方分享您的信息：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">1、向您提供我们的服务。我们可能向合作伙伴及其他第三方分享您的信息，以实现您需要的核心功能或提供您需要的服务，例如：向物流服务商提供对应的订单信息；</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">2、维护和改善我们的服务。我们可能向合作伙伴及其他第三方分享您的信息，以帮助我们为您提供更有针对性、更完善的服务，例如：代表我们发出电子邮件或推送通知的通讯服务提供商等；</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">3、实现本《隐私政策》第二条“我们如何收集和使用信息”部分所述目的；</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">4、履行我们在本《隐私政策》或我们与您达成的其他协议中的义务和行使我们的权利；</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">5、向委托我们进行推广的合作伙伴等第三方共享，但我们仅会向这些委托方提供推广的覆盖面和有效性的信息，而不会提供可以识别您身份的信息，例如姓名电话号码或电子邮箱；或者我们将这些信息进行汇总，以便它不会识别您个人。比如我们可以告知该委托方有多少人看了他们的推广信息或在看到这些信息后购买了委托方的商品，或者向他们提供不能识别个人身份的统计信息，帮助他们了解其受众或顾客。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">6、在法律法规允许的范围内，为了遵守法律、维护我们及我们的关联方或合作伙伴、您或其他</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">用户或社会公众利益、财产或安全免遭损害，比如为防止欺诈等违法活动和减少信用风险，我们可能与其他公司和组织交换信息。不过,这并不包括违反本《隐私政策》中所作的承诺而为获利目的出售、出租、共享或以其它方式披露的信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">7、应您合法需求，协助处理您与他人的纠纷或争议；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">8、应您的监护人合法要求而提供您的信息；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">9、根据与您签署的单项服务协议（包括在线签署的电子协议以及相应的平台规则）或其他的法律文件约定所提供；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">10、基于学术研究而提供；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">11、基于符合法律法规的社会公共利益而提供。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们仅会出于合法、正当、必要、特定、明确的目的共享您的信息。对我们与之共享信息的公司、组织和个人，我们会与其签署严格的保密协定，要求他们按照我们的说明、本《隐私政策》以及其他任何相关的保密和安全措施来处理信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（二）转让</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">1、随着我们业务的持续发展，我们有可能进行合并、收购、资产转让或类似的交易，而您的信息有可能作为此类交易的一部分而被转移。</span></span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们会要求新的持有您信息的公司、组织继续受本《隐私政策》的约束，否则,我们将要求该公司、组织重新向您征求授权同意。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2、在获得您的明确同意后，我们会向其他方转让您的信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（三）披露</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们仅会在以下情况下，且采取符合业界标准的安全防护措施的前提下，才会披露您的信息：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">1、根据您的需求，在您明确同意的披露方式下披露您所指定的信息；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2、根据法律、法规的要求、强制性的行政执法或司法要求所必须提供您信息的情况下，我们可能会依据所要求的信息类型和披露方式披露您的信息。在符合法律法规的前提下，当我们收到上述披露信息的请求时，我们会要求接收方必须出具与之相应的法律文件，如传票或调查函。我们坚信，对于要求我们提供的信息，应该在法律允许的范围内尽可能保持透明。我们对所有的请求都进行了慎重的审查，以确保其具备合法依据，且仅限于执法部门因特定调查目的且有合法权利获取的数据。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">四、我们如何保留、储存和保护信息</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们仅在本《隐私政策》所述目的所必需期间和法律法规要求的时限内保留您的信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们在中华人民共和国境内运营中收集和产生的信息，存储在中国境内，以下情形除外：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">1、法律法规有明确规定；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">2、获得您的授权同意；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">3、您使用的产品、服务涉及跨境，</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">需要向境外提供您的个人信息的。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">针对以上情形，我们会确保依据本政策及国家法律法规要求对您的个人信息提供足够的保护。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们为保护信息采取的其他安全措施</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们通过建立数据分类分级制度、数据安全管理规范、数据安全开发规范来管理规范信息的存储和使用。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们通过信息接触者保密协议、监控和审计机制来对数据进行全面安全控制。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">加强安全意识。我们还会举办安全和隐私保护培训课程，加强员工对于保护信息重要性的认识。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">我们仅允许有必要知晓这些信息的</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">员工、合作伙伴访问您的信息，并为此设置了严格的访问权限控制和监控机制。我们同时要求可能接触到您的信息的所有人员履行相应的保密义务。如果未能履行这些义务，可能会被追究法律责任或被中止与</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">的合作关系。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们会采取一切合理可行的措施，确保未收集无关的信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">互联网并非绝对安全的环境，而且电子邮件、即时通讯、社交软件或其他服务软件等与其他用户的交流方式无法确定是否完全加密，我们建议您使用此类工具时请使用复杂密码，并注意保护您的信息安全。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">互联网环境并非百分之百安全，我们将尽力确保或担保您发送给我们的任何信息的安全性。如果我们的物理、技术、或管理防护设施遭到破坏，导致信息被非授权访问、公开披露、篡改、或毁坏，导致您的合法权益受损，我们将承担相应的法律责任。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">安全事件处置</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">在通过</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务与第三方进行沟通或购买商品及服务时，您不可避免的要向交易对方或潜在的交易对方披露自己的信息，如联络方式或者邮政地址等。请您妥善保护自己的信息，仅在必要的情形下向他人提供。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">为应对信息泄露、损毁和丢失等可能出现的风险，我们制定了多项制度，明确安全事件、安全漏洞的分类分级标准及相应的处理流程。我们也为安全事件建立了专门的应急响应团队，按照安全事件处置规范要求，针对不同安全事件启动安全预案，进行止损、分析、定位、制定补救措施、联合相关部门进行溯源和打击。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">在不幸发生信息安全事件后，我们将按照法律法规的要求，及时向您告知：安全事件的基本情况和可能的影响、我们已采取或将要采取的处置措施、您可自主防范和降低风险的建议、对您的补救措施等。我们同时将及时将事件相关情况以邮件、信函、电话、推送通知等方式告知您，难以逐一告知信息主体时，我们会采取合理、有效的方式发布公告。同时，我们还将按照监管部门要求，主动上报信息安全事件的处置情况。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">请您理解，由于技术的限制以及风险防范的局限，即便我们已经尽量加强安全措施，也无法始终保证信息百分之百的安全。您需要了解，您接入</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务所用的系统和通讯网络，有可能因我们可控范围外的情况而发生问题。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">有关敏感信息的提示</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">某些信息因其特殊性可能被认为是敏感信息，例如您的种族、宗教、个人健康和医疗信息等，以及身份证明文件、个人生物识别信息、财产信息、行踪轨迹、未成年人的信息等。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">请注意，您在</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务中所提供、上传或发布的内容和信息（例如有关您社交活动的照片或信息），可能会泄露您的敏感信息。您需要谨慎地考虑，是否使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务披露您的敏感信息。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">您同意您的敏感信息按本《隐私政策》所述的目的和方式来处理。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">六、第三方服务</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">青羚鲜生</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务可能链接至第三方提供的社交媒体或其他服务（包括网站或其他服务形式）。包括：</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（1）您可利用“分享”键将某些内容分享到</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务，或您可利用第三方服务登录</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务。这些功能可能会收集您的信息（包括您的日志信息），并可能在您的电脑装置COOKIES，从而正常运行上述功能；</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（2）我们通过广告或我们服务的其他方式向您提供链接，使您可以接入第三方的服务或网站；及</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">（3）其他接入第三方服务的情形。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">该等第三方社交媒体或其他服务由相关的第三方负责运营。您使用该等第三方的社交媒体服务或其他服务（包括您向该等第三方提供的任何信息），须受第三方自己的服务条款及信息保护声明（而非本《隐私政策》）约束，您需要仔细阅读其条款。本《隐私政策》仅适用于我们所收集的任何信息，并不适用于任何第三方提供的服务或第三方的信息使用规则，而我们对任何第三方使用由您提供的信息不承担任何责任。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">七、年龄限制</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们建议：</span><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">任何未成年人参加网上活动应事先取得家长或其法定监护人（以下简称&quot;监护人&quot;）的同意。</span></span></strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们将根据国家相关法律法规的规定保护未成年人的相关信息。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">我们鼓励父母或监护人指导未成年人使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务。我们建议未成年人鼓励他们的父母或监护人阅读本《隐私政策》，并建议未成年人在提交信息之前寻求父母或监护人的同意和指导。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">八、通知和修订</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">我们可能适时修改本《隐私政策》的条款，该等修改构成本《隐私政策》的一部分。对于重大变更，我们会提供更显著的通知，您可以选择停止使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务；在该种情况下，如您仍然继续使用</span></span></strong>青羚鲜生<strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\"></span></span></strong><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">服务的，即表示同意受经修订的本《隐私政策》的约束。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">任何修改都会将您的满意度置于首位。我们鼓励您在每次使用</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">服务时都查阅我们的隐私政策。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">我们可能在必需时（例如当我们由于系统维护而暂停某一项服务时）发出与服务有关的公告。您可能无法取消这些与服务有关、性质不属于推广的公告。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><strong><span style=\"text-decoration-line: underline;\"><span style=\"font-family: 微软雅黑; letter-spacing: 0px; font-size: 14px;\">最后，您必须对您的账号和密码信息负有保密义务。任何情况下，请小心妥善保管。</span></span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 23px; background: rgb(255, 255, 255);\"><strong><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 15px;\">九、如何联系我们</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">如您有关于网络信息安全的投诉和举报，或您对本《隐私政策》、您的信息的相关事宜有任何问题、意见或建议，以及有关本声明或</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的隐私措施的问题请与</span>青羚鲜生<span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\"></span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">的协调人联系</span><span style=\"font-family: 微软雅黑; color: rgb(51, 51, 51); letter-spacing: 0px; font-size: 14px;\">。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; text-indent: 28px; padding: 0px; line-height: 21px; background: rgb(255, 255, 255);\"><span', '1651045925', '0');
INSERT INTO `xn_pages` VALUES ('32', '帮助中心', '', '11', '1', '<p>111</p>', '1651045943', '0');

-- ----------------------------
-- Table structure for `xn_partner`
-- ----------------------------
DROP TABLE IF EXISTS `xn_partner`;
CREATE TABLE `xn_partner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT '' COMMENT '用户名',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `cate_id` int(11) DEFAULT '0' COMMENT '类别id',
  `title` varchar(50) DEFAULT '' COMMENT '车库名称',
  `introduc` varchar(100) DEFAULT '' COMMENT '一句话简介',
  `logo` varchar(255) DEFAULT NULL,
  `images` varchar(255) DEFAULT '',
  `avg_price` decimal(10,2) DEFAULT '0.00' COMMENT '人均消费',
  `dafen` decimal(10,1) DEFAULT '5.0',
  `hot` int(10) DEFAULT '0' COMMENT '热度',
  `lable` varchar(200) DEFAULT '' COMMENT 'lable',
  `address` varchar(20) DEFAULT '' COMMENT '车库位置',
  `lat` varchar(255) DEFAULT '0' COMMENT '纬度',
  `lng` varchar(255) DEFAULT '0' COMMENT '经度',
  `name` varchar(30) DEFAULT '' COMMENT '联系人',
  `mobile` varchar(15) DEFAULT '' COMMENT '联系电话',
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `status` tinyint(1) DEFAULT '1' COMMENT '1通过 .2 审核',
  `detail` text COMMENT '商户详情',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `admin_id` int(10) DEFAULT '0',
  `sell_time` varchar(50) DEFAULT '' COMMENT '营业时间',
  `content` longtext,
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '余额',
  `money_shouru` decimal(10,2) DEFAULT '0.00' COMMENT '已结算',
  `jiesuan_type` tinyint(1) DEFAULT '1' COMMENT '1银行卡 2微信',
  `openid` varchar(50) DEFAULT '' COMMENT 'openid',
  `bank_name` varchar(20) DEFAULT '' COMMENT '银行名称',
  `bank_card` varchar(50) DEFAULT '' COMMENT '银行卡号',
  `bank_username` varchar(40) DEFAULT '' COMMENT '开户姓名',
  `bank_mobile` varchar(20) DEFAULT '' COMMENT '联系电话',
  `yunfei` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5445 DEFAULT CHARSET=utf8 COMMENT='车位主认证';

-- ----------------------------
-- Records of xn_partner
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_partner_tixian`
-- ----------------------------
DROP TABLE IF EXISTS `xn_partner_tixian`;
CREATE TABLE `xn_partner_tixian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户 id',
  `partner_id` int(10) DEFAULT '0' COMMENT '商户ID',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:未处理 2已处理 3拒绝',
  `cash_price` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  `before_price` decimal(10,2) DEFAULT '0.00' COMMENT '提现前余额',
  `after_price` decimal(10,2) DEFAULT '0.00' COMMENT '提现后余额',
  `service_price` decimal(10,2) DEFAULT '0.00' COMMENT '手续费',
  `deal_cash_price` decimal(10,2) DEFAULT '0.00' COMMENT '实际提现金额',
  `mode` tinyint(1) DEFAULT '1' COMMENT '提现方式：1银行卡 2支付宝 3微信',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员id',
  `update_time` datetime DEFAULT NULL COMMENT '处理',
  `create_time` datetime DEFAULT NULL,
  `account` varchar(50) DEFAULT '' COMMENT '提现账户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3038 DEFAULT CHARSET=utf8 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of xn_partner_tixian
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_peisong`
-- ----------------------------
DROP TABLE IF EXISTS `xn_peisong`;
CREATE TABLE `xn_peisong` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT '' COMMENT '联系人',
  `mobile` varchar(15) DEFAULT '' COMMENT '联系电话',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `lat` varchar(255) DEFAULT '0' COMMENT '纬度',
  `lng` varchar(255) DEFAULT '0' COMMENT '经度',
  `score` int(11) DEFAULT '0' COMMENT '积分',
  `on` tinyint(1) DEFAULT '1' COMMENT '1通过 .2 审核',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '余额',
  `bank_name` varchar(20) DEFAULT '' COMMENT '银行名称',
  `bank_card` varchar(50) DEFAULT '' COMMENT '银行卡号',
  `bank_username` varchar(40) DEFAULT '' COMMENT '开户姓名',
  `bank_mobile` varchar(20) DEFAULT '' COMMENT '联系电话',
  `yongjin` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5451 DEFAULT CHARSET=utf8 COMMENT='车位主认证';

-- ----------------------------
-- Records of xn_peisong
-- ----------------------------
INSERT INTO `xn_peisong` VALUES ('1', '张三', '13550515067', '123456', '35.5454', '104.45454', '666', '1', '1666666666', '1666666666', '66666.00', '', '', '', '', null);

-- ----------------------------
-- Table structure for `xn_peisong_tixian`
-- ----------------------------
DROP TABLE IF EXISTS `xn_peisong_tixian`;
CREATE TABLE `xn_peisong_tixian` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `peisong_id` int(10) DEFAULT '0' COMMENT '类别ID',
  `mobile` varchar(20) DEFAULT '',
  `name` varchar(255) DEFAULT '' COMMENT '图片1',
  `card` varchar(255) DEFAULT '' COMMENT 'jieshao',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT 'shangjia shijian',
  `status` tinyint(1) DEFAULT '0' COMMENT '0 未处理， 1已处理 ，2 拒绝',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '添加时间',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `remark` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of xn_peisong_tixian
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_tags`
-- ----------------------------
DROP TABLE IF EXISTS `xn_tags`;
CREATE TABLE `xn_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `show_num` int(10) DEFAULT '9' COMMENT '显示个数',
  `show_type` tinyint(1) DEFAULT '0' COMMENT '0 大图 1 竖排 2横排',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '0',
  `image` varchar(255) DEFAULT '',
  `jianjie` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_tags
-- ----------------------------
INSERT INTO `xn_tags` VALUES ('25', '新鲜蔬果', '2', '8', '1', '1', '0', '1', 'http://7niudukeyouxuan.51duoke.cn/1/20211223/06204da4589a9228b8ef760d93e6ef60.png', '这里挑');
INSERT INTO `xn_tags` VALUES ('26', '鲜肉鲜鱼', '3', '9', '0', '1', '0', '1', '', '天天新鲜');
INSERT INTO `xn_tags` VALUES ('28', '时令尝鲜', '5', '9', '0', '1', '0', '0', '', '食鲜果');
INSERT INTO `xn_tags` VALUES ('30', '居家必囤', '7', '9', '0', '1', '0', '0', '', '替你扛到家');
INSERT INTO `xn_tags` VALUES ('31', '今日特价', '0', '9', '0', '1', '0', '0', '', '新鲜果蔬');

-- ----------------------------
-- Table structure for `xn_upload_files`
-- ----------------------------
DROP TABLE IF EXISTS `xn_upload_files`;
CREATE TABLE `xn_upload_files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `storage` tinyint(1) DEFAULT '0' COMMENT '存储位置 0本地',
  `app` smallint(4) DEFAULT '0' COMMENT '来自应用 0前台 1后台',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '根据app类型判断用户类型',
  `file_name` varchar(100) DEFAULT '',
  `file_size` int(11) DEFAULT '0',
  `extension` varchar(10) DEFAULT '' COMMENT '文件后缀',
  `url` varchar(500) DEFAULT '' COMMENT '图片路径',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1253 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_upload_files
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user`;
CREATE TABLE `xn_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) DEFAULT '0',
  `username` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `open_id` varchar(125) DEFAULT '' COMMENT 'openid',
  `client_type` tinyint(1) DEFAULT '1' COMMENT '1pc端 2移动端 3安卓App 4IOSApp 5微信小程序',
  `is_daren` tinyint(1) DEFAULT '0' COMMENT '是否达人:1.达人 2申请中',
  `daren_id` int(10) DEFAULT '0' COMMENT '达人ID 邀请人',
  `unionid` varchar(120) DEFAULT '',
  `vip` int(10) DEFAULT '0' COMMENT 'vip',
  `vip_time` int(10) DEFAULT '0' COMMENT 'vipshijian',
  `daren_money` decimal(10,2) DEFAULT '0.00' COMMENT '达人推广总金额',
  `daren_renshu` int(10) DEFAULT '0' COMMENT '达人推广总金额',
  PRIMARY KEY (`id`),
  KEY `user_login` (`username`),
  KEY `user_nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=100000128 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of xn_user
-- ----------------------------
INSERT INTO `xn_user` VALUES ('1', '1', '15984344251', 'e10adc3949ba59abbe56e057f20f883e', '15984344255', '777777', '1', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLKW3scorVoIlLxwT4uZLJhz7R35oISGp0Kb94LGibgXrxtYLx0PcyFwWGphLqExpwATNT7tEpEsaA/132', '1615453709', '76', '17.00', '1615453709', '1', '', '这个用户很懒,什么也没留下...', '223.104.216.87', 'oimIN0XKWTFCeCktiD9295mxzL1U', '1', '1', '0', '', '1', '1658509312', '57.00', '0');

-- ----------------------------
-- Table structure for `xn_user_money_log`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_money_log`;
CREATE TABLE `xn_user_money_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `description` varchar(50) DEFAULT '' COMMENT '用户操作名称：订单完成，签到',
  `money` decimal(11,2) DEFAULT '0.00' COMMENT '更改积分，可以为负',
  `type` int(11) DEFAULT '0' COMMENT '0签到',
  `other_id` int(11) DEFAULT '0' COMMENT '积分商品ID',
  `money_yue` decimal(11,2) DEFAULT '0.00' COMMENT '更改积分，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of xn_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user_ping`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_ping`;
CREATE TABLE `xn_user_ping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unionid` varchar(120) DEFAULT '',
  `utoken` varchar(50) DEFAULT '' COMMENT 'uuid',
  `mtoken` varchar(50) DEFAULT '',
  `btoken` varchar(50) DEFAULT '',
  `nick_name` varchar(200) DEFAULT '',
  `user_name` varchar(100) DEFAULT '',
  `phone` varchar(15) DEFAULT '',
  `parent_phone` varchar(15) DEFAULT '' COMMENT '上级电话 ',
  `parent_utoken` varchar(50) DEFAULT '',
  `parent_id` int(10) DEFAULT '0',
  `level` tinyint(1) DEFAULT '1' COMMENT '1特困，2贫困，3一般困',
  `apply_time` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：1正常2禁用',
  `qrcode_arr` varchar(100) DEFAULT '' COMMENT '二维码',
  `remark` varchar(100) DEFAULT '' COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `created_time` datetime DEFAULT NULL,
  `maid_money` decimal(10,2) DEFAULT '0.00',
  `total_with_draw_money` decimal(10,2) DEFAULT '0.00' COMMENT '累计提现金额',
  `share_picture` varchar(200) DEFAULT '',
  `station_code` varchar(10) DEFAULT '0',
  `parent_station_code` varchar(10) DEFAULT '0',
  `card_id` varchar(20) DEFAULT '',
  `ping_age` int(10) DEFAULT '0' COMMENT '年龄',
  `ping_avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `family_population` int(10) DEFAULT '0' COMMENT '家庭人数',
  `poverty_attribute` varchar(50) DEFAULT '' COMMENT '贫困属性',
  `avg_income` decimal(10,2) DEFAULT '0.00' COMMENT '人均收入',
  `poverty_reason` varchar(100) DEFAULT '' COMMENT '贫困原因',
  `confirm_standard` varchar(20) DEFAULT '',
  `house_size` int(10) DEFAULT '0' COMMENT '人口数',
  `family_info` varchar(50) DEFAULT '',
  `family_images` varchar(255) DEFAULT '',
  `son_num` int(10) DEFAULT '0' COMMENT '下级个数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000102 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of xn_user_ping
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user_score_log`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_score_log`;
CREATE TABLE `xn_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `description` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称：订单完成，签到',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0签到',
  `other_id` int(11) DEFAULT '0' COMMENT '积分商品ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of xn_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user_sign`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_sign`;
CREATE TABLE `xn_user_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0',
  `last_sign_time` int(14) DEFAULT '0' COMMENT '最后签到时间',
  `total_day` int(11) DEFAULT '0' COMMENT '累计天数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=381 DEFAULT CHARSET=utf8 COMMENT='签到信息';

-- ----------------------------
-- Records of xn_user_sign
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user_sign_log`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_sign_log`;
CREATE TABLE `xn_user_sign_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0',
  `create_time` int(16) DEFAULT '0' COMMENT '最后签到时间',
  `day` varchar(5) DEFAULT '0' COMMENT '今日号数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=376 DEFAULT CHARSET=utf8 COMMENT='签到信息';

-- ----------------------------
-- Records of xn_user_sign_log
-- ----------------------------

-- ----------------------------
-- Table structure for `xn_user_withdraw`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_withdraw`;
CREATE TABLE `xn_user_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `money_total` decimal(10,2) DEFAULT '0.00' COMMENT '提现总金额',
  `money_daozhang` decimal(10,2) DEFAULT '0.00' COMMENT '实际到账金额',
  `money_shouxu` decimal(10,2) DEFAULT '0.00' COMMENT '手续费',
  `money_bili` decimal(10,2) DEFAULT '0.00' COMMENT '手续费比例',
  `status` tinyint(1) DEFAULT '0' COMMENT '0 提现中 ， 1提现成功',
  `create_time` int(14) DEFAULT '0' COMMENT '最后签到时间',
  `pay_time` int(14) DEFAULT '0' COMMENT '处理时间',
  `remark` varchar(50) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=386 DEFAULT CHARSET=utf8 COMMENT='提现记录';