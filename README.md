后端程序目录
===============

**系统需求**

- PHP >= 7.2.5
- MySQL >= 5.6.3
- Redis

## 安装

## 快速安装

> 第一步：安装代码

```
git clone https://gitee.com/multi-customer-open-source/multi-social.git
```
```
再使用composer安装 composer install
```

## 一键安装
上传你的代码，站点入口目录设置/public
在浏览器中输入你的域名或IP（例如：www.yourdomain.com）,
安装程序会自动执行安装。期间系统会提醒你输入数据库信息以完成安装，安装完成后建议删除app\install目录。

后台访问地址：
1.域名/admin
2.域名/index.php/admin
3.域名/index.php?s=/admin


安装过程中请牢记您的账号密码！

## 重新安装
1. 清除数据库
2. 删除/public/install.lock 文件
3. 执行：域名/install/ 按照提示进行安装
## 手动安装
1.创建数据库，倒入数据库文件
数据库文件目录/app/install/data/install.sql
2.修改数据库连接文件
配置文件路径/.env
~~~
APP_DEBUG = true

[APP]
DEFAULT_TIMEZONE = Asia/Shanghai

[DATABASE]
TYPE = mysql
HOSTNAME = 127.0.0.1 #数据库连接地址
DATABASE = test #数据库名称
USERNAME = username #数据库登录账号
PASSWORD = password #数据库登录密码
HOSTPORT = 3306 #数据库端口
CHARSET = utf8
DEBUG = true

[LANG]
default_lang = zh-cn

[REDIS]
REDIS_HOSTNAME = 127.0.0.1 # redis链接地址
PORT = 6379 #端口号
REDIS_PASSWORD = 123456 #密码
SELECT = 0 #数据库
~~~
3.修改目录权限（linux系统）777
/public
/runtime
4.后台登录：
http://域名/admin
默认账号：admin 密码：123456

## 功能简介
 
 ```
 Admin（后台功能）
 ├─ 管理首页
 |  ├─介绍版本信息、数据统计、常用模块、Echart数据概览
 ├─ 菜单管理
 |  ├─后台权限菜单管理 编辑访客权限，处理菜单父子关系，被权限系统依赖（极为重要）
 ├─ 系统管理
 |  ├─ 用户管理 - 添加新用户，封号，删号以及给账号分配权限组
 |  ├─ 权限管理 - 权限组管理，给权限组添加权限，将用户提出权限组
 |  └─ 上传管理 - 记录所有上传的图片文件信息、定位文件位置大小以及上传时间
 ├─ 配置管理
 |  ├─ 基本设置 - 配置网站基本信息：标题、域名、客服电话、前端主题配色、前端字体颜色等前端基础配置信息修改
 |  ├─ 上传配置 - 文件存储方式选择：本地存储、阿里云OSS、七牛云配置
 |  └─ 操作日志 - 记录管理员的操作，用于追责，回溯和备案
 ├─ 站点设置
 |  ├─ 广告管理 - 删改查
 |  ├─ 首页管理 - ....
 |  └─ 单页管理 - ....
 ├─ 圈子管理
 |  ├─ 圈子列表 - ....
 |  └─ 话题管理 - ....
 ├─ 会员管理
 |  ├─ 会员列表 - ....
 |  └─ 勋章管理 - ....
 ├─ ......
 ```

### 页面展示
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/1.png "1.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/2.png "2.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/3.png "3.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/4.png "4.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/5.png "5.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/6.png "6.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/7.png "7.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/8.png "8.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/9.png "9.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/10.png "10.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/11.png "11.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/12.png "12.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/13.png "13.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/14.png "14.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/15.png "15.png")
![输入图片说明](https://gitee.com/multi-customer-open-source/multi-social/tree/master/ReadmeImages/16.png "16.png")


## 文档

[TP6开发手册](https://www.kancloud.cn/manual/thinkphp6_0/content)


## 参与开发

