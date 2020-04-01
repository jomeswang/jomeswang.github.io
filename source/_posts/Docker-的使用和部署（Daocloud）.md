---
title: Docker 的使用和部署（Daocloud）
top: false
comments: true
categories:
  - docker
tags:
  - docker
abbrlink: e43ebf58
date: 2020-03-18 12:39:31
---

## 一：Docker的安装和Daocloud的使用

### 1.1 docker安装

#### 1.1.1 主流 Linux 发行版上安装

Docker 的[安装资源文件](https://get.docker.com/)存放在Amazon S3，国内下载速度极其缓慢。您可以通过执行下面的命令，使用 DaoCloud 镜像站点，高速安装Docker。

<!--- more -->

```
curl -sSL https://get.daocloud.io/docker | sh 
```

该安装包适用于 Ubuntu，Debian，Centos 等大部分主流 Linux 发行版，DaoCloud 后台会每隔 3 小时同步一次 Docker 官方资源，确保您第一时间获取最新的 Docker 安装文件。

您也可以安装[体验版](https://github.com/docker/docker/tree/master/experimental)或测试版，体验最新 Docker。

```
curl -sSL https://get.daocloud.io/docker-experimental | sh
curl -sSL https://get.daocloud.io/docker-test | sh 
```

如果安装不成功，可以选择使用二进制包安装方式，点击[下载二进制包](https://get.daocloud.io/docker/builds)，DaoCloud 安装镜像也提供了各种历史版本的安装包。

检测docker 是否安装成功

```
使用 docker --version
```

#### 1.1.2  Windows

### Windows

首先，在 [get.daocloud.io](http://get.daocloud.io/) 下载 Windows 版本的 Docker Toolbox，这是 Docker 提供的一个完整的开发组件，适用于 Mac OS X 10.8+ 和 Windows 7 & 8.1，Docker Toolbox 包含：

- Docker Client
- Docker Machine
- Docker Compose (Mac only)
- Docker Kitematic
- VirtualBox

Docker Toolbox 安装文件尺寸在 200M 左右，如果从 Docker 主站下载，速度会非常缓慢，建议您在 [get.daocloud.io](http://get.daocloud.io/) 的镜像上下载。

 Docker Toolbox 启动了一个运行在 VirtualBox 虚拟机之上的 Linux，并通过类似 ssh 的方式，使 Windows 用户连接进入这个虚拟机的终端，进行各类 Docker 操作。有关 Docker Toolbox 的使用细节，可以参考 Docker 的[官方文档](https://docs.docker.com/engine/installation/windows/)。 

### 1.2  daocloud 加速器的安装

#### 1.2.1 Linux

```
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
```

该脚本可以将 --registry-mirror 加入到你的 Docker 配置文件 /etc/docker/daemon.json 中。适用于 Ubuntu14.04、Debian、CentOS6 、CentOS7、Fedora、Arch Linux、openSUSE Leap 42.1，其他版本可能有细微不同。更多详情请访问文档。

#### 1.2.2  Windows

Docker For Windows

在桌面右下角状态栏中右键 docker 图标，修改在 Docker Daemon 标签页中的 json ，把下面的地址:

```
http://f1361db2.m.daocloud.io
```

加到" `registry-mirrors`"的数组里。点击 Apply 。

Docker Toolbox 等配置方法请参考[帮助文档](http://guide.daocloud.io/dcs/daocloud-9153151.html#docker-toolbox)。

Docker 镜像站是什么，我需要使用吗？

 **Docker 镜像站是什么，我需要使用吗？** 使用 Docker 的时候，需要经常从官方获取镜像，但是由于显而易见的网络原因，拉取镜像的过程非常耗时，严重影响使用 Docker 的体验。因此 DaoCloud 推出了镜像站工具解决这个难题，通过智能路由和缓存机制，极大提升了国内网络访问 Docker Hub 的速度，目前已经拥有了广泛的用户群体，并得到了 Docker 官方的大力推荐。如果您是在国内的网络环境使用 Docker，那么 Docker 镜像站一定能帮助到您。

## 二：Daocloud 界面的配置

### 2.1 GitHub，微信绑定

### 2.2 在集群管理处增加管理主机 方便管理docker主机

daocloud帮助文档： http://guide.daocloud.io/dcs/daocloud-9153148.html 

daocloud镜像市场：  https://hub.daocloud.io/ 

## 三：Docker 的使用

### 3.1：Docker的拉取和部署

#### 3.1.1 	2048Docker拉取

[网页版2048docker](https://hub.daocloud.io/repos/6f7a340c-b193-4a36-a765-4e660ddebd1c)

进去后发现镜像地址和版本以及说明

最新版本:	latest

镜像地址:	daocloud.io/daocloud/dao-2048

然后在终端中运行

```
dao pull daocloud.io/daocloud/dao-2048:latest
```

dao pull命令是daocloud的拉取命令

看是否拉取成功(看本机中是否有2048 docker)

```
docker images
```

#### 3.1.2 2048 的部署

```
docker run -d -it --name 2048 -p 9094:80 daocloud.io/daocloud/dao-2048
```

```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

-d: 后台运行容器，并返回容器ID；

-i: 以交互模式运行容器，通常与 -t 同时使用；

-P: 随机端口映射，容器内部端口随机映射到主机的高端口

-p: 指定端口映射，格式为：主机(宿主)端口:容器端口(小写)

-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；

--name="nginx-lb": 为容器指定一个名称；
```

之后就可以打开 `主机ip:9094` 看到轻松部署的网页版2048了，是不是很简单啊！

