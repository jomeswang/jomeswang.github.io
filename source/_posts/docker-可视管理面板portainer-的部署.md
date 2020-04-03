---
title: docker 可视管理面板portainer 的部署
top: false
comments: false
categories:
- docker
tags:
- docker
abbrlink: c7474bc9
date: 2020-03-27 23:20:08
---

## 一：前言

之前觉得一直黑面板管理docker项目很不好并且很多项目要去查找，最近发现了一个docker的可视面板，非常就像搞一下中文版的。（默认已经安装好docker了）

<!-- more -->

## 二：步骤

### 2.1 拉取portainer 镜像

```
docker pull portainer/portainer
```

并用`docker images` 查看是否拉取成功

`[root@iZwz9ci7skvj0jt7t5mwdpZ ~]# docker images`
`REPOSITORY    		    TAG       IMAGE ID     CREATED      SIZE`
`portainer/portainer    latest   2869fc110bf7   7 days ago  78.6MB`

### 2.2 原版portainer（推荐）

```
docker volume create portainer_data

docker run -d -p 8000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --name portainer-test portainer/portainer
```

`参数说明：`
`-d：容器在后台运行；`
`-p 8000:9000 ：宿主机9000端口映射容器中的8000端口`
`–restart 标志会检查容器的退出代码，并据此来决定是否要重启容器，默认是不会重启。``–restart=always：自动重启该容器`
`-v /var/run/docker.sock:/var/run/docker.sock ：把宿主机的Docker守护进程(Docker daemon)默认监听的Unix域套接字挂载到容器中`
`-v portainer_data:/data ：把宿主机portainer_data数据卷挂载到容器/data目录`
`–name portainer ： 给容器起名为portainer`

### 2.3	中文版portainer（翻译的不太友好）

#### 2.3.1 下载汉化包并放置

可以下载[汉化包](https://pan.baidu.com/s/1BLXMSmJFcgESeNMhQL26Mg&shfl=sharepset)（提取码：6vjr），之后解压，并将解压后的public文件夹上传到centos系统的根目录下，如下图所示：

![](http://photo.jomeswang.top/20200401151628.png)

#### 2.3 .2	创建portainer容器

```
docker volume create portainer_data

docker run -d -p 8000:9000 --restart=always  -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /public:/public --name portainer  portainer/portainer
（如果已部署，需要将之前的容器删除）
```

`参数说明：`
`-d：容器在后台运行；`
`-p 8000:9000 ：宿主机9000端口映射容器中的8000端口`
`–restart 标志会检查容器的退出代码，并据此来决定是否要重启容器，默认是不会重启。``–restart=always：自动重启该容器`
`-v /var/run/docker.sock:/var/run/docker.sock ：把宿主机的Docker守护进程(Docker daemon)默认监听的Unix域套接字挂载到容器中`
`-v portainer_data:/data ：把宿主机portainer_data数据卷挂载到容器/data目录`
`–name portainer ： 给容器起名为portainer`

使用`docker	ps` 看是否在运行中

采用 `IP:8000`访问

### 2.4	Portainer   的web页面访问设置

![](http://photo.jomeswang.top/20200401151703.png)

由于是本地docker，所有选择local

![](http://photo.jomeswang.top/20200401151720.png)

之后点击“Connect”，成功后跳转到主页界面（汉化后），如下图：

![](http://photo.jomeswang.top/20200401151744.png)

 点击“local”，进入该docker内，展示相关容器、堆栈、镜像等信息，如下图所示：

![](http://photo.jomeswang.top/20200401151800.png)

可以安装speedtest`docker`

```
docker run -d -p 8002:80 ilemonrain/html5-speedtest:alpine
```

