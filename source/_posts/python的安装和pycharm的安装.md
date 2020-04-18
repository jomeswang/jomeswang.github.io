---
title: python的安装和pycharm的安装
top: false
comments: true
categories:
  - python
tags:
  - pycharm
abbrlink: e0facaa1
date: 2020-02-29 16:59:29
---

基于python3和selenium3做自动化测试，俗话说：工欲善其事必先利其器；没有金刚钻就不揽那瓷器活，磨刀不误砍柴工，因此你必须会搭建基本的开发环境，掌握python基本的语法和一个IDE来进行开发，这里通过详细的讲解，介绍怎么搭建python3开发环境，并提供一个基本入门的代码，后续逐步提供系列实践文章。

<!-- more -->

### **安装包**

#### **python**

笔者使用python3.6.4，请根据机器是64位还是32位来选择对应的python版本。（相信绝大部分人都可以很从容的来查看自己机器的位数，在这里就不赘述了，如果不清楚自己可以百度一下就可以）

可以去python官网：https://www.python.org/下载对应机器的安装包。

安装包下载

第一步：进入python官网，点击download，如下图所示：

![](http://photo.jomeswang.top/20200410131352.png)

第二步：选择对应的操作系统和python版本，如下图所示：

![](http://photo.jomeswang.top/20200410131500.png)

第三步：点击要下载的python版本，即可下载安装包，如下图所示：

![](http://photo.jomeswang.top/20200410131519.png)

 

**开发工具**

笔者使用pyCharm开源版本
https://download.jetbrains.com/python/pycharm-community-2017.3.2.exe

## **python安装过程**

第一步：双击已下载的python安装包，出现如下图所示的界面，点击运行

  ![](http://photo.jomeswang.top/20200410131535.png)

然后出现如下界面：

  ![](http://photo.jomeswang.top/20200410131552.png)

在这里我选择的是自定义安装（Customize installation）,一定要勾选Add_Python 3.6 to PATH,防止手工添加环境变量 ，添加到环境变量也可以等安装完成之后手动添加到环境变量中，如果不添加环境变量运行python时则会出现如下界面：

 ![](http://photo.jomeswang.top/20200410131606.png)

在这里我没有选择添加到环境变量中，后面会手动配置

继续下一步界面如下：

![](http://photo.jomeswang.top/20200410131621.png)

选择安装的属性，Documentation、pip、tcl/tk and IDLE 必须安装，tcl/tk and IDLE是Python环境的开发环境窗口，pip用来安装numpy等package。 
我选择的是全部安装

继续下一步

![](http://photo.jomeswang.top/20200410131718.png)

ok了，点击install进行安装，在这里我安装的目录是D盘，D:\Python36 目录名可以自定义

注意我在这里依旧没有选择添加到环境变量，不想麻烦的话，可以直接选择添加到环境变量中

安装中

![](http://photo.jomeswang.top/20200410131732.png)

安装成功：

![](http://photo.jomeswang.top/20200410131754.png)

验证是否安装成功，使用系统的cmd命令：

![](http://photo.jomeswang.top/20200410131941.png)

验证失败，如果在安装的过程你选择了添加到环境变量中，输入python就会直接进入python的环境中，现在开始演示手动添加到环境变量：

首先，点击计算机->属性->高级系统设置

![](http://photo.jomeswang.top/20200410131954.png)

![](http://photo.jomeswang.top/20200410132024.png)

选择环境变量

![](http://photo.jomeswang.top/20200410132053.png)

新建 PATH 

![image-20200410132115623](C:\Users\Admin-Jumper\AppData\Roaming\Typora\typora-user-images\image-20200410132115623.png)

点击确定，接下来进行验证python是否安装成功：

依然是cmd命令下输入python，效果如下：

![](http://photo.jomeswang.top/20200410132143.png)

当你输入python出现如下命令时则表示python环境已经安装好了，就可以进行python之旅了。

安装pycharm，

先安装jb toolbox    https://www.jetbrains.com/toolbox-app/   再在这里安装pycharm

然后就可以新建项目并创建py文件运行

```
print("123")
```

试一下啊能否运行成功

