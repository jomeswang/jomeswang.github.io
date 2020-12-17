---
title: node 虚拟环境
top: false
comments: false
categories:
  - node
tags:
  - node
abbrlink: c46c956
date: 2020-12-13 16:21:13
---

> 众里寻它千百度漠然回首，那人却在灯火阑珊处

<!--more--->

Taro有个很麻烦的问题，就是Taro的项目工程对Taro的版本要求比较严格，例如使用1.3.25版本开发的项目，就不能使用1.3.33的版本运行，即小版本无法兼容。

同时，Taro为了能够跟上各端的前进步伐，自己的版本更新也很快。这很容易导致一个现象，如果本地同时开发两个或多个Taro项目，但它们使用的Taro版本又不一致，每次运行一个项目可能就需要先重新安装一次Taro，而且多个项目不能同时运行。

为了解决这个问题特意搜索一番，发现一个python的包可以利用：nodeenv。是的你没看错，就是python的，但它实现的是创建node的虚拟环境，与python虚拟环境很类似。

首先要保证本地环境安装了python，mac及linux系统自带2.x版本的python，windows环境需要自己安装，关于python的话题在此不多说。下面我们介绍如何利用nodeenv解决Taro版本冲突问题。

- 安装nodeenv

> sudo pip install nodeenv

- 在当前项目路径下创建虚拟nodeenv环境

> nodeenv --node=system taro3.0.7

`--node=system`表示利用当前系统中的node创建虚拟环境，即不独立安装node，且在虚拟环境下能访问到系统node安装的全局工具包。

如果要安装完全独立的环境，可去掉该参数或把system改为具体的node版本号。由于我们只要是解决Taro问题，所以选择使用系统的node来创建。

`taro3.0.7`是要创建的虚拟环境的文件夹名称

- 启动虚拟环境

> .  taro3.0.7/bin/activate

启动后命令行提示符变成这样

> (taro3.0.7) $

- 在虚拟环境下安装指定版本的Taro

> (taro3.0.7)  $ npm install -g @tarojs/cli@3.0.7

***注意，一定要用npm做全局安装，yarn不受虚拟环境影响会安装到系统全局\***

安装完成后可查看版本

> (taro3.0.7) $ taro -V

> 

> 👽 Taro v3.0.7

> 

> 3.0.7

查看taro的安装位置

> which taro

> /Users/konghui/Project/Wosai/dbb-merchant-mini/taro3.0.7/bin/taro

- 正常启动项目就可以了

> (taro3.0.7) $  yarn dev:weapp

所有项目本地的操作使用yarn与npm都可以。

- 退出虚拟环境

在不需要虚拟环境时可直接执行如下命令

> (taro3.0.7) $ deactivate_node

### 附图

**下面是两个不同的项目，分别使用taro1.3.25和3.0.7版本**

```
tarojs1.3.25版本示意图
```

> ![img](https:////upload-images.jianshu.io/upload_images/25030467-5071811a114d40b0.png?imageMogr2/auto-orient/strip|imageView2/2/w/358/format/webp)
>
> 1.3.25图片

> ![img](https:////upload-images.jianshu.io/upload_images/25030467-4bf8887524abf704.png?imageMogr2/auto-orient/strip|imageView2/2/w/805/format/webp)
>
> 1.3.25图片

```
tarojs3.0.7版本示意图
```

> ![img](https:////upload-images.jianshu.io/upload_images/25030467-b0ce11984d4b294c.png?imageMogr2/auto-orient/strip|imageView2/2/w/358/format/webp)
>
> 3.0.7图片

> ![img](https:////upload-images.jianshu.io/upload_images/25030467-20ca9bac115cc873.png?imageMogr2/auto-orient/strip|imageView2/2/w/865/format/webp)
>
> 3.0.7图片

## 注意

项目目录下的的虚拟环境目录只在本地保留即刻，`切勿`上传到gitlab，把你使用的虚拟环境的目录写到`.gitignore`里面。

如我是用taro+版本号的虚拟环境目录，可以在gitignore内加入下面一行代码



作者：辉_31d6
链接：https://www.jianshu.com/p/7896ec42d904
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。