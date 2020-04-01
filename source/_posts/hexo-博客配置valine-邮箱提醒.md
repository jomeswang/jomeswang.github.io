---
title: hexo 博客配置valine 邮箱提醒
top: false
comments: true
abbrlink: 84c51fe9
date: 2020-03-29 17:33:39
categories:
- hexo
tags:
- hexo
---

首先需要确保 Valine 的基础功能是正常的，参考 [Valine Docs](https://valine.js.org/)。

然后进入 [Leancloud](https://leancloud.cn/dashboard/applist.html#/apps) 对应的 Valine 应用中。[原项目github 地址](https://github.com/DesertsP/Valine-Admin)

<!-- more -->

## 快速部署

### 1.	在[Leancloud](https://leancloud.cn/dashboard/#/apps)云引擎设置界面，填写代码库并保存：https://github.com/DesertsP/Valine-Admin.git

[![GVTsN4.md.png](https://s1.ax1x.com/2020/03/29/GVTsN4.md.png)](https://imgchr.com/i/GVTsN4)

### 2.	在设置页面，设置环境变量以及 Web 二级域名。

[![GVTy4J.md.png](https://s1.ax1x.com/2020/03/29/GVTy4J.md.png)](https://imgchr.com/i/GVTy4J)

| 变量             | 示例                                      | 说明                                                         |
| ---------------- | ----------------------------------------- | ------------------------------------------------------------ |
| SITE_NAME        | Deserts                                   | [必填]博客名称                                               |
| SITE_URL         | [https://deserts.io](https://deserts.io/) | [必填]首页地址                                               |
| **SMTP_SERVICE** | QQ                                        | [新版支持]邮件服务提供商，支持 QQ、163、126、Gmail 以及 [更多](https://nodemailer.com/smtp/well-known/#supported-services) |
| SMTP_USER        | [xxxxxx@qq.com](mailto:xxxxxx@qq.com)     | [必填]SMTP登录用户                                           |
| SMTP_PASS        | ccxxxxxxxxch                              | [必填]SMTP登录密码（QQ邮箱需要获取独立密码）                 |
| SENDER_NAME      | Deserts                                   | [必填]发件人                                                 |
| SENDER_EMAIL     | [xxxxxx@qq.com](mailto:xxxxxx@qq.com)     | [必填]发件邮箱                                               |
| ADMIN_URL        | https://xxx.leanapp.cn/                   | [建议]Web主机二级域名，用于自动唤醒    [qq的看这](https://service.mail.qq.com/cgi-bin/help?subtype=1&&no=1001256&&id=28) |
| BLOGGER_EMAIL    | [xxxxx@gmail.com](mailto:xxxxx@gmail.com) | [可选]博主通知收件地址，默认使用SENDER_EMAIL                 |
| AKISMET_KEY      | xxxxxxxxxxxx                              | [可选]Akismet Key 用于垃圾评论检测，设为MANUAL_REVIEW开启人工审核，留空不使用反垃圾 |

**以上必填参数请务必正确设置。**

#### 2.2  二级域名用于评论后台管理，如[https://deserts.leanapp.cn](https://deserts.leanapp.cn/) 。

1. 切换到部署标签页，分支使用master，点击部署即可

[![一键部署](https://camo.githubusercontent.com/fa5f1d143d0e7657f75e8653627fb76c712fcb72/68747470733a2f2f636c6f75642e70616e6a756e77656e2e636f6d2f323031382f30392f70696e672d6d752d6b7561692d7a68616f2d323031382d30392d31352d7869612d77752d31322d35362d35302e706e67)](https://camo.githubusercontent.com/fa5f1d143d0e7657f75e8653627fb76c712fcb72/68747470733a2f2f636c6f75642e70616e6a756e77656e2e636f6d2f323031382f30392f70696e672d6d752d6b7561692d7a68616f2d323031382d30392d31352d7869612d77752d31322d35362d35302e706e67)

第一次部署需要花点时间。

1. 评论管理。访问设置的二级域名`https://二级域名.leanapp.cn/sign-up`，注册管理员登录信息，如：https://deserts.leanapp.cn/sign-up 

此后，可以通过`https://二级域名.leanapp.cn/`管理评论。

### 3	定时任务设置

目前实现了两种云函数定时任务：(1)自动唤醒，定时访问Web APP二级域名防止云引擎休眠；(2)每天定时检查24小时内漏发的邮件通知。

进入云引擎-定时任务中，创建定时器，创建两个定时任务。

选择self-wake云函数，Cron表达式为`0 0/30 7-23 * * ?`，表示每天早6点到晚23点每隔30分钟访问云引擎，`ADMIN_URL`环境变量务必设置正确：

[![GV7YVO.png](https://s1.ax1x.com/2020/03/29/GV7YVO.png)](https://imgchr.com/i/GV7YVO)

[![GV7GqK.png](https://s1.ax1x.com/2020/03/29/GV7GqK.png)](https://imgchr.com/i/GV7GqK)

选择resend-mails云函数，Cron表达式为`0 0 8 * * ?`，表示每天早8点检查过去24小时内漏发的通知邮件并补发：

[![GV7GqK.png](https://s1.ax1x.com/2020/03/29/GV7GqK.png)](https://imgchr.com/i/GV7GqK)

**添加定时器后记得点击启动方可生效。**