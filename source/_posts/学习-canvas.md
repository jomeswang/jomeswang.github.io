---
title: 学习 canvas
top: false
comments: true
categories:
  - canvas
tags:
  - canvas
abbrlink: e8300743
date: 2020-12-04 23:35:11
---

> 万事起头难啊！！！当自己真正放下心去学习的时候，才知道原来一切都是肝就完事了

<!--more-->

## 一：微信小程序的canvas

### 1.1 使用微信小程序自带的 组件

小程序内通过静态模板和样式绘制 canvas ，导出图片，可用于生成分享图等场景。

##### 1.1.1.  npm 安装

```
npm install --save wxml-to-canvas
```



#### 1.1.2  json 组件声明

```
{
  "usingComponents": {
    "wxml-to-canvas": "wxml-to-canvas",
  }
}
```

![](http://photo.jomeswang.top/20201205001119.png)

#### 1.1.3  index.wxml 引入组件

![](http://photo.jomeswang.top/20201205001232.png)



#### 1.1.4 index.js获取实例

![](http://photo.jomeswang.top/20201205001638.png)

![](http://photo.jomeswang.top/20201205001836.png)

#### 1.1.5  编写 demo,js 既 要 渲染成 canvas 的 wxml 和 styles

![](http://photo.jomeswang.top/20201205002105.png)



### 1.2 使用 wxml2canvas 库

下载安装库

![](http://photo.jomeswang.top/20201205003442.png)

#### 1.2.1 使用wxml 格式

![](http://photo.jomeswang.top/20201205004006.png)

![](http://photo.jomeswang.top/20201205004023.png)



#### 1.2.2  使用json 格式绘画

![](http://photo.jomeswang.top/20201205004052.png)



## 二： 网页的canvas 

### 2.1 使用原生的canvas 

#### 2.1.1 使用canvas 标签

![](http://photo.jomeswang.top/20201205181250.png)

#### 2.2.2 初始化 canvas

![](http://photo.jomeswang.top/20201205181312.png)

#### 2.2.3 画线

#### 2.2.4 画圆

#### 2.2.5 画矩形

#### 2.2.6 画图