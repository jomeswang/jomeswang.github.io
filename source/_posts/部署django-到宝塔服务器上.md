---
title: 部署django 到宝塔服务器上
top: false
comments: true
categories:
  - python
tags:
  - python
  - django
  - 宝塔面板
abbrlink: c2d74008
date: 2020-03-15 23:43:10
---

## 一、服务器安装宝塔面板并进行基础设置

宝塔面板有很多实用的功能，具体可以去[宝塔官网](https://links.jianshu.com/go?to=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttps%3A%2F%2Fwww.bt.cn%2F)查看。我们的服务器使用的是 centos8 的系统，所以安装 linux 免费版的宝塔。

<!-- more -->

安装方法很简单，远程到服务器，输入命令进行安装即可

```csharp
# 安装命令
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
```

中途会有一次确认，按照操作提示输入 y 即可。

安装成功后，控制台会显示出宝塔面板的登录地址、用户名、密码。如下图所示，将内容记录好。

![](http://photo.jomeswang.top/20200406220250.png)

进行登录后，会提示推荐安装套件，直接关闭即可。然后点击左侧菜单栏中的面板设置，调整面板的 端口、安全入口、用户名及密码。修改完成后，记得点击最下方的保存。

注：安全入口：是拼接在登录地址之后的。之前系统会自动设置一个随机字符，更改安全入口后，将登录地址中的随机字符换成你更改后的内容。例如：安装后的登录地址为： [http://10.10.10.10:8888/f5165b61](https://links.jianshu.com/go?to=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttp%3A%2F%2F10.10.10.10%3A8888%2Ff5165b61) 修改安全入口的内容为： /btmb 以后宝塔面板的登录地址变为：[http://10.10.10.10:8888/btmb](https://links.jianshu.com/go?to=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttp%3A%2F%2F10.10.10.10%3A8888%2Fbtmb)

![](http://photo.jomeswang.top/20200406220325.png)



## 二、安装环境包

宝塔的基础设置搞完了，接下来我们安装环境部署的一些必要软件程序：python、nginx、mysql（如果用到了就安装）
 **注意：这里我们用的是Django3的版本，从Django2.0起就不支持mysql5.5了，所以这里要安装高版本的mysql，推荐`mysql5.6`**

在宝塔左侧菜单栏 点击 软件商店，第一页我们就可以看到nginx，点击安装选择急速安装即可。

![](http://photo.jomeswang.top/20200406220341.png)

与此同时，我们选择 宝塔插件 类别，在该类别下 选择 Python项目管理器 进行安装

![](http://photo.jomeswang.top/20200406220400.png)

安装成功后，会有一个 首页显示 的开关，我们打开这个开关，记得nginx也要打开这个哦。这个时候 我们在首页就可以看到了，因为后面我们会经常使用，所以最好要展示在首页。

![](http://photo.jomeswang.top/20200406220416.png)

接下来，我们该安装 python 了，在首页点击 python项目管理器，会出现一个弹窗，点击版本管理，选择一下你项目开发时使用的 python 版本。我使用的是 python 3.6.5 所以我安装这个版本。

注：python 2.7.5 显示已安装，这是系统自带的，我们不用管他。

![](http://photo.jomeswang.top/20200406220427.png)



## 三、上传项目文件并创建python项目

在上传项目文件的时候，我们需要先配置好项目所有的环境依赖包，所以，在本地开发的时候建议使用虚拟环境，这样我们创建依赖文件的时候，能减少引入一些不必要的包。在本地项目环境目录中(如果是虚拟环境，需要激活虚拟环境再进入项目目录)【django项目目录，即是在manage.py文件所处的路径】输入下方命令

```bash
pip freeze > requirements.txt
# 注意当前是 pip 还是 pip3
```

会生成一个 requirements.txt 文件，里面就会包含我们当前环境下所有的python包。

接下来，打开宝塔面板，点击 文件 ，

此时注意路径需要在/www/wwwroot/下

![](http://photo.jomeswang.top/20200406220446.png)

点击上传按钮，选择目录，将我们项目的整个目录都上传上来*（可以不用上传venv目录，这个是虚拟环境目录，会自动生成）。* 我的项目在电脑路径为D:/xzbcx_1.11，此时上传就选择django_test目录。上传弹窗需要加载一会才能展示出文件,之后点击弹窗底部的开始上传，在右上角有一个进度条，等上传完成后就可以关闭该弹窗。

![](http://photo.jomeswang.top/20200406220500.png)

项目文件大的话上传时间就会比较长，是的，我上传了三十多分钟。

好了，现在我们开始创建 python 项目。打开首页的 python 项目管理器，点击 添加项目。填充数据：

![](http://photo.jomeswang.top/20200406220520.png)

- 项目名称： 自定义就行，你开心就好
- 路径： 定位到项目目录即可
- Python 版本： 选择你项目对应的 python 版本
- 框架： 选择 django
- 启动方式： uswgi（自测了一下只有uswgi启动方式可行，其他的都没用，添加后服务启动不起来，除非自己去服务器手动启动）
- 启动文件/文件加： 定位到 [wsgi.py](https://links.jianshu.com/go?to=https%3A%2F%2Flink.zhihu.com%2F%3Ftarget%3Dhttp%3A%2F%2Fwsgi.py) 所在的路径
- 端口： 自定义就行，你开心就好，注意不要和系统端口冲突，设置1024端口号之后的，不然就算你开心也没用。
- 勾选上 是否安装模块依赖 与 开机启动

点击确定，然后等待创建。

##### 设置配置文件

注意： 选择的框架是 django 的时候，不需要设置

创建成功后，点击配置，增加一行wsgi.py的位置（`注意此步必做，否则会爆 Internal Server Error`
如果出现的是Internal Server Error，则应该是uwsgi的配置问题。
如果出现Server Error (500)则表示在其他方面出现了问题。
另外，经测试，如果数据库连接错误也会显示Server Error (500)。 ）

```undefined
wsgi-file = 你的文件路径
```

![](http://photo.jomeswang.top/20200406220630.png)

`502 Bad Gateway nginx错误的解决方法：`

这里有一个坑，改了上面的代码之后，有时会提示端口已经被占用，需要更改端口。
有时会造成这里改了端口，而nginx那里没有改，出现上面的错误。

这时只要保证二者的端口一致就可以了。

## 四、创建并同步数据库

### 	4.1 MYSQL 数据库

​	在宝塔面板左边菜单选择数据库，然后添加一个数据库：

创建完数据库后，把你项目中的数据库导出然后上传。如果你不从本地同步数据库导入，也可以直接在服务器上根据django规则来重新生成数据库。生成数据库步骤如下：

- 打开宝塔SSH终端
- 定位到项目目录

```bash
cd /var/www/wwwroot/xxx
```

- 进入虚拟环境

```bash
source xxx_venv/bin/activate
```

- 同步数据库

```css
python manage.py makemigrations
python manage.py migrate
```

创建完数据库之后，宝塔会自动生成用户名和一个随机密码

为了能连接数据库，这个时候需要把项目中的数据库配置修改一下。进入setting.py文件进行编辑，将下面的`NAME`、`USER`和`PASSWORD`修改成上图中的对应值之后保存。

```bash
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '数据库名称',
        'USER': '用户名',
        'PASSWORD': '数据库密码',
        'HOST': '',
        'PORT': ''
    }
}
```

### 	4.2.sqlite3数据库

 发现服务器本身的sqlite3数据库版本较低，为3.7 但django2.2版本以上的最低sqlite3版本为3.8以上，所以有两种方法解决

#### 	4.2.1 降django版本（最简单的方法）

```
卸载django:   pip uninstall django
安装低版本：   pip install django==2.1.8
```

### 4.2.2 更新sqlite3版本

```
＃更新SQLite 3
＃获取源代码（在主目录中运行）
[root@djangoServer ~]# cd ~
[root@djangoServer ~]# wget https://www.sqlite.org/2019/sqlite-autoconf-3270200.tar.gz
[root@djangoServer ~]# tar -zxvf sqlite-autoconf-3270200.tar.gz
 
＃构建并安装
[root@djangoServer ~]# cd sqlite-autoconf-3270200
[root@djangoServer sqlite-autoconf-3270200]# ./configure --prefix=/usr/local/sqlite
[root@djangoServer sqlite-autoconf-3270200]# make && make install
 
＃检查版本
## 最新安装的sqlite3版本
[root@djangoServer ~]# /usr/local/sqlite/bin/sqlite3 --version
3.27.2 2019-02-25 16:06:06 bd49a8271d650fa89e446b42e513b595a717b9212c91dd384aab871fc1d0f6d7
[root@djangoServer ~]# 
 
## Centos7自带的sqlite3版本
[root@djangoServer ~]# /usr/bin/sqlite3 --version
3.7.17 2013-05-20 00:56:22 118a3b35693b134d56ebd780123b7fd6f1497668
[root@djangoServer ~]# 
 
## 可以看到sqlite3的版本还是旧版本，那么需要更新一下。
[root@djangoServer ~]# sqlite3 --version
3.7.17 2013-05-20 00:56:22 118a3b35693b134d56ebd780123b7fd6f1497668
[root@djangoServer ~]# 
 
## 更改旧的sqlite3
[root@djangoServer ~]# mv /usr/bin/sqlite3  /usr/bin/sqlite3_old
 
## 软链接将新的sqlite3设置到/usr/bin目录下
[root@djangoServer ~]# ln -s /usr/local/sqlite/bin/sqlite3   /usr/bin/sqlite3
 
## 查看当前全局sqlite3的版本
[root@djangoServer ~]# sqlite3 --version
3.27.2 2019-02-25 16:06:06 bd49a8271d650fa89e446b42e513b595a717b9212c91dd384aab871fc1d0f6d7
[root@djangoServer ~]# 
 
＃将路径传递给共享库
# 设置开机自启动执行，可以将下面的export语句写入 ~/.bashrc 文件中，如果如果你想立即生效，可以执行source 〜/.bashrc 将在每次启动终端时执行
[root@djangoServer ~]# export LD_LIBRARY_PATH=/usr/local/sqlite/lib
[root@djangoServer ~]# vim ~/.bashrc

    # .bashrc

    # User specific aliases and functions

    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'

    # Source global definitions
    if [ -f /etc/bashrc ]; then
            . /etc/bashrc
    fi
    . "/root/.acme.sh/acme.sh.env"
    # 在这里加上这一行，位置要对
    export LD_LIBRARY_PATH="/usr/local/sqlite/lib"
    export PATH=~/.pyenv/bin:$PATH
    
 [root@djangoServer ~]# source ~/.bashrc
 [root@djangoServer ~]# python3
Python 3.6.8 (default, Aug  7 2019, 17:28:10) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-39)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3
>>> sqlite3.sqlite_version
'3.27.2'
# 成功完成，踩坑许多，特来记录
```

## 五、检查项目是否运行成功

经过上面的操作之后，项目已经在本地服务器运行起来了，这个时候先检查一下项目运行的状况，是否有报错。

在面板中Python项目管理器 ，点击右侧的日志选项，查看你项目的运行状况，我这边项目的日志如下：

![](http://photo.jomeswang.top/20200406221116.png)

发现有报错，查阅资料发现是Django2.2之后内部的一个版本限制在作怪，相关文章在[这里](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fweixin_45476498%2Farticle%2Fdetails%2F100098297)查看，解决方案如下：

- 找到 `venv(虚拟环境路径)/lib/python/site-packages/django/db/backends/mysql/base.py` 
- 注释掉下面两行代码

```bash
version = Database.version_info
# if version < (1, 3, 13):
#     raise ImproperlyConfigured('mysqlclient 1.3.13 or newer is required; you have %s.' % Database.__version__)
```

- 重启python项目

继续观察日志，直到没有新的报错日志出现就说明项目运行成功了！

## 六、关闭DEBUG模式，调整静态设置

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
STATIC_ROOT = '/home/xxx_static/static/'
```

这里也有一个坑，我之前弄好之后，访问网站老是提示：Bad Request (400)，后来一检查，才发现自己的ALLOWED_HOSTS这里设置有问题。修改之后，在python项目管理器中重启一下就好了。

## 七、设置网站服务，并配置nginx代理

上述操作，我们已经在内部启动了，接下来就是设置成网站服务，提供外部访问，并设置 nginx 代理加载静态文件。

在 python 项目管理器 中点击 映射，设置域名 或者外网IP`（注意端口号要与之前的管理器上的端口号一致否则会爆400error）`。映射成功后在面板侧边栏 网站 菜单中查看。（此时已经可以在外部访问了。但是是没有静态文件的）

在网站中点击我们刚才映射出的域名或ip，会出现一个弹窗，选择 反向代理-》配置文件

找个缝隙，来添加静态文件和媒体资源的配置。

关于静态文件：就是存放css，js文件的位置。django框架中以static命名的。

关于媒体资源：比如用户上传图片的存放位置，一般命名有 media。 你设置的什么名字就写什么名字。

```csharp
location /static/ {
    root /home/xzbcx1_static/;
    break;
}
location /media/ {
    alias /www/wwwroot/xzbcx1.11/media/;
}
```

按照文件路径设置即可，只需要替换红色框内的，换成你的路径，其他的不用动。如果保存的时候出现报错，就把空格啥的删除一下。

![](http://photo.jomeswang.top/20200406230854.png)

完成之后需要在项目中执行以下如下命名收集admin后台的静态文件，不然通过`uwsgi`服务启动的django服务，会找不到admin的样式文件导致样式失效。

- 进入项目根目录

```bash
cd /var/www/wwwroot/xxx
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

到此，万事大吉！可以通过你设置的域名或ip进行访问了。

如果不行尝试在虚拟环境下手动执行：

```powershell
newsgirl-d --ini /www/wwwroot/boxdata/uwsgi.ini -w boxdata.wsgi.application
```



[Django+Nginx+uWSGI部署到服务器Django admin后台样式消失](https://blog.csdn.net/qq_31024823/article/details/87703974)

[宝塔面板成功部署Django项目流程](https://blog.dyboy.cn/program/144.html#title-9)

