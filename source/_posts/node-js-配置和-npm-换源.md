---
title: node.js 配置和 npm 换源
top: false
comments: false
abbrlink: '73e70778'
date: 2020-06-06 15:09:56
categories:
- 环境配置
tags:
- 环境配置
- 教程
---

# node.js 配置和 npm 换源

<!--more-->

## 一：下载node.js

进入官网：https://nodejs.org/zh-cn/download/

就会出现下图：

![](http://photo.jomeswang.top/20200605153121.png)

## 二：安装node.js 

点击刚刚下载的文件。

会出现如下的页面点击Next 

![](http://photo.jomeswang.top/20200605153254.png)

之后

![](http://photo.jomeswang.top/20200605153350.png)

选择安装路径：  这里我选择的是  `D:\Program Files\nodejs\`

![](http://photo.jomeswang.top/20200605153513.png)

![](http://photo.jomeswang.top/20200605153634.png)

​	![](http://photo.jomeswang.top/20200605185454.png)

之后点击安装即可。

等待安装完成后是如下模样。

![](http://photo.jomeswang.top/20200605154103.png)

## 三：测试安装是否成功

安装完成后打开 cmd(或powershell)，输入命令 `node -v` 或者 `npm -v` 来查看node当前版本号或者npm当前版本。（cmd 可以在文件地址栏敲cmd 回车就会出现）

```
> node -v
v13.1.0
> npm -v
6.12.1
```

## 四：配置环境

> 说明：这里的环境配置主要配置的是npm安装的全局模块所在的路径，以及缓存cache的路径，之所以要配置，是因为以后在执行类似：npm install express [-g] （后面的可选参数-g，g代表global全局安装的意思）的安装语句时，会将安装的模块安装到【C:\Users\用户名\AppData\Roaming\npm】路径中，占C盘空间。

所以我希望将全模块所在路径和缓存路径放在我node.js安装的文件夹中，则在我安装的文件夹`D:\Program Files\nodejs`下创建两个文件夹`【node_global】及【node_cache】`

创建完两个空文件夹之后，打开cmd命令窗口，输入

```
npm config set prefix “D:\Program Files\nodejs\node_global”
npm config set cache “D:\Program Files\nodejs\node_cache”
```

![](http://photo.jomeswang.top/20200605172552.png)



接下来设置环境变量，关闭cmd窗口，“我的电脑”-右键-“属性”-“高级系统设置”-“高级”-“环境变量”

![](http://photo.jomeswang.top/20200605172609.png)

选择用户环境变量：备注：
环境变量Path的作用：path是路径变量，它的作用是告诉系统在当前目录找不到所需文件时，就按path指定的路径查找

![](http://photo.jomeswang.top/20200605173825.png)

在cmd中.查看nodeJS全局安装路径：

```
npm config ls
```



![](http://photo.jomeswang.top/20200605210534.png)

将这个`prefix` 的值替换成下方所要替换的路径

![](http://photo.jomeswang.top/20200605173856.png)



即变为：![](http://photo.jomeswang.top/20200605211101.png)

点确定就完成了。

## 五：npm换源

因为npm源在国外，所以国内就有人将这个仓库把他拷到国内，所以我们就要将这个地址替换掉原来的地址

### 5.1 直接换源法

npm查看源和换源：

在cmd中输入：

```
npm config get registry  // 查看npm当前镜像源

npm config set registry https://registry.npm.taobao.org/  // 设置npm镜像源为淘宝镜像
```

![](http://photo.jomeswang.top/20200605174800.png)

镜像源地址部分如下：

```
npm --- https://registry.npmjs.org/

cnpm --- https://r.cnpmjs.org/

taobao --- https://registry.npm.taobao.org/

nj --- https://registry.nodejitsu.com/

rednpm --- https://registry.mirror.cqupt.edu.cn/

npmMirror --- https://skimdb.npmjs.com/registry/

deunpm --- http://registry.enpmjs.org/
```

### 5.2 使用nrm 换源法

在使用 npm 的过程中，可能插件安装速度比较慢，我们可能会使用淘宝源对插件进行下载安装。或者在公司内部，有一些私有的插件，需要使用公司的源才可以下载。这种情况，我们就需要设置不同的源来进行下载。每次手动设置相对比较麻烦。而 nrm 可以很好的解决这个问题。

#### 5.2.1 nrm 的安装

```
# 全局安装 nrm
$ npm install nrm -g
复制代码
```

安装完成后，输入命令 `nrm ls`，可以看到默认已经有了 6 个源（带 * 号的为当前使用的源）

```
* npm ---- https://registry.npmjs.org/
  cnpm --- http://r.cnpmjs.org/
  taobao - https://registry.npm.taobao.org/
  nj ----- https://registry.nodejitsu.com/
  npmMirror  https://skimdb.npmjs.com/registry/
  edunpm - http://registry.enpmjs.org/
```

输入 `nrm use taobao`，即切换 registry 到 taobao，即可使用淘宝的源进行插件的安装下载了。

#### 5.2.2   nrm 常用命令

- `nrm ls`              ：查看所有配置好的源以及对应名称
- `nrm add company http://npm.xxx.cn`：添加源，`company` 是名称，可以自行命名，后面是源的 `url` 地址
- `nrm del company`     ：删除源，根据名称 `company` 可以删除对应的源
- `nrm test [registry]` ：测试源的速度，不加对应的 `registry` 名称，测试所有源的速度，添加对应的名称，比如 `company`，就是测试 `company` 对应的源的速度
- `nrm use company`     ：切换源，即可使用 `company` 对应名称的源
- 更多命令在命令行输入 `nrm` 即可查看

### 5.3 安装cnpm

你可以使用我们定制的 [cnpm](https://github.com/cnpm/cnpm) (gzip 压缩支持) 命令行工具代替默认的 `npm`:

```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

最后使用

```
cnpm install -g express 
```

试一下可是否可以运行cnpm。

![](http://photo.jomeswang.top/20200605212022.png)