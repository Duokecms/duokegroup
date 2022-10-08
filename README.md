
![输入图片说明](http://www.51duoke.cn/quanzi/images/head2.jpg)

###  **商业版已上市，演示请看二维码
** 
![输入图片说明](http://www.51duoke.cn/quanzi/images/d.jpg)

<h3 align="center">多客圈子社区系统开源版1.2.1版</h3> 

  

 - 她是谁？？？ 她是一款全开源支持免费商用的圈子社区论坛系统；是的!对!没看错! 她就是我们技术宅男的女神，我们为她熬夜伤肝，我们为她牵肠挂肚，我们为她彻夜难眠！
 
 - 多客开源团队（www.51duoke.cn)2022年伤肝之作！系统基于TP6+Uni-app框架开发；客户移动端采用uni-app开发，管理后台TH6开发。

 - 系统支持微信公众号端、微信小程序端、H5端、PC端多端账号同步，可快速打包生成APP；

 - 我们为你准备了完善的后台管理，不需要你懂PHP，按照教程3分钟安装完即可使用，堪比深夜的杜蕾斯还方便。

 - 我们为你准备漂亮的UI前端，导入UNI,2分钟编译为小程序，3分钟编译为安卓app，5分钟编译为ios系统。

 

 - 如果，我是说如果，你啥都不会，服务器不会架设，数据库也不会操作，打包也不会，联系我们即可。

 - 我们提供一整套安装调试上架服务。

 - 当然我们后续也会有商业版出品plus版，增加各种酷炫功能。
 
 - 当然我们也会接二次定制开发的版本，只要你想，你就可以拥有。


 ![输入图片说明](http://www.51duoke.cn/quanzi/images/quanhanner.jpg)




## 开源基础版后端演示
http://quan.51duoke.cn/admin
账号demo  密码demo    （仅有查看权限）


后端下载地址：https://gitee.com/multi-customer-open-source/multi-social

后端程序目录
===============

**系统需求**

- PHP >= 7.2.5
- MySQL >= 5.6.3
- Redis

## uniapp安装

将前端UNI目录导入到你的HBuilder里

修改tools/siteinfo.js 里的域名为你的域名即可

如果打包小程序及app 请参考uniapp官方文档




## 后端安装
将后端php代码放到你的网站根目录即可

====运行WEB目录====
public

====数据库====
导入目录下的  db.sql 文件
修改目录下的  .env 数据库配置

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


====后台登陆====
http://域名/admin
默认账号：admin 密码：6192652

## 后台功能简介


进入后台后，请在基础配置里配置你的参数即可。

H5和APP是手机号登陆，如果需要发送验证码，已经集成了阿里云的sms

上传集成阿里云oss和七牛云，也可以本地储存

内容监控和屏蔽，采用七牛云，请在上传配置出配置name和key



 
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
 ### 前端页面展示

 **首页和广场**
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan/qianduan/1.jpg)

**圈子和帖子**

![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan/qianduan/2.jpg)

**个人主页**

![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan/qianduan/3.jpg)


### 页面展示
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//1.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//2.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//3.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//4.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//5.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//6.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//7.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//8.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//9.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//10.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//11.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//12.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//13.jpg)

![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//15.jpg)
![输入图片说明](http://guanwang.qiniu.51duoke.cn/quan//16.jpg)

## 文档

[TP6开发手册](https://www.kancloud.cn/manual/thinkphp6_0/content)

[uniapp开发手册](https://uniapp.dcloud.net.cn/)


 ![输入图片说明](http://www.51duoke.cn/quanzi/images/quanhanner.jpg)

## 商业版已上市，更多功能！更多服务！

多客圈子社交系统商业版 1.3版



1、即时聊天功能，支持发送语音 图片 文字。

2、增加音乐随声听，后台管理音乐库，用户可选择播放和关闭，播放器。

3、修改简化帖子发布流程。

4、增加后台10种开关显示，方便控制模块。

5、个人资料增加 年龄、标签。

6、增加派对频道， **增加语音聊天房间** ，可邀请好友加入，或用户主动进入。



![输入图片说明](http://www.51duoke.cn/quanzi/images/d.jpg)


## 安装使用常见问答


1、关于敏感词过滤问题？
答：请到七牛云注册账号，在我的里会有AccessKey和AccessKeySecret，填写到我们后台的 上传配置七牛云那里，点击保存。 如果是想使用七牛云的图片储存请继续填写后面的空间名和域名等信息，如果不想使用七牛云储存，只需要填写key和secret。然后在选择储存方式为本地。 意思是七牛云这个必填。否则无法过滤。

如果不想过滤请到app/controller/user.php 这个接口文件里搜索 checkCloseSpeck 并把这一行注释掉。

2、关于APP版 发布活动选择地址和查看地址失效问题？
答：请在Hbiuder里 打开manifest.json， 点击APP模块配置，选中maps，选择你要使用那个地图，一般推荐高德和腾讯。请到高德或腾讯开放平台 注册账号，并添加应用。获取到key填写到这里。 因为APP采用的是sdk地图。小程序不需要考虑，是直接用微信的地图。

3、关于短信登录问题？
答：后台关闭短信验证，是为了测试使用的，或者是短信通道临时故障之类使用。就是用户不需要接收短信，直接可以登录。当正式版本发布后，建议你开启短信验证，并去阿里云购买短信，填写在后台即可使用。

4、我们的演示APP或者小程序为啥不能发帖子？
答：演示已经关闭发布功能，因为测试的人太多，天天乱发，影响测试的美观。
请自己搭建后 自己发布到你的数据库去。

5、linux系统需要配置伪静态代码
location / {
if (!-e  request_filename){ rewrite ^(.*)  /index.php?s=$1 last; break;
}
}

6、windows系统设置伪静态。

  请在宝塔里设置伪静态选择TH6 。

 

7、出现api接口读取500错误，

答：原因很多，大部分是 没有设置伪静态，请看第5条。或者是数据库没连接上。

 
8、安装后台后访问出现404找不到页面

答：大部分使用为宝塔的网站管理开启了防跨站，请关闭。


不断更新中....




## 特别鸣谢

排名不分先后，感谢这些软件的开发者：thinkphp、小牛admin、图鸟UI、vue、mysql、redis、uniapp等！


## 开源版使用须知

1.允许用于个人学习、毕业设计、教学案例、公益事业、商业使用;

2.如果商用必须保留版权信息，请自觉遵守;

3.禁止将本项目的代码和资源进行任何形式的出售，产生的一切任何后果责任由侵权者自负。

## 版权信息


版权所有Copyright © 2016-2022 by 四川掌上时代科技有限公司旗下多客开源事业部 (http://www.51duoke.cn   http://www.siyibang.com)

All rights reserved。

著作权所有者为四川掌上时代科技有限公司。
