---
title: 记录一次将django项目成功部署到宝塔面板上
top: false
comments: true
categories:
  - python
tags:
  - django
abbrlink: 40c55697
date: 2020-04-07 12:29:51
---

## 一：前言

之前已经部署过一次django项目写过一次博客（ https://hexo.jomeswang.top/posts/c2d74008/ ），但这次再次部署又出现新的问题和新的发现，并写下此篇博客记录部署时踩过的坑。

<!-- more -->

## 二：步骤

### 2.1 事先准备

### 2.1.1 bt面板安装和环境包

这里只描述，不详写，详情可看这篇（ https://hexo.jomeswang.top/posts/c2d74008/ ）。

环境：使用的是 

1.Nginx1.16.1

2. bt面板的python项目管理器
3. python3.7.2
4. django3.0

### 2.2 上传并部署django文件

1. 生成依赖包文件

在上传项目文件的时候，我们需要先配置好项目所有的环境依赖包，所以，在本地开发的时候建议使用虚拟环境，这样我们创建依赖文件的时候，能减少引入一些不必要的包。在本地项目环境目录中(如果是虚拟环境，需要激活虚拟环境再进入项目目录)【django项目目录，即是在manage.py文件所处的路径】输入下方命令

```bash
pip freeze > requirements.txt
# 注意当前是 pip 还是 pip3
```

会生成一个 requirements.txt 文件，里面就会包含我们当前环境下所有的python包。

2. 先要上传django文件夹的全部到，/www/wwwroot/ 上的文件夹中，之后打开python项目管理器

![](http://photo.jomeswang.top/20200407123827.png)

3. 配置python项目管理器

![](http://photo.jomeswang.top/20200407124650.png)

4. 映射域名（注意一定要域名，如果是端口后面django后台样式将会不见）

![](http://photo.jomeswang.top/20200407125014.png)

### 2.3 踩坑开始

#### 2.3.1 Internal Server Error

打开之后发现页面显示Internal Server Error , 这个不出我所料。因此别慌

![](http://photo.jomeswang.top/20200407125152.png)

出现这个问题，一般是wsgi 出错

1. 首先先看一下能不能运行django

   进入虚拟环境

   ```
   source xxx_venv/bin/activate
   python manage.py runserver
   ```

   ![](http://photo.jomeswang.top/20200407134556.png)

发现可以成功运行。如果不可以成功运行有一下错误

![](http://photo.jomeswang.top/20200406232754.png)

这是python版本错误，通常是python3版本没有安装好，重新安装即可，也有可能是之前选择python版本时，选择了一个错误的python版本，因此需要重新上传部署。

还有另外一个错误是，如果你的数据库是sqlite3的话，也会有报错，因为centos7默认的数据库版本较低，可参照（ https://hexo.jomeswang.top/posts/c2d74008/ ）重新安装部署sqlite3数据库

2. 配置wsgi日志，配置wsgi文件

   建议先停止项目

   ```
   wsgi-file = 你的文件路径
   daemonize = 日志文件路径
   ```

   ![](http://photo.jomeswang.top/20200407135535.png)

3. 再次打开页面

   发现还是

   ![](http://photo.jomeswang.top/20200407135929.png)

#### 2.3.2 查看日志文件发现问题

1. 发现错误

   ![](http://photo.jomeswang.top/20200407141925.png)

2. 发现是django版本和sqlite3 版本不对

   我有点迷茫我的sqlite3版本已经升级成3.27了啊，为什么还是错误。可能重新安装python，重新安装sqlite3可以 https://stackoverflow.com/questions/55674176/django-cant-find-new-sqlite-version-sqlite-3-8-3-or-later-is-required-found 

   有点不懂。于是我只有选择降django版本了


```
卸载django:   pip uninstall django
安装低版本：   pip install django==2.1.8
```

#### 2.3.3 发现后台的样式不见了。。。。

现在我们通过 侧边栏 文件 菜单 进入项目文件，找到 [setting.py](https://links.jianshu.com/go?to=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttp%3A%2F%2Fsetting.py) 文件，进行编辑。

DEBUG模式设置为False，ALLOWED_HOST 添加 '*'

```php
DEBUG = False

ALLOWED_HOSTS = ['*']
```

配置静态文件地址为`/home/xxx_static/static/`，后面会统一把静态文件移至该目录

```csharp
STATIC_URL = '/static/'
STATICFILES_DIR = [
    os.path.join(BASE_DIR,'static'),
]
STATIC_ROOT = os.path.join(BASE_DIR,'static'),
```

这里也有一个坑，我之前弄好之后，访问网站老是提示：Bad Request (400)，后来一检查，才发现自己的ALLOWED_HOSTS这里设置有问题。修改之后，在python项目管理器中重启一下就好了。

**配置nginx代理**

在网站中点击我们映射出的域名或ip，会出现一个弹窗，选择 反向代理-》配置文件

找个缝隙，来添加静态文件和媒体资源的配置。

![](http://photo.jomeswang.top/20200407162808.png)

关于静态文件：就是存放css，js文件的位置。django框架中以static命名的。

关于媒体资源：比如用户上传图片的存放位置，一般命名有 media。 你设置的什么名字就写什么名字。

```csharp
location /static/ {
	alias /www/wwwroot/test/static/;
}
location /media/ {
    alias /www/wwwroot/test/media/;
}
```

按照文件路径设置即可，只需要替换红色框内的，换成你的路径，其他的不用动。如果保存的时候出现报错，就把空格啥的删除一下。

![](http://photo.jomeswang.top/20200407164105.png)

完成之后需要在项目中执行以下如下命名收集admin后台的静态文件，不然通过`uwsgi`服务启动的django服务，会找不到admin的样式文件导致样式失效。

- 进入项目根目录

```bash
cd /www/wwwroot/xxx
```

- 进入虚拟环境

```bash
source xxx_venv/bin/activate
```

- 执行如下命令（该命令将收集项目中所有静态资源，转移到上面配置的`/home/xxx_static/static/`目录）

```css
python manage.py collectstatic
```

- 重启python项目和nginx服务

这样应该就可以了，记住不要用域名加端口号访问，需要用域名访问，否则后台的样式会消失的。这个问题暂且放下。

![](http://photo.jomeswang.top/20200408113256.png)

## 三：总结

搞这个django后台确实非常累，总会遇到形形色色的问题，因此我又写下一篇篇文章，这些文章记录我的成长，希望我的经验可以让看到的人少走一些路，观者共勉。

