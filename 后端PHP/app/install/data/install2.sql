-- ----------------------------
-- Table structure for td_admin
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `mobile` char(11)  NOT NULL DEFAULT '' COMMENT '手机号',
  `uname` varchar(255)  NOT NULL DEFAULT '' COMMENT '用户名',
  `pass` varchar(255)  NOT NULL DEFAULT '' COMMENT '密码',
  `ip` varchar(255)  NOT NULL COMMENT '登陆IP',
  `login_time` datetime DEFAULT NULL  COMMENT '登陆时间',
  `create_time` datetime DEFAULT NULL  COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ----------------------------
-- Table structure for td_auth_menu
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_auth_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '菜单名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父级ID',
  `icon` varchar(50)  NOT NULL DEFAULT '' COMMENT 'icon',
  `route` varchar(100)  NOT NULL DEFAULT '' COMMENT '路由',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1显示、2隐藏',
  `son` tinyint(1) NOT NULL DEFAULT '0' COMMENT '子菜单',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of td_auth_menu
-- ----------------------------
BEGIN;
INSERT INTO `td_auth_menu` VALUES (1, '系统设置', 0, 'el-icon-setting', '', 0, 2, 1, '2021-06-15 16:38:52');
INSERT INTO `td_auth_menu` VALUES (2, '权限设置', 0, 'el-icon-lock', '', 0, 2, 1, '2021-06-11 17:20:05');
INSERT INTO `td_auth_menu` VALUES (3, '菜单设置', 2, '31', '/admin/auth.menu/index', 1, 2, 2, '2021-06-10 17:08:02');
INSERT INTO `td_auth_menu` VALUES (4, '角色设置', 2, '', '/admin/auth.role/index', 1, 2, 2, '2021-06-11 17:49:43');
INSERT INTO `td_auth_menu` VALUES (5, '添加\\修改', 3, '', '/admin/auth.menu/post', 0, 1, 2, '2021-06-16 11:28:41');
INSERT INTO `td_auth_menu` VALUES (6, '删除', 3, '', '/admin/auth.menu/delete', 0, 1, 2, '2021-06-16 11:29:45');
INSERT INTO `td_auth_menu` VALUES (7, '批量删除', 3, '', '/admin/auth.menu/deletes', 0, 1, 2, '2021-06-16 11:30:16');
INSERT INTO `td_auth_menu` VALUES (8, '添加\\修改', 4, '', '/admin/auth.role/post', 0, 1, 2, '2021-06-16 18:01:53');
INSERT INTO `td_auth_menu` VALUES (9, '删除', 4, '', '/admin/auth.role/delete', 0, 1, 2, '2021-06-16 18:02:19');
INSERT INTO `td_auth_menu` VALUES (10, '批量删除', 4, '', '/admin/auto.role/deletes', 0, 1, 2, '2021-06-16 18:03:11');
INSERT INTO `td_auth_menu` VALUES (11, '管理员', 2, '', '/admin/auth.admin/index', 0, 2, 2, '2021-06-16 18:04:27');
INSERT INTO `td_auth_menu` VALUES (12, '添加\\修改', 11, '', '/admin/auth.admin/post', 0, 1, 2, '2021-06-16 18:05:19');
INSERT INTO `td_auth_menu` VALUES (13, '删除', 11, '', '/admin/auth.admin/delete', 0, 1, 2, '2021-06-16 18:05:51');
INSERT INTO `td_auth_menu` VALUES (14, '批量删除', 11, '', '/admin/auth.admin/deletes', 0, 1, 2, '2021-06-16 18:06:53');
INSERT INTO `td_auth_menu` VALUES (15, '站点配置', 1, 'el-icon-c-scale-to-original', '/admin/config/index?active_name=basic', 0, 2, 2, '2021-06-21 16:39:05');
INSERT INTO `td_auth_menu` VALUES (16, '增加配置', 15, '', '/admin/config/post', 0, 1, 2, '2021-06-22 15:44:17');
INSERT INTO `td_auth_menu` VALUES (17, '更新配置', 15, '', '/admin/config/save', 0, 1, 2, '2021-06-22 15:44:51');
INSERT INTO `td_auth_menu` VALUES (18, '配置分组', 15, '', '/admin/config/group', 0, 1, 2, '2021-06-22 15:45:24');
INSERT INTO `td_auth_menu` VALUES (19, '附件管理', 1, 'el-icon-picture-outline', '/admin/general.files/index', 0, 2, 2, '2021-06-23 14:54:49');
INSERT INTO `td_auth_menu` VALUES (20, '附件修改', 19, '', '/admin/general.files/edit', 0, 1, 2, '2021-06-23 14:58:04');
INSERT INTO `td_auth_menu` VALUES (21, '附件删除', 19, '', '/admin/general.files/delete', 0, 1, 2, '2021-06-23 14:58:43');
INSERT INTO `td_auth_menu` VALUES (22, '附件批量删除', 19, '', '/admin/general.fiels/deletes', 0, 1, 2, '2021-06-23 14:59:33');
INSERT INTO `td_auth_menu` VALUES (23, '删除配置', 15, '', '/admin/config/delete', 0, 1, 2, '2021-06-23 15:03:26');
INSERT INTO `td_auth_menu` VALUES (24, '基础设置', 0, 'el-icon-menu', '', 0, 2, 1, '2021-06-25 11:46:40');
INSERT INTO `td_auth_menu` VALUES (25, '网站分类', 24, '', '/admin/category/index', 0, 2, 2, '2021-06-25 11:48:48');
INSERT INTO `td_auth_menu` VALUES (26, '添加\\修改', 25, '', '/admin/category/post', 0, 1, 2, '2021-06-25 11:50:05');
INSERT INTO `td_auth_menu` VALUES (27, '删除', 25, '', '/admin/category/delete', 0, 1, 2, '2021-06-25 11:50:36');
INSERT INTO `td_auth_menu` VALUES (28, '批量删除', 25, '', '/admin/category/deletes', 0, 1, 2, '2021-06-25 11:51:00');
INSERT INTO `td_auth_menu` VALUES (29, '系统工具', 0, 'el-icon-s-ticket', '', 0, 2, 1, '2021-07-03 17:18:09');
INSERT INTO `td_auth_menu` VALUES (30, '模块生成器', 29, '', '/admin/general.tool/index', 0, 2, 2, '2021-07-03 17:19:19');
COMMIT;

