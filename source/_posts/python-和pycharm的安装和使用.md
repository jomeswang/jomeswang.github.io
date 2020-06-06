---
title: python 和pycharm的安装和使用
top: false
comments: true
categories:
  - 环境配置
tags:
  - 环境配置
  - 教程
abbrlink: e9ec5064
date: 2020-06-06 16:06:47
---

> 人生苦短，我用python

<!--more-->

## 一：安装Python配置pip

### 1.1 安装python

进入官网：https://www.python.org/

![](http://photo.jomeswang.top/20200606095229.png)

安装：

![](http://photo.jomeswang.top/20200606095355.png)

之后等待安装完成即可

之后在cmd中敲python看是否安装成功

![](http://photo.jomeswang.top/20200606095627.png)

### 1.2 配置pip源

源地址：https://zhuanlan.zhihu.com/p/33345935

由于国内通过pip下载python包的速度真的很慢，特别是下载包文件比较大的情况下经常会导致下载失败，使用pqi可以把默认的PyPi源迅速切换化为国内源tuna, douban, aliyun, ustc从而加快python包的安装速度-项目地址欢迎star和fork，下图为提速效果展示。

![](http://photo.jomeswang.top/20200606100220.png)

#### 1.安装（cmd中敲）

```
pip install pqi
```

#### 2. 命令行输入 pqi 回车

```
>>> pqi
Usage:
  pqi ls
  pqi use <name>
  pqi show
  pqi add <name> <url>
  pqi remove <name>
  pqi (-h | --help)
  pqi (-v | --version)
Options:
  -h --help        Show this screen.
  -v --version     Show version.
```

+ 列举所有支持的pip源

```
pqi ls
```

+ 改变pip源(当前pip源改为清华的pip源)

```
pip use tuna
```



## 二：安装Pycharm

1. ### 下载安装toolbox

进入官网下载toolbox：https://www.jetbrains.com/toolbox-app/

![](http://photo.jomeswang.top/20200606094845.png)

这是jb家中一个安装管理软件。

之后点击运行安装即可。

2. ### 安装pycharm

运行刚刚安装的然后

![](http://photo.jomeswang.top/20200606101013.png)

3. ### 安装的pycharm 是付费版的，需要使用学生邮箱激活使用

打开官网申请：https://www.jetbrains.com/zh-cn/community/education/#students

1. 接下来输入你的个人信息和学校邮箱（用来接收验证信息）。确认无误后，你的校内邮箱将会收到一封邮件，然后查看这个邮件，根据上面的提示创建一个JetBrains账号（注意这是你的JetBrains账号，不一定是你的邮箱密码）。

2. 接下来打开一款JetBrains Product，激活方式选择输入你的学生账号和密码，确认就可以激活了，应该是可以免费用一年。

3. ### 配置pycharm

   打开安装好的pycharm 

   ![](http://photo.jomeswang.top/20200606101734.png)

   ![](http://photo.jomeswang.top/20200606101827.png)

   ![](http://photo.jomeswang.top/20200606101944.png)

   激活完成！！！

   1. 配置环境

   ![](http://photo.jomeswang.top/20200606102224.png)

   ![](http://photo.jomeswang.top/20200606102251.png)

   ![](http://photo.jomeswang.top/20200606103729.png)

在cmd中输入

```
where python
```

![](http://photo.jomeswang.top/20200606105339.png)

把这一行路径复制到刚刚那里缺少路径的地方。

![](http://photo.jomeswang.top/20200606105819.png)

这样就可以了！！