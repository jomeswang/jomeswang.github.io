---
title: 在服务器上使用docker安装Jupyter Notebook
top: false
comments: true
categories:
  - docker
tags:
  - docker
  - Jupyter Notebook
abbrlink: 65c8dfc1
date: 2020-04-05 20:34:00
---

## 一：前言

使用docker快速安装Jupyter Notebook，来在远程快速编写python代码并运行

<!-- more -->

## 二：步骤

本文仅简略描述安装过程，对于安装那个版本请看[官网](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html)，本文采用`jupyter/datascience-notebook:9b06df75e445`

```
docker run --rm -p 8003:8888 --name 'jupyter_notebook' -dit -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/work jupyter/datascience-notebook:9b06df75e445
```

本代码指定8003的服务器端口连接容器的8888端口，并取名`'jupyter_notebook'`

同时使用`-dit` 来让docker容器在后端运行。-v 挂载本机的/home/www 至容器的/home/jovyan/work ，因此存储在此文件夹的文件在容器消失后仍在本机中。

在浏览器中输入   `IP:8003` 进行访问，会出现如下页面。

![](http://photo.jomeswang.top/20200405204712.png)

它要求token，可是他在后端运行，该怎么办呢.

1. 于是 使用 `docker ps`命令来查看该容器的`id` 并获取 

![](http://photo.jomeswang.top/20200405204843.png)

2. 再用 `docker logs id`  来获取这个容器的后台日志，如此就可以获得token，并在页面中输入并设置密码了。

![](http://photo.jomeswang.top/20200405204938.png)

3. 之后就可以看见页面了

![](http://photo.jomeswang.top/20200405205225.png)

