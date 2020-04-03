---
title: Ubuntu 配置阿里源和安装图形界面
top: false
comments: true
categories:
  - linux
tags:
  - ubuntu
abbrlink: e832a134
date: 2020-04-01 14:29:45
---

## 一：前言

之前搞了一个华为云的服务器想学习一下ubuntu，于是安装了一个Ubuntu系统。

想搞一个图形界面。

<!-- more -->

## 二：过程

### 2.1配置阿里源

ubuntu 的本身的apt源不在国内，因此下载速度非常慢，于是配置阿里云的镜像源，这样可以加速下载的速度。

```
ubuntu:~$ cd /etc/apt
ubuntu:/etc/apt$ sudo mv sources.list sources.list.bak
ubuntu:/etc/apt$ vim sources.list  
按i 在复制粘贴 之后按esc结束， 按:wq 保存并退出
```

将这个复制进去（注意此版本是Ubuntu 18.04 ）如果是其他版本，请看[阿里云镜像源的配置](https://developer.aliyun.com/mirror/ubuntu)

```
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```

之后更新镜像源

```
ubuntu:~$ sudo apt-get update 
```

### 2.2 安装图形界面

```
apt-get update # 更新软件库
apt-get upgrade # 升级软件(记得有一个要Y的)
apt-get install ubuntu-desktop #安装ubuntu默认的图形化操作界面(记得有一个要Y的)
```

将这三条命令逐一运行，之后就是等待等待再等待了。

安装好之后记得重启

```
reboot
```

### 2.3 配置图形界面

之后按照提示设置账户用户名等信息。

然后直接下载按照teamviewer

#### 2.3.1	开启桌面共享

进入系统->首选项->桌面共享->开启远程桌面，设置登陆密码

![](http://photo.jomeswang.top/20200403122317.png)

![](http://photo.jomeswang.top/20200403122449.png)

![](http://photo.jomeswang.top/20200403122523.png)



#### 3.2.2	安装vncserver基础服务

`sudo apt-get install xrdp vnc4server xbase-clients`

#### 3.2.3	安装dconf-editor(取消权限限制)

`sudo apt-get install dconf-editor`
打开dconf-editor工具->依次展开org->gnome->desktop->remote-access，然后取消 “requlre-encryption”的勾选即可

![](http://photo.jomeswang.top/20200403124707.png)

#### 3.2.4	登陆（记得要在安全组中先开放5900端口）

使用windows自带mstsc（在运行端口中输入mstsc 即可打开），选择vnc-any模式，输入ip、密码





参考链接 ： [https://www.lizhongyi.com/archives/ubuntu-%E5%AE%89%E8%A3%85%E8%BF%9C%E7%A8%8B%E6%A1%8C%E9%9D%A2/](https://www.lizhongyi.com/archives/ubuntu-安装远程桌面/) 