-- ----------------------------
-- Table structure for td_auth_role
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_auth_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '角色名称',
  `routes` varchar(255)  NOT NULL DEFAULT '' COMMENT '权限ID',
  `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '描述',
  `selected` varchar(255)  NOT NULL DEFAULT '' COMMENT '级联选择',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of td_auth_role
-- ----------------------------
BEGIN;
INSERT INTO `td_auth_role` VALUES (1, '管理员', '1,15,17,19,20', '拥有很多权限', '[[1,15,17],[1,19,20]]', '2021-06-16 16:15:11');
COMMIT;

-- ----------------------------
-- Table structure for td_category
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255)  DEFAULT '' COMMENT '分类名称',
  `pid` int(11) DEFAULT '0' COMMENT '父级ID',
  `url` varchar(255)  DEFAULT NULL COMMENT '跳转地址',
  `image` varchar(255)  DEFAULT '' COMMENT '图片地址',
  `tag` tinyint(1) DEFAULT NULL COMMENT 'tag,1首页，2热门，3推荐',
  `keywords` varchar(255)  DEFAULT '' COMMENT '关键词',
  `description` varchar(255)  DEFAULT '' COMMENT '描述',
  `weigh` int(11) DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常，2隐藏',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of td_category
-- ----------------------------
BEGIN;
INSERT INTO `td_category` VALUES (1, '开发教程', 0, '', '/storage/images/20210625/f7079b992dfbf53cdf49d9439bebc111.jpeg', 1, '', '开发教程', 0, 1, '2021-06-25 11:35:37');
INSERT INTO `td_category` VALUES (2, 'Java', 1, '/java', '/storage/images/20210625/854c41a9b0bb3298f9a45892b8849046.webp', 2, '', 'Java', 1, 1, '2021-06-25 11:37:16');
INSERT INTO `td_category` VALUES (3, 'PHP', 1, '/php', '/storage/images/20210625/e56f623289dfc113a3e24caaa4919452.jpeg', 2, '', 'PHP', 2, 1, '2021-06-25 11:40:25');
INSERT INTO `td_category` VALUES (4, '科技资讯', 0, '/zixun', '/storage/images/20210625/8083a27271b6b387f5f26530b1dacc6e.jpeg', 1, '', '科技', 0, 1, '2021-06-25 11:44:22');
COMMIT;

-- ----------------------------
-- Table structure for td_config
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `key` varchar(255)  DEFAULT '' COMMENT 'key',
  `value` varchar(255)  DEFAULT '' COMMENT '值',
  `title` varchar(255)  DEFAULT NULL COMMENT 'label',
  `group` varchar(255)  DEFAULT NULL COMMENT '分组',
  `rule` varchar(255)  DEFAULT NULL COMMENT '验证',
  `type` varchar(255)  DEFAULT '' COMMENT '类型',
  `options` varchar(800)  DEFAULT '' COMMENT '选项值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of td_config
-- ----------------------------
BEGIN;
INSERT INTO `td_config` VALUES (1, 'group', '{\"basic\":\"基础配置\",\"dictionary\":\"配置分组\",\"email\":\"邮箱配置\"}', '配置分组', 'dictionary', NULL, 'json', '');
INSERT INTO `td_config` VALUES (2, 'title', 'Think-element', '网站名称', 'basic', 'require', 'input', '');
INSERT INTO `td_config` VALUES (3, 'keywords', 'Thinkphp6,Element', '关键词', 'basic', '', 'input', '');
INSERT INTO `td_config` VALUES (4, 'email_type', '2', '类型', 'email', '', 'select', '[{\"id\":\"1\",\"name\":\"QQ\"},{\"id\":\"2\",\"name\":\"163\"}]');
INSERT INTO `td_config` VALUES (6, 'description', 'Think-element', '描述', 'basic', '', 'input', '');
INSERT INTO `td_config` VALUES (7, 'record', '蜀ICP备15010979号-1', '备案号', 'basic', '', 'input', '');
INSERT INTO `td_config` VALUES (8, 'version', '1.0.0', '版本号', 'basic', '', 'input', '');
INSERT INTO `td_config` VALUES (11, 'admin_title', 'Think-element', '后台名称', 'basic', '', 'input', '');
INSERT INTO `td_config` VALUES (13, 'logo', '/storage/images/20210625/e56f623289dfc113a3e24caaa4919452.jpeg', 'Logo', 'basic', '', 'Image', '');
COMMIT;

-- ----------------------------
-- Table structure for td_files
-- ----------------------------
CREATE TABLE IF NOT EXISTS `td_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '源文件名称',
  `size` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '文件大小',
  `url` varchar(255)  NOT NULL COMMENT '文件路径',
  `ext` varchar(255)  NOT NULL DEFAULT '' COMMENT '后缀',
  `mime_type` varchar(255)  NOT NULL COMMENT '文件类型',
  `width` int(11) NOT NULL DEFAULT '0' COMMENT '图像宽',
  `height` int(11) NOT NULL DEFAULT '0' COMMENT '图像高',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of td_files
