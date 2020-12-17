---
title: git 初步使用
top: false
comments: true
categories:
  - git
tags:
  - git
abbrlink: 595a2712
date: 2020-09-22 22:20:35
---

> 团队协作使用Git   !!!!

<!--more--->

## 一：配置SSH

一、登录GitHub，新建一个仓库，进入仓库，我们会注意到，GitHub给出的地址不止一个，还可以用https这样的地址。实际上，Git支持多种协议，默认的git://使用ssh，但也可以使用https等其他协议。但是使用https除了速度慢以外，还有个最大的麻烦是每次推送都必须输入口令。

![](http://photo.jomeswang.top/20200922222529.png)

二、复制SSH链接，在git bash输入：git clone SSH链接，显示如下：

![](http://photo.jomeswang.top/20200922222553.png)

显示没有权限（无公钥）

三、输入：`ssh-keygen -t rsa` ，连续三次回车（即不做任何输入），结果如下：

![](http://photo.jomeswang.top/20200922222602.png)

通过结果显示及cat命令查看可知public key存放于id_rsa.pub中

四、输入：`cat id_rsa.pub`  （去指定目录下）(  一般在)C盘下的用户文件下的.ssh 文件下的  `id_rsa.pub`  复制所有内容

![](http://photo.jomeswang.top/20200922222620.png)

五、到github右上角账户管理-Setting下面找到左侧“SSH and GPG keys”菜单，接着点击“Add SSH key”，在”title”栏输入一个自己喜欢的标题，“key”栏中粘贴刚刚复制的公钥内容，最后点击“Add key”按钮。（粘贴时选择为纯文本），最后生成的结果

![](http://photo.jomeswang.top/20200922222823.png)

![](http://photo.jomeswang.top/20200922222839.png)

输入：ssh -vT git@github.com ，显示如图则成功

![](http://photo.jomeswang.top/20200922222939.png)

六、再次clone远程库，成功！我们可以在远程库修改文件，本地通过git pull同步远程库或者git push推送本地文件！

![](http://photo.jomeswang.top/20200922222956.png)

## 二：仓库管理

如果想直接在别人的仓库进行操作需要先向管理员拿到管理员权限。才可以直接操作。不然的话就fork到自己的仓库中，然后push  然后再让管理员进行分支的合并。

如果没有管理员权限就直接push的话会有如下的报错。

![](http://photo.jomeswang.top/20200922223238.png)