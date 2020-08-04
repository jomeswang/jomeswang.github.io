---
title: Django REST framework 学习
top: false
comments: true
categories:
  - Django
tags:
  - Django
  - python
  - DRF
abbrlink: bf8f345a
date: 2020-08-04 14:53:55
---

> 不要重复造轮子

<!--more--->

DRF模式就是高度集成化的 后端模式   可以将 工作简单化。

比较大的区别就是  有 序列化  有视图集可以简单化工作。

举一个例子。

我们将创建一个简单的允许管理员用户查看和编辑系统中的用户和组的API。

## 项目设置

创建一个名为 `tutorial` 的新django项目，然后启动一个名为 `quickstart` 的新app。

```
# 创建项目目录
mkdir tutorial
cd tutorial

# 创建一个virtualenv来隔离我们本地的包依赖关系
virtualenv env
source env/bin/activate  # 在Windows下使用 `env\Scripts\activate`

# 在创建的虚拟环境中安装 Django 和 Django REST framework
pip install django
pip install djangorestframework

# 创建一个新项目和一个单个应用
django-admin.py startproject tutorial .  # 注意结尾的'.'符号
cd tutorial
django-admin.py startapp quickstart
cd ..
```

现在第一次同步你的数据库：

```
python manage.py migrate
```

我们还要创建一个名为 `admin` 的初始用户，密码为 `password123`。我们稍后将在该示例中验证该用户。

```
python manage.py createsuperuser
```

等你建立好一个数据库和初始用户，并准备好开始。打开应用程序的目录，我们就要开始编码了...

## Serializers

首先我们要定义一些序列化程序。我们创建一个名为 `tutorial/quickstart/serializers.py`的文件，来用作我们的数据表示。

```
from django.contrib.auth.models import User, Group
from rest_framework import serializers


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'groups')


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')
```

请注意，在这个例子中我们用到了超链接关系，使用 `HyperlinkedModelSerializer`。你还可以使用主键和各种其他关系，但超链接是好的RESTful设计。

## Views

好了，我们接下来再写一些视图。打开 `tutorial/quickstart/views.py` 文件开始写代码了。

```
from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from tutorial.quickstart.serializers import UserSerializer, GroupSerializer


class UserViewSet(viewsets.ModelViewSet):
    """
    允许用户查看或编辑的API路径。
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer


class GroupViewSet(viewsets.ModelViewSet):
    """
    允许组查看或编辑的API路径。
    """
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
```

不再写多个视图，我们将所有常见行为分组写到叫 `ViewSets` 的类中。

如果我们需要，我们可以轻松地将这些细节分解为单个视图，但是使用viewsets可以使视图逻辑组织良好，并且非常简洁。

## URLs

好的，现在我们在`tutorial/urls.py`中开始写连接API的URLs。

```
from django.conf.urls import url, include
from rest_framework import routers
from tutorial.quickstart import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)

# 使用自动URL路由连接我们的API。
# 另外，我们还包括支持浏览器浏览API的登录URL。
urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
```

因为我们使用的是viewsets而不是views，所以我们可以通过简单地使用路由器类注册视图来自动生成API的URL conf。

再次，如果我们需要对API URL进行更多的控制，我们可以简单地将其拉出来使用常规基于类的视图，并明确地编写URL conf。

最后，我们将包括用于支持浏览器浏览的API的默认登录和注销视图。这是可选的，但如果您的API需要身份验证，并且你想要使用支持浏览器浏览的API，那么它们很有用。

## Settings

我们也想设置一些全局设置。我们想打开分页，我们希望我们的API只能由管理员使用。设置模块都在 `tutorial/settings.py` 中。

```
INSTALLED_APPS = (
    ...
    'rest_framework',
)

REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAdminUser',
    ],
    'PAGE_SIZE': 10
}
```

好了，我们完成了。





Django REST framework 中文网 :https://q1mi.github.io/Django-REST-framework-documentation/tutorial/quickstart_zh/



 Django REST framework的使用总结：https://juejin.im/post/6844903869336518664#heading-30



总结：https://www.atjiang.com/django-rest-tut5-relationships-and-hyperlinked-apis/