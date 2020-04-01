---
title: 配置七牛云图床和搭配使用picgo
top: false
comments: true
categories:
  - blog
tags:
  - 七牛云
  - 图床
abbrlink: 833e23de
date: 2020-03-30 19:40:13
---

## 一：前言

之前一直使用路过图床，使用起来非常不方便，于是打算自建图床并搭配使用picgo, 这样搭配使用，写文章时感觉飞起. 使我可以专注于写作本身，而不用中途因为想去粘贴图片而去转移平台。使用千牛云免费的10G云存储空间，搭建一个私人图床。

<!-- more -->

## 二：过程

### 2.1  首先注册七牛云

​	这个你自己搞定  [千牛云官网](https://www.qiniu.com/events/free)

### 2.2   创建空间

![](http://photo.jomeswang.top/1.png)

![](http://photo.jomeswang.top/20200330200400.png)

### 2.3  绑定域名（可选）

七牛云的注册域名可以免费用一个月，但不持久，只能使用已经备案过的域名来绑定。因此这里讲述如何绑定

![](http://photo.jomeswang.top/20200330200811.png)

先在七牛这里获取解析地址之后要 在 域名商 那里 解析 cname .

![](http://photo.jomeswang.top/4.png)

我的域名是在阿里云的，于是做一个演示。

![](http://photo.jomeswang.top/20200330201230.png)

过了几分钟之后发现解析成功了。

![](http://photo.jomeswang.top/20200330201326.png)

### 2-4 配置图片瘦身（可选）

配置七牛云的图片瘦身，可以压缩图片，反正便宜。（0.1/千）

![](http://photo.jomeswang.top/7.png)

![](http://photo.jomeswang.top/8.png)

尝试一下这个有什么用。= = 

### 2.5  安装配置 picgo

picgo 好处多多，非常方便

推荐一个好看又好用的开源图床上传工具——PicGO. 拖拽图片就可以自动上传并复制外链到剪贴板。

给出官方地址： https://github.com/Molunerfinn/PicGo 

先安装这个，可以[点击这里下载](https://github.com/Molunerfinn/PicGo/releases)所需版本  

之后在

![](http://photo.jomeswang.top/20200330202338.png)

![](http://photo.jomeswang.top/20200330202419.png)

![](http://photo.jomeswang.top/10.png)

![](http://photo.jomeswang.top/12.png)

![](http://photo.jomeswang.top/11.png)

到此就可以快乐沉浸写写博客的本身上了。

具体picgo 的用法可以参照官方文档

