/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50651
Source Host           : localhost:3306
Source Database       : quan_51duoke_cn

Target Server Type    : MYSQL
Target Server Version : 50651
File Encoding         : 65001

Date: 2022-09-26 14:30:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xn_active`
-- ----------------------------
DROP TABLE IF EXISTS `xn_active`;
CREATE TABLE `xn_active` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `detail` varchar(255) DEFAULT '' COMMENT '排序',
  `images` varchar(200) DEFAULT '',
  `times` varchar(20) DEFAULT '',
  `address` varchar(200) DEFAULT '',
  `user_id` int(10) DEFAULT '0',
  `lat` varchar(100) DEFAULT '',
  `lng` varchar(100) DEFAULT '',
  `join_num` int(10) DEFAULT '0',
  `view_num` int(10) DEFAULT '0',
  `create_time` int(10) DEFAULT '0',
  `is_sh` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1469 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_active
-- ----------------------------
INSERT INTO `xn_active` VALUES ('1467', '七夕情人节同城约会', '周末孤独一人不如来参加脱单派对\n朝九晚五的生活实在乏善可陈，\n于是我和小伙伴开始在这上面发起一些活动\n听一首老歌、读一本好书、遇到一个有趣的人\n想要认识有趣的人，先要加入一个有趣的圈子\n因为一个有趣的圈子，才会源源不断吸引有趣的人', '/uploads/1/file/20220920/de3532d35a3dc37490c6d214d390c8a9.jpg,/uploads/1/file/20220920/d33b93ac9febc41d6ec1c70f901e5bc0.png', '2022-09-29', '成都天府广场A座34号遇见酒吧', '1', '', '', '4', '21', '1663655358', '1');
INSERT INTO `xn_active` VALUES ('1468', '宠物交流会', '关于宠物的一起都来这里讨论吧', '/uploads/1/file/20220920/c6c01a45fc39950b72e97e7e586753e2.jpeg,/uploads/1/file/20220920/c6c01a45fc39950b72e97e7e586753e2.jpeg', '', '成都天府广场A座34号遇见酒吧', '1', '', '', '3', '15', '1663658485', '1');

-- ----------------------------
-- Table structure for `xn_active_join`
-- ----------------------------
DROP TABLE IF EXISTS `xn_active_join`;
CREATE TABLE `xn_active_join` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_active_join
-- ----------------------------
INSERT INTO `xn_active_join` VALUES ('15', '1', '1', '1663648725');
INSERT INTO `xn_active_join` VALUES ('16', '1467', '1', '1663655740');
INSERT INTO `xn_active_join` VALUES ('17', '1468', '1', '1663659921');
INSERT INTO `xn_active_join` VALUES ('18', '1468', '55', '1664079491');
INSERT INTO `xn_active_join` VALUES ('19', '1467', '55', '1664080982');
INSERT INTO `xn_active_join` VALUES ('20', '1468', '56', '1664084390');
INSERT INTO `xn_active_join` VALUES ('21', '1467', '56', '1664084395');
INSERT INTO `xn_active_join` VALUES ('22', '1467', '60', '1664084876');

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
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_adinfo
-- ----------------------------
INSERT INTO `xn_adinfo` VALUES ('39', '广告幻灯', '278', '/uploads/1/file/20220905/1ee98aedbc4b50e756efa5647fa2d3de.png', '1', '1', '1', '0', '1');
INSERT INTO `xn_adinfo` VALUES ('41', '活动幻灯', '1', '/uploads/1/file/20220912/483262b183422aa9d3b4504b54563c20.jpeg', '2', '2', '1', '0', '1');
INSERT INTO `xn_adinfo` VALUES ('42', '活动那个2', '', '/uploads/1/file/20220920/f482027a1775d103c324103948bf43d2.jpg', '2', '3', '1', '0', '1');
INSERT INTO `xn_adinfo` VALUES ('43', '首页光阿公', '', '/uploads/1/file/20220921/69cb53d22b693b8a0070983368c1de66.jpg', '1', '4', '1', '0', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_admin
-- ----------------------------
INSERT INTO `xn_admin` VALUES ('1', 'admin', '0df250f0b09b7562f80b4a1f0400a598', '', '', null, null, '1', '1661932693', '183.223.233.4', '1661932693', null, '10', '', '', '', '', '', '', '', '', null, null, null, '0', '0', '0.00', '', '', '0', '0', '0', '0');
INSERT INTO `xn_admin` VALUES ('25', 'demo', '24092a0430d6d1e80964820a1de4807b', '', '', null, null, '1', '0', '', '0', null, '10', '', '', '', '', '', '', '', '', null, null, null, '0', '0', '0.00', '', '', '0', '0', '0', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=2059 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_admin_log
-- ----------------------------
INSERT INTO `xn_admin_log` VALUES ('2050', '1', 'http://quan.51duoke.cn/admin/AdminLog/clear.html', '清除日志', '183.222.247.12', '1663899530', 'GET', '[]');
INSERT INTO `xn_admin_log` VALUES ('2051', '1', 'https://quan.51duoke.cn/admin/login/index.html', '后台登录', '183.222.247.12', '1663920937', 'POST', '{\"username\":\"admin\",\"password\":\"6192652\",\"vercode\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2052', '1', 'https://quan.51duoke.cn/admin/login/index.html', '后台登录', '183.222.247.12', '1663988850', 'POST', '{\"username\":\"admin\",\"password\":\"6192652\",\"vercode\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2053', '1', 'http://quan.51duoke.cn/admin/login/index.html', '后台登录', '223.87.75.167', '1664080812', 'POST', '{\"username\":\"admin\",\"password\":\"6192652\",\"vercode\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2054', '1', 'http://quan.51duoke.cn/admin/Category/delete.html?id=1500', '删除圈子', '223.87.75.167', '1664080945', 'GET', '{\"id\":\"1500\"}');
INSERT INTO `xn_admin_log` VALUES ('2055', '1', 'http://quan.51duoke.cn/admin/login/index.html', '后台登录', '182.132.193.144', '1664114496', 'POST', '{\"username\":\"admin\",\"password\":\"6192652\",\"vercode\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2056', '1', 'http://quan.51duoke.cn/admin/Auth/add.html?pid=36', '添加权限节点', '182.132.193.144', '1664114632', 'POST', '{\"pid\":\"36\",\"title\":\"\\u4e3e\\u62a5\\u7ba1\\u7406\",\"name\":\"admin\\/report\\/index\",\"is_menu\":\"1\",\"is_curd\":\"1\",\"icon\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2057', '1', 'http://quan.51duoke.cn/admin/login/index.html', '后台登录', '223.87.75.167', '1664157588', 'POST', '{\"username\":\"admin\",\"password\":\"6192652\",\"vercode\":\"\"}');
INSERT INTO `xn_admin_log` VALUES ('2058', '1', 'http://quan.51duoke.cn/admin/Auth/edit.html', '编辑权限节点', '223.87.75.167', '1664166921', 'POST', '{\"id\":\"134\",\"is_menu\":\"0\"}');

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
INSERT INTO `xn_auth_group` VALUES ('1', '超级管理员', '1', '2,2,3,4,5,14,14,15,15,1,6,7,8,9,10,11,12,13,18,18,19,20,20,24,25,26,27,89,90,65,66,67,68,69,88,91,55,56,96,21,21,16,17,22,32,32,84,85,36,36,37,78,79,86,57,57,58,59,60,73,92,92,94,61,93,95,81,81,82,83,87,97,97,98,99');
INSERT INTO `xn_auth_group` VALUES ('2', '一般管理员', '1', '15,15,6,10,18,20,20,65,96,21,21,16,17,22,36,36,101,102,57,57,73,106,103,103,104,105,105,24,88');

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
INSERT INTO `xn_auth_group_access` VALUES ('25', '2');

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
) ENGINE=MyISAM AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of xn_auth_rule
-- ----------------------------
INSERT INTO `xn_auth_rule` VALUES ('101', '36', 'admin/goods/index', '帖子列表', '1', '1', '', '1', '999', '', '', '');
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
INSERT INTO `xn_auth_rule` VALUES ('18', '15', 'admin/upload_files/index', '上传管理', '1', '1', '', '1', '5', 'layui-icon-picture', '', '');
INSERT INTO `xn_auth_rule` VALUES ('19', '18', 'admin/upload_files/delete', '删除文件', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('20', '0', '', '站点设置', '1', '1', '', '1', '6', 'layui-icon-face-surprised', '', '');
INSERT INTO `xn_auth_rule` VALUES ('21', '0', 'admin/config/index', '配置管理', '1', '1', '', '1', '3', 'layui-icon-set', '', '');
INSERT INTO `xn_auth_rule` VALUES ('22', '21', 'admin/AdminLog/index', '日志管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('24', '105', 'admin/category/index', '圈子列表', '1', '1', '', '1', '2', 'layui-icon-note', '', '');
INSERT INTO `xn_auth_rule` VALUES ('25', '24', 'admin/category/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('26', '24', 'admin/category/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('27', '24', 'admin/category/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('118', '102', 'admin/active/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('90', '89', 'admin/mini/news', '滚动新闻', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('89', '20', 'admin/mini/setting', '首页管理', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('36', '0', 'admin/goods/index', '帖子管理', '1', '1', '', '1', '11', 'layui-icon-cart', '', '');
INSERT INTO `xn_auth_rule` VALUES ('102', '36', 'admin/active/index', '活动管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('55', '20', 'admin/test/index', '演示demo', '1', '0', '', '1', '999', 'layui-icon-template-1', '', '');
INSERT INTO `xn_auth_rule` VALUES ('56', '20', 'admin/admin/info', '基本设置', '1', '0', '', '1', '1', 'layui-icon-template-1', '', '');
INSERT INTO `xn_auth_rule` VALUES ('57', '0', 'admin/user/index', '会员管理', '1', '1', '', '1', '7', 'layui-icon-username', '', '');
INSERT INTO `xn_auth_rule` VALUES ('58', '57', 'admin/user/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('59', '57', 'admin/user/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('60', '57', 'admin/user/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('113', '104', 'admin/message/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('65', '20', 'admin/adinfo/index', '广告管理', '1', '1', '', '1', '5', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('66', '65', 'admin/adinfo/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('67', '65', 'admin/adinfo/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('68', '65', 'admin/adinfo/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('69', '89', 'admin/active/index', '首页活动', '1', '0', '', '1', '6', 'layui-icon-dollar', '', '');
INSERT INTO `xn_auth_rule` VALUES ('73', '57', 'admin/user/index', '会员列表', '1', '1', '', '1', '777', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('103', '0', 'admin/message/index', '消息管理', '1', '1', '', '1', '999', 'layui-icon-speaker', '', '');
INSERT INTO `xn_auth_rule` VALUES ('104', '103', 'admin/message/index', '消息列表', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('105', '0', 'admin/quanzi/index', '圈子管理', '1', '1', '', '1', '6', 'layui-icon-at', '', '');
INSERT INTO `xn_auth_rule` VALUES ('106', '57', 'admin/medal/index', '勋章管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('107', '88', 'admin/tags/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('108', '88', 'admin/tags/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('109', '88', 'admin/tags/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('110', '101', 'admin/goods/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('111', '101', 'admin/goods/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('112', '101', 'admin/goods/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('88', '105', 'admin/tags/index', '话题管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('91', '89', 'admin/mini/tags', '首页标签', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('114', '104', 'admin/message/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('96', '20', 'admin/pages/index', '单页管理', '1', '1', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('115', '104', 'admin/message/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('116', '102', 'admin/active/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('117', '102', 'admin/active/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('119', '106', 'admin/medal/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('120', '106', 'admin/medal/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('121', '106', 'admin/medal/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('122', '96', 'admin/pages/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('123', '96', 'admin/pages/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('124', '96', 'admin/pages/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('125', '16', 'admin/config/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('126', '16', 'admin/config/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('127', '16', 'admin/config/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('128', '17', 'admin/config/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('129', '17', 'admin/config/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('130', '17', 'admin/config/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('131', '22', 'admin/AdminLog/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('132', '22', 'admin/AdminLog/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('133', '22', 'admin/AdminLog/delete', '删除', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('134', '36', 'admin/report/index', '举报管理', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('135', '134', 'admin/report/add', '添加', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('136', '134', 'admin/report/edit', '编辑', '1', '0', '', '1', '999', '', '', '');
INSERT INTO `xn_auth_rule` VALUES ('137', '134', 'admin/report/delete', '删除', '1', '0', '', '1', '999', '', '', '');

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
-- Table structure for `xn_category`
-- ----------------------------
DROP TABLE IF EXISTS `xn_category`;
CREATE TABLE `xn_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `title_sub` varchar(250) DEFAULT '',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像，相对于upload/avatar目录',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '1' COMMENT '管理员ID',
  `fid` int(10) DEFAULT '0' COMMENT '父级ID',
  `banner` varchar(255) DEFAULT '' COMMENT '幻灯',
  `follow_num` int(10) DEFAULT '0',
  `is_tui` tinyint(1) DEFAULT '0',
  `is_sh` tinyint(1) DEFAULT '0',
  `goods_num` int(10) DEFAULT '0',
  `hot` int(10) DEFAULT '3264',
  `bg` varchar(255) DEFAULT '' COMMENT '6',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_category
-- ----------------------------
INSERT INTO `xn_category` VALUES ('1294', '交友恋爱', '灵魂伴侣你再哪？我是么么哒', '/uploads/1/file/20220910/881161a96e976c06e9612eadcd0272c5.jpg', '11', '1', '1641282534', '1', '0', '/uploads/1/file/20220912/1d5512069768eccebc92acff67a56d10.jpg', '0', '1', '1', '0', '3379', '1');
INSERT INTO `xn_category` VALUES ('1295', '女M聚集', '妹妹专属领地，哥哥不要来', '/uploads/1/file/20220910/bc1d2bca22443d10f38bf9f6582fcfc0.jpg', '23', '1', '1641282534', '1', '0', '/uploads/1/file/20220912/b00b341eb4fcf41028436c2d35842bae.jpg', '2', '1', '1', '0', '3309', '1');
INSERT INTO `xn_category` VALUES ('1462', '游戏专区', 'LOL、王者荣耀【越菜瘾越大】', '/uploads/1/file/20220912/f629131c3085c93b8879f9a5169de877.jpeg', '3', '1', '1641282534', '1', '0', '/uploads/1/file/20220912/483262b183422aa9d3b4504b54563c20.jpeg', '0', '1', '1', '0', '3272', '1');
INSERT INTO `xn_category` VALUES ('1309', '全日小酒馆', '我有酒你有故事吗？', '/uploads/1/file/20220912/cda6d5cc6324a8a6051665d0d6ebf805.jpg', '4', '1', '1641282534', '1', '0', '/uploads/1/file/20220912/c9c3492428699450f89b9e700f9c0d23.jpg', '1', '1', '1', '0', '3269', '1');
INSERT INTO `xn_category` VALUES ('1310', '沙雕乐趣多', '做一个沙雕，快乐天天有', '/uploads/1/file/20220912/3b4bf520267658f5f4988933582e13e0.jpg', '28', '1', '1641282534', '1', '0', '/uploads/1/file/20220912/1d5512069768eccebc92acff67a56d10.jpg', '1', '1', '1', '0', '3279', '1');
INSERT INTO `xn_category` VALUES ('1498', '健身俱乐部', '想健身的一起来搜起来啊', '/uploads/1/file/20220920/fbc34ec6867f5286ba4730102e9d0e80.jpeg', '0', '1', '1663659132', '1', '0', '/uploads/1/file/20220920/9750a3f83821f2f88edb8b6e6bce1173.jpg', '4', '1', '1', '0', '3359', '1');
INSERT INTO `xn_category` VALUES ('1497', '宠物之家', '关于宠物的一切东西都在这里', '/uploads/1/file/20220920/0b18d0dac2d89b01d0d678915b86bb3d.jpeg', '0', '1', '1663658802', '1', '0', '/uploads/1/file/20220920/a5f944a739ecb5c3499cda60a967e6e3.jpg', '0', '1', '1', '0', '3272', '1');
INSERT INTO `xn_category` VALUES ('1499', '动漫二次元', '喜欢二次元的一切，人和画', '/uploads/1/file/20220920/69c10d790b7b86c347576e628a0993f3.jpeg', '0', '1', '1663659192', '1', '0', '', '2', '1', '1', '0', '3313', '1');

-- ----------------------------
-- Table structure for `xn_category_follow`
-- ----------------------------
DROP TABLE IF EXISTS `xn_category_follow`;
CREATE TABLE `xn_category_follow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `cate_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `is_manage` tinyint(1) DEFAULT '0',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_category_follow
-- ----------------------------
INSERT INTO `xn_category_follow` VALUES ('20', '1', '1310', '1', '1663213892');
INSERT INTO `xn_category_follow` VALUES ('21', '1', '1295', '1', '1663373334');
INSERT INTO `xn_category_follow` VALUES ('26', '1', '1', '1', '1663648420');
INSERT INTO `xn_category_follow` VALUES ('27', '1', '1309', '1', '1663657461');
INSERT INTO `xn_category_follow` VALUES ('29', '1', '1498', '0', '1663839795');
INSERT INTO `xn_category_follow` VALUES ('31', '50', '1498', '1', '1663990664');
INSERT INTO `xn_category_follow` VALUES ('32', '2', '1498', '0', '1663993804');
INSERT INTO `xn_category_follow` VALUES ('33', '55', '1498', '0', '1664067595');
INSERT INTO `xn_category_follow` VALUES ('34', '55', '1295', '0', '1664067620');
INSERT INTO `xn_category_follow` VALUES ('36', '50', '1499', '0', '1664080591');
INSERT INTO `xn_category_follow` VALUES ('37', '67', '1499', '0', '1664091583');

-- ----------------------------
-- Table structure for `xn_goods`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods`;
CREATE TABLE `xn_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `images` text COMMENT '多图',
  `tags_ids` varchar(255) DEFAULT '',
  `user_id` int(10) DEFAULT '0',
  `cate_id` int(10) DEFAULT '0' COMMENT 'quanzi ',
  `like_num` int(10) DEFAULT '0',
  `ping_num` int(10) DEFAULT '0',
  `view_num` int(10) DEFAULT '0',
  `is_tuijian` tinyint(1) DEFAULT '0',
  `is_ding` tinyint(1) DEFAULT '0',
  `is_sh` tinyint(1) DEFAULT '1',
  `content` longtext CHARACTER SET utf8mb4 COMMENT '详情',
  `update_time` int(14) DEFAULT '0' COMMENT '修改时间',
  `create_time` int(14) DEFAULT '0' COMMENT '申请时间',
  `delete_time` int(10) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=297 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of xn_goods
