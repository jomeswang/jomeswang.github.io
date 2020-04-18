---
title: Anaconda 入坑记 解决pythonwarning
top: false
comments: true
categories:
  - python
tags:
  - python
abbrlink: fa71d059
date: 2020-03-06 23:45:11
---

法一：

<!-- more -->

1、确定当前环境

　　使用终端或Anaconda提示符执行以下步骤。

　　默认情况下，活动环境---您当前使用的环境---显示在命令提示符开头的括号（）或括号[]中：(myenv) $

　　如果您没有看到这个，请运行：`conda info --envs`

　　在显示的环境列表中，当前环境以星号（*）突出显示。

　　![](http://photo.jomeswang.top/20200410110708.png)

　　2、激活环境

　　`conda activate d:\Tools\Anaconda2`

　![](http://photo.jomeswang.top/20200410110802.png)

法二：

直接运行    `activate`