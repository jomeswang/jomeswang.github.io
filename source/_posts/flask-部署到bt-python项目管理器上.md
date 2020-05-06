---
title: flask 部署到bt python项目管理器上
top: false
comments: true
categories:
  - python
tags:
  - python
  - flask
  - python项目管理器
abbrlink: '84479843'
date: 2020-05-05 08:44:48
---

## 一：前言

今天要搞个快速部署到BT服务器上的教程，运用BT的python 项目管理器。

<!--more-->

## 二：内容

原始返回：

![](http://photo.jomeswang.top/20200505084744.png)

之后，打开BT面板（如果未装过，[请点击安装](https://www.bt.cn/bbs/thread-19376-1-1.html)），之后配好环境

```
 pip freeze > requirements.txt
```

用这个命令去把项目所需的拓展包导出

然后打开这个文件，按需删除其他不需要的拓展包（非虚拟环境下）

![](http://photo.jomeswang.top/20200505091118.png)

### 2.1 安装python项目管理器

之后进入软件商店找到python项目管理器后安装（注意bt版本要在7以上才有这界面，如果没有请自行升级bt版本）

![](http://photo.jomeswang.top/20200505085142.png)

### 2.2 上传文件

1. 新建server_test目录

![](http://photo.jomeswang.top/20200505094915.png)

2. 新建flask目录

![](http://photo.jomeswang.top/20200505085615.png)

3. 新建flask_test 目录

![](http://photo.jomeswang.top/20200505085857.png)

4. 在里面上传.py文件和 requirements.txt

### 2.3 进入python项目管理器

![](http://photo.jomeswang.top/20200505090116.png)

1. 添加python项目

![](http://photo.jomeswang.top/20200505095711.png)

2. 映射域名

![](http://photo.jomeswang.top/20200505095919.png)

3. 改变端口号

![](http://photo.jomeswang.top/20200505100211.png)

4. 成功啦

![](http://photo.jomeswang.top/20200505100716.png)

## 三：总结

在使用的过程中，也预料到一些麻烦，比如文件名是中文的话，就可能不能被识别，然后尝试了一番才发现，那么只有多尝试最后才能找到真理啊！！！