-- ----------------------------
BEGIN;
INSERT INTO `td_files` VALUES (1, 'Foxmail20210621042636.png', 2.38, '/storage/images/20210623/346a7a7b1187918e0d68265436022c3e.png', 'png', 'image/png', 223, 218, '2021-06-23 11:58:46');
INSERT INTO `td_files` VALUES (2, 'src=http___www.gzxdxh.com_uploads_allimg_200312_06235222C_0.jpg&refer=http___www.gzxdxh.jpeg', 38.16, '/storage/images/20210625/f7079b992dfbf53cdf49d9439bebc111.jpeg', 'jpeg', 'image/jpeg', 580, 300, '2021-06-25 11:34:39');
INSERT INTO `td_files` VALUES (3, 'u=4084129530,3438713827&fm=26&fmt=auto&gp=0.webp', 8.11, '/storage/images/20210625/854c41a9b0bb3298f9a45892b8849046.webp', 'webp', 'image/webp', 348, 347, '2021-06-25 11:39:36');
INSERT INTO `td_files` VALUES (4, 'src=http___jn.php.tedu.cn_img_201709_1504771686441.png&refer=http___jn.php.tedu.jpeg', 9.53, '/storage/images/20210625/e56f623289dfc113a3e24caaa4919452.jpeg', 'jpeg', 'image/jpeg', 536, 313, '2021-06-25 11:40:15');
INSERT INTO `td_files` VALUES (5, 'src=http___pic.soutu123.com_back_pic_04_26_43_285839aea9ef03c.jpg!_fw_700_quality_90_unsharp_true_compress_true&refer=http___pic.soutu123.jpeg', 41.38, '/storage/images/20210625/8083a27271b6b387f5f26530b1dacc6e.jpeg', 'jpeg', 'image/jpeg', 650, 514, '2021-06-25 11:43:48');
COMMIT;
