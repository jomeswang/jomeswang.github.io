---
title: Mobx 和 Taro 的结合运用
top: false
comments: true
categories:
  - Taro
tags:
  - Taro
  - Mobx
abbrlink: 6673b515
date: 2020-12-20 14:38:45
---

> 静下心来学习一些数据管理方面的知识吧！！

<!--more-->

![](http://photo.jomeswang.top/20201220144649.png)

## 一： 安装与使用

在使用  `taro init taro-ts` 之后可以创建一个基于 Mobx 数据统一管理， 使用Ts的Taro （React）框架。



## 二： 目录解析以及方法说明

![](http://photo.jomeswang.top/20201220144350.png)

### 2.1  mobx 的引入

在项目的入口文件中 app.tsx 中使用

![](http://photo.jomeswang.top/20201220144835.png)

### 2.2 写一个计数器的 数据管理

![](http://photo.jomeswang.top/20201220145011.png)



### 2.3 通过在页面中 使用 @inject 装饰器来引入 并且解构来使用

![](http://photo.jomeswang.top/20201220153223.png)

