---
title: hexo配置在云服务器（宝塔面板）上
top: false
comments: true
categories:
  - hexo
tags:
  - hexo
  - ECS
abbrlink: b2d2fe74
date: 2020-02-23 14:31:32
---

## 一：前言

发现博客部署到github上访问非常慢，于是将它部署到自己的服务器上。

<!-- more -->

## 二：安装

### 2.1配置

#### 2.1.1 服务器配置

centos7服务器，已经安装bt面板和lamp环境

#### 2.1.2本机配置

win10，已经部署好hexo至github

### 2.2安装配置git

#### 2.2.1安装git

```
yum install git
```

+ 检查安装信息：`git --version`     

#### 2.2.2创建git用户

```
adduser git
```

#### 2.2.3配置git用户

```
chmod 740 /etc/sudoers
vim /etc/sudoers
```

找到以下内容

```
## Allow root to run any commands anywhere
root    ALL=(ALL)     ALL
```

在下面添加一行

```
git     ALL=(ALL)       ALL
```

 保存退出后改回权限：`chmod 400 /etc/sudoers` 

#### 2.2.4打开git服务器的rsa认证

 vim /etc/ssh/sshd_config
在sshd_config中开启以下几项（若没有请自行添加没有项）： 

```
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile  .ssh/authorized_keys
```

#### 2.2.5 设置git用户的密码

```
#需要root权限
sudo passwd git
```

#### 2.2.6 配置ssh

切换至git用户，创建 ~/.ssh 文件夹和 ~/.ssh/authorized_keys 文件，并赋予相应的权限

```
su git
mkdir ~/.ssh
vim ~/.ssh/authorized_keys
#然后将电脑中执行 cat ~/.ssh/id_rsa.pub | pbcopy ,将公钥复制粘贴到authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

- 然后就可以在本机端执行ssh 命令`ssh -v git@SERVER_IP`测试是否可以免密登录 至此，Git用户添加完成

如果成功最后会显示 `Welcome to xxx`,如若不行，请重新配置公钥再重试一次

### 2.3创建git仓库

 执行命令：`sudo git init --bare hexo.git` 

>  使用–bare 参数，Git 就会创建一个裸仓库，裸仓库没有工作区，我们不会在裸仓库上进行操作，它只为共享而存在。 

改变 /home/git/hexo.git 目录的拥有者为git用户：`sudo chown -R git:git hexo.git`

也可以 `git clonegit@YOUR_SERVER_IP:/home/git/hexo.git`看一下能不能把空仓库克隆下来，如果可以说明交互正常。

### 2.4配置钩子

有钩子可以在gitpull后处理文件

在 `hexo.git/hooks` 目录下新建一个 `post-receive` 文件，进入`cd /home/git/hexo.git/hooks/`，编辑这个文件`vim post-receive`
 在 `post-receive` 文件中写入如下内容：

```
#!/bin/bash
git --work-tree=/www/wwwroot/hexo --git-dir=/home/git/hexo.git checkout -f
```

+ 记住要改变网站所在目录的权限为777(是之有写入权利)
+ 设置这个文件的可执行权限：`chmod +x post-receive`

+ 注意，`/www/wwwroot/hexo` 要换成你自己的部署目录，正如上文所说，我是的配置目录是`/www/wwwroot/hexo`。其中`/home/git/hexo.git`是git仓库的位置。上面那句 git 命令可以在我们每次 push 完之后，把部署目录更新到博客的最新生成状态。这样便可以完成达到自动部署的目的了。

## 三.在本机上配置

搭建好后，修改hexo根目录下的_config.yml

```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
- type: git
  repository: 
    ECS:    git@YOUR_SERVER_IP:/home/git/hexo.git,master
```

其中`YOUR_SERVER_IP`换成你的服务器ip或域名，`/home/git/hexo.git`换成你的git仓库地址

最后 hexo clean && hexo g && hexo d

看一下有没有部署到服务器上