-- ----------------------------
INSERT INTO `xn_goods` VALUES ('278', '/uploads/1/file/20220919/a47c8d872993fb2df1983c6fbae2bf7b.jpg', ',25,', '1', '1295', '1', '7', '192', '1', '1', '1', '出身年:2002\r\n目前所在城市:河南\r\n生肖:马\r\n星座:狮子座\r\n身高:165\r\n学历:大专\r\n职业:美容\r\n爱好:追剧\r\n自我介绍:有自己的事业，买的有车\r\n交友要求:有上进心努力赚钱', '1663657285', '1663579468', '0');
INSERT INTO `xn_goods` VALUES ('281', '/uploads/1/file/20220922/5927e61296002a7152340c9c88fdee36.jpg,/uploads/1/file/20220922/3d3d7c51ca0705a0f22846137feb8708.jpg,/uploads/1/file/20220922/19d7313e14863b18b4e344d915447d57.jpg,/uploads/1/file/20220922/a244daa5dfb114b90bb736727a1206af.jpg', ',25,', '2', '1295', '1', '11', '61', '0', '0', '1', '职场打工人办公室的报恩下午茶来了‼️\r\n（*感谢朝日唯品提供的产品品尝，真诚分享～）\r\n\r\n姜姜作为投行打工人\r\n\r\n平时在办公室没日没夜的开会加班都是常态\r\n\r\n工作压力大的时候真滴会突然就hin馋零食\r\n\r\n忙起来也会顾不上吃饭\r\n\r\n下午可能就随便吃个饼干蛋糕对付了\r\n\r\n⚠️其实上面这些习惯\r\n\r\n都❌hin不健康！\r\n\r\n跟我一样的集美可要注意了\r\n\r\n你可能跟我一样也离「过劳肥」不远了??‍♂️\r\n\r\n·\r\n\r\n然而打工人可不能亏待自己呀\r\n\r\n在忙再累总不能饿着吧‼️\r\n\r\n我终于找到了适合上班族囤在办公室的报恩零食了??\r\n\r\n自从把办公室下午茶换成这个小酪乳轻食小方杯', '0', '1663829088', '0');
INSERT INTO `xn_goods` VALUES ('282', '/uploads/1/file/20220922/1c6e2911b6483ac8873c90a028e9d317.jpg,/uploads/1/file/20220922/744fe1d64ca7f0a6e3b5d4eb536b4d0e.jpg,/uploads/1/file/20220922/fc78af79d93c7673653c805d0ff850d3.jpg,/uploads/1/file/20220922/4f0b43e797cd2db90b45ddde37a4d653.jpg,/uploads/1/file/20220922/f197d90cb3eebdb54bfd51052a1be728.jpg', ',25,26,31,', '3', '1294', '0', '0', '0', '0', '0', '1', '宝宝英语启蒙装备，轻松阅读不费妈❗️\r\n虽然从小我们就有安排上早教，但是毕竟每周去的频率有限，尤其是在英语启蒙上，感觉宝宝学习掌握的词汇量和句子还是很有限，于是我就总想着在家给他磨耳朵?，比如说可以让娃爱上英语阅读的点读笔！\r\n\r\n.\r\n\r\n之所以给他选小怪兽点读笔，最主要为了让他刷原版红火箭分级阅读系列，这套分级绘本比较适合0⃣️基础的孩子，主要是从26个字母入手，相对来说比较实用也易接受！[清单R]像我都是每天在固定时间段给布丁树立一个“英语时间”，每天读完当天的任务会给他一个小奖励，比如说一个帖纸或者一个兑换币，就有点类似于很多机构的打卡换贴纸一样，集齐多少个贴纸就可以兑换个小礼物?！而且这款点读笔的音质很不错，发音也很标准，所以每天读的时候我都尽量让孩子自己使用点读笔去听读和写，基本一本书2-3遍就可以完全掌握了！先从紫色刷起，然后慢慢过渡到粉色和红色！\r\n\r\n.\r\n\r\n老实说我还是第一次见到能支持这么多绘本的点读笔，这款3.0盖世小怪兽点读笔能支持红火箭、babyall、甜心、脏脏书等等等盖世家的绘本，可点读绘本1000+，全买回来的话真的2个书架都放不下！配套840张录音贴+840张音频贴，自制点读贴，可以扩展阅读绘本范围，而且笔在闲置状态时，可以自动下载在线点读过的点读包，不需要时可以删除资源包，节省内存，这点还是蛮方便的！\r\n\r\n.\r\n\r\n平时不点读的时候，也可以用来当英语故事机来磨耳朵?，目前来看布丁还是蛮喜欢自己用点读笔阅读的呢！也想在家给娃磨耳朵的宝妈不妨按我上面说的方法试试看吧！', '0', '1663829447', '0');
INSERT INTO `xn_goods` VALUES ('283', '/uploads/1/file/20220922/f2a979afb9287a1f62c35f00430ccf6c.jpg,/uploads/1/file/20220922/d1e96535edc948c0c541b550d1aecf1d.jpg,/uploads/1/file/20220922/dc9833ef0ac96abf028e89fb7dce8031.jpg,/uploads/1/file/20220922/779c141932c62c1a206d15504f51d65d.jpg', ',25,28,31,', '4', '1294', '0', '0', '2', '0', '0', '1', '体重两位数的就别吃了！给胖子留条活路吧！\r\n真的不是智商税姐妹们！\r\n\r\n跟我一样管不住嘴，还迈不开腿的?\r\n\r\n真的可以试试这个丝蓓缇的3倍分解酵母\r\n\r\n我试过了，贼有用！\r\n\r\n（也不排除我是什么天选体质哈）\r\n\r\n就是很简单！火锅前吃两粒\r\n\r\n第二天早起上称基本没⬆称！真的很满意了！！\r\n\r\n不过我不是天天吃\r\n\r\n就是偶尔大餐前吃一下～\r\n\r\n-\r\n\r\n成分我也看过，主要是：\r\n\r\n✔酵母（分解糖分的）\r\n\r\n✔白芸豆提取物（抑制淀粉的）\r\n\r\n还有✔壳聚糖（阻断油脂的）\r\n\r\n看起来真是想长肉都难hhh\r\n\r\n而且很多女明星都分享过，口碑也信得过！\r\n\r\n-\r\n\r\n我现在可以说是走到哪就带到哪\r\n\r\n以防万一！！\r\n\r\n咱就是说终于实现干饭自由了！\r\n\r\n本身就吃不胖的姐妹就别整了\r\n\r\n把机会留给我们这种喝水都能胖的吧！\r\n\r\n*产品从跨境电商渠道购入', '0', '1663829553', '0');
INSERT INTO `xn_goods` VALUES ('284', '/uploads/1/file/20220922/db9aafd5e63ab3cf411dde24943cb408.jpg,/uploads/1/file/20220922/ea8c4e89aba2b81bf83b77c1ea0a0787.jpg,/uploads/1/file/20220922/f6608b50803a3a0bb7d206879684924e.jpg,/uploads/1/file/20220922/f9148081493f1d2791150c318161b4d1.jpg,/uploads/1/file/20220922/67bbb6f168f052c136cd5f162030830f.jpg,/uploads/1/file/20220922/96277a9fe3c5e16b86ee5304539ebc01.jpg', ',25,28,31,', '5', '1497', '0', '15', '104', '1', '0', '1', '粉嫩宝贝护肤指南 | 育婴师全套干货整理！\r\n人们常用婴儿肌来形容一个人皮肤好，通常宝宝皮肤含水量比成人要高，摸起来确实是水嫩Q弹，但是应对气温变化大，自身修护能力不是很强，特别是换季期间就更需要加倍的呵护！\r\n\r\n我总结了夏秋换季宝宝容易出现的皮肤问题，从症状判断，护理流程和如何选护肤品这几个方面出发，助力宝妈省心又安心呵护宝贝成长！\r\n\r\n.\r\n\r\n天气热出汗多，这几种常见的皮肤问题要注意起来，详细的症状判断可以看图：\r\n\r\n?皮肤干痒，?热红点?晒后修护?红屁屁\r\n\r\n.\r\n\r\n常见皮肤问题护理步骤：\r\n\r\n➡️皮肤干痒：清水洗澡?→浴巾擦干→涂护肤膏→穿棉质衣物\r\n\r\n➡️热红点：金银花水洗澡?→浴巾擦干→涂桃子水→穿棉质衣物\r\n\r\n➡️晒后修护→温水洗澡→毛巾擦干→涂芦荟凝胶→穿棉质衣物\r\n\r\n➡️红屁屁→温水洗澡→湿巾清理→涂护臀膏→穿纸尿裤\r\n\r\n.\r\n\r\n我家宝宝还是挺怕热的，尤其是夏天，太阳一晒就会脸红噗噗的，如果不及时舒缓降温，就会痒痒的想挠，更严重一点就会干痒起皮，所以我早早就给她准备了寻荟记的儿童芦荟胶和儿童桃子水，外出的时候都会带上。\r\n\r\n他们家是有自己的种植基地的，成分上很安心，宝宝在太阳下面玩一会就给她涂抹芦荟胶，满满一瓶的芦荟原液，上脸凉凉的好舒服，跟果冻一样，涂抹以后很快就化成水珠，我家宝宝超爱！还有在草丛里面被蚊子咬的包包也可以涂，一瓶多用。\r\n\r\n桃子水可以给宝宝涂抹全身，特别是身上喜欢出红点点的地方可以多涂几遍，很清爽不黏腻，涂抹以后很快就吸收了，不用担心粘上衣服，它里面有新鲜的芦荟叶水和桃叶提取物，舒缓退红的效果很不错，晚上洗澡后涂抹效果更好~\r\n\r\n这个夏天有它俩，真是爱动宝宝的出游好帮手！妈妈们再也不用担心挑花了眼，手忙脚乱啦！', '1663900384', '1663829679', '0');
INSERT INTO `xn_goods` VALUES ('285', '/uploads/1/file/20220922/7c8562f9db34062468d74793a115d8ee.jpg,/uploads/1/file/20220922/9bd3bb6ea003fd763a2b133a12b481ad.jpg,/uploads/1/file/20220922/0d4f19440d0e293d42a02a4b7784570d.jpg,/uploads/1/file/20220922/792478682afe887fb41ae06d2da9464c.jpg,/uploads/1/file/20220922/0af81e0d12f665cc63eb412a57bc71be.jpg', ',25,26,31,', '6', '1309', '0', '0', '1', '0', '1', '1', '请大数据推给爱喝生椰拿铁的姐妹们！\r\n咱奶茶店姐妹给我推荐的厚椰乳！！！\r\n\r\n贼小！炫着椰香味贼浓！还有点厚的奶香味！\r\n\r\n??随便来个乌龙茶和咖啡跟它搭配绝啦！\r\n\r\n入口贼顺滑～直接溜进喉咙里！满嘴椰咖啡香～\r\n\r\n真的好鲜鲜鲜！我愿称之为清醒三件套！！', '1663900381', '1663829951', '0');
INSERT INTO `xn_goods` VALUES ('286', '/uploads/1/file/20220922/1d9e301bb6191d9c7a8e25f0de55730a.jpg,/uploads/1/file/20220922/0abb1a28b332b1ffb68629350711a119.jpg,/uploads/1/file/20220922/50cd9509d5569d8d16d871409fa7e495.jpg,/uploads/1/file/20220922/162117b9713c39f367ed8335c47519d4.jpg,/uploads/1/file/20220922/9b4cdfc995f62b5c356b862eeab7ca32.jpg,/uploads/1/file/20220922/d5b31662ee83d74e97cef723c7f93779.jpg', ',25,28,31,', '7', '1309', '0', '2', '9', '1', '0', '1', '啤酒?小龙虾?，带来秋天第一场聚餐的快乐\r\n???\r\n\r\n夏日渐远，秋意渐浓……\r\n\r\n???\r\n\r\n一周忙碌的工作，身心很是疲惫。想着这个周末，喊几个脾气相投的好朋友来家小聚，做些好吃的，大家放松放松~~\r\n\r\n???\r\n\r\n我和我的朋友们，都是食肉动物，无肉不欢~就这样，我家大厨做上满满一大盆爆椒小龙虾，梅菜扣肉，青椒莲藕爆玉米仁，萝卜干爆炒猪油渣，那香味儿都飘进了客厅……\r\n\r\n???\r\n\r\n小龙虾和啤酒是绝配。今天聚餐安排上的是加拿大的魔书啤酒，昨晚就提前放冰箱冷藏了！\r\n\r\n???\r\n\r\n随着啤酒瓶盖子打开，清澈的酒液像丰收时的稻谷色。丰富、细腻、绵密的白色啤酒花，挂杯经久不消。倒出啤酒液的瞬间，大家同时都闻到了烘焙面包时的芬芳。\r\n\r\n???\r\n\r\n一起碰杯，共饮上一大口，哇，冰镇后的啤酒，一丝凉意，携带着芬芳，顺喉而下，直达胃部，那感觉就一个字，爽！\r\n\r\n???\r\n\r\n大口吃上一片扣肉，再剥上一只肥美够劲辣的小龙虾，哇哈哈~美好的周末聚餐开动……', '1663900383', '1663830037', '0');
INSERT INTO `xn_goods` VALUES ('287', '/uploads/1/file/20220922/d87094f4116df873e22c7a7f00d68628.jpg,/uploads/1/file/20220922/3d866318653c92c3747e1a23a977425d.jpg,/uploads/1/file/20220922/eb7a59fa25a8697664492a22ce0c5309.jpg,/uploads/1/file/20220922/cb656fbcbc3fef47e097e30e93bcb018.jpg,/uploads/1/file/20220922/894fb4567a52d821a09345705d92efed.jpg,/uploads/1/file/20220922/48a65e384ecba59de037e722f3dfa7f1.jpg', ',25,30,31,', '8', '1309', '1', '1', '4', '1', '0', '1', '❤️与我的8岁小闺蜜一起｜享受心动下午茶☕️\r\n很多妈妈问，二胎应该怎么照顾大娃的情绪。其实在生二宝之前，我也有过这样的顾虑，但是直到老三来了我就明白，其实这些的关键还是在于父母能不能给到孩子足够的爱跟良好的家庭氛围～\r\n\r\n.\r\n\r\n像我们家，除了平常的相处，我还会专门的留出周末的时间，跟姐姐一起玩耍，陪她聊聊天，了解孩子在学校跟生活中的一些趣事，所以即使有了三娃，姐姐不仅没有被冷落，还跟我的关系更加的亲密～\r\n\r\n.\r\n\r\n说到每个周末的闺蜜时光，就不得不提我们母女的“闺蜜”下午茶聚会啦，带上姐姐喜欢的奥利奥，就可以开始啦！\r\n\r\n先是奥利奥的经典吃法，扭一扭，舔一舔，泡一泡~三步下来，就能尝到奥利奥的美味，以前就很爱吃原味，后面发现巧克力夹心味的奥利奥比原味多了一份浓郁的可可味，这简直让我这个可可控爱不释手～\r\n\r\n.\r\n\r\n最近我又嗑上了恋综天花板《心动的信号5》，里面女嘉宾们一起用奥利奥做闺蜜下午茶的场景也让我心动不已，下周就准备带姐姐一起DIY一份奥利奥闺蜜下午茶☕️，尽情享受只属于我们母女俩的“心动闺蜜下午茶”～\r\n\r\n.\r\n\r\n当然聚会除了吃，怎么玩也非常重要！选择奥利奥也是因为她太好玩了！我经常就会在家陪姐姐一起玩奥利奥五子棋的游戏：奥利奥为棋子，巧脆卷当格子，锻炼孩子的思维能力的同时，还能把“吃到”的奥利奥吃进肚子，一举两得，还好奥利奥的好吃又不腻，不然我这个“棋圣”可得吃撑了!玩完还能把巧脆卷吃掉，又酥又脆～\r\n\r\n.\r\n\r\n提起巧脆卷就不得不说这也是我和宝宝的心头爱，松脆的外皮配上柔滑的夹心，整根巧脆卷都充满着香草的馥郁味道，口口都是咔嚓咔嚓的松脆感，好吃又解压！一口咔嚓巧脆卷，根本停不下来~\r\n\r\n.\r\n\r\n虽然生了三娃之后，确实不能像以前一样只宠爱姐姐一个人，但是我跟爸爸还是有竭尽全部告诉姐姐，无论有没有弟弟们，爸妈依然都会很爱她～', '1663900382', '1663830159', '0');
INSERT INTO `xn_goods` VALUES ('288', '/uploads/1/file/20220922/018776d9e9838bf9bf48b59246bec110.jpg,/uploads/1/file/20220922/dcb7cc67d171c1e19d77d203305a2ca1.jpg,/uploads/1/file/20220922/be981413b04c8f75dfb310745e0a72ff.jpg', ',25,30,31,', '9', '1294', '0', '0', '0', '0', '1', '1', '请大数据推送给要备孕的姐妹！后悔吃晚了?\r\n大家都知道怀孕的时候要补充DHA\r\n\r\n对宝宝的大脑发育有好处\r\n\r\n孕期大部分人孕反都蛮大的?\r\n\r\n很多味大的东西根本吃不下\r\n\r\n尤其是市面上很多DHA都是鱼油的，那味真的太难受了?\r\n\r\n-\r\n\r\n在这里给大家安利?港版惠氏玛特纳藻油DHA！\r\n\r\n这款DHA用的是藻油，是从大西洋深海海藻提取的\r\n\r\n不含鱼油，所以划重点！没有任何鱼腥味！?️\r\n\r\n而且它的颗粒比一般的DHA要小很多，滑溜溜的很好吞咽\r\n\r\n孕反严重的麻麻也可以放心冲！\r\n\r\n-\r\n\r\n每粒胶囊都含有200mgDHA?\r\n\r\n一天一粒，补足孕期每日推荐摄入量\r\n\r\n帮助宝宝大脑发育，促进视网膜光感细胞的成熟\r\n\r\n麻麻早吃，宝宝早补，说得一点错都没有‍️??\r\n\r\n-\r\n\r\n更关键的是\r\n\r\n惠氏这个DHA的胶皮完全不含明胶\r\n\r\n而是采用藻胶胶皮\r\n\r\n从根源上跟重金属残留说拜拜\r\n\r\n成分党麻麻也给我冲！！\r\n\r\n-\r\n\r\n给孕妈和宝宝的东西都需要特别谨慎\r\n\r\n惠氏是百年大品牌啦，背书这一块没话说\r\n\r\n可以信得过?\r\n\r\n-\r\n\r\n毕竟是整个孕期都要吃的\r\n\r\n所以孕妈们，一定要选对补对！\r\n\r\n妈妈吃起来安心，宝宝也可以轻松躺赢～\r\n\r\n*产品通过跨境电商渠道购入', '1663900380', '1663830283', '0');
INSERT INTO `xn_goods` VALUES ('289', '/uploads/1/file/20220922/6d0d3272cf6fd1bd0599473a114ed73a.jpg,/uploads/1/file/20220922/affca43f272c8ffbac3faeddf9ee178c.jpg,/uploads/1/file/20220922/fe51aed603710e8b8a88cc822376214c.jpg,/uploads/1/file/20220922/655f960900681139b938de7fe465937e.jpg,/uploads/1/file/20220922/9f0e7725bb56c286cc5a73cd5ffdf428.jpg,/uploads/1/file/20220922/94b0a745b65d0716a5c6ea499f913249.jpg', ',25,28,31,', '10', '1309', '1', '0', '11', '1', '0', '1', '5g入秋的简约氛围感穿搭｜你爱哪个风格？\r\n北京早已有了初秋的气息，时髦精各种风格的衣服早就备好了！依旧是简约大气又耐看的经典款穿搭，轻松打造了不同的氛围和风格\r\n\r\n都来自我最近发现质量优质性价比超高-诚衣乐服，作为经典质感款玩家简直买到停不下来！\r\n\r\nLook1⃣️休闲风\r\n\r\n没有咖色的秋天不完整，是焦糖拿铁般的浓郁和洋气\r\n\r\n宽松的卫衣给足了温暖和氛围感，搭配灯芯绒的直筒长裙和贝雷帽\r\n\r\n时髦随性的街头少女感\r\n\r\nLook2⃣️简约浪漫风\r\n\r\n简单的针织和百褶长裙可能是早秋关于浪漫最好的诠释，针织开衫作为最百搭的单品，搭配起来更是无限可能。配上淡粉的碎花裙和礼帽，灵动舒适的女孩没错了\r\n\r\nAll from @诚衣乐服\r\n\r\n你们更爱我哪种风格？', '1663900384', '1663830567', '0');
INSERT INTO `xn_goods` VALUES ('290', '/uploads/1/file/20220922/f6c50894709ed4915b1dfb4c8f07e854.jpg,/uploads/1/file/20220922/8b082cf1d06d1f7cc3e3e40d6cc0ce36.jpg,/uploads/1/file/20220922/82c3cdfe4bdc27449c86286df99176f0.jpg,/uploads/1/file/20220922/d706a3c1c307bbab5ed984773b0f468a.jpg,/uploads/1/file/20220922/327ae113c70ce120efbf8277d0fd3388.jpg,/uploads/1/file/20220922/3bb39493eaeb3143765359fb8d40f79e.jpg', ',25,28,31,', '11', '1310', '2', '14', '144', '1', '1', '1', 'uu们?没想到这保暖衣这么好穿！穿上和没穿一样！！\r\n.\r\n\r\n前两天下了一场不太解渴的雨\r\n\r\n直接导致气温速降！！短袖都有点穿不住了\r\n\r\n火速去做肌底衣功课\r\n\r\n满足我的诉求☑️不会起球☑️穿着保暖舒适\r\n\r\n这个ubras肌底衣我要封神了\r\n\r\n咱就是说安全下车了！！\r\n\r\n到手就是一整个惊艳！\r\n\r\n.\r\n\r\n软糯糯的亲肤感把我折服了\r\n\r\n差点以为被棉花糖包裹了！\r\n\r\n我之前皮肤敏感抗拒穿打底衣\r\n\r\n有一半原因就是穿久了会痒，起静电\r\n\r\n这个面料里面加入了氨基酸\r\n\r\n像给皮肤贴面膜一样\r\n\r\n一整个沙漠干柴皮?大救星\r\n\r\n比普通打底衣更舒服\r\n\r\n干燥起电再也没体验过！！\r\n\r\n.\r\n\r\n薄薄的但锁温效果很好\r\n\r\n穿上一会身上就暖暖的\r\n\r\n像是恒温“小空调”一样！\r\n\r\n穿了就舍不得脱\r\n\r\n.\r\n\r\n作为内搭也很百搭！\r\n\r\n?居家当家居服\r\n\r\n?出门搭配宽松卫衣大衣秒秒出圈\r\n\r\n这是我反复“剁手”停不下来的重要原因！！\r\n\r\n版型超好看\r\n\r\n❗️很贴身！很收肉（但又不会紧绷难受！）\r\n\r\n以往买的打底衣勒得慌\r\n\r\n这个就不会！弹力贼好\r\n\r\n穿上它再穿牛仔裤 都能弹跳自如！！\r\n\r\n而且也不会臃肿显胖\r\n\r\n咱终于“风度”和“温度”两相全了！\r\n\r\n秋冬也能当辣妹！\r\n\r\n谁让它就是很显身材啊！！\r\n\r\n.\r\n\r\n当然??最牛掰的还是\r\n\r\n不仅贴肤舒服，随便扔洗衣机也不娇气！不变形不起球\r\n\r\n直接给我妈我姐安排了两套\r\n\r\n都被夸到爆！', '1663900382', '1663830724', '0');
INSERT INTO `xn_goods` VALUES ('291', '/uploads/1/file/20220924/ff020e14fbdd64d13e787ed9496a6f01.jpg,/uploads/1/file/20220924/0c4bfdcb7e0be2aa2443d0776edb0eb9.jpg,/uploads/1/file/20220924/e851c14b96a53122e8695d364a7ee236.jpg', ',0,', '55', '1498', '2', '5', '103', '1', '0', '1', '我想知道  我起来帅不帅？？？', '1663988923', '1663988803', '0');
INSERT INTO `xn_goods` VALUES ('292', '', ',0,', '55', '1498', '0', '0', '0', '0', '0', '0', '纯文字的试试\n????????', '0', '1664078596', '0');
INSERT INTO `xn_goods` VALUES ('295', '/uploads/1/file/20220925/8233f24735dcb5817f1858609bd63009.jpg,/uploads/1/file/20220925/8e6007aef3aa0b55e018aeee4e6e7737.jpg', ',25,', '60', '1294', '0', '0', '0', '0', '0', '0', '啦啦啦啦啦啦队长啦了。我是了头条文章的时候就知道我', '0', '1664085742', '0');
INSERT INTO `xn_goods` VALUES ('296', '/uploads/1/file/20220925/3e18f45a5288539c12cadfdcba257fa8.jpg', ',0,', '65', '1310', '0', '0', '0', '0', '0', '0', '你品你细品', '0', '1664087789', '0');

-- ----------------------------
-- Table structure for `xn_goods_comment`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_comment`;
CREATE TABLE `xn_goods_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `fa_user_id` int(10) DEFAULT '0',
  `content` varchar(200) DEFAULT '',
  `create_time` int(10) DEFAULT '0',
  `like_num` int(10) DEFAULT '0',
  `pid` int(10) DEFAULT '0',
  `to_name` varchar(50) DEFAULT '',
  `is_ding` int(10) DEFAULT '0' COMMENT '是否置顶',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_goods_comment
