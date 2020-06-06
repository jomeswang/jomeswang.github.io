---
title: hexo 迁移电脑
top: false
comments: true
categories:
  - 环境配置
tags:
  - 环境配置
  - 教程
abbrlink: 921d30fb
date: 2020-06-06 16:05:35
---

hexo 迁移电脑

<!--more--->

## 一：安装gitbash

打开官网，下载，然后几乎全部默认安装即可

进入官网：https://gitforwindows.org/

![](http://photo.jomeswang.top/20200606134139.png)

## 二：设置密钥连接GitHub

- 设置git全局邮箱和用户名

```text
git config --global user.name "yourgithubname"
git config --global user.email "yourgithubemail"
```

- 设置ssh key

```text
ssh-keygen -t rsa -C "youremail"
#生成后填到github和coding上（有coding平台的话）
```

打开其中的文件，将其中的内容复制下来，进入web的GitHub

![](http://photo.jomeswang.top/20200606142650.png)

进入GitHub，选取settings->SSH and GPG keys->NewSSH key

title随意，然后将刚才复制的密钥粘贴进去。

此时进入git bash 中，输入

```
#验证是否成功
ssh -T git@github.com
```

![](http://photo.jomeswang.top/20200606142754.png)

然后打开自己的GitHub仓库使用ssh方式克隆下仓库，同时克隆下的仓库默认是master分支，所以需要先更改默认分支为dev，然后在clone下来。

之后

```
cd  xxx.github.io
npm install // 安装好依赖包
npm install hexo-deployer-git --save

然后使用
hexo clean && hexo g && hexo d
看看能不能发布上去
```

