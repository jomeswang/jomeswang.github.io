---
title: Ubuntu 挂载硬盘
top: false
comments: true
categories:
  - Linux
tags:
  - Linux
  - Ubuntu
abbrlink: b4f7e34f
date: 2020-10-26 22:45:57
---

> 每天一篇学习记录

<!--more--->

### 一： 第一步  使用   `df -h`        # 查看磁盘空间占用

![](http://photo.jomeswang.top/20201026224925.png)

### 二：  fdisk -l 　　# 查看磁盘设备信息

![](http://photo.jomeswang.top/20201026224933.png)

### 三： 整理磁盘，并且，新增磁盘分区

```
fdisk　 /dev/sda　＃进行磁盘操作
```

![](http://photo.jomeswang.top/20201026225016.png)

![](http://photo.jomeswang.top/20201026225026.png)

![](http://photo.jomeswang.top/20201026225050.png)

![](http://photo.jomeswang.top/20201026225104.png)

### 四： 挂载磁盘

使用命令 sudo mkfs.ext4  /dev/sda2    # 设置分区的文件系统类型



咱们需要做的就是，将这个磁盘 挂载到某个你想要的位置即可。

例如：在 home 下新建sda2作为这块磁盘挂载点

```
mkdir /home/sda2
sudo mount /dev/sda2 /home/sda2
```



### 五： 设置开机磁盘自动挂载

```
vi /etc/fstab
添加行  /dev/sda2     /home/work   ext4   defaults 0 1
```