-- ----------------------------
INSERT INTO `xn_goods_comment` VALUES ('24', '1', '1', '1', '最新评论2', '1663225792', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('25', '1', '1', '1', '评论3', '1663225899', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('26', '1', '1', '1', '评论4', '1663225961', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('30', '1', '1', '1', '评论77', '1663226572', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('32', '1', '1', '1', '呀呀呀呀呀呀晕晕晕', '1663235905', '0', '30', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('33', '1', '1', '1', '一月又一月', '1663235912', '0', '32', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('34', '1', '1', '1', '一月又一月', '1663235972', '0', '30', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('35', '1', '1', '1', '777777', '1663236012', '0', '30', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('36', '1', '1', '1', '66666', '1663236025', '0', '35', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('37', '1', '1', '1', '广东省发给', '1663236054', '0', '26', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('38', '1', '1', '1', '发送到发斯蒂芬', '1663236068', '0', '37', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('39', '1', '1', '1', '33333333', '1663236129', '0', '25', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('40', '1', '1', '1', '444444', '1663236147', '0', '30', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('41', '1', '1', '1', '3', '1663293591', '1', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('42', '1', '1', '1', '444444', '1663293624', '0', '30', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('43', '278', '1', '1', '真的很棒', '1663659216', '2', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('44', '278', '1', '1', '666', '1663659739', '2', '43', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('45', '278', '1', '1', '66', '1663659757', '1', '43', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('46', '281', '55', '2', '爱了 爱了。美得不要不的', '1663927434', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('47', '290', '55', '11', '这身材？？？啧啧啧！', '1663927485', '1', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('48', '286', '50', '7', '我就说嘛，吃货是改不了的。恶心', '1663927741', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('49', '278', '50', '1', '可以的', '1663928219', '1', '43', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('50', '290', '55', '11', '怎么说，还有人喜欢的吗', '1663929248', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('51', '290', '55', '11', '自己回复自己。我愿意', '1663929339', '0', '50', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('52', '278', '50', '1', '什么可以', '1663930119', '0', '43', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('53', '278', '50', '1', '顶顶顶顶', '1663930339', '0', '43', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('54', '278', '50', '1', '444444444', '1663930493', '0', '43', '北方的猪', '0');
INSERT INTO `xn_goods_comment` VALUES ('55', '290', '50', '11', '测试回复', '1663985600', '0', '50', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('56', '290', '50', '11', '测试回复2', '1663985965', '0', '50', '我的乖乖', '0');
INSERT INTO `xn_goods_comment` VALUES ('57', '290', '50', '11', '很简洁', '1663986093', '1', '50', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('58', '290', '50', '11', '6666', '1663986108', '1', '50', '我的乖乖', '0');
INSERT INTO `xn_goods_comment` VALUES ('59', '290', '50', '11', '7777777777', '1663986182', '1', '50', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('60', '290', '55', '11', '我爱你', '1663986629', '0', '47', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('61', '290', '55', '11', '我默默', '1663986641', '1', '50', '我的乖乖', '0');
INSERT INTO `xn_goods_comment` VALUES ('62', '290', '55', '11', '墨迹记录', '1663986756', '1', '50', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('63', '290', '55', '11', '????', '1663987421', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('64', '290', '50', '11', '44444444444', '1663988670', '2', '50', '刘涛', '0');
INSERT INTO `xn_goods_comment` VALUES ('65', '291', '50', '55', '我自己就觉得帅咋的', '1663993431', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('66', '281', '2', '2', '哈哈 谢谢你的', '1663993606', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('67', '281', '2', '2', '可达一的', '1663994000', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('68', '281', '2', '2', '自己回复自己', '1664018501', '0', '67', '且听风铃', '0');
INSERT INTO `xn_goods_comment` VALUES ('69', '281', '2', '2', '自己再次回复自己', '1664018779', '0', '66', '且听风铃', '0');
INSERT INTO `xn_goods_comment` VALUES ('70', '281', '2', '2', '范德萨打发啊手动阀', '1664019941', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('71', '281', '2', '2', '33333333', '1664020131', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('72', '281', '2', '2', '顶顶顶顶顶顶顶顶', '1664020259', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('73', '281', '2', '2', '44', '1664020324', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('88', '284', '2', '5', '777777777777', '1664021662', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('90', '284', '2', '5', '9999999', '1664025222', '1', '88', '且听风铃', '0');
INSERT INTO `xn_goods_comment` VALUES ('94', '284', '2', '5', '33333333333', '1664026470', '0', '0', '', '1');
INSERT INTO `xn_goods_comment` VALUES ('97', '291', '2', '55', 'df ', '1664028774', '0', '65', '我的乖乖', '0');
INSERT INTO `xn_goods_comment` VALUES ('98', '281', '55', '2', '我才爱你嫩么啊', '1664067696', '0', '73', '且听风铃', '0');
INSERT INTO `xn_goods_comment` VALUES ('99', '291', '50', '55', '545555', '1664075893', '0', '65', '我的乖乖', '0');
INSERT INTO `xn_goods_comment` VALUES ('100', '291', '55', '55', '爱你么么啊 ?????', '1664076891', '0', '65', '且听风铃', '0');
INSERT INTO `xn_goods_comment` VALUES ('101', '291', '55', '55', '测试自己和自己评论', '1664076958', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('102', '287', '58', '8', '人', '1664085032', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('103', '286', '58', '7', '你呢', '1664085042', '0', '0', '', '0');
INSERT INTO `xn_goods_comment` VALUES ('104', '290', '58', '11', '6666', '1664155511', '0', '50', '我的乖乖', '0');

-- ----------------------------
-- Table structure for `xn_goods_comment_like`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_comment_like`;
CREATE TABLE `xn_goods_comment_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `fa_user_id` int(10) DEFAULT '0',
  `goods_id` int(10) DEFAULT '0',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_goods_comment_like
-- ----------------------------
INSERT INTO `xn_goods_comment_like` VALUES ('26', '1', '1', '1', '0', '1663214943');
INSERT INTO `xn_goods_comment_like` VALUES ('28', '41', '1', '1', '0', '1663654781');
INSERT INTO `xn_goods_comment_like` VALUES ('29', '45', '1', '1', '0', '1663659761');
INSERT INTO `xn_goods_comment_like` VALUES ('30', '44', '1', '1', '0', '1663659762');
INSERT INTO `xn_goods_comment_like` VALUES ('31', '43', '1', '1', '0', '1663659764');
INSERT INTO `xn_goods_comment_like` VALUES ('37', '49', '50', '50', '278', '1663928909');
INSERT INTO `xn_goods_comment_like` VALUES ('41', '44', '50', '1', '278', '1663929174');
INSERT INTO `xn_goods_comment_like` VALUES ('42', '43', '50', '1', '278', '1663929177');
INSERT INTO `xn_goods_comment_like` VALUES ('43', '64', '50', '50', '290', '1663992987');
INSERT INTO `xn_goods_comment_like` VALUES ('44', '59', '50', '50', '290', '1663992990');
INSERT INTO `xn_goods_comment_like` VALUES ('45', '90', '2', '2', '284', '1664026565');
INSERT INTO `xn_goods_comment_like` VALUES ('46', '47', '59', '55', '290', '1664085385');
INSERT INTO `xn_goods_comment_like` VALUES ('47', '64', '59', '50', '290', '1664085386');
INSERT INTO `xn_goods_comment_like` VALUES ('48', '62', '59', '55', '290', '1664085387');
INSERT INTO `xn_goods_comment_like` VALUES ('49', '61', '59', '55', '290', '1664085388');
INSERT INTO `xn_goods_comment_like` VALUES ('50', '57', '59', '50', '290', '1664085392');
INSERT INTO `xn_goods_comment_like` VALUES ('51', '58', '59', '50', '290', '1664085393');

-- ----------------------------
-- Table structure for `xn_goods_like`
-- ----------------------------
DROP TABLE IF EXISTS `xn_goods_like`;
CREATE TABLE `xn_goods_like` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `fa_user_id` int(10) DEFAULT '0',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_goods_like
-- ----------------------------
INSERT INTO `xn_goods_like` VALUES ('36', '278', '1', '1', '1663807728');
INSERT INTO `xn_goods_like` VALUES ('37', '290', '55', '11', '1663922507');
INSERT INTO `xn_goods_like` VALUES ('39', '281', '2', '2', '1663994124');
INSERT INTO `xn_goods_like` VALUES ('40', '291', '50', '55', '1664079922');
INSERT INTO `xn_goods_like` VALUES ('41', '287', '58', '8', '1664085027');
INSERT INTO `xn_goods_like` VALUES ('42', '290', '59', '11', '1664085363');
INSERT INTO `xn_goods_like` VALUES ('43', '289', '61', '10', '1664086824');
INSERT INTO `xn_goods_like` VALUES ('44', '291', '65', '55', '1664088132');

-- ----------------------------
-- Table structure for `xn_medal`
-- ----------------------------
DROP TABLE IF EXISTS `xn_medal`;
CREATE TABLE `xn_medal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `image` varchar(255) DEFAULT '',
  `meet_num` int(10) DEFAULT '0',
  `type` tinyint(1) DEFAULT '0' COMMENT '0:帖子数，1：评论数，2：粉丝数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `has_num` int(10) DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_medal
-- ----------------------------
INSERT INTO `xn_medal` VALUES ('32', '发帖达人', '/uploads/1/file/20220921/c02be53e300bac90a22d3c32bff93cb6.png', '50', '0', '1', '1', '0');
INSERT INTO `xn_medal` VALUES ('33', '点赞达人', '/uploads/1/file/20220921/7df86b9a47f2957462cb495a2577e858.png', '50', '2', '1', '0', '0');
INSERT INTO `xn_medal` VALUES ('34', '评论达人', '/uploads/1/file/20220921/66d74bac35ede57b6ede542c4f4e32c4.png', '50', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for `xn_medal_list`
-- ----------------------------
DROP TABLE IF EXISTS `xn_medal_list`;
CREATE TABLE `xn_medal_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `medal_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_medal_list
-- ----------------------------
INSERT INTO `xn_medal_list` VALUES ('1', '32', '1', '1666666666');
INSERT INTO `xn_medal_list` VALUES ('2', '33', '1', '1666666666');
INSERT INTO `xn_medal_list` VALUES ('3', '99', '1', '1666666666');
INSERT INTO `xn_medal_list` VALUES ('4', '33', '55', '1666666666');

-- ----------------------------
-- Table structure for `xn_message`
-- ----------------------------
DROP TABLE IF EXISTS `xn_message`;
CREATE TABLE `xn_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_id` int(13) NOT NULL DEFAULT '0' COMMENT '发送者ID',
  `to_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接收ID',
  `title` varchar(255) DEFAULT '',
  `content` varchar(255) DEFAULT '' COMMENT 'neirong',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:系统消息',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_message
-- ----------------------------
INSERT INTO `xn_message` VALUES ('22', '0', '0', '关于申请圈子的说明', '<p>最近很多人申请圈子。请务必认真填写啊！</p>', '1', '1663818746');

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
INSERT INTO `xn_pages` VALUES ('25', '关于我们', '/uploads/file/20211210/f6f61c642983feea788530cc803b0378.png', '2', '1', '<p><img src=\"http://quan.51duoke.cn/ueditor/php/upload/image/20220920/1663630612147827.png\" title=\"1663630612147827.png\" alt=\"微信截图_20220920073623.png\"/></p><p>离偏见远一点，就会离自己近一点</p><p><br/></p><p>做自己，也做一个有情趣的人</p><p><br/></p><p>在这里，每一种情趣都会受到尊重</p><p><br/></p><p>释放本真，遇见真正契合的灵魂</p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p>这是你的驭圈，也是你的驭吧</p><p><br/></p><p>更是作为字母同好的快乐源泉</p><p><br/></p><p><br/></p><p><br/></p><p>是一种交付，更是一种信任</p><p><br/></p><p>是一份严厉，更是一份宠爱</p><p><br/></p><p>我们始终倡导“纯粹·平等·尊重”的社区理念</p><p><br/></p><p>只为懂的人做一个纯粹的小圈子</p><p><br/></p><p><br/></p><p><br/></p><p>每个人都是独一无二的</p><p><br/></p><p>找到懂你的TA ，开启圈内之旅</p><p><br/></p><p>我们的特色</p><p><br/></p><p>　　1、我们有最快的方法帮你找附近同好，随时随地打开聊天;</p><p>　　2、百万同好在线，分享圈内生活，展现自我，赢得更多关注;</p><p>　　3、圈内专栏作家云集，数万篇圈内专业文章与大咖交流探讨;</p><p>　　4、多项隐私保护功能，让您安全放心。</p><p>　　5、一款兴趣小的社交圈App;</p><p>　　6、用户可以在上面真实地表达自己，建立一个全新的社会身份;</p><p><br/></p><p><br/></p><p><br/></p><p>　　7、在上面你可以尽情地放松自己，与大家一起交流。</p><p><br/></p><p><br/></p><p><br/></p><p>我们的亮点</p><p><br/></p><p>　　1、我们有最快的方式帮你找到附近同好，随时随地开启聊天;</p><p>　　2、百万同好在线，分享圈内生活，展示自己获得更多关注;</p><p>　　3、圈内专栏作者云集，上万篇圈内专业文章，和大咖们交流讨论;</p><p>　　4、多重隐私保护功能，让你安全放心。</p><p><br/></p>', '0', '1');
INSERT INTO `xn_pages` VALUES ('26', '联系我们', '', '2', '1', '<p><span class=\"title\" style=\"box-sizing: border-box; margin-bottom: 53px; font-size: 36px; line-height: 39px; font-weight: 700; display: inline-block; font-family: -apple-system, &quot;SF UI Text&quot;, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; background-color: rgb(255, 255, 255);\">我们在这里</span><span style=\"color: rgb(51, 51, 51); font-family: -apple-system, &quot;SF UI Text&quot;, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\"></span></p><p><span class=\"office-name\" style=\"box-sizing: border-box; display: block; color: rgb(0, 0, 0); margin-bottom: 10px;\">上海总部</span><span class=\"office-address\" style=\"box-sizing: border-box; display: block; width: 362px; line-height: 20px;\">上海市 黄浦区 马当路388号 SOHO复兴广场C座</span></p><p><span class=\"office-name\" style=\"box-sizing: border-box; display: block; color: rgb(0, 0, 0); margin-bottom: 10px;\">北京</span><span class=\"office-address\" style=\"box-sizing: border-box; display: block; width: 362px; line-height: 20px;\">北京市 朝阳区 安定路 中海国际B座18楼</span></p><p><span class=\"office-name\" style=\"box-sizing: border-box; display: block; color: rgb(0, 0, 0); margin-bottom: 10px;\">武汉</span><span class=\"office-address\" style=\"box-sizing: border-box; display: block; width: 362px; line-height: 20px;\">武汉市 光谷大道 现代光谷世贸中心B座10楼</span><span class=\"office-address\" style=\"box-sizing: border-box; display: block; width: 362px; line-height: 20px;\"><br/></span></p><p><span class=\"title\" style=\"box-sizing: border-box; margin-bottom: 50px; font-size: 36px; line-height: 39px; font-weight: 700; display: inline-block; font-family: -apple-system, &quot;SF UI Text&quot;, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">关心每一位用户与合作伙伴的声音</span></p><p class=\"content\" style=\"box-sizing: border-box; font-size: 20px; line-height: 30px; margin-top: 0px; margin-bottom: 0px; padding: 0px;\">如您在使用或合作中遇到难以解决的问题，以及任何对平台发展有益的意见及建议，欢迎您直接写信到CEO邮箱：<strong style=\"box-sizing: border-box;\">ceo@baidu.com</strong>。</p><p class=\"content\" style=\"box-sizing: border-box; font-size: 20px; line-height: 30px; margin-top: 0px; margin-bottom: 0px; padding: 0px;\">为了您的来信能够得到更高效的处理，请您在邮件中标注以下信息：</p><ul class=\"list list-paddingleft-2\" style=\"list-style-type: none;\"><li style=\"\"><p>您的个人或工作单位信息（公司/品牌/部门/岗位/姓名 等）</p></li><li style=\"\"><p>您的联系方式（邮箱地址/直线电话 等）</p></li><li style=\"\"><p>相关问题、意见或建议的具体描述（背景/案例/各类支持性材料 等）</p></li></ul><p><br/></p>', '0', '1');
INSERT INTO `xn_pages` VALUES ('27', '用户协议', '', '2', '1', '<p>更新时间：2021年12月27日</p><p>生效时间：2022年01月04日</p><p><br/></p><p>感谢您选择注册并使用多客圈子，在使用“多客圈子”软件及相关服务前，请您认真阅读本协议（特别是以加粗方式提示您注意的可能存在免除或者限制责任等重要内容的条款），并确认承诺同意遵守本协议之全部约定。本协议由您与行吟信息科技（上海）有限公司（包括其关联机构，以下合称“本公司”）于您点击同意本协议之时在上海市黄浦区签署并生效。</p><p><br/></p><p>一、协议条款的确认及接受</p><p>1.1 多客圈子（包括网址为 xiaohongshu.com 的网站，以及可在 iOS 系统及 Android 系统中运行的名为“多客圈子”、多客圈子视频版（暂定，具体名称以上线时标注的为准）及其他不同版本的应用程序，以下简称&quot;本网站&quot;或“多客圈子”）由行吟信息科技（上海）有限公司（包括其关联机构，以下合称“本公司”）运营并享有完全的所有权及知识产权等权益，多客圈子提供的服务将完全按照其发布的条款和操作规则严格执行。</p><p><br/></p><p>1.2 您确认同意本协议（协议文本包括《多客圈子用户服务协议》、《多客圈子用户隐私政策》、《多客圈子社区规范》、《多客圈子社区公约》及多客圈子已公示或将来公示的各项规则及提示，所有前述协议、规则及提示乃不可分割的整体，具有同等法律效力，共同构成用户使用”多客圈子”软件及相关服务的整体协议，以下合称“本协议”）所有条款并完成注册程序时，本协议在您与本公司间成立并发生法律效力，同时您成为多客圈子正式用户。</p><p><br/></p><p>二、帐号注册及使用规则</p><p>2.1 您注册成功后，多客圈子将给予您一个用户帐号及相应的密码，该用户帐号和密码由您负责保管；您应当对以其用户帐号进行的所有活动和事件负法律责任。</p><p><br/></p><p>2.2 您须对在多客圈子的注册信息的真实性、合法性、有效性承担全部责任。您理解并承诺，您所设置的帐号不得违反国家法律法规及多客圈子的相关规则，您的帐号名称、头像和简介等注册信息及其他个人信息中不得出现违法和不良信息，您不得冒充他人或使用他人名义（包括但不限于冒用他人姓名、名称、字号、头像等足以让人引起混淆的方式）开设帐号；不得利用他人的名义发布任何信息；不得恶意使用注册帐户导致其他用户误认；否则多客圈子有权立即停止提供服务，收回其帐号并由您独自承担由此而产生的一切法律责任。</p><p><br/></p><p>2.3 您理解且确认，您在多客圈子注册帐号的所有权及有关权益均归本公司所有，您完成注册手续后仅享有该帐号的使用权。您的帐号仅限于您本人使用，未经本公司书面同意，禁止以任何形式赠与、借用、出租、转让、售卖或以其他方式许可他人使用该帐号。如果本公司发现或者有合理理由认为使用者并非帐号初始注册人，公司有权在未通知您的情况下，暂停或终止向该注册帐号提供服务，并有权永久禁用该帐号或注销该帐号，而无需向注册该帐号的用户承担法律责任。</p><p><br/></p><p>2.4 您应保证注册管理帐号时填写的身份信息的真实性并使用真实、准确、合法、有效的相关身份证明材料及必要信息（包括您的姓名及电子邮件地址、联系电话、联系地址等）。依照国家相关法律法规的规定，为使用“多客圈子”软件及相关服务的部分功能，您需要按照相关法律规定完成实名认证，并注意及时更新上述相关信息。若您提交的材料或提供的信息不准确、不真实、不规范或公司有理由怀疑为错误、不实、不合法的资料，则公司有权拒绝为您提供相关功能，您可能无法使用“多客圈子”软件及相关服务或在使用过程中部分功能受到限制。</p><p><br/></p><p>2.5 您理解并确认，除登录、使用”多客圈子”软件及相关服务外，您还可以用多客圈子帐号登录使用本公司及其关联方或其他合作方提供的其他软件、服务；同时，若您在相应软件、服务中确认相关内容同步功能的，则您在前述软件中发布的内容及相关数据将同步至您的多客圈子帐号中。您以多客圈子帐号登录并使用前述服务的，同样应受其他软件、服务实际提供方的用户协议及其他协议条款约束。</p><p><br/></p><p>2.6 为提高用户内容曝光量及发布效率，您同意将您在多客圈子帐号中所发布的全部内容均授权本公司以您的帐号自动同步发布至多客圈子视频版（暂定，具体名称以上线时标注的为准）及多客圈子其他不同版本、本公司及/或关联方运营的其他软件及网站，您的帐号之头像、昵称等公开信息可能会一并同步。用户在多客圈子发布、修改、删除内容的操作，均会同步到上述软件及网站中。</p><p><br/></p><p>2.7 您理解并同意，为了充分使用帐号资源，如您在注册后未及时进行初次登录使用或连续超过三个月未登录帐号并使用等情形，本公司有权收回您的注册帐号。如您的帐号被收回，您可能无法通过您此前持有的帐号登录并使用”多客圈子”软件及相关服务，您该帐号下保存的任何个性化设置和使用记录将无法恢复。在收回您的帐号之前，公司将以适当的方式向您作出提示，如您在收到相关提示后一个月内仍未登录、使用帐号，公司将进行帐号收回。</p><p><br/></p><p>2.8 您承诺不得以任何方式利用多客圈子直接或间接从事违反中国法律、以及社会公德的行为，多客圈子有权对违反上述承诺的内容予以删除。</p><p><br/></p><p>2.9 您不得利用本网站制作、上传、复制、发布、传播或者转载如下内容：（1）反对宪法所确定的基本原则的；（2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；（3）损害国家荣誉和利益的；（4）煽动民族仇恨、民族歧视，破坏民族团结的；（5）破坏国家宗教政策，宣扬邪教和封建迷信的；（6）散布谣言，扰乱社会秩序，破坏社会稳定的；（7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；（8）侮辱或者诽谤他人，侵害他人合法权益的；（9）侵害未成年人合法权益或者损害未成年人身心健康的；（10）散布商业广告，或类似的商业招揽信息、过度营销信息及垃圾信息；（11）含有法律、行政法规禁止的其他内容的信息。</p><p><br/></p><p>2.10 多客圈子鼓励用户充分利用多客圈子平台自由地发布和共享自己的信息，用户对于其创作并在多客圈子上发布的合法内容（包括但不限于文字、图片、视频、音频等）依法享有著作权。您不应通过多客圈子发布他人受知识产权法律等保护的内容，除非获得他人的合法授权。就您发布的内容，若第三方向多客圈子投诉并提交初步证据，经多客圈子判断投诉属实的，多客圈子将会删除这些内容。如因您发布的内容给多客圈子带来损失的，您应当负责赔偿。</p><p><br/></p><p>2.11 经本公司许可后，您、第三方对多客圈子的信息内容的分享、转发等行为，还应符合以下规范： （1）对抓取、统计、获得的相关搜索热词、命中率、分类、搜索量、点击率、阅读量等相关数据，未经公司事先书面同意，不得将上述数据以任何方式公示、提供、泄露给任何第三人； （2）不得对多客圈子的源网页进行任何形式的任何改动，包括但不限于多客圈子的首页链接、广告系统链接等入口，也不得对多客圈子的源页面的展示进行任何形式的遮挡、插入、弹窗等妨碍； （3）应当采取安全、有效、严密的措施，防止多客圈子的信息内容被第三方通过包括但不限于“蜘蛛”（spider）程序等任何形式进行非法获取； （4）不得把相关数据内容用于公司书面许可范围之外的目的，进行任何形式的销售和商业使用，或向第三方泄露、提供或允许第三方为任何方式的使用。 （5）您向任何第三人分享、转发、复制多客圈子信息内容的行为，还应遵守公司为此制定的其他规范和标准，如《多客圈子社区规范》及其他已公示或将来公示的各项规则及提示等。</p><p><br/></p><p>2.12 多客圈子有权对您使用多客圈子的情况进行审查和监督，如您在使用多客圈子时违反任何上述规定，多客圈子或其授权的人有权要求您改正或直接采取一切必要的措施（包括但不限于更改或删除您的内容、暂停或终止您使用多客圈子的权利）以减轻您的不当行为造成的影响。</p><p><br/></p><p>2.13 如您需要终止使用多客圈子服务，您可以申请注销您的帐号。注销成功后，帐号记录、功能等将无法恢复或提供，但您仍应对您在注销帐号前且使用多客圈子服务期间的行为承担相应责任。</p><p><br/></p><p>三、服务内容</p><p>3.1 本公司可能为不同的终端设备及使用需求开发不同的应用程序软件版本，您应当根据实际设备及需求状况获取、下载、安装合适的版本。</p><p><br/></p><p>3.2 本网站的服务具体内容根据实际情况提供，多客圈子保留变更、中断或终止部分或全部服务的权利。多客圈子不承担因业务调整给您造成的损失。除非本协议另有其它明示规定，增加或强化目前本网站的任何新功能，包括所推出的新产品，均受到本协议之规范。您了解并同意，本网站服务仅依其当前所呈现的状况提供，对于任何用户通讯或个人化设定之时效、删除、传递错误、未予储存或其它任何问题，多客圈子均不承担任何责任。如您不接受服务调整，请停止使用本服务；否则，您的继续使用行为将被视为其对调整服务的完全同意且承诺遵守。</p><p><br/></p><p>3.3 多客圈子在提供服务时，可能会对部分服务的用户收取一定的费用。在此情况下，多客圈子会在相关页面上做明确的提示。如您拒绝支付该等费用，则不能使用相关的服务。</p><p><br/></p><p>3.4 您理解，多客圈子仅提供相关的服务，除此之外与相关服务有关的设备（如电脑、调制解调器及其他与接入互联网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费）均应由您自行负担。</p><p><br/></p><p>3.5 多客圈子提供的服务内容可能包括：文字、软件、声音、图片、视频、图表等。所有这些内容受著作权、商标和其它财产所有权法律的保护。您只有在获得多客圈子或其他相关权利人的授权之后才能使用这些内容，不能擅自复制、再造这些内容、或创造与内容有关的派生产品。</p><p><br/></p><p>3.6 多客圈子会员服务</p><p><br/></p><p>3.6.1 多客圈子会员，是指在多客圈子具有良好消费记录的个人注册用户根据多客圈子公布的收费标准支付相应的费用后获取的特殊资格。以下称“会员”。</p><p><br/></p><p>3.6.2 会员服务，指会员享有的特殊服务，包括以相对优惠的价格购买指定商品（即会员专享价），以及其他由多客圈子明示的优惠措施。您开通会员服务时，须按照多客圈子公布的收费标准支付相应的会员服务费用。基于业务的发展，多客圈子有权调整收费标准，调整后的收费标准自公布之日起生效。</p><p><br/></p><p>3.6.3 会员知悉并确认，当开通会员服务后，若您中途取消服务或终止资格的，多客圈子将不退还您已支付的会员服务费用。</p><p><br/></p><p>3.6.4 使用会员服务过程中，您应当是具备完全民事权利能力和完全民事行为能力的自然人、法人或其他组织。若您不具备前述主体资格，则您及您的监护人应当承担因此而导致的一切后果，多客圈子有权向您的监护人追偿。</p><p><br/></p><p>3.6.5 您知悉并同意，多客圈子有权通邮件、短信等方式，向您发送会员相关活动的信息；</p><p><br/></p><p>3.6.6 您确认会员服务仅限您本人使用，同时，您保证，您将合理使用会员服务，不会利用会员服务非法获利，不以任何形式转让您所享有的会员服务，不以任何形式将您所享有的会员服务借给他人使用，如多客圈子有合理理由怀疑您存在不当使用会员服务时，多客圈子有权取消您的会员资格且不退还您支付的会员服务费用，因此产生的相关责任及损失均由您自行承担，给多客圈子造成损失的，多客圈子保留向您追偿的权利。</p><p><br/></p><p>3.6.7 多客圈子保留在法律法规允许的范围内自行决定是否接受您的会员服务申请、调整会员服务内容、取消会员资格等权利。</p><p><br/></p><p>3.7 商品/服务的购买与评价</p><p><br/></p><p>3.7.1 您可以通过多客圈子商城购买多客圈子或者第三方商家为您提供的商品/服务，商品/服务来源以是否标注“自营”予以区分。</p><p><br/></p><p>3.7.2 您在多客圈子下订单时，请您仔细确认所购商品的名称、价格、数量、型号、规格、尺寸、联系地址、电话、收货人等信息。收货人与您本人不一致的，收货人的行为和意思表示视为您的行为和意思表示，您应对收货人的行为及意思表示的法律后果承担连带责任。</p><p><br/></p><p>3.7.3 您理解并同意：多客圈子上展示的商品/服务和价格等信息为向您发出的要约。您下单时须填写您希望购买的商品/服务数量、价款及支付方式、收货人、联系方式、收货地址等内容；付款及订单提交成功前，您有权修改所填信息。付款及订单提交成功后，将视您与销售商之间就您购买的商品/服务成立了合同关系，销售商会按照您在订单中订购的商品/服务进行发货。</p><p><br/></p><p>3.7.4 尽管销售商做出最大的努力，但由于市场变化及各种以合理商业努力难以控制因素的影响，本软件无法避免您提交的订单信息中的商品出现缺货情况；如您下单所购买的商品发生缺货，您有权取消订单以解除电子合同，销售商在取得您同意的前提下可以取消订单以解除电子合同，若您已经付款，则为您办理退款。</p><p><br/></p><p>3.7.5 您有权在多客圈子提供的评价系统中对与其达成交易的商品/服务进行评价。您的评价内容应当客观真实，不应包含任何污言秽语、色情低俗、恶意贬低及法律法规与本协议列明的其他禁止性信息；您不应以不正当方式帮助商家提升销量、信用或利用评价权利对相关商家进行恐吓、敲诈勒索等违法行为。多客圈子可按照本协议及相关法律法规的规定对您实施上述行为所产生的评价信息进行删除或屏蔽。</p><p><br/></p><p>四、知识产权</p><p>4.1 本公司在“多客圈子”软件及相关服务中提供的内容（包括但不限于软件、技术、程序、网页、文字、图片、图像、商标、标识、音频、视频、图表、版面设计、电子文档等）的知识产权属于本公司所有。同时本公司提供服务所依托的软件的著作权、专利权、商标及其他知识产权均归本公司所有。未经本公司许可，任何人不得擅自使用（包括但不限于通过任何机器人、蜘蛛等程序或设备监视、复制、传播、展示、镜像、上载、下载“多客圈子”软件及相关服务中的内容）。</p><p><br/></p><p>4.2 请您在任何情况下都不要私自使用公司的包括但不限于“行吟”、“多客圈子”和“xiaohongshu.com”等在内的任何商标、服务标记、商号、域名、网站名称或其他显著品牌特征等（以下统称为“标识”）。未经公司事先书面同意，您不得将本条款前述标识以单独或结合任何方式展示、使用或申请注册商标、进行域名注册等，也不得实施向他人明示或暗示有权展示、使用、或其他有权处理该些标识的行为。由于您违反本协议使用公司上述商标、标识等给公司或他人造成损失的，由您承担全部法律责任。</p><p><br/></p><p>五、用户授权及隐私保护</p><p>5.1 除非有相反证明，您知悉、理解并同意，为使您的作品得到更好的分享及推广，提高其传播价值及影响力，您通过多客圈子上传、发布或传输的内容（包括但不限文字，图像，音频，视频、直播内容等各种形式的内容及其中包括的音乐、声音、台词、视觉设计、对话等所有组成部分），授予本公司及其关联方、控制公司、继承公司一项全球范围内、免费、非独家、可再许可（通过多层次）的权利（包括但不限于复制权、翻译权、汇编权、信息网络传播权、改编权及制作衍生品、表演和展示的权利等），上述权利的使用范围包括但不限于在当前或其他网站、应用程序、产品或终端设备等使用。您在此确认并同意，“多客圈子”软件及相关服务、公司和/或公司品牌有关的任何宣传、推广、广告、营销和/或研究中使用和以其他方式开发内容（全部或部分）的权利和许可。为避免疑义，您理解并同意，上述授予的权利包括使用、复制和展示您拥有或被许可使用并植入内容中的个人形象、肖像、姓名、商标、服务标志、品牌、名称、标识和公司标记（如有）以及任何其他品牌、营销或推广资产、物料、素材等的权利和许可。基于部分功能的特性，您通过多客圈子发布的内容（包括但不限于内容中包含的声音、音频或对话等）可供其他用户使用“多客圈子”软件创作及发布相关内容时使用。</p><p><br/></p><p>5.2 您确认并同意授权本公司以公司名义或委托专业第三方对侵犯您上传发布的享有知识产权的内容进行代维权，维权形式包括但不限于：监测侵权行为、发送维权函、提起诉讼或仲裁、调解、和解等，本公司有权对维权事宜做出决策并独立实施。</p><p><br/></p><p>5.3 保护用户隐私（请参见《多客圈子用户隐私政策》）是多客圈子的一项基本政策，多客圈子保证不对外公开或向第三方提供您的注册资料及您在使用本网站服务时存储在多客圈子的非公开内容，但下列情况除外：（1）事先获得您的明确授权；（2）根据有关的法律法规要求；（3）按照相关政府主管部门的要求；（4）为维护社会公众的利益；（5）维护多客圈子的合法权益。</p><p><br/></p><p>5.4 在获得您授权的情况下，多客圈子可能会与第三方合作向您提供相关的服务，在此情况下，如该第三方同意承担与多客圈子同等的保护用户隐私的责任，则多客圈子可将您的注册资料等提供给该第三方。</p><p><br/></p><p>5.5 用户关注信息公开：多客圈子提供的某些服务项目中有“关注”功能，用户选择“关注”后，可以在“我的关注”中查看自己关注的信息，包括关注的“用户”、“商家”、“标签”、“专辑”等，您须知，多客圈子平台对用户关注的项目是公开的，即其他用户可以查看到该用户关注的项目。另外您可以在“设置”-“隐私设置”中调整“评论设置”、“通讯录设置”“微博设置”等，自行调整评论、以及添加好友的方式等。</p><p><br/></p><p>六、免责声明</p><p>6.1 您将照片、个人信息等资料上传到互联网上，有可能会被其他组织或个人复制、转载、擅改或做其它非法用途，用户必须充分意识此类风险的存在。您明确同意其使用“多客圈子”软件及相关服务所存在的风险（包括但不限于受到第三方侵权或对第三方造成侵权）完全由您自己承担；因您使用“多客圈子”软件及相关服务而产生的一切后果也由您自己承担，多客圈子对此不承担任何责任。</p><p><br/></p><p>6.2 多客圈子不担保本网站服务一定能满足您的要求，也不担保本网站服务不会中断，对本网站服务的及时性、安全性、准确性、真实性、完整性也都不作担保。</p><p><br/></p><p>6.3 对于因不可抗力或多客圈子不能控制的原因造成的本网站服务中断或其它缺陷，多客圈子不承担任何责任，但多客圈子将尽力减少因此而给您造成的损失和影响。</p><p><br/></p><p>6.4 根据有关法律法规，多客圈子在此郑重提请您注意，多客圈子作为信息存储空间及网络交易平台的提供者，任何经由本网站以上载、张贴、发送电子邮件或任何其它方式传送的资讯、资料、文字、软件、音乐、音讯、照片、图形、视讯、信息或其它资料（以下简称“内容”），无论系公开还是私下传送，均由内容提供者承担责任。多客圈子无法控制经由本网站传送之内容，因此不保证内容的正确性、完整性或品质。在任何情况下，多客圈子均不为任何内容负责，包含但不限于任何内容之任何错误或遗漏，以及经由本网站服务以张贴、发送电子邮件或其它方式传送任何内容而衍生之任何损失或损害。但多客圈子有权依法停止传输任何前述内容并采取相应行动，包括但不限于暂停用户使用本网站服务的全部或部分，保存有关记录，并向有关机关报告。</p><p><br/></p><p>七、违约责任</p><p>7.1 针对您违反本协议或其他服务条款的行为，本公司有权独立判断并视情况采取预先警示、拒绝发布、立即停止传输信息、删除内容或跟帖、短期禁止发布内容或评论、限制帐号部分或者全部功能直至永久关闭帐号等措施，对于因此而造成您无法正常使用帐号及相关服务、无法正常获取您帐号内资产或其他权益等后果，公司不承担任何责任。本公司有权公告处理结果，且有权根据实际情况决定是否恢复使用。对涉嫌违反法律法规、涉嫌违法犯罪的行为将保存有关记录，并依法向有关主管部门报告、配合有关主管部门调查。</p><p><br/></p><p>7.2 因您违反本协议或其他服务条款规定，引起第三方投诉或诉讼索赔的，您应当自行承担全部法律责任。因您的违法或违约行为导致本公司及其关联公司、控制公司向任何第三方赔偿或遭受国家机关处罚的，您还应足额赔偿本公司及其关联公司、控制公司因此遭受的全部损失。</p><p><br/></p><p>7.3 本公司尊重并保护用户及他人的知识产权、名誉权、姓名权、隐私权等合法权益。您保证，在使用”多客圈子”软件及相关服务时上传的文字、图片、视频、音频等不侵犯任何第三方的知识产权、名誉权、姓名权、隐私权等权利及合法权益。否则，本公司有权在收到权利方或者相关方通知的情况下移除该涉嫌侵权内容。针对第三方提出的全部权利主张，您应自行处理并承担全部可能由此引起的法律责任；如因您的侵权行为导致本公司遭受损失的（包括经济、商誉等损失），您还应足额赔偿本公司遭受的全部损失。</p><p><br/></p><p>八、未成年人使用条款</p><p>8.1 若您是未满18周岁的未成年人，应在监护人监护、指导并获得监护人同意情况下阅读本协议和使用“多客圈子”软件及相关服务。</p><p><br/></p><p>8.2 多客圈子重视对未成年人个人信息的保护，未成年用户在填写个人信息时，请加强个人保护意识并谨慎对待，并应当在取得监护人的同意以及在监护人指导下正确使用“多客圈子”软件及相关服务。</p><p><br/></p><p>8.3 未成年人用户及其监护人理解并确认，如您违反法律法规、本协议内容，则您及您的监护人应依照法律规定承担因此而可能导致的全部法律责任。</p><p><br/></p><p>8.4 未成年人用户特别提示</p><p><br/></p><p>未成年人使用“多客圈子”软件及相关服务应在其监护人的监督指导下，在合理范围内正确学习使用网络，避免沉迷虚拟的网络空间，影响日常的学习生活，养成良好上网习惯。未成年人用户及监护人在使用“多客圈子”软件及相关服务使应必须遵守《全国青少年网络文明公约》： 要善于网上学习,不浏览不良信息。 要诚实友好交流,不侮辱欺诈他人。 要增强自护意识,不随意约会网友。 要维护网络安全,不破坏网络秩序。 要有益身心健康,不沉溺虚拟时空。</p><p><br/></p><p>8.5 为更好地保护未成年人隐私权益，多客圈子特别提醒您慎重发布包含未成年人素材的内容，一经发布，即视为您已获得权利人同意在“多客圈子”软件及相关服务展示未成年人的肖像、声音等信息，且允许多客圈子依据本协议使用、处理该等与未成年人相关的内容。如权利人通知多客圈子您发布的内容侵犯未成年人权利、出于保护权利人及未成年人权利的考虑，多客圈子有权对您发布的内容进行处理并通知您。</p><p><br/></p><p>8.6 对于未成年人的隐私保护，多客圈子将严格按照平台公布的《多客圈子用户隐私政策》、《儿童/青少年个人信息保护规则》中阐述的方式、方法执行。</p><p><br/></p><p>8.7 监护人特别提示</p><p><br/></p><p>8.7.1 法定监护人应指导子女上网应该注意的安全问题，防患于未然。如您的被监护人使用“多客圈子”软件及相关服务的，您作为监护人应指导并监督被监护人的注册和使用行为，如您的被监护人申请注册多客圈子帐号，多客圈子将有权认为其已取得您的同意。</p><p><br/></p><p>8.7.2 您的被监护人在使用“多客圈子”软件及相关服务时可能使用充值、打赏、多客圈子卡会员服务、商品/服务购买等功能。多客圈子不鼓励未成年人使用“多客圈子”软件及相关服务进行任何消费行为。您作为监护人，请保管好您的支付设备、支付账户及支付密码等，以避免被监护人在未取得您同意的情况下通过您的多客圈子帐号使用充值、打赏、多客圈子卡会员服务、商品/服务购买等功能。</p><p><br/></p><p>九、协议修改</p><p>9.1 多客圈子有权根据法律法规政策、国家有权机构或公司经营要求修改本协议的有关条款，多客圈子将会通过适当方式在网站上予以公示。</p><p><br/></p><p>9.2 若您不同意多客圈子对本协议相关条款所做的修改，您有权停止使用”多客圈子”软件及相关服务。如果您继续使用”多客圈子”软件及相关服务，则视为您接受多客圈子对本协议相关条款所做的修改。</p><p><br/></p><p>十、其他</p><p>10.1 本协议的订立、生效、履行、解释、修订、终止及纠纷解决，适用中华人民共和国法律（仅为本协议之目的，不包括香港特别行政区、澳门特别行政区和台湾地区）。</p><p><br/></p><p>10.2 本协议的签订地为中华人民共和国上海市黄浦区。若您与公司发生任何争议，双方应尽量友好协商解决，如协商不成，您同意应将争议提交至本协议签订地的人民法院诉讼解决。</p><p><br/></p>', '0', '1');
INSERT INTO `xn_pages` VALUES ('31', '隐私政策', '', '3', '1', '<p>更新日期：2022年04月30日</p><p>生效日期：2022年05月01日</p><p><br/></p><p>引言</p><p>多客圈子（以下简称为“我们”）尊重并保护所有多客圈子用户的个人信息及隐私安全。为同时给您提供更准确、有个性化的服务和更安全的互联网环境，我们依据《中华人民共和国网络安全法》《中华人民共和国个人信息保护法》《中华人民共和国民法典》《信息安全技术个人信息安全规范》以及其他相关法律法规和技术规范明确了我们收集/使用/对外提供个人信息的原则，进一步阐述了关于您个人信息的相关权利。</p><p><br/></p><p>本政策与您所使用的我们的产品与/或服务息息相关，您在下载、安装、启动、浏览、注册、登录、使用我们的产品与/或服务（以下统称“使用我们的产品与/或服务”）时，我们将按照本政策的约定处理和保护您的个人信息。我们尽量以简明扼要的表述向您解释本政策所涉及的技术词汇，以便于您理解。 本政策中与您权益（可能）存在重大关系的条款，我们已使用加粗字体予以区别，请您重点查阅。</p><p><br/></p><p>多客圈子特别提请未满18周岁的未成年（特别是未满十四周岁的儿童）及其监护人的注意，我们已明确未成年保护专门章节（以粗体提示），请您仔细阅读。</p><p><br/></p><p>请在使用/继续使用我们的各项产品与服务前，仔细阅读并充分理解本政策，并在需要时，按照本政策的指引，做出适当的选择。如果您不同意本政策的内容，将可能导致我们的产品与/或服务无法正常运行，或者无法达到我们拟达到的服务效果，您应立即停止访问/使用我们的产品与/或服务。您使用或继续使用我们提供的产品与/或服务的行为，都表示您充分理解和同意本《多客圈子用户隐私政策》（包括更新版本）的全部内容。</p><p><br/></p><p>关于我们</p><p>多客圈子网站及APP的经营者为行吟信息科技（上海）有限公司及其关联公司。</p><p><br/></p><p>注册地址为上海嘉定区曹安公路1611号4D67室。</p><p><br/></p><p>目录</p><p>一、我们如何收集和使用您的个人信息</p><p>二、我们如何共享、转让、公开披露您的个人信息</p><p>三、我们如何存储和保护您的个人信息</p><p>四、您如何管理您的个人信息</p><p>五、您如何注销您的账号</p><p>六、有关第三方提供产品和/或服务的特别说明</p><p>七、我们如何使用Cookie和其他同类技术</p><p>八、未成年人保护</p><p>九、我们如何更新隐私政策</p><p>十、如何联系我们</p><p>十一、其他</p><p><br/></p><p>一、我们如何收集和使用您的个人信息</p><p>您理解并同意：</p><p><br/></p><p>多客圈子是年轻人的生活方式平台，多客圈子以“Inspire Lives 分享和发现世界的精彩”为使命，用户可以通过短视频、图文等形式记录生活点滴，分享生活方式，并基于兴趣形成互动。我们将在本政策中依次向您说明每项功能可能收集的个人信息范围、收集目的、收集方式，以及拒绝提供个人信息可能导致的结果。请您知悉，您拒绝提供各项功能实现所必要的对应信息时，仍然可以使用多客圈子App的其他功能。</p><p><br/></p><p>我们会遵循正当、合法、必要的原则，出于本政策所述的以下目的，收集和使用您在使用我们服务过程中主动提供或因使用我们产品和/或服务而产生的个人信息。如果我们要将您的个人信息用于本政策未载明的其它用途，或基于特定目的将已经收集的信息用于其他目的，我们将以合理的方式向您告知，并在使用前再次征得您的同意。您可通过【我-设置-个人信息收集清单】查看详情。</p><p><br/></p><p>账号注册及登录</p><p><br/></p><p>1.1. 当您注册及登录时，如您使用一键登录的功能，基于我们与通信运营商的合作，我们会收集您的【手机号码和网络运营商信息】，以便为您提供快捷的登录服务；同时，为帮助您完成注册过程，我们还将收集您的 【兴趣】，以为您提供多客圈子初始服务。</p><p><br/></p><p>1.2. 如您使用第三方账号进行登录，为了满足网络实名制要求，在您使用发布、评论及其他要求实名认证的功能与服务前，我们将另行收集您的手机号码以完成实名认证 。请您谨慎考虑后提供这类信息，若您拒绝提供，您可能无法正常使用相应的功能。</p><p><br/></p><p>1.3. 您还可以根据自身需求选择填写或更改头像、名字、性别、生日、职业、地区、学校、简介、穿搭信息来完善您的信息，但如您不提供此类信息，不会影响您使用本产品和相关服务。</p><p><br/></p><p>1.4. 如果您成功注册多客圈子账号，我们会在多客圈子应用程序及网站中显示您的名字、头像、地区、简介信息。</p><p><br/></p><p>1.5. 在使用“多客圈子”客户端应用程序及相关网站为您提供的服务时，您在“多客圈子”客户端应用程序注册的账号 可同时登录“多客圈子视频版”（暂定，具体名称以上线时标注的为准，以下简称“多客圈子视频版”）及其他不同版本 客户端应用程序并获得多客圈子视频版相关服务、使用相关功能，但部分使用第三方账号注册的情形除外。您使用 该账号登录、使用多客圈子视频版的，应同时受《“多客圈子视频版”用户服务协议》、《“多客圈子视频版”隐私政策》 及相关协议条款的约束。</p><p><br/></p><p>向您提供产品和/或服务</p><p><br/></p><p>2.1. 信息浏览、发布、点赞、收藏、分享功能。</p><p><br/></p><p>2.1.1.为了向您提供我们最核心的信息展示服务并向您推荐可能感兴趣的笔记及相关信息，我们会收集您填写个人资料、您的浏览记录（您的关注、浏览）和点击操作记录（兴趣、点击、搜索、点赞、收藏、分享、评论、发布记录及有关行为）。若您希望关闭我们基于有关信息向您进行的推荐，您可参照本政策2.14条进行操作。</p><p><br/></p><p>2.1.2.当您使用发布、编辑内容功能时，我们会请求您授权存储（相册、媒体和其他文件）、相机（摄像头）、麦克风（录音）权限。您如果拒绝授权提供，将无法使用相应功能，但不影响您正常使用多客圈子的其他功能。为了提升视频的上传速度、丰富发布功能和优化体验，在您点击“发布笔记”前，我们会将您编辑的视频临时加载至服务器。如果您退出编辑页面、或者因其他原因未发布笔记，我们会立即删除相关视频。您可通过【我-设置-通用设置-不允许发布时提前上传视频】关闭此功能。</p><p><br/></p><p>2.1.3.当您使用发布、评论、点赞、收藏、分享功能时，您发布的文字、照片、视频、音频、评论、点赞、收藏、分享记录信息会存储在我们的服务器中，因为存储是实现这一功能所必需的。我们会以加密的方式存储，您也可以随时删除这些信息。</p><p><br/></p><p>2.2.安全运行与风控验证。为了保障软件与服务的安全运行，防止您的个人信息被非法获取，更准确地预防欺诈和保护账号安全，我们会收集您的设备信息【包括：设备型号、设备名称、SIM卡序列号、设备唯一标识符（包括：IMEI、IMSI、AndroidID、IDFA、OAID）】、地理位置、存储（相册、媒体和其他文件）、浏览器类型和设置、语言设置、传感器、操作系统和应用程序版本、网络设备硬件地址（MAC地址）、登录IP地址、接入网络的方式、网络质量数据、移动网络信息（包括运营商名称）、产品版本号以及软件使用记录信息，如您不同意我们收集前述信息，可能无法完成风控验证。请您理解，为动态检测您的账户是否存在异常登录，每次您把多客圈子切换至后台或重新启动程序时，我们可能会再次读取，我们将把读取频次控制在合理范围内。为了维护网络安全、保障良好生态，您的IP地址所对应的归属地域信息将会展示在您的个人资料页、笔记发布页和评论中。境内展示到省(区、市)，境外展示到国家(地区)，信息以网络运营商数据为准。</p><p><br/></p><p>2.3.搜索功能。当您使用多客圈子搜索功能时，我们会收集您查询的关键词、阅读记录和访问时间、评论和互动记录。收集此信息可以向您提供您所需要的内容和可能更感兴趣的服务，同时亦可以改进我们的产品和服务。</p><p><br/></p><p>2.4.定位功能。当您开启设备定位功能并使用多客圈子基于地理位置提供的相关服务（含内容推荐、内容发布、购物编辑收货信息、资料编辑）时，我们可能会通过弹窗获得您的单独同意后收集有关您的地理位置信息。地理位置信息属于个人敏感信息，拒绝提供该信息您将无法使用上述基于位置提供的相关服务，但不影响您正常使用多客圈子的其他功能。</p><p><br/></p><p>2.5. 互动功能与服务。</p><p><br/></p><p>2.5.1.当您关注您感兴趣的账号、进行浏览、评论、点赞、收藏、分享内容时，我们会收集您关注的账号和前述信息，并向您展示您关注账号发布的内容；同时，您点赞或收藏的内容会向您的粉丝展示，您可将收藏的内容设置仅自己可见，可以在【我】-【收藏】-【收藏专辑】中开启仅自己可见。</p><p><br/></p><p>2.5.2.当您使用推荐通讯录好友功能或您主动发现好友时，在获得您明示同意后，我们会收集您的通讯录信息，用于向您展示通讯录中的好友，您的好友也能看到您使用多客圈子服务。如果您不希望被推荐，可以在【我】-点击左上角-【设置】-【隐私设置】-【不把我推荐给可能认识的人】中选择关闭。通讯录信息属于个人敏感信息，拒绝提供该信息仅会使您无法使用上述功能，但不影响您正常使用多客圈子及相关服务的其他功能。</p><p><br/></p><p>2.5.3.当您购买商品或服务时，如您需要编辑收货信息，我们可能会向您请求通讯录权限，通讯录权限是敏感权限，拒绝提供仅会使您无法通过通讯录编辑收货信息，但不影响其他功能的使用。</p><p><br/></p><p>2.5.4.当您选择使用扫码添加好友时，我们可能会向您请求相机（摄像头）权限，相机（摄像头）权限是敏感权限，拒绝提供仅会使您无法通过扫码途径添加好友，不影响其他功能的使用。</p><p><br/></p><p>2.6. 购买、查询、使用虚拟财产。为了方便您查询虚拟财产，并尽量降低可能存在的风险， 【钱包】会记录您的充值、余额与使用情况。</p><p><br/></p><p>2.7. 身份认证功能及账号找回。</p><p><br/></p><p>2.7.1.当您使用身份认证功能申请成为认证用户时，我们可能会收集您的身份信息，包括您的真实姓名、身份证件号码或照片、面部识别信息，用于证实您的个人身份。若您拒绝提供，不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>2.7.2.当您使用账号找回功能时，我们可能会收集您的身份信息，包括您的真实姓名、身份证件号码或照片、面部识别信息，用于证实您的身份，便于您找回多客圈子账号。若您拒绝提供，不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>2.7.3.当您申请开通直播功能时，根据法律法规的要求，我们可能会收集您的身份信息，包括您的真实姓名、身份证件号码或照片、面部识别信息，用于证实您的个人身份。若您拒绝提供，不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>2.7.4.当您申请商品合作功能时，根据法律法规的要求，我们可能会收集您的身份信息，包括您的真实姓名、身份证件号码或照片、面部识别信息，用于证实您的个人身份；为了帮助您顺利完成商品合作，我们可能收集您的手机号或微信号。若您拒绝提供，不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>2.7.5.当您申请品牌合作功能时，为了验证您的个人身份并判断您是否符合使用品牌合作功能的准入条件，我们可能会收集您的真实姓名、身份证件号码或照片、多客圈子账号信息、职业、学历以及收入明细信息。若您拒绝提供，不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>2.8.商品购买功能。您可以在多客圈子商城订购商品/服务。为了帮助您顺利完成交易、保障您的交易安全、查询订单信息、提供物流服务，在您下单交易或为了完成交易时，我们会收集您的交易商品/服务信息、订单号、下单时间、交易金额、支付方式、收货人姓名、地址、联系电话、物流信息。对于部分特殊类型的商品和服务，您还需要提供该商品或服务所必需的其他信息，例如涉及跨境交易时您需要提供您的真实姓名、身份证件号码以及身份证件正反面照片以完成清关。</p><p><br/></p><p>2.9.当您申请开通数字藏品功能时，我们可能会收集您的身份信息，包括您的真实姓名、身份证件号码或照片、面部识别信息，用于证实您的个人身份。</p><p><br/></p><p>2.10.客服和售后服务功能。当您联系我们的客服或提出我们的产品与/或服务的售后申请时，我们系统可能会记录您与客服之间的通讯记录。为了您的账号与系统安全，我们可能需要您提供相关个人信息与您之前提供的个人信息相匹配以验证您的用户身份。验证成功后，我们可能会收集您与我们的沟通信息（账号信息、订单信息、您为了证明相关事实而提供的图片/视频/文字信息及有关信息）、您的联系方式以及您与我们的沟通记录，包括线上沟通记录、电话录音，以便尽快为您解决问题和改进我们的产品与/或服务。同时，我们可能会以电话、短信、站内信及相关方式主动联系您，沟通您在使用我们产品及服务过程中产生的问题。</p><p><br/></p><p>为了保证服务的体验、处理服务纠纷，您与客服间的通话信息可能会被录音。有关上述信息的收集和使用规则如下：</p><p><br/></p><p>2.10.1.当您使用多客圈子服务与平台或者商家发生纠纷时，我们可调取并使用录音信息作为解决纠纷的参考依据。</p><p><br/></p><p>2.10.2.为了向您提供客服和售后服务，我们可能将您的通话录音存储在第三方客服系统中，我们会通过协议约束等方式，确保第三方无法访问您的通话录音；除以下情形外，平台不会将录音提供给任何人（包括通话主、被叫方）：a.有权机关依法定程序调取；b.被录音的一方持司法机关出具的法律文件依法调取。</p><p><br/></p><p>2.11.支付功能。您可以在多客圈子购买商品/服务以及多客圈子会员服务。在您使用该功能的过程中可能会需要进行支付，在支付过程中，我们可能会收集您的第三方支付账号（支付宝账号、微信账号、银联账号及有关账号）。</p><p><br/></p><p>2.12.信息预填写功能。您在多客圈子平台填写表单或订单信息时，为帮您节省填写时间，我们会根据您注册、购物时向平台提供的姓名、性别（如有）、手机号码、地区（如有）帮您自动填充表单信息。</p><p><br/></p><p>2.13.测肤、试妆功能。当您使用多客圈子提供的测肤或试妆功能时，我们可能需要在通过弹窗征得您单独同意后收集您的存储（相册、媒体和其他文件）、相机（摄像头）权限或面部信息以为您提供该项服务。但我们在提供测肤和试妆服务后不会存储您的面部特征信息。若您拒绝提供前述面部特征信息，您将无法体验我们的测肤、试妆功能，但不会影响多客圈子其他功能的正常使用。</p><p><br/></p><p>请注意，由于上述面部特征信息直接关系到您的人身和财产安全，因此您在向我们提供时需慎重考虑。我们将仅基于为您提供测肤、试妆服务的目的收集处理您的上述面部特征信息，而个人信息的处理将仅影响您所体验的测肤、试妆功能的结果。</p><p><br/></p><p>2.14.为保证您在使用多客圈子平台服务时能够与后台服务器保持即时通信、且您能够及时收到个性化内容推送，我们会 i）向您获取及调用您的开机广播权限用于启动多客圈子或其关联公司移动客户端软件，ii）采用第三方消息推送服务为您生成标识ID用于区分您的设备的唯一性，iii）读取手机状态，用于判断多客圈子软件处在前台还是后台，以提升推送服务的时效性。</p><p><br/></p><p>2.15.为向您展示个性化的内容，或确保您能获知更为适宜的内容，我们可能会收集在您在多客圈子平台上搜索/播放/展示推荐内容的记录、音视频播放记录，或使用您填写的个人资料信息（如性别、生日）。如您对推送内容不感兴趣或希望减少某些信息推送时，您可以在长按笔记内容，点击“不感兴趣”。您也可选择关闭推送信息，具体可前往【我】-点击左上角-【设置】-【隐私设置】-【个性化选项】关闭个性化推荐机制。</p><p><br/></p><p>2.16.为向您提供更便捷、更符合您个性化需求的商品信息展示、搜索及推送服务，我们会根据您的 设备信息（包括2.2条所述设备信息及移动应用列表信息） 和您使用多客圈子客户端时的 浏览使用信息、购买记录， 提取您的偏好特征，并基于特征标签产出间接人群画像，用于向您展示、推送信息和可能的商业广告 (请您理解，单独的设备信息无法识别特定自然人的身份信息。如果我们将这类非个人信息与其他信息结合用于识别特定自然人身份，或者将其与个人信息结合使用，则在结合使用期间，这类非个人信息将被视为个人信息，除取得您授权或法律法规另有规定外，我们会将该类个人信息做匿名化处理）。对于您在使用我们产品或服务的过程中提供的您的联系方式（电话、邮箱及其他联系方式），我们在运营中可能会以短信、电话的方式，为您提供您可能感兴趣的服务，功能或活动及相关商业性信息。我们努力保障您的浏览体验。如果您不想接受我们给您发送的商业广告，您可通过短信提示回复退订或提供的其他方式进行退订或关闭，也可以直接与我们联系进行退订。</p><p><br/></p><p>2.17．在您分享或被分享信息、参加活动情形下，我们需要访问您的剪切板，读取其中包含的口令、分享码、链接，以为您实现跳转、分享、活动联动功能或服务。</p><p><br/></p><p>2.18.设备权限调用汇总</p><p><br/></p><p>我们对多客圈子在提供服务过程中，会调用您的主要设备权限汇总如下。您可以在设备的设置功能中选择关闭部分或全部权限。在不同设备中，权限显示方式及关闭方式可能有所不同，具体请参考设备及系统开发方说明或指引：</p><p><br/></p><p>设备权限<span style=\"white-space:pre\">	</span>对应业务功能<span style=\"white-space:pre\">	</span>功能场景说明<span style=\"white-space:pre\">	</span>是否可关闭</p><p>麦克风（录音）<span style=\"white-space:pre\">	</span>1.内容发布</p><p>2.直播</p><p>3.消息和聊天<span style=\"white-space:pre\">	</span>1.发布内容时进行录音</p><p>2.开启直播时进行录音</p><p>3. 与其他用户聊天时发送语音消息、向商城在线客服发布短视频内容时进行录音<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>通讯录<span style=\"white-space:pre\">	</span>1.发现或推荐好友</p><p>2.购物时编辑收货信息<span style=\"white-space:pre\">	</span>1.发现或推荐通讯录中的好友（含消息推送形式）</p><p>2.用户购买商品或服务时，编辑收货信息<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>通知<span style=\"white-space:pre\">	</span>系统通知<span style=\"white-space:pre\">	</span>APP相关消息推送<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>网络权限<span style=\"white-space:pre\">	</span>上网功能<span style=\"white-space:pre\">	</span>开启上网功能，实时读取与更新<span style=\"white-space:pre\">	</span>可以，关闭后APP内容无法实时读取与更新，无法正常使用APP</p><p>相机（摄像头）<span style=\"white-space:pre\">	</span>1.直播</p><p>2.内容笔记</p><p>3.测肤、试妆功能</p><p>4.扫一扫</p><p>5.消息</p><p>6.注册认证</p><p>7.AR拍摄功能<span style=\"white-space:pre\">	</span>1.开启直播时进行拍摄</p><p>2.发布内容时进行拍摄</p><p>3.使用测肤、试妆功能时进行拍摄</p><p>4.添加好友或活动相关二维码扫描</p><p>5. 与其他用户聊天时进行拍摄</p><p>6.注册和认证时进行拍摄</p><p>7.使用AR拍摄功能时进行拍摄<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>日历<span style=\"white-space:pre\">	</span>1. 直播活动提醒</p><p>2. 聊天活动提醒<span style=\"white-space:pre\">	</span>提醒直播和聊天活动<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>悬浮窗<span style=\"white-space:pre\">	</span>1.直播</p><p>2.聊天<span style=\"white-space:pre\">	</span>将直播、聊天画面悬浮于其他内容上<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>地理位置<span style=\"white-space:pre\">	</span>1.内容推荐</p><p>2.内容发布</p><p>3.购物时编辑收货信息</p><p>4.资料编辑</p><p>5.安全运行与风控验证<span style=\"white-space:pre\">	</span>1.根据用户所在位置推荐内容，如附近功能</p><p>2.用户发布内容时定位所在区域，如用户使用含定位的贴纸、发布定位标签、使用标记功能</p><p>3.用户购买商品或服务时，编辑收货信息</p><p>4.个人页编辑地区</p><p>5.本政策第2.2条描述<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>存储（相册、媒体和其他文件）<span style=\"white-space:pre\">	</span>1.注册认证</p><p>2.内容发布</p><p>3.内容保存</p><p>4.直播</p><p>5.测肤、试妆</p><p>6.消息</p><p>7.分享</p><p>8.资料编辑</p><p>9.意见反馈</p><p>10.扫一扫</p><p>11.安全运行与风控验证<span style=\"white-space:pre\">	</span>1.注册和认证时上传照片或视频</p><p>2.发布内容时读取相册和媒体内容、进行存储</p><p>3.日志信息记录、信息缓存</p><p>4.直播：上传照片、下载直播内容、观看本地视频</p><p>5.使用测肤、试妆功能时</p><p>6.消息：私信下载、与商城在线客服沟通时读取相册内容</p><p>7.截图分享</p><p>8.编辑资料选择头像图片时读取相册内容</p><p>9.用“意见反馈”功能时读取相册内容</p><p>10.添加好友或活动相关二维码扫描时读取相册内容</p><p>11.App安全运行与风控验证<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>电话状态（包括设备信息和运行状态）<span style=\"white-space:pre\">	</span>1.APP安全运行与风控验证</p><p>2.内容推荐</p><p>3.展示和其他功能优化<span style=\"white-space:pre\">	</span>1.本政策第2.2条描述</p><p>2.本政策第2.15条描述</p><p>3.展示和其他功能优化<span style=\"white-space:pre\">	</span>可以，关闭后仅影响对应功能，不影响APP其他功能</p><p>我们可能从第三方间接获取您的个人信息</p><p><br/></p><p>如您使用第三方平台的账号登录时，经过您明确授权账号绑定后， 第三方平台会向我们同步您在该平台上使用的头像、昵称、地区（如有）、性别（如有）及好友信息（针对微博平台） ，以使您可以直接登录并使用多客圈子。</p><p><br/></p><p>如您不希望被推荐给微博好友，可以在【我】-【设置】-【隐私】-【不把我推荐给微博好友】中选择关闭。</p><p><br/></p><p>征得授权同意的例外</p><p><br/></p><p>根据相关法律法规的规定，在以下情形中，我们可以在不征得您的授权同意的情况下收集、使用一些必要的个人信息：</p><p><br/></p><p>（1）为订立、履行个人作为一方当事人的合同所必需，或者按照依法制定的劳动规章制度和依法签订的集体合同实施人力资源管理所必需；</p><p><br/></p><p>（2）为履行法定职责或者法定义务所必需；</p><p><br/></p><p>（3）为应对突发公共卫生事件，或者紧急情况下为保护自然人的生命健康和财产安全所必需；</p><p><br/></p><p>（4）为公共利益实施新闻报道、舆论监督等行为，在合理的范围内处理个人信息；</p><p><br/></p><p>（5）依照《个人信息保护法》规定在合理的范围内处理个人自行公开或者其他已经合法公开的个人信息；</p><p><br/></p><p>（6）法律法规规定的其他情形</p><p><br/></p><p>二、我们如何共享、转让、公开披露您的个人信息</p><p>共享：</p><p><br/></p><p>对于您的个人信息，我们不会与任何公司、组织和个人进行共享，除非存在以下一种或多种情形：</p><p><br/></p><p>（1） 事先已得到您的授权；</p><p><br/></p><p>（2） 您自行提出的；</p><p><br/></p><p>（3） 与商业合作伙伴的必要共享：</p><p><br/></p><p>您理解并知悉，为了向您提供更完善、优质的产品和服务，我们将授权商业合作伙伴为您提供部分服务。此种情形下，我们可能会与合作伙伴共享您的某些个人信息，以提供更好的客户服务和用户体验。请您注意，我们仅会出于合法、正当、必要、特定、明确的目的共享您的个人信息，并且只会共享提供服务所必要的个人信息。我们将对信息数据的输出形式、流转、使用进行安全评估与处理，以保护数据安全。同时，我们会对合作伙伴进行严格的监督与管理，一旦发现其存在违规处理个人信息的行为，将立即停止合作并追究其法律责任。</p><p><br/></p><p>目前，我们的合作伙伴包括以下类型，具体请查阅《第三方信息共享清单》：</p><p><br/></p><p>A. 平台的第三方商家：为帮助您实现产品或服务的购买或者为您提供售后服务，平台的第三方商家会与我们共享您的订单和交易相关信息。</p><p><br/></p><p>B. 第三方物流服务商：当您成功下单后，如商品需第三方配送的，我们为了准确、安全向您完成货物的交付及配送。第三方物流公司在发货及配送环节内不可避免地会获知您的相关配送信息。我们向您承诺，我们会以最大努力保障您的个人信息安全，我们会严格要求第三方物流公司对您的个人信息保密，只以配送之目的获悉和使用，不得对外泄露或做其他任何用途。</p><p><br/></p><p>C.广告和统计分析类合作伙伴：为帮助进行广告或决策建议、提高广告有效触达率、进一步了解用户需求，我们可能会与委托我们进行信息推广和广告投放的合作伙伴、或统计分析类合作伙伴共享去标识化的设备信息或统计信息，这些信息难以或无法与你的真实身份相关联。请您知悉，为了您的信息安全，我们目前仅与已签署严格数据安全保密协议的合作伙伴进行合作。</p><p><br/></p><p>D. 内容审核服务商：为保证用户在互联网信息平台上发布的内容是安全的，我们可能会向委托的第三方内容审核服务商共享您在平台上发布的内容信息。</p><p><br/></p><p>E. 实名认证审核服务商：当您进行实名认证或使用找回账号功能时，我们会向第三方审核服务商共享您的个人信息，以便您顺利找回账号。</p><p><br/></p><p>F. 测肤功能的服务商：具体测肤功能由与多客圈子合作的第三方服务商提供，当您使用该功能时，我们会向第三方服务商共享您基于此功能向平台提供的个人信息，以便您顺利体验该功能。</p><p><br/></p><p>G. 第三方小程序：当您使用第三方小程序时，未经您同意，我们不会向这些开发者、运营者共享您的个人信息。当您使用小程序时，小程序可能会使用您授权的相关系统权限，您可以在相应的小程序中撤回该等授权。</p><p><br/></p><p>H. 数字藏品技术服务提供方：当您使用数字藏品功能，我们会向第三方技术服务商共享您向平台提供的个人信息，以便您顺利体验该功能。</p><p><br/></p><p>I. 其他业务合作伙伴：委托我们进行推广和广告投放相关的合作伙伴。您授权我们有权与委托我们进行推广和广告投放的合作伙伴共享我们使用您的相关信息集合形成的间接用户画像，以帮助其进行广告或决策建议、提高广告有效触达率、进一步了解用户需求。 但我们承诺：未经您的同意，我们不会与其共享可以识别您身份的个人信息。</p><p><br/></p><p>J. 合作的第三方SDK服务商：当您使用多客圈子APP中由第三方提供的功能时，我们可能会接入由第三方提供的软件开发包（SDK）以实现相关功能。此时，第三方SDK服务商可能会收集您相关的个人信息。我们会尽到审慎义务，对前述第三方SDK进行严格的安全监测，以保护个人信息安全：</p><p><br/></p><p>a. 一键登录功能：为给您提供账号登录——一键登录功能，第三方服务商可能会获取您的必要设备信息、网络相关信息、地理位置、存储（相册、媒体和其他文件）（包括在后台状态下收集）信息;</p><p><br/></p><p>b. 第三方账号登录功能：为给您提供第三方账号登录的功能，第三方服务商可能会获取您的必要设备信息、网络相关信息、地理位置、存储（相册、媒体和其他文件）（包括在后台状态下收集）信息；</p><p><br/></p><p>c. 消息推送服务：为给您提供消息推送，第三方推送服务商可能会获取您的推送SDK版本号、必要设备信息、手机状态信息、地理位置信息、网络相关信息、存储（相册、媒体和其他文件）（包括在后台状态下收集）信息以便推送您可能更感兴趣的信息；</p><p><br/></p><p>d. 地理位置服务：为给您提供地理位置服务（内容推荐、内容发布、购物时编辑收货信息、资料编辑），第三方地理位置服务商会收集您的设备信息及地理位置信息以便可以向您推送附近内容；</p><p><br/></p><p>e. 云储存服务：为给您提供云端储存服务（您上传至多客圈子的图片、音视频内容会储存在云端以及有关场景），第三方服务商可能会收集您的设备信息、网络相关信息、运营商信息；</p><p><br/></p><p>f. 账号安全服务：为保障您和其他用户的账号与财产安全，使您和我们的正当合法权益免受不法侵害，第三方安全服务商可能会收集您的必要设备信息、网络相关信息、运营商信息、日志信息、存储（相册、媒体和其他文件）（包括在后台状态下收集）信息以提供账号安全服务；</p><p><br/></p><p>g. 支付服务：为保障您顺利购买平台上的商品/服务、虚拟商品，第三方支付服务商可能会收集您的设备信息、网络信息、运营商信息以实现顺利完成支付以及保证支付安全；</p><p><br/></p><p>h. 直播服务：为保障平台直播功能的顺利使用，第三方服务商可能会收集您的设备信息、网络相关信息、推送SDK版本号、运营商信息。</p><p><br/></p><p>（4） 当您选择参加我们及我们的关联方或平台上的第三方举办的营销活动时，可能需要您提供姓名、性别、通信地址、联系方式、银行账号信息。 这些信息可能涉及敏感个人信息，拒绝提供可能会影响您参加相关活动，但不会影响其他功能。 只有经过您的同意，我们才会将这些信息与关联方或第三方共享，以保障您在活动中获得体验一致的服务，或委托第三方及时向您兑现奖励。</p><p><br/></p><p>（5） 与我们的关联公司必要共享：我们可能会与我们的关联公司共享您的个人信息。我们只会共享必要的个人信息，且这种共享受本政策所声明的目的的约束。关联公司如要改变个人信息的处理目的，将再次征得您的授权和同意；</p><p><br/></p><p>（6） 登录、使用多客圈子视频版：您将已持有的多客圈子账号及相关信息授权我们同步到多客圈子视频版后，您将通过同一账号同时使用多客圈子和多客圈子视频版的相关服务和功能。</p><p><br/></p><p>（7） 您可以基于多客圈子平台与第三人（包括不特定对象）共享您的个人信息或其他信息，但因您的共享行为而导致的信息泄露、被使用及相关情况，与多客圈子无关，多客圈子不因此承担法律责任。</p><p><br/></p><p>转让：</p><p><br/></p><p>转让是指将取得您个人信息的控制权转让给其他公司、组织或个人。除非获取您的明确同意，否则我们不会将您的个人信息转让给任何公司、组织或个人。但下述情形除外：</p><p><br/></p><p>（1） 事先已征得您的同意；</p><p><br/></p><p>（2） 您自行提出的；</p><p><br/></p><p>（3） 如果公司发生合并、分立、解散、被宣告破产，将可能涉及到个人信息转让，此种情况下我们会告知您接收方的名称或者姓名和联系方式并要求新的持有您个人信息的公司、组织继续受本政策的约束。若接收方变更个人信息处理目的、处理方式的，我们将要求其重新获取您的明示同意。</p><p><br/></p><p>（4） 其他法律法规规定的情形。</p><p><br/></p><p>公开披露：</p><p><br/></p><p>公开披露是指向社会或不特定人群发布信息的行为。原则上，我们不会对您的个人信息进行公开披露。但下述情况除外：</p><p><br/></p><p>（1） 因公布账号中奖、处罚通知时展示必要的相关脱敏信息；</p><p><br/></p><p>（2） 取得您的明示同意后。</p><p><br/></p><p>共享、转让、公开披露个人信息授权同意的例外情形</p><p><br/></p><p>根据相关法律法规的规定，在以下情形中，我们可能在未事先征得您的授权同意的情况下共享、转让、公开披露您的个人信息：</p><p><br/></p><p>（1） 为订立、履行个人作为一方当事人的合同所必需，或者按照依法制定的劳动规章制度和依法签订的集体合同实施人力资源管理所必需；</p><p><br/></p><p>（2） 为履行法定职责或者法定义务所必需；</p><p><br/></p><p>（3） 为应对突发公共卫生事件，或者紧急情况下为保护自然人的生命健康和财产安全所必需；</p><p><br/></p><p>（4） 为公共利益实施新闻报道、舆论监督等行为，在合理的范围内处理个人信息；</p><p><br/></p><p>（5） 依照《个人信息保护法》规定在合理的范围内处理个人自行公开或者其他已经合法公开的个人信息；</p><p><br/></p><p>（6） 法律法规规定的其他情形。</p><p><br/></p><p>请您了解，根据现行法律规定及监管要求，共享、转让经匿名化处理的个人信息，且确保数据接收方无法复原并重新识别个人信息主体的，无需另行向您通知并征得您的同意。</p><p><br/></p><p>三、我们如何存储和保护您的个人信息</p><p>存储：</p><p><br/></p><p>存储地点：我们将从中华人民共和国境内获得的个人信息存放于中华人民共和国境内。以下情形下，我们会确保在履行了法律规定的义务后，向境外实体提供您的个人信息：</p><p><br/></p><p>（1）适用的法律有明确规定;</p><p><br/></p><p>（2）获得您的明确授权;</p><p><br/></p><p>（3）您通过互联网进行跨境交易等个人主动行为。</p><p><br/></p><p>针对以上情形，我们会通过合同等形式确保以不低于本政策规定的程度保护您的个人信息。</p><p><br/></p><p>存储时间：我们承诺始终按照法律的规定在合理必要期限内在存储您个人信息。超出上述期限后，我们将删除您的个人信息或对您的个人信息进行匿名化处理。</p><p><br/></p><p>如我们停止运营，我们将及时停止收集您个人信息的活动，将停止运营的通知以逐一送达或公告的形式通知您，并对所持有的您的个人信息进行删除或匿名化处理。</p><p><br/></p><p>保护：</p><p><br/></p><p>为了保护您的个人信息安全，我们将努力采取各种符合行业标准的安全措施来保护您的个人信息以最大程度降低您的个人信息被毁损、盗用、泄露、非授权访问、使用、披露和更改的风险。我们将积极建立数据分类分级制度、数据安全管理规范、数据安全开发规范来管理规范个人信息的存储和使用，确保未收集与我们提供的服务无关的个人信息。</p><p><br/></p><p>您的账户均有安全保护功能，请妥善保管您的账户及密码信息。多客圈子将通过向其它服务器备份、对用户密码进行加密及相关安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。为防止安全事故的发生，我们已按照法律法规的规定，制定了妥善的预警机制和应急预案。如确发生安全事件，我们将及时将相关情况选择以邮件、信函、电话、推送通知及相关方式告知您，难以逐一告知个人信息主体时，我们会采取合理、有效的方式发布公告。同时，我们还将按照监管部门要求，主动上报个人信息安全事件的处置情况，紧密配合政府机关的工作。</p><p><br/></p><p>当我们的产品或服务发生停止运营的情形时，我们会及时停止继续收集个人信息的活动。上述变更，我们将以推送通知、公告及相关形式通知你，并在合理的期限内删除你的个人信息或进行匿名化处理（所谓“匿名化处理”，是指通过对个人信息的技术处理，使得个人信息主体无法被识别，且处理后的信息不能被复原的过程。个人信息经匿名化处理后所得的信息不属于个人信息。）</p><p><br/></p><p>四、您如何管理您的个人信息</p><p>我们非常重视并尽全力保障您对自己个人信息的相关权利。</p><p><br/></p><p>自主决定接收信息</p><p><br/></p><p>在关注中会根据您主动选择关注的账号信息进行展示，您可以根据需要自主选择关注或取消关注。</p><p><br/></p><p>个人信息副本的访问、获取、更正和删除相关信息</p><p><br/></p><p>我们通过交互界面的设计，为您提供了可自行访问、获取、更正和删除相关个人信息的渠道，您可通过以下方式进行设置：</p><p><br/></p><p>（1） 通过【我-编辑资料】访问、获取、更正自己的个人资料，含头像、昵称、性别、常住地、院校及入学时间、生日、个人介绍；</p><p><br/></p><p>（2） 通过【我-设置-账号与安全】设置、访问、获取、更正账号信息，含手机号（每月仅可换绑一次）、登录密码、绑定的第三方平台账号（含微信、微博和QQ账号）；</p><p><br/></p><p>（3） 通过【我-设置-隐私】设置、访问、获取、更正隐私信息，含评论设置、@设置、通讯录推荐设置、微博推荐设置、位置信息设置和黑名单设置；</p><p><br/></p><p>（4） 通过【我-笔记/收藏/赞过】访问、获取、更正、删除相关信息。</p><p><br/></p><p>除上述外，有下列情形之一的，我们将应当主动删除您的个人信息，您也有权请求我们删除：</p><p><br/></p><p>（1）处理目的已实现、无法实现或者为实现处理目的不再必要；</p><p><br/></p><p>（2）我们已停止提供产品或者服务，或者保存期限已届满；</p><p><br/></p><p>（3）您已明确撤回同意；</p><p><br/></p><p>（4）如您有足够的理由认为我们违反法律、行政法规或者违反约定处理您的个人信息；</p><p><br/></p><p>（5）法律、行政法规规定的其他情形。</p><p><br/></p><p>变更或撤回授权范围</p><p><br/></p><p>您可通过【我-设置-通知设置/隐私/通用】变更或撤回授权范围，包括：1）微信账号、微博账号和QQ账号的绑定；2）互动、私信、社区内容、和商城通知；3）评论设置、@设置、通讯录推荐设置、微博推荐设置、位置信息设置和黑名单设置；4）系统默认字体的获取和使用设置。</p><p><br/></p><p>您也可以通过设备本身操作系统变更或撤回您对麦克风（录音）、通讯录、通知、网络、相机（摄像头）、日历、悬浮窗、地理位置、相机（摄像头）、存储（相册、媒体和其他文件）、电话状态权限的授权，不同设备型号的功能可能不尽相同，我们将根据您变更或撤回授权的设置进行个人信息的收集，如您撤回授权我们将不再收集与这些权限相关的信息，但提请您注意这将导致部分功能或全部功能的不可用。同时，您变更或撤回授权的决定，不会影响我们此前基于您的授权而进行的个人信息处理。</p><p><br/></p><p>附条件的个人信息转移权</p><p><br/></p><p>若您需要将您的个人信息转移至其他平台、企业或组织，您可以通过本隐私政策所披露的方式联系我们。我们将对您的请求进行审核，在符合我国网信部门规定的条件下，我们将为您提供转移相应个人信息的途径。</p><p><br/></p><p>约束信息系统自动决策</p><p><br/></p><p>在一些业务功能中，我们可能仅依据信息系统、算法在内的非人工自动决策机制作出决定。如果这些决定显著影响您的合法权益，您有权要求我们作出解释，我们也将提供适当的救济方式。</p><p><br/></p><p>在符合相关法律要求的情况下，您的近亲属可以对您的相关个人信息行使上述查阅、复制、更正、删除等权利；您另有安排的除外。</p><p><br/></p><p>联系我们进行管理</p><p><br/></p><p>出于安全性和身份识别的考虑，您可能无法直接通过多客圈子交互界面自行访问、更正或删除某些信息（实名认证后的信息、您的部分使用记录及有关信息）；如您确有必要访问、修改或依法要求删除该类信息，请您按照本政策第十条中所提供的联系方式，将您的问题通过邮件发送至指定的联系邮箱，我们将尽快审核所涉问题，并在核验您的用户身份后及时予以回复。</p><p><br/></p><p>五、您如何注销您的账号</p><p>您可以通过【我-设置-帮助与客服-社区问题-如何注销账号】或【我-设置-账号与安全-注销账号】，在满足账号注销的条件下选择【申请注销账号】，来注销您的账号；我们会在收到您的注销申请并验证您的用户身份后七个工作日内尽快为您处理。账号注销后，除法律明确规定必须由我们保留的个人信息外（如您在多客圈子交易相关的信息），您的个人信息将会从多客圈子移除。</p><p><br/></p><p>六、有关第三方提供产品和/或服务的特别说明</p><p>多客圈子中可能包括第三方产品和/或服务或链接至第三方提供的信息和/或服务， 该第三方产品和/或服务在使用前，您需要跳转到相应的小程序或第三方页面。您使用该第三方服务（包括您向该第三方提供的任何个人信息），须受该第三方的服务条款及隐私政策（而非本政策）约束，您需要仔细阅读其条款并自行决定是否接受。 请您妥善保护自己的个人信息，仅在必要的情况下向他人提供。本政策仅适用于我们所收集、保存、使用、共享、披露信息，并不适用于任何第三方提供的服务或第三方的信息使用规则， 第三方使用您信息时的行为由其自行负责。</p><p><br/></p><p>七、我们如何使用Cookie和其他同类技术</p><p>1. Cookies的使用</p><p><br/></p><p>（1） 在您接受cookies的情况下，多客圈子会在您的计算机以及相关移动设备上设定或取用cookies，以便您能登录或使用依赖于cookies的多客圈子平台服务或功能。多客圈子使用cookies可为您提供更加周到的个性化服务，包括推广服务。</p><p><br/></p><p>（2） 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式或在移动设备中设置拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的多客圈子平台服务或功能。</p><p><br/></p><p>（3） 通过多客圈子所设cookies所取得的有关信息，将适用本政策。</p><p><br/></p><p>八、未成年人保护</p><p>以下条款请未成年用户（特别是未满十四周岁的儿童用户）在监护人的陪同下仔细阅读，并由监护人在充分理解后作出是否接受或拒绝本政策的决定：</p><p><br/></p><p>若用户是未满18周岁的未成年人（特别是未满十四周岁的儿童用户），应在监护人监护、指导并获得监护人同意情况下阅读本协议和使用多客圈子相关服务。</p><p><br/></p><p>我们重视对未成年人个人信息的保护，未成年用户在填写个人信息时，请加强个人保护意识并谨慎对待，请在监护人指导时正确使用多客圈子相关服务。</p><p><br/></p><p>我们将根据国家相关法律法规及本政策的规定保护未成年人用户信息的保密性及安全性。如果我们发现自己在未事先获得可证实的父母或法定监护人同意的情况下收集了未成年人的个人信息，则会设法尽快删除相关数据 。同时我们建立了严格的未成年人信息收集使用规则，以保护儿童和青少年个人信息安全，您可以通过阅读《多客圈子儿童/青少年个人信息保护规则》了解更具体的内容。若您是未成年人的监护人，当您对您所监护的未成年人使用我们的服务或其向我们提供的用户信息有任何疑问时，请您根据本政策第十条提供的联系方式及时与我们联系。</p><p><br/></p><p>九、我们如何更新隐私政策</p><p>为了给您提供更好的服务，我们会根据产品的更新情况及法律法规的相关要求更新本政策的条款，这些更新将构成本政策的一部分。未经您明确同意，我们不会削减您依据当前生效的本政策所应享受的权利。</p><p>如遇本政策更新，我们会通过APP客户端推送通知或其他合理方式通知您，以便您能及时了解本政策的最新版本。</p><p>十、如何联系我们</p><p>如您对个人信息保护问题有任何投诉、建议、疑问，或您对本政策有任何疑问，您可以通过以下方式联系我们，我们将尽快审核所涉问题，并在验证您的用户身份后的十五个工作日内予以答复：shuduizhang@xiaohongshu.com。</p><p><br/></p><p>十一、其他</p><p>因本政策以及我们处理您个人信息事宜引起的任何争议，您可诉至上海市黄浦区人民法院。</p><p><br/></p><p>如果您认为我们的个人信息处理行为损害了您的合法权益，您也可向有关政府部门进行反映。</p><p><br/></p>', '1651045925', '0');
INSERT INTO `xn_pages` VALUES ('32', '帮助中心', '', '11', '1', '<p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">1、下载客户端安装到自己的设备上，点击打开引导界面，选择使用者的性别等信息，设置完成之后可以在个人信息进行编辑和修改。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">2、搜索和关注自己喜欢的内容，点击上方的搜索框输入关键词或者关键语句对内容进行检索，找到对应的视频点击就可以看到。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">3、新用户登陆客户端需要使用账号和密码登陆，点击下方的用户注册，根据提示输入用户信息，注册完成使用账号登陆即可。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">4、在编辑个人信息的头像可以选择使用相册里的照片替换当前的头像，返回到主界面点击取消就可以撤销当前的操作。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">5、再就是客户端需要用户的授权才可以使用某些功能，在弹出的对话框里点击允许使用当前功能，不允许点击拒绝授权。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">6、登陆之后对用户的身份信息进行认证，点击我的进入到个人中心，找到下方的身份认证，补充其他的用户信息，进一步做到完善。</p><p style=\"margin: 10px auto; padding: 0px; font-size: 15px; line-height: 30px; color: rgb(51, 51, 51); overflow-wrap: break-word; font-family: &quot;Microsoft YaHei&quot;, 微软雅黑, &quot;PingFang SC&quot;, Arial, &quot;Heiti SC&quot;; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">7、在客户端收到的消息会保存在右上角的提醒选项里，点击上方的表示就可以看到未读和已读的消息，使用起来还是很方便的。</p><p><br/></p>', '1651045943', '0');

-- ----------------------------
-- Table structure for `xn_report`
-- ----------------------------
DROP TABLE IF EXISTS `xn_report`;
CREATE TABLE `xn_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `fa_user_id` int(10) DEFAULT '0',
  `content` varchar(200) DEFAULT '',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_report
-- ----------------------------
INSERT INTO `xn_report` VALUES ('37', '290', '55', '11', '不良消息，误导他人', '1663922507');
INSERT INTO `xn_report` VALUES ('39', '281', '2', '2', '不良消息，误导他人', '1663994124');
INSERT INTO `xn_report` VALUES ('40', '291', '50', '55', '不良消息，误导他人', '1664079922');
INSERT INTO `xn_report` VALUES ('41', '287', '58', '8', '不良消息，误导他人', '1664085027');
INSERT INTO `xn_report` VALUES ('42', '290', '59', '11', '不良消息，误导他人', '1664085363');
INSERT INTO `xn_report` VALUES ('43', '289', '61', '10', '不良消息，误导他人', '1664086824');
INSERT INTO `xn_report` VALUES ('44', '291', '65', '55', '不良消息，误导他人', '1664088132');

-- ----------------------------
-- Table structure for `xn_tags`
-- ----------------------------
DROP TABLE IF EXISTS `xn_tags`;
CREATE TABLE `xn_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `admin_id` int(10) DEFAULT '0',
  `image` varchar(255) DEFAULT '',
  `jianjie` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
  `goods_num` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_tags
-- ----------------------------
INSERT INTO `xn_tags` VALUES ('25', '为什么恋爱会让人降智', '2', '1', '0', '1', 'http://7niudukeyouxuan.51duoke.cn/1/20211223/06204da4589a9228b8ef760d93e6ef60.png', '为什么恋爱会让人降智', '0');
INSERT INTO `xn_tags` VALUES ('26', '工作到92岁是什么体验', '3', '1', '0', '1', '', '工作到92岁是什么体验', '0');
INSERT INTO `xn_tags` VALUES ('28', '为什么玩得好的人学得也好', '5', '1', '0', '0', '', '为什么玩得好的人学得也好', '0');
INSERT INTO `xn_tags` VALUES ('30', '爱上一个人需要理由吗', '7', '1', '0', '0', '', '爱上一个人需要理由吗', '0');
INSERT INTO `xn_tags` VALUES ('31', '谈恋爱长相重要吗', '0', '1', '0', '0', '', '谈恋爱长相重要吗', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=1445 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xn_upload_files
-- ----------------------------
INSERT INTO `xn_upload_files` VALUES ('1253', '0', '1', '1', 'banner.png', '503825', 'png', '/uploads/1/file/20220905/1ee98aedbc4b50e756efa5647fa2d3de.png', '1662366331');
INSERT INTO `xn_upload_files` VALUES ('1254', '0', '1', '1', '20180123120518400.jpg', '155798', 'jpg', '/uploads/1/file/20220905/d2d2f66c3570677bed5add64c694f21e.jpg', '1662367332');
INSERT INTO `xn_upload_files` VALUES ('1255', '0', '1', '1', '本地推广.png', '6676', 'png', '/uploads/1/file/20220906/87f0d20b6e80a2f273f658294bdcbec6.png', '1662435438');
INSERT INTO `xn_upload_files` VALUES ('1256', '0', '1', '1', '土特产.png', '6889', 'png', '/uploads/1/file/20220906/0c5df4131af82729263471401d976e85.png', '1662435464');
INSERT INTO `xn_upload_files` VALUES ('1257', '0', '1', '1', '物品交易.png', '7670', 'png', '/uploads/1/file/20220906/3bbae635e7ab2630196f196e4debac37.png', '1662435494');
INSERT INTO `xn_upload_files` VALUES ('1258', '0', '1', '1', '16424697889150313.jpg', '23582', 'jpg', '/uploads/1/file/20220910/881161a96e976c06e9612eadcd0272c5.jpg', '1662769804');
INSERT INTO `xn_upload_files` VALUES ('1259', '0', '1', '1', '16608688755823652.jpg', '29414', 'jpg', '/uploads/1/file/20220910/bc1d2bca22443d10f38bf9f6582fcfc0.jpg', '1662769812');
INSERT INTO `xn_upload_files` VALUES ('1260', '0', '1', '1', 'banner.jpg', '34654', 'jpg', '/uploads/1/file/20220912/75b131db753ac329b357bae9590f7ce7.jpg', '1662937137');
INSERT INTO `xn_upload_files` VALUES ('1261', '0', '1', '1', 'jiuguan.jpg', '100343', 'jpg', '/uploads/1/file/20220912/cda6d5cc6324a8a6051665d0d6ebf805.jpg', '1662937937');
INSERT INTO `xn_upload_files` VALUES ('1262', '0', '1', '1', 'adno2.jpg', '71650', 'jpg', '/uploads/1/file/20220912/b00b341eb4fcf41028436c2d35842bae.jpg', '1662938192');
INSERT INTO `xn_upload_files` VALUES ('1263', '0', '1', '1', 'adno3.jpg', '69764', 'jpg', '/uploads/1/file/20220912/ad10e71e40d31038659c168cb6348cfa.jpg', '1662938194');
INSERT INTO `xn_upload_files` VALUES ('1264', '0', '1', '1', 'adno4.jpg', '49867', 'jpg', '/uploads/1/file/20220912/c9c3492428699450f89b9e700f9c0d23.jpg', '1662938198');
INSERT INTO `xn_upload_files` VALUES ('1265', '0', '1', '1', 'adno5.jpg', '147631', 'jpg', '/uploads/1/file/20220912/1d5512069768eccebc92acff67a56d10.jpg', '1662938201');
INSERT INTO `xn_upload_files` VALUES ('1266', '0', '1', '1', 'content_1.jpeg', '162545', 'jpeg', '/uploads/1/file/20220912/483262b183422aa9d3b4504b54563c20.jpeg', '1662938205');
INSERT INTO `xn_upload_files` VALUES ('1267', '0', '1', '1', '沙雕.jpg', '42592', 'jpg', '/uploads/1/file/20220912/3b4bf520267658f5f4988933582e13e0.jpg', '1662938435');
INSERT INTO `xn_upload_files` VALUES ('1268', '0', '1', '1', 'youxi.jpeg', '47081', 'jpeg', '/uploads/1/file/20220912/f629131c3085c93b8879f9a5169de877.jpeg', '1662938554');
INSERT INTO `xn_upload_files` VALUES ('1269', '0', '1', '1', 'banner.png', '284801', 'png', '/uploads/1/file/20220912/17ffa6456ace3e438311ffe123824e3c.png', '1662938771');
INSERT INTO `xn_upload_files` VALUES ('1270', '0', '1', '1', 'banner.png', '524288', 'png', '/uploads/1/file/20220912/ec14f03e596b500498d02392b114cfdd.png', '1662938771');
INSERT INTO `xn_upload_files` VALUES ('1271', '0', '1', '1', '2020z5vskigajo5.jpg', '52754', 'jpg', '/uploads/1/file/20220913/d31bae1e90d833f317b0b6857d11f3c1.jpg', '1663005942');
INSERT INTO `xn_upload_files` VALUES ('1272', '0', '1', '1', '7.jpeg', '59881', 'jpeg', '/uploads/1/file/20220913/b3ab71c5f002ffd52eaf469b107105fd.jpeg', '1663006079');
INSERT INTO `xn_upload_files` VALUES ('1273', '0', '1', '1', '1640182884657.png', '2476', 'png', '/uploads/1/file/20220915/cdd55477dd88c45bba3c038e3adf81df.png', '1663246895');
INSERT INTO `xn_upload_files` VALUES ('1274', '0', '1', '1', 'fatie.png', '10898', 'png', '/uploads/1/file/20220916/41e7433374ec4ca3a85eefc2809179c9.png', '1663315817');
INSERT INTO `xn_upload_files` VALUES ('1275', '0', '1', '1', 'dianzan.png', '11882', 'png', '/uploads/1/file/20220916/3ccb0ad7ea678120475d11dae3fdd846.png', '1663315841');
INSERT INTO `xn_upload_files` VALUES ('1276', '0', '1', '1', 'huangguan.png', '10295', 'png', '/uploads/1/file/20220916/e58a51ceaac5d26f047afb9f5cbae1cd.png', '1663315862');
INSERT INTO `xn_upload_files` VALUES ('1277', '0', '3', '1', '小白截图20220916122149.png', '315945', 'png', '/uploads/1/file/20220919/abe0ec1c8c5482c0fb91363f03a45eb3.png', '1663570069');
INSERT INTO `xn_upload_files` VALUES ('1278', '0', '3', '1', '小白截图20220916122149.png', '315945', 'png', '/uploads/1/file/20220919/ea261aa9be84de49bfaee729060bb5a1.png', '1663570173');
INSERT INTO `xn_upload_files` VALUES ('1279', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/607e7017e62fb259bf613ebba6ebd628.png', '1663570524');
INSERT INTO `xn_upload_files` VALUES ('1280', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/a79b6a86f23d9292963d4edb6668f451.png', '1663570524');
INSERT INTO `xn_upload_files` VALUES ('1281', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/fb2cd35064952edc923b5c5e4e5e0683.png', '1663571124');
INSERT INTO `xn_upload_files` VALUES ('1282', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/d2a9f05625be62147f72d94badd7bed1.png', '1663571125');
INSERT INTO `xn_upload_files` VALUES ('1283', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/d253eaf426adb22a9ae5e205a28017b4.png', '1663571663');
INSERT INTO `xn_upload_files` VALUES ('1284', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/e19b9a4f29129d10f64bc23a81d7e8b9.png', '1663571664');
INSERT INTO `xn_upload_files` VALUES ('1285', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/43c0b027648063d61cc38e6ad8cc92c8.png', '1663571878');
INSERT INTO `xn_upload_files` VALUES ('1286', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/e806143fd5603b0d453b5b7b8f71bd24.png', '1663571957');
INSERT INTO `xn_upload_files` VALUES ('1287', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/ab656a3822beae9a9afc17ab9a3e89e4.png', '1663571958');
INSERT INTO `xn_upload_files` VALUES ('1288', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/4b0a2d774f5b64f263780c935a5d5891.png', '1663571959');
INSERT INTO `xn_upload_files` VALUES ('1289', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/5cba75204ae784c12a30d9a947864899.png', '1663572335');
INSERT INTO `xn_upload_files` VALUES ('1290', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/05afc008ab4d2ab5f6bba3b615dd2688.png', '1663572335');
INSERT INTO `xn_upload_files` VALUES ('1291', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/17ea20a7b5a2140dc614f415060d4cd5.png', '1663573329');
INSERT INTO `xn_upload_files` VALUES ('1292', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/9ea7c5db6ba2eee8fc31e92b9191d4b4.png', '1663573330');
INSERT INTO `xn_upload_files` VALUES ('1293', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/2a407a62c898c6dbb16b6f76e18808f8.png', '1663573330');
INSERT INTO `xn_upload_files` VALUES ('1294', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/b9a5228d81995b973922b981fb1c8ad6.png', '1663573565');
INSERT INTO `xn_upload_files` VALUES ('1295', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/eb2081d6e7f1e5f2e63a0a2fa532a162.png', '1663573565');
INSERT INTO `xn_upload_files` VALUES ('1296', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/283b6ec3b887fdcaf46ca488e9948be0.png', '1663573750');
INSERT INTO `xn_upload_files` VALUES ('1297', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/3bb6ca94ee75721d1eb95d9828b35451.png', '1663573856');
INSERT INTO `xn_upload_files` VALUES ('1298', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/d954e92439ac2a4094b738ff781b4ab8.png', '1663574153');
INSERT INTO `xn_upload_files` VALUES ('1299', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/da022bfe79395840bcbb897bc3201c6c.png', '1663574154');
INSERT INTO `xn_upload_files` VALUES ('1300', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/ffce1ec5c55f8187a62a9cd132750862.png', '1663574203');
INSERT INTO `xn_upload_files` VALUES ('1301', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/cae29e52524a9c560b5ea93df625d59f.png', '1663574204');
INSERT INTO `xn_upload_files` VALUES ('1302', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/95e5a3ed5dd6e5a3819863e4d45fcbca.png', '1663574532');
INSERT INTO `xn_upload_files` VALUES ('1303', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/60455d0979d9c818a679a64c932bdf41.png', '1663575072');
INSERT INTO `xn_upload_files` VALUES ('1304', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/b36054903f8ae781d19033e7c2b42146.png', '1663575072');
INSERT INTO `xn_upload_files` VALUES ('1305', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/ff46ea0e58ade62dfac04d5dbe996d73.png', '1663575099');
INSERT INTO `xn_upload_files` VALUES ('1306', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/557c53ade0270fe769cf7c0be7f32acd.png', '1663575099');
INSERT INTO `xn_upload_files` VALUES ('1307', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/95db9261703def45372775d5df387a93.png', '1663575196');
INSERT INTO `xn_upload_files` VALUES ('1308', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/1085be9ea2f2c0f6370a90b5bf6492e4.png', '1663575226');
INSERT INTO `xn_upload_files` VALUES ('1309', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/4c952067fc95b50e3b7338645273bc88.png', '1663575265');
INSERT INTO `xn_upload_files` VALUES ('1310', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/101ae8fed89b3a8a1e6686e01b7cbac4.png', '1663575276');
INSERT INTO `xn_upload_files` VALUES ('1311', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/5f13ebfb468833e74850144402ada50b.png', '1663575290');
INSERT INTO `xn_upload_files` VALUES ('1312', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/a00a6aec6ec8086de45dd454d454b69e.png', '1663575306');
INSERT INTO `xn_upload_files` VALUES ('1313', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/3c1c1af934e6353b774daaad8df8b4cc.png', '1663575330');
INSERT INTO `xn_upload_files` VALUES ('1314', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/fb352ab0d470212669b07c6372191326.png', '1663575361');
INSERT INTO `xn_upload_files` VALUES ('1315', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/ae86f4313d4177b1e1973511b85b840b.png', '1663575381');
INSERT INTO `xn_upload_files` VALUES ('1316', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/f2a3dcc7fd62979c464bde865bf8f7e7.png', '1663575426');
INSERT INTO `xn_upload_files` VALUES ('1317', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/c20ff7a5b7574811b3d08bddc3956522.png', '1663575503');
INSERT INTO `xn_upload_files` VALUES ('1318', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/446d6621d392f0299b54425894bccb2a.png', '1663575669');
INSERT INTO `xn_upload_files` VALUES ('1319', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/e26b654ec312acf5b9a1307edcfa4c56.png', '1663575693');
INSERT INTO `xn_upload_files` VALUES ('1320', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/91c585a96057ef3dc352fa991fb03ee6.png', '1663575710');
INSERT INTO `xn_upload_files` VALUES ('1321', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/a68c1f3205260583a0f508ba36b1eb60.png', '1663575779');
INSERT INTO `xn_upload_files` VALUES ('1322', '0', '3', '1', '医院.png', '3583', 'png', '/uploads/1/file/20220919/6fb40692fc90625f83671a81aba14721.png', '1663575779');
INSERT INTO `xn_upload_files` VALUES ('1323', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/f439f4b348819d01c83e7998725321c6.png', '1663575825');
INSERT INTO `xn_upload_files` VALUES ('1324', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/3e9c00b8da4f69786fbf2c664bbd88b0.png', '1663575837');
INSERT INTO `xn_upload_files` VALUES ('1325', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/83096b7646ef248d47775881a87bdd6d.png', '1663575917');
INSERT INTO `xn_upload_files` VALUES ('1326', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/a5a9d6dbd0304d6156453585dc83ae2e.png', '1663575938');
INSERT INTO `xn_upload_files` VALUES ('1327', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/491aa77c28358034657888abe55439af.png', '1663577464');
INSERT INTO `xn_upload_files` VALUES ('1328', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/8dc9af918bb4426bd4e72961593dcf6f.png', '1663577583');
INSERT INTO `xn_upload_files` VALUES ('1329', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/e9668d58110a3b7640c0eaecbc36f522.png', '1663577621');
INSERT INTO `xn_upload_files` VALUES ('1330', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/caceba60c95fe1bea52e90def59a5aeb.png', '1663577648');
INSERT INTO `xn_upload_files` VALUES ('1331', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/291a308f7521186d0dbc18618c077724.png', '1663577664');
INSERT INTO `xn_upload_files` VALUES ('1332', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/8b6ab4c94910765353cc1847f75c41a8.png', '1663578128');
INSERT INTO `xn_upload_files` VALUES ('1333', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/cebc7bf4a183a44016f869350d294a1e.png', '1663578237');
INSERT INTO `xn_upload_files` VALUES ('1334', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/54bbb994597ce4ddb29051b1140741e9.png', '1663578237');
INSERT INTO `xn_upload_files` VALUES ('1335', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/f4bb4cc874203ccadacdfb1ecc61ff7b.png', '1663578237');
INSERT INTO `xn_upload_files` VALUES ('1336', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/90e96bb57ea0abfbcd61f13ca4a3a204.png', '1663578306');
INSERT INTO `xn_upload_files` VALUES ('1337', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/5c898f02f19ef73f3ecc8096f97e656a.png', '1663578306');
INSERT INTO `xn_upload_files` VALUES ('1338', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/162de6de5b8b3f2b92aeb5e7b8f18327.png', '1663578306');
INSERT INTO `xn_upload_files` VALUES ('1339', '0', '3', '1', '书店.png', '2970', 'png', '/uploads/1/file/20220919/e9f1773f017b52eb340955460e21ae7c.png', '1663578521');
INSERT INTO `xn_upload_files` VALUES ('1340', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/baf2e37694a8e6573757e30ff1e8e43e.png', '1663578522');
INSERT INTO `xn_upload_files` VALUES ('1341', '0', '3', '1', '停车场.png', '4302', 'png', '/uploads/1/file/20220919/a07a111870b1c050547fc5302153fb24.png', '1663578522');
INSERT INTO `xn_upload_files` VALUES ('1342', '0', '3', '1', '体育.png', '7202', 'png', '/uploads/1/file/20220919/cd6e6a368a73e185ebe44b56b7d9b35f.png', '1663579412');
INSERT INTO `xn_upload_files` VALUES ('1343', '0', '3', '1', 'jiuguan.jpg', '334822', 'jpg', '/uploads/1/file/20220919/a47c8d872993fb2df1983c6fbae2bf7b.jpg', '1663579468');
INSERT INTO `xn_upload_files` VALUES ('1348', '0', '3', '1', '16424697889150313.jpg', '20617', 'jpg', '/uploads/1/file/20220920/de3532d35a3dc37490c6d214d390c8a9.jpg', '1663655357');
INSERT INTO `xn_upload_files` VALUES ('1349', '0', '3', '1', '小白截图20220920124749.png', '981103', 'png', '/uploads/1/file/20220920/d33b93ac9febc41d6ec1c70f901e5bc0.png', '1663655358');
INSERT INTO `xn_upload_files` VALUES ('1346', '0', '3', '1', '16608688755823652.jpg', '51375', 'jpg', '/uploads/1/file/20220920/d009c7994fa6d475e87b1caa36e38f02.jpg', '1663651460');
INSERT INTO `xn_upload_files` VALUES ('1347', '0', '3', '1', '16608688755823652.jpg', '51375', 'jpg', '/uploads/1/file/20220920/d9a4e0018b6f3420f6ac1c705ac3f11a.jpg', '1663651576');
INSERT INTO `xn_upload_files` VALUES ('1350', '0', '1', '1', 'adno4.jpg', '49867', 'jpg', '/uploads/1/file/20220920/f482027a1775d103c324103948bf43d2.jpg', '1663655991');
INSERT INTO `xn_upload_files` VALUES ('1351', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/467e61565785e2178ed11650df332c51.jpeg', '1663658081');
INSERT INTO `xn_upload_files` VALUES ('1352', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/cf8ecd9ada01fe63d4c19fb8731ae769.jpeg', '1663658154');
INSERT INTO `xn_upload_files` VALUES ('1353', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/77396cb2d727be8490a26299aacb176b.jpg', '1663658154');
INSERT INTO `xn_upload_files` VALUES ('1354', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/c6c01a45fc39950b72e97e7e586753e2.jpeg', '1663658484');
INSERT INTO `xn_upload_files` VALUES ('1355', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/4f6862b4bfbf553946ff183dd9353062.jpg', '1663658484');
INSERT INTO `xn_upload_files` VALUES ('1356', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/866f93e4ea9ef00a2c20d33767de508d.jpeg', '1663658637');
INSERT INTO `xn_upload_files` VALUES ('1357', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/24b6cfb12c83c6f0d5a84fa263887d2b.jpg', '1663658638');
INSERT INTO `xn_upload_files` VALUES ('1358', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/14c03049973fa01e8a035cb455e37e9b.jpeg', '1663658712');
INSERT INTO `xn_upload_files` VALUES ('1359', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/92d1bca3b5ddae689f5bff12e2c842ba.jpg', '1663658712');
INSERT INTO `xn_upload_files` VALUES ('1360', '0', '3', '1', '19110300_43.jpeg', '54195', 'jpeg', '/uploads/1/file/20220920/0b18d0dac2d89b01d0d678915b86bb3d.jpeg', '1663658801');
INSERT INTO `xn_upload_files` VALUES ('1361', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/a5f944a739ecb5c3499cda60a967e6e3.jpg', '1663658802');
INSERT INTO `xn_upload_files` VALUES ('1362', '0', '1', '1', 'e0a958952719a560285dcc4693e2835e.png', '45123', 'png', '/uploads/1/file/20220920/a6aae5f19b89fbebb69f1297eefe266b.png', '1663658980');
INSERT INTO `xn_upload_files` VALUES ('1363', '0', '3', '1', '19110300_105.jpeg', '47862', 'jpeg', '/uploads/1/file/20220920/fbc34ec6867f5286ba4730102e9d0e80.jpeg', '1663659131');
INSERT INTO `xn_upload_files` VALUES ('1364', '0', '3', '1', 'adno2.jpg', '136800', 'jpg', '/uploads/1/file/20220920/9750a3f83821f2f88edb8b6e6bce1173.jpg', '1663659131');
INSERT INTO `xn_upload_files` VALUES ('1365', '0', '3', '1', '19110300_55.jpeg', '42159', 'jpeg', '/uploads/1/file/20220920/69c10d790b7b86c347576e628a0993f3.jpeg', '1663659191');
INSERT INTO `xn_upload_files` VALUES ('1366', '0', '3', '1', 'adno3.jpg', '113841', 'jpg', '/uploads/1/file/20220920/61278de783066acf266fbb90cbf83ae5.jpg', '1663659192');
INSERT INTO `xn_upload_files` VALUES ('1367', '0', '1', '1', 'medal2.gif', '26321', 'gif', '/uploads/1/file/20220921/b8412f8258d2435e57b64de7cd8dc6c3.gif', '1663727023');
INSERT INTO `xn_upload_files` VALUES ('1368', '0', '1', '1', '12.jpg', '32334', 'jpg', '/uploads/1/file/20220921/69cb53d22b693b8a0070983368c1de66.jpg', '1663730877');
INSERT INTO `xn_upload_files` VALUES ('1369', '0', '1', '1', 'xunzhang1.png', '19563', 'png', '/uploads/1/file/20220921/c02be53e300bac90a22d3c32bff93cb6.png', '1663749362');
INSERT INTO `xn_upload_files` VALUES ('1370', '0', '1', '1', 'xunzhang2.png', '18855', 'png', '/uploads/1/file/20220921/7df86b9a47f2957462cb495a2577e858.png', '1663749372');
INSERT INTO `xn_upload_files` VALUES ('1371', '0', '1', '1', 'xunzhang3.png', '18661', 'png', '/uploads/1/file/20220921/66d74bac35ede57b6ede542c4f4e32c4.png', '1663749383');
INSERT INTO `xn_upload_files` VALUES ('1372', '0', '3', '1', '1663828734058.jpeg', '36184', 'jpeg', '/uploads/1/file/20220922/8642d389726858c2b770dca1f2656b14.jpeg', '1663828732');
INSERT INTO `xn_upload_files` VALUES ('1373', '0', '1', '1', '1.jpg', '174469', 'jpg', '/uploads/1/file/20220922/5927e61296002a7152340c9c88fdee36.jpg', '1663828929');
INSERT INTO `xn_upload_files` VALUES ('1374', '0', '1', '1', '2.jpg', '150888', 'jpg', '/uploads/1/file/20220922/3d3d7c51ca0705a0f22846137feb8708.jpg', '1663828929');
INSERT INTO `xn_upload_files` VALUES ('1375', '0', '1', '1', '3.jpg', '110139', 'jpg', '/uploads/1/file/20220922/19d7313e14863b18b4e344d915447d57.jpg', '1663828929');
INSERT INTO `xn_upload_files` VALUES ('1376', '0', '1', '1', '4.jpg', '136659', 'jpg', '/uploads/1/file/20220922/a244daa5dfb114b90bb736727a1206af.jpg', '1663828929');
INSERT INTO `xn_upload_files` VALUES ('1377', '0', '1', '1', '1.jpg', '194118', 'jpg', '/uploads/1/file/20220922/1c6e2911b6483ac8873c90a028e9d317.jpg', '1663829445');
INSERT INTO `xn_upload_files` VALUES ('1378', '0', '1', '1', '2.jpg', '182770', 'jpg', '/uploads/1/file/20220922/744fe1d64ca7f0a6e3b5d4eb536b4d0e.jpg', '1663829445');
INSERT INTO `xn_upload_files` VALUES ('1379', '0', '1', '1', '3.jpg', '216333', 'jpg', '/uploads/1/file/20220922/fc78af79d93c7673653c805d0ff850d3.jpg', '1663829445');
INSERT INTO `xn_upload_files` VALUES ('1380', '0', '1', '1', '5.jpg', '195181', 'jpg', '/uploads/1/file/20220922/f197d90cb3eebdb54bfd51052a1be728.jpg', '1663829445');
INSERT INTO `xn_upload_files` VALUES ('1381', '0', '1', '1', '4.jpg', '211267', 'jpg', '/uploads/1/file/20220922/4f0b43e797cd2db90b45ddde37a4d653.jpg', '1663829445');
INSERT INTO `xn_upload_files` VALUES ('1382', '0', '1', '1', '1.jpg', '4668', 'jpg', '/uploads/1/file/20220922/f2a979afb9287a1f62c35f00430ccf6c.jpg', '1663829551');
INSERT INTO `xn_upload_files` VALUES ('1383', '0', '1', '1', '2.jpg', '4671', 'jpg', '/uploads/1/file/20220922/d1e96535edc948c0c541b550d1aecf1d.jpg', '1663829551');
INSERT INTO `xn_upload_files` VALUES ('1384', '0', '1', '1', '3.jpg', '4017', 'jpg', '/uploads/1/file/20220922/dc9833ef0ac96abf028e89fb7dce8031.jpg', '1663829551');
INSERT INTO `xn_upload_files` VALUES ('1385', '0', '1', '1', '4.jpg', '3395', 'jpg', '/uploads/1/file/20220922/779c141932c62c1a206d15504f51d65d.jpg', '1663829551');
INSERT INTO `xn_upload_files` VALUES ('1386', '0', '1', '1', '1 (1).jpg', '4351', 'jpg', '/uploads/1/file/20220922/db9aafd5e63ab3cf411dde24943cb408.jpg', '1663829676');
INSERT INTO `xn_upload_files` VALUES ('1387', '0', '1', '1', '3.jpg', '3744', 'jpg', '/uploads/1/file/20220922/f6608b50803a3a0bb7d206879684924e.jpg', '1663829676');
INSERT INTO `xn_upload_files` VALUES ('1388', '0', '1', '1', '2.jpg', '4379', 'jpg', '/uploads/1/file/20220922/ea8c4e89aba2b81bf83b77c1ea0a0787.jpg', '1663829676');
INSERT INTO `xn_upload_files` VALUES ('1389', '0', '1', '1', '4.jpg', '4124', 'jpg', '/uploads/1/file/20220922/f9148081493f1d2791150c318161b4d1.jpg', '1663829676');
INSERT INTO `xn_upload_files` VALUES ('1390', '0', '1', '1', '5.jpg', '3614', 'jpg', '/uploads/1/file/20220922/67bbb6f168f052c136cd5f162030830f.jpg', '1663829677');
INSERT INTO `xn_upload_files` VALUES ('1391', '0', '1', '1', '6.jpg', '3493', 'jpg', '/uploads/1/file/20220922/96277a9fe3c5e16b86ee5304539ebc01.jpg', '1663829677');
INSERT INTO `xn_upload_files` VALUES ('1392', '0', '1', '1', '1.jpg', '3964', 'jpg', '/uploads/1/file/20220922/7c8562f9db34062468d74793a115d8ee.jpg', '1663829949');
INSERT INTO `xn_upload_files` VALUES ('1393', '0', '1', '1', '3.jpg', '3685', 'jpg', '/uploads/1/file/20220922/0d4f19440d0e293d42a02a4b7784570d.jpg', '1663829949');
INSERT INTO `xn_upload_files` VALUES ('1394', '0', '1', '1', '2.jpg', '3890', 'jpg', '/uploads/1/file/20220922/9bd3bb6ea003fd763a2b133a12b481ad.jpg', '1663829949');
INSERT INTO `xn_upload_files` VALUES ('1395', '0', '1', '1', '4.jpg', '2932', 'jpg', '/uploads/1/file/20220922/792478682afe887fb41ae06d2da9464c.jpg', '1663829949');
INSERT INTO `xn_upload_files` VALUES ('1396', '0', '1', '1', '5.jpg', '4487', 'jpg', '/uploads/1/file/20220922/0af81e0d12f665cc63eb412a57bc71be.jpg', '1663829949');
INSERT INTO `xn_upload_files` VALUES ('1397', '0', '1', '1', '1.jpg', '3651', 'jpg', '/uploads/1/file/20220922/1d9e301bb6191d9c7a8e25f0de55730a.jpg', '1663830035');
INSERT INTO `xn_upload_files` VALUES ('1398', '0', '1', '1', '2.jpg', '3484', 'jpg', '/uploads/1/file/20220922/0abb1a28b332b1ffb68629350711a119.jpg', '1663830035');
INSERT INTO `xn_upload_files` VALUES ('1399', '0', '1', '1', '3.jpg', '3754', 'jpg', '/uploads/1/file/20220922/50cd9509d5569d8d16d871409fa7e495.jpg', '1663830035');
INSERT INTO `xn_upload_files` VALUES ('1400', '0', '1', '1', '4.jpg', '3358', 'jpg', '/uploads/1/file/20220922/162117b9713c39f367ed8335c47519d4.jpg', '1663830035');
INSERT INTO `xn_upload_files` VALUES ('1401', '0', '1', '1', '5.jpg', '4231', 'jpg', '/uploads/1/file/20220922/9b4cdfc995f62b5c356b862eeab7ca32.jpg', '1663830035');
INSERT INTO `xn_upload_files` VALUES ('1402', '0', '1', '1', '6.jpg', '4324', 'jpg', '/uploads/1/file/20220922/d5b31662ee83d74e97cef723c7f93779.jpg', '1663830036');
INSERT INTO `xn_upload_files` VALUES ('1403', '0', '1', '1', '1.jpg', '242212', 'jpg', '/uploads/1/file/20220922/d87094f4116df873e22c7a7f00d68628.jpg', '1663830157');
INSERT INTO `xn_upload_files` VALUES ('1404', '0', '1', '1', '2.jpg', '190516', 'jpg', '/uploads/1/file/20220922/3d866318653c92c3747e1a23a977425d.jpg', '1663830157');
INSERT INTO `xn_upload_files` VALUES ('1405', '0', '1', '1', '3.jpg', '283330', 'jpg', '/uploads/1/file/20220922/eb7a59fa25a8697664492a22ce0c5309.jpg', '1663830158');
INSERT INTO `xn_upload_files` VALUES ('1406', '0', '1', '1', '4.jpg', '195719', 'jpg', '/uploads/1/file/20220922/cb656fbcbc3fef47e097e30e93bcb018.jpg', '1663830158');
INSERT INTO `xn_upload_files` VALUES ('1407', '0', '1', '1', '5.jpg', '235583', 'jpg', '/uploads/1/file/20220922/894fb4567a52d821a09345705d92efed.jpg', '1663830158');
INSERT INTO `xn_upload_files` VALUES ('1408', '0', '1', '1', '6.jpg', '250906', 'jpg', '/uploads/1/file/20220922/48a65e384ecba59de037e722f3dfa7f1.jpg', '1663830158');
INSERT INTO `xn_upload_files` VALUES ('1409', '0', '3', '1', '1663830277451.jpeg', '36759', 'jpeg', '/uploads/1/file/20220922/c8c0402fba4b74ee9bae204bfae9461c.jpeg', '1663830275');
INSERT INTO `xn_upload_files` VALUES ('1410', '0', '1', '1', '1.jpg', '187875', 'jpg', '/uploads/1/file/20220922/018776d9e9838bf9bf48b59246bec110.jpg', '1663830281');
INSERT INTO `xn_upload_files` VALUES ('1411', '0', '1', '1', '3.jpg', '150811', 'jpg', '/uploads/1/file/20220922/be981413b04c8f75dfb310745e0a72ff.jpg', '1663830281');
INSERT INTO `xn_upload_files` VALUES ('1412', '0', '1', '1', '2.jpg', '207334', 'jpg', '/uploads/1/file/20220922/dcb7cc67d171c1e19d77d203305a2ca1.jpg', '1663830281');
INSERT INTO `xn_upload_files` VALUES ('1413', '0', '1', '1', '1.jpg', '172428', 'jpg', '/uploads/1/file/20220922/6d0d3272cf6fd1bd0599473a114ed73a.jpg', '1663830564');
INSERT INTO `xn_upload_files` VALUES ('1414', '0', '1', '1', '2.jpg', '188389', 'jpg', '/uploads/1/file/20220922/affca43f272c8ffbac3faeddf9ee178c.jpg', '1663830564');
INSERT INTO `xn_upload_files` VALUES ('1415', '0', '1', '1', '3.jpg', '165662', 'jpg', '/uploads/1/file/20220922/fe51aed603710e8b8a88cc822376214c.jpg', '1663830564');
INSERT INTO `xn_upload_files` VALUES ('1416', '0', '1', '1', '5.jpg', '174289', 'jpg', '/uploads/1/file/20220922/9f0e7725bb56c286cc5a73cd5ffdf428.jpg', '1663830565');
INSERT INTO `xn_upload_files` VALUES ('1417', '0', '1', '1', '4.jpg', '198543', 'jpg', '/uploads/1/file/20220922/655f960900681139b938de7fe465937e.jpg', '1663830565');
INSERT INTO `xn_upload_files` VALUES ('1418', '0', '1', '1', '6.jpg', '252271', 'jpg', '/uploads/1/file/20220922/94b0a745b65d0716a5c6ea499f913249.jpg', '1663830565');
INSERT INTO `xn_upload_files` VALUES ('1419', '0', '1', '1', '1.jpg', '227719', 'jpg', '/uploads/1/file/20220922/f6c50894709ed4915b1dfb4c8f07e854.jpg', '1663830722');
INSERT INTO `xn_upload_files` VALUES ('1420', '0', '1', '1', '2.jpg', '241163', 'jpg', '/uploads/1/file/20220922/8b082cf1d06d1f7cc3e3e40d6cc0ce36.jpg', '1663830722');
INSERT INTO `xn_upload_files` VALUES ('1421', '0', '1', '1', '3.jpg', '212255', 'jpg', '/uploads/1/file/20220922/82c3cdfe4bdc27449c86286df99176f0.jpg', '1663830722');
INSERT INTO `xn_upload_files` VALUES ('1422', '0', '1', '1', '5.jpg', '195699', 'jpg', '/uploads/1/file/20220922/327ae113c70ce120efbf8277d0fd3388.jpg', '1663830723');
INSERT INTO `xn_upload_files` VALUES ('1423', '0', '1', '1', '4.jpg', '223910', 'jpg', '/uploads/1/file/20220922/d706a3c1c307bbab5ed984773b0f468a.jpg', '1663830723');
INSERT INTO `xn_upload_files` VALUES ('1424', '0', '1', '1', '6.jpg', '182252', 'jpg', '/uploads/1/file/20220922/3bb39493eaeb3143765359fb8d40f79e.jpg', '1663830723');
INSERT INTO `xn_upload_files` VALUES ('1425', '0', '3', '1', '1663831272165.jpeg', '55245', 'jpeg', '/uploads/1/file/20220922/e6a528d6123d3f8e8a44441a90aff2d1.jpeg', '1663831270');
INSERT INTO `xn_upload_files` VALUES ('1426', '0', '3', '1', '1663831289373.jpeg', '70000', 'jpeg', '/uploads/1/file/20220922/7e3bad5a962fda545d29717c69e9ef69.jpeg', '1663831287');
INSERT INTO `xn_upload_files` VALUES ('1427', '0', '3', '1', '1663831401852.jpeg', '35517', 'jpeg', '/uploads/1/file/20220922/fce3e7fe2f8cfd15bad6cad62eaee9cb.jpeg', '1663831400');
INSERT INTO `xn_upload_files` VALUES ('1428', '0', '3', '1', '1663831443556.jpeg', '70361', 'jpeg', '/uploads/1/file/20220922/4ae6d794db4d3746cad184a98f4bf971.jpeg', '1663831441');
INSERT INTO `xn_upload_files` VALUES ('1429', '0', '3', '1', '1663831473743.jpeg', '86640', 'jpeg', '/uploads/1/file/20220922/0d2621cb60d0630bad68ddde81cee97a.jpeg', '1663831471');
INSERT INTO `xn_upload_files` VALUES ('1430', '0', '3', '1', '1663831556063.jpeg', '42957', 'jpeg', '/uploads/1/file/20220922/15f96e085e7963ea56c8bb22003edaa4.jpeg', '1663831554');
INSERT INTO `xn_upload_files` VALUES ('1431', '0', '3', '1', '1663831601665.jpeg', '73512', 'jpeg', '/uploads/1/file/20220922/fdff45e2cad52d610db333750a185586.jpeg', '1663831599');
INSERT INTO `xn_upload_files` VALUES ('1432', '0', '3', '1', '1663831643942.jpeg', '36184', 'jpeg', '/uploads/1/file/20220922/008074c7fac5a5854fc64b7d80e1f922.jpeg', '1663831642');
INSERT INTO `xn_upload_files` VALUES ('1433', '0', '3', '1', '1663831678568.jpeg', '36184', 'jpeg', '/uploads/1/file/20220922/a2887dbee8dc27ad8c30a4a61830b251.jpeg', '1663831676');
INSERT INTO `xn_upload_files` VALUES ('1434', '0', '3', '1', '1663832064294.jpeg', '58199', 'jpeg', '/uploads/1/file/20220922/59e59b3724b5ee2422f98e92b3833b7f.jpeg', '1663832062');
INSERT INTO `xn_upload_files` VALUES ('1435', '0', '3', '1', 'tmp_9e5d1dd1d1e18cafdd57aa49bebd0c59.jpg', '40715', 'jpg', '/uploads/1/file/20220923/987fff8b7b1aa7ab22b179d5f3296b87.jpg', '1663904394');
INSERT INTO `xn_upload_files` VALUES ('1436', '0', '1', '1', 'ico.png', '8671', 'png', '/uploads/1/file/20220923/1144400642bf03b425c10279af25fa9a.png', '1663927385');
INSERT INTO `xn_upload_files` VALUES ('1437', '0', '3', '1', 'tmp_63fe1b826ae3cbb3b1fec2dab5aa4953.jpg', '16681', 'jpg', '/uploads/1/file/20220924/ff020e14fbdd64d13e787ed9496a6f01.jpg', '1663988801');
INSERT INTO `xn_upload_files` VALUES ('1438', '0', '3', '1', 'tmp_c10f63e0708e99906b6c68c4f004082b.jpg', '79070', 'jpg', '/uploads/1/file/20220924/0c4bfdcb7e0be2aa2443d0776edb0eb9.jpg', '1663988802');
INSERT INTO `xn_upload_files` VALUES ('1439', '0', '3', '1', 'tmp_941070e3237c1d3332fa349c8458eca3.jpg', '19898', 'jpg', '/uploads/1/file/20220924/e851c14b96a53122e8695d364a7ee236.jpg', '1663988803');
INSERT INTO `xn_upload_files` VALUES ('1440', '0', '3', '1', 'tmp_6d555e2ee9f11e6d9cec2c3f1f94f5c4.jpg', '33973', 'jpg', '/uploads/1/file/20220925/07bdd899e01c854e44cd156e86742b8c.jpg', '1664079187');
INSERT INTO `xn_upload_files` VALUES ('1441', '0', '3', '1', 'tmp_757fd65c46958214dd15f10f3375ab57.jpg', '33973', 'jpg', '/uploads/1/file/20220925/fda0d2c6ace79f56bae7bae6da91ec56.jpg', '1664080409');
INSERT INTO `xn_upload_files` VALUES ('1442', '0', '3', '1', 'tmp_935ad375dc8f1db1fe041a835bfb17c1.jpg', '503202', 'jpg', '/uploads/1/file/20220925/8e6007aef3aa0b55e018aeee4e6e7737.jpg', '1664085740');
INSERT INTO `xn_upload_files` VALUES ('1443', '0', '3', '1', 'tmp_3c6d6b6f14aa609fc8d94706efcbbd6d.jpg', '503202', 'jpg', '/uploads/1/file/20220925/8233f24735dcb5817f1858609bd63009.jpg', '1664085741');
INSERT INTO `xn_upload_files` VALUES ('1444', '0', '3', '1', 'tmp_325ff8554176b9a088b3f97ec4e5448835a0b960a8b7589f.jpg', '52128', 'jpg', '/uploads/1/file/20220925/3e18f45a5288539c12cadfdcba257fa8.jpg', '1664087788');

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
  `nickname` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户状态;0正常 1禁言',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `open_id` varchar(125) DEFAULT '' COMMENT 'openid',
  `client_type` tinyint(1) DEFAULT '1' COMMENT '1pc端 2移动端 3安卓App 4IOSApp 5微信小程序',
  `unionid` varchar(120) DEFAULT '',
  `bg_img` varchar(255) DEFAULT '',
  `shenfen` varchar(20) DEFAULT NULL,
  `fans_num` int(10) DEFAULT '0',
  `vip` int(10) DEFAULT '0',
  `dec` varchar(255) DEFAULT '' COMMENT '个人介绍',
  `is_see_follow` int(10) DEFAULT '0',
  `is_see_fans` int(10) DEFAULT '0',
  `platform` varchar(50) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `lv` tinyint(1) DEFAULT '1',
  `lv_score` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_login` (`username`),
  KEY `user_nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of xn_user
-- ----------------------------
INSERT INTO `xn_user` VALUES ('1', '1', '15984344251', 'e10adc3949ba59abbe56e057f20f883e', '15984344255', '北方的猪', '1', 'http://quan.51duoke.cn/uploads/1/file/20220922/59e59b3724b5ee2422f98e92b3833b7f.jpeg', '1615453709', '0', '0.00', '1615453709', '0', '', '223.87.75.167', 'oimIN0XKWTFCeCktiD9295mxzL1U', '1', '', '', '', '1', '0', '春天的风到底在哪里|170|65kg', '0', '0', '', '四川省-眉山市', '3', '210');
INSERT INTO `xn_user` VALUES ('2', '0', '13567834629', '', '13567834629', '且听风铃', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.222.247.12', '', '1', '', '', null, '1', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('3', '0', '13567416113', '', '13567416113', '微光倾城', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('4', '0', '13567478911', '', '13567478911', '偷得浮生', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('5', '0', '13567988808', '', '13567988808', '雨晨的清风', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('6', '0', '13567926763', '', '13567926763', '烛光里的愿', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('7', '0', '13567164603', '', '13567164603', '紫色的彩虹', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('8', '0', '13567917274', '', '13567917274', '伊人泪满面', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '1', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('9', '0', '13567435437', '', '13567435437', '青丝茧', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('10', '0', '13567555231', '', '13567555231', '微醉阳光', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '1', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('11', '0', '13567188807', '', '13567188807', '如花的旋律', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '3', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('12', '0', '13567523295', '', '13567523295', '代价是折磨', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('13', '0', '13567638984', '', '13567638984', '倚靠窗畔', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('14', '0', '13567731985', '', '13567731985', '花舞花落', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('15', '0', '13567311865', '', '13567311865', '泪梦里花', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('16', '0', '13567790354', '', '13567790354', '浅浅嫣然笑', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('17', '0', '13567241021', '', '13567241021', '深巷的猫', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('18', '0', '13567442768', '', '13567442768', '漫步云海涧', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('19', '0', '13567566631', '', '13567566631', '执手不忆殇', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('20', '0', '13567702751', '', '13567702751', '云纹梦纷蝶', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('21', '0', '13567176173', '', '13567176173', '阳光温暖', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('22', '0', '13567135253', '', '13567135253', '空屋触摸阳光', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('23', '0', '13567630269', '', '13567630269', '闪耀旳白梦', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('24', '0', '13567142120', '', '13567142120', '橱窗的光', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('25', '0', '13567511427', '', '13567511427', '初晓微芒', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('26', '0', '13567664877', '', '13567664877', '深渊的那支花', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('27', '0', '13567993385', '', '13567993385', '地平线', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('28', '0', '13567111113', '', '13567111113', '无际烟雨彷徨', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('29', '0', '13567527085', '', '13567527085', '回忆的沙漏', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('30', '0', '13567546929', '', '13567546929', '黑魅惑', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('31', '0', '13567476258', '', '13567476258', '钢琴上的芭蕾', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('32', '0', '13567158179', '', '13567158179', '潮起潮落', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('33', '0', '13567919983', '', '13567919983', '半颗心的暖', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('34', '0', '13567806089', '', '13567806089', '焰火灿烂时', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('35', '0', '13567986660', '', '13567986660', '化思念为星', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('36', '0', '13567997704', '', '13567997704', '流苏书包', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('37', '0', '13567222094', '', '13567222094', '芭比萌妹', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('38', '0', '13567645062', '', '13567645062', '不再回忆谁', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('39', '0', '13567504838', '', '13567504838', '海氹有点甜', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('40', '0', '13567469488', '', '13567469488', '梦梦贝莉雅', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('41', '0', '13567762312', '', '13567762312', '三字故事', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('42', '0', '13567374792', '', '13567374792', '乱世小熊', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('43', '0', '13567878723', '', '13567878723', '呵呵恩恩哦', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('44', '0', '13567839402', '', '13567839402', '一瞬之光', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('45', '0', '13567323481', '', '13567323481', '萌傻卿', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('46', '0', '13567335677', '', '13567335677', '勇敢的小萝卜', '0', '', '1663296371', '0', '0.00', '1663296371', '0', '', '183.223.237.188', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('47', '0', '13550515067', '', '13550515067', '13550515067', '0', '', '1663641861', '0', '0.00', '1663641861', '0', '', '183.222.247.163', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('48', '0', '15984344999', '', '15984344999', '15984344999', '0', '', '1663642023', '0', '0.00', '1663642023', '0', '', '183.222.247.163', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '', '', '1', '0');
INSERT INTO `xn_user` VALUES ('49', '0', '13778881314', '', '13778881314', '13778881314', '0', '', '1663659517', '0', '0.00', '1663659517', '0', '', '183.222.247.163', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', 'H5', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('50', '0', '15984344666', '', '15984344666', '我的乖乖', '0', 'http://quan.51duoke.cn/uploads/head.jpg', '1663660542', '0', '0.00', '1663660542', '0', '', '223.87.75.167', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', 'H5', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('51', '0', '15984666666', '', '15984666666', '15984666666', '0', '', '1663838172', '0', '0.00', '1663838172', '0', '', '223.87.75.167', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', 'H5', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('52', '0', '15984644999', '', '15984644999', '匿名', '0', '', '1663838490', '0', '0.00', '1663838490', '0', '', '183.222.247.12', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', 'H5', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('55', '0', '', '', '', '四川掌上时代', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep4iaauHk6qmCH5cqRORFxcU3OIXMKQZ1A6QQyWVjOH9ltDVFRt3JtaQPgw1mwoarlLFUK4Hpf8WtA/132', '1663896762', '0', '0.00', '1663896762', '0', '', '223.87.75.167', 'ogjgP40Tg4bY9KAH9mODRczBPaW8', '1', '', '', null, '2', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '四川省-眉山市', '1', '60');
INSERT INTO `xn_user` VALUES ('56', '0', '', '', '', 'APP小程序', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIzVGyhMctYa9wfZWib2BZKYUiaGuhfrF5OjehNQV01ZYGSlLANNu4AjfVVsPWMp6fmicYrKszTf9N3A/132', '1664084377', '0', '0.00', '1664084377', '0', '', '182.132.193.144', 'ogjgP441nYHTXrOcUSqGr9cCr7Uw', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '四川省-眉山市', '1', '0');
INSERT INTO `xn_user` VALUES ('57', '0', '', '', '', 'Alamina', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLJjhpNGfdgFoC71YrT1gffruBByzJ5RxtiaGEowy96E7nS6L2icf6dFloauDW1xkW1HH5B1XJQDEZQ/132', '1664084570', '0', '0.00', '1664084570', '0', '', '114.254.1.98', 'ogjgP4-YA_fd9HO5W2ZjjHKlclq4', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '北京市-北京市', '1', '0');
INSERT INTO `xn_user` VALUES ('58', '0', '', '', '', '·', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83epc8AQT59dISNhiaM2aSOkMScCX1vGDBMeduoic5NCZntBgkdMGYJqmyf912jofHJHcjY6GibcibJXNoQ/132', '1664084577', '0', '0.00', '1664084577', '0', '', '43.242.155.45', 'ogjgP4_hdfm-K5fJBR4pOxP_Cu44', '1', '', '', null, '1', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '新疆维吾尔自治区-乌鲁木齐市', '1', '0');
INSERT INTO `xn_user` VALUES ('59', '0', '', '', '', '等风来', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoKibgVGTYLSLyibuqxxtlKeL47oGud3A3P5WKibEFc3gjl9A9aN1b9dfA9oMEiboYY5lDXkrUYZM7dlg/132', '1664084623', '0', '0.00', '1664084623', '0', '', '113.248.4.84', 'ogjgP4x3Ay4wl87ieT9ejJ2esOV8', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '重庆市-重庆市', '1', '0');
INSERT INTO `xn_user` VALUES ('60', '0', '', '', '', '雷滨', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/2coPnop7bs2615XBnBy49Gky9UIDGIJgickabdFcnhELVdMhmiaMIJhPp3PY3MFzjUTxr8VM0k2rJfng3UV5ORnA/132', '1664084855', '0', '0.00', '1664084855', '0', '', '183.95.250.6', 'ogjgP4_34xY3BWOl0CJKgITmUzEo', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '湖北省-荆门市', '1', '10');
INSERT INTO `xn_user` VALUES ('61', '0', '', '', '', 'Rain', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJLAxia7JictXmUPibbs9gfQa1dpVTqNiaziaEJBEOBLk97vnBCicv26CjyRBVYotsxGpO8KRfIHCtaF9icw/132', '1664084923', '0', '0.00', '1664084923', '0', '', '27.154.212.164', 'ogjgP4wfT5uA7np539zYSboF-2II', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '福建省-厦门市', '1', '0');
INSERT INTO `xn_user` VALUES ('62', '0', '', '', '', '琪琪', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/OfJ9icCJn7AeRPJEDSjYHXgibQDkiamSuexq0HIWhA5FfdY3ujg7X7qG5ydSfD2q2ppAGhW4veOzcY2qaic1ibJkZjw/132', '1664085649', '0', '0.00', '1664085649', '0', '', '175.4.246.184', 'ogjgP48wehN1MNFYBgBUY0cUjz9Y', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '湖南省-株洲市', '1', '0');
INSERT INTO `xn_user` VALUES ('63', '0', '', '', '', 'Confident', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/vhPLb5yB1LE6O4FmowIFllTk59BhqwYteWZ1K9n0FGiaq9Xn7gd8rGTlWKokDZXZoYiadkqJPtZZGyr1PS6Yr96Q/132', '1664085722', '0', '0.00', '1664085722', '0', '', '223.104.60.152', 'ogjgP42IM7fnpdMbEwhgUYf0nsJA', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '广东省-广州市', '1', '0');
INSERT INTO `xn_user` VALUES ('64', '0', '', '', '', 'RTX', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/arkPXmFNGCbicYicoRuI40Jlib75ickEMfUlFRQpYeZXsnK0NdibcJaHePaDPE4oDBo5xQTvAPmYkianKp18N0SWCkoA/132', '1664086183', '0', '0.00', '1664086183', '0', '', '112.94.76.215', 'ogjgP48MKAX33IlLACPLhlAlN5qk', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '广东省-广州市', '1', '0');
INSERT INTO `xn_user` VALUES ('65', '0', '', '', '', 'A\' 星辰 ?', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/o4UCmcIPjXAsZ45ZZichmHXNJg15wRfKMOkzg7iaMicTGNicibBEIkfmYxTVgkd7BR6oymEonRsmFfmdlD1Yb68PoSQ/132', '1664086265', '0', '0.00', '1664086265', '0', '', '119.190.251.252', 'ogjgP42mIuIph46QqAnVXBYlLCSU', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '山东省-威海市', '1', '10');
INSERT INTO `xn_user` VALUES ('66', '0', '', '', '', '风颖', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erziaPqq4yb4rmYHnFraPTUdZrE0K2yR0Zs1Egy4Is7ebEoEUb48xwc0AoH4oDSl8gDSicMq811UfbA/132', '1664086343', '0', '0.00', '1664086343', '0', '', '106.224.142.131', 'ogjgP4ws7PCrdK-oZqiFgjqSSO8s', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '江西省-南昌市', '1', '0');
INSERT INTO `xn_user` VALUES ('67', '0', '', '', '', '米其林', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/FUpZfECx0mbdnaF2441g8bKoGxvMic00AMfghEiapledicibpARklODmEpStucTGYuvdLJtXw4aD7kAzBPpEo40icMg/132', '1664091533', '0', '0.00', '1664091533', '0', '', '119.131.223.106', 'ogjgP44qx0KXSXQf4xYpWR4M0gRc', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '广东省-广州市', '1', '0');
INSERT INTO `xn_user` VALUES ('68', '0', '', '', '', 'R.M.R.Y.R.L', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKHWWZd0MRcRk3NpKSFbAQvq7xstrvrk98WtNxkZKCiavIR2icZIVQeOYY6ke3QSHJTMH5ekXcVvicmQ/132', '1664101237', '0', '0.00', '1664101237', '0', '', '113.201.55.156', 'ogjgP4_1uGXzd9kkq4zIhIopADco', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '陕西省-西安市', '1', '0');
INSERT INTO `xn_user` VALUES ('69', '0', '', '', '', 'momo', '0', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q3auHgzwzM69NB0uQib2ZlOWWMSVsOHs91f8MqH3Z90LkKptF1JWSxZfCMojvr3Vs75mhpmicWfooaMrpmbQiatSg/132', '1664157628', '0', '0.00', '1664157628', '0', '', '223.70.118.22', 'ogjgP453MzALb_YqBMobovlKhfvc', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', '小程序', '北京市-北京市', '1', '0');
INSERT INTO `xn_user` VALUES ('70', '0', '15984346666', '', '15984346666', '匿名', '0', '', '1664165881', '0', '0.00', '1664165881', '0', '', '223.87.75.167', '', '1', '', '', null, '0', '0', '这个用户很懒,什么也没留下...', '0', '0', 'H5', '四川省-眉山市', '1', '0');

-- ----------------------------
-- Table structure for `xn_user_fans`
-- ----------------------------
DROP TABLE IF EXISTS `xn_user_fans`;
CREATE TABLE `xn_user_fans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(13) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `fans_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- Records of xn_user_fans
-- ----------------------------
INSERT INTO `xn_user_fans` VALUES ('30', '1', '2', '0');
INSERT INTO `xn_user_fans` VALUES ('31', '1', '6', '0');
INSERT INTO `xn_user_fans` VALUES ('32', '1', '8', '1663455853');
INSERT INTO `xn_user_fans` VALUES ('35', '2', '1', '1663836421');
INSERT INTO `xn_user_fans` VALUES ('36', '2', '55', '1663926397');
INSERT INTO `xn_user_fans` VALUES ('37', '11', '50', '1663985535');
INSERT INTO `xn_user_fans` VALUES ('38', '11', '2', '1664018432');
INSERT INTO `xn_user_fans` VALUES ('39', '55', '56', '1664084414');
INSERT INTO `xn_user_fans` VALUES ('40', '8', '58', '1664085017');
INSERT INTO `xn_user_fans` VALUES ('41', '55', '62', '1664085706');
INSERT INTO `xn_user_fans` VALUES ('42', '11', '67', '1664091597');
INSERT INTO `xn_user_fans` VALUES ('43', '10', '58', '1664155532');
INSERT INTO `xn_user_fans` VALUES ('46', '58', '58', '1664155548');

-- ----------------------------
-- Table structure for `xn_verification_code`
-- ----------------------------
DROP TABLE IF EXISTS `xn_verification_code`;
CREATE TABLE `xn_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=534 DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of xn_verification_code
-- ----------------------------
INSERT INTO `xn_verification_code` VALUES ('524', '1', '1663641511', '1663643311', '2565', '15984344266');
INSERT INTO `xn_verification_code` VALUES ('525', '4', '1663657355', '1663659155', '9026', '13550515067');
INSERT INTO `xn_verification_code` VALUES ('526', '1', '1663838484', '1663840284', '4086', '15984644999');
INSERT INTO `xn_verification_code` VALUES ('527', '1', '1663642019', '1663643819', '6238', '15984344999');
INSERT INTO `xn_verification_code` VALUES ('528', '1', '1663659515', '1663661315', '9617', '13778881314');
INSERT INTO `xn_verification_code` VALUES ('529', '4', '1664161188', '1664162988', '3111', '15984344666');
INSERT INTO `xn_verification_code` VALUES ('530', '2', '1664160411', '1664162211', '1141', '15984344255');
INSERT INTO `xn_verification_code` VALUES ('531', '1', '1664160699', '1664162499', '7820', '15984666666');
INSERT INTO `xn_verification_code` VALUES ('532', '1', '1663993562', '1663995362', '2604', '13567834629');
INSERT INTO `xn_verification_code` VALUES ('533', '1', '1664165879', '1664167679', '8770', '15984346666');
