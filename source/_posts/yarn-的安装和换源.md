---
title: yarn 的安装和换源
top: false
comments: true
categories:
  - 环境配置
tags:
  - 环境配置
  - 教程
abbrlink: 1d9a2b3e
date: 2020-06-06 16:07:48
---

# yarn 的安装和换源

<!--more-->

## 一：介绍

### **1.1   Yarn 的简介：**

​     Yarn是facebook发布的一款取代npm的包管理工具；

### **1.2   Yarn的特点：**

​    1）速度超快----Yarn缓存了每个下载过的包，所以再次使用时无需重复下载。同时利用并行下载以最大化资源利用率，因此安装快。

​     2）超级安全----在执行代码之前，Yarn会通过算法检验每个安装包的完整性。

​     3）超级可靠-----使用详细、简洁的锁文件格式和明确的安装算法，Yarn能够保证在不同系统上无差异工作。

## 二：安装

进入官网：https://classic.yarnpkg.com/zh-Hans/docs/install#windows-stable

下载安装程序

之后点击运行，之后一直点击Next就可以了



![](http://photo.jomeswang.top/20200605215052.png)

在cmd中输入

```
yarn --version
```

看到如下界面即是成功了。

![](http://photo.jomeswang.top/20200605215234.png)

## 三：换源

```
yarn config get registry  // 查看yarn当前镜像源

yarn config set registry https://registry.npm.taobao.org/  // 设置yarn镜像源为淘宝镜像
```

![](http://photo.jomeswang.top/20200605220028.png)



