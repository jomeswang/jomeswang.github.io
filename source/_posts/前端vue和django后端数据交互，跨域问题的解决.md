---
title: 前端vue和django后端数据交互，跨域问题的解决
top: false
comments: true
categories:
  - vue
  - django
tags:
  - vue
  - django
abbrlink: b84be3d8
date: 2020-03-31 22:24:55
---

## 一：前言

再前后端的数据交互问题上，经常会遇到跨域问题。即这个错误

>  Access to XMLHttpRequest at '[http://127.0.0.1](http://127.0.0.1/):8000/api/test/' from origin '[http://127.0.0.1](http://127.0.0.1/):3000' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource. 

 翻译过来即是：从源地址 [http://127.0.0.1](http://127.0.0.1/):3000 发起的到[http://127.0.0.1](http://127.0.0.1/):8000/api/test/ 的XMLHttpRequest访问违反了同源策略：因为在请求头中没有Access-Control-Allow-Origin的值 

<!-- more -->

现在来看一看什么是跨域问题。

### 1.1 什么是跨域

>  由于开发模式为前后端分离式开发，故而通常情况下，前端和后端可能运行不同的ip或者port下，导致出现跨域问题，故而单独说明 

跨域是指一个域下的文档或脚本试图去请求另一个域下的资源，这里跨域是广义的。
其实我们通常所说的跨域是狭义的，是由浏览器同源策略限制的一类请求场景。

什么是同源策略？

同源策略/SOP（Same origin policy）是一种约定，由Netscape公司1995年引入浏览器，它是浏览器最核心也最基本的安全功能，如果缺少了同源策略，浏览器很容易受到XSS、CSFR等攻击。所谓同源是指"协议+域名+端口"三者相同，即便两个不同的域名指向同一个ip地址，也非同源。

同源策略限制以下几种行为：

1. Cookie、LocalStorage 和 IndexDB 无法读取
2. DOM 和 Js对象无法获得
3. AJAX 请求不能发送

### 二：解决方法

### 2.1 ： 前端解决

运用vue-jsonp

详情可参考这篇博客：  https://hexo.jomeswang.top/posts/860a051a/ 

简单讲就是

先安装

```
使用npm的用 npm install vue-jsonp -save

使用yarn 的可用 yarn add vue-jsonp

之后再vue-cli的入口文件 main.js 引入

import VueJsonp from 'vue-jsonp'
Vue.use(VueJsonp)
```

然后使用

```
//访问地址'url?q=123'
this.$jsonp('url',{q: 123 })
	.then( ( response ) => { console.log(response) })
	.catch( (error) => { console.log(error)} )
```

 详情可看[官网](https://github.com/LancerComet/vue-jsonp#readme) 

### 2.2： 后端解决

#### 2.2.1  安装  django-cors-headers

```
pip install django-cors-headers
```

#### 2.2.2 注册运用

```
在项目的文件中有个settings.py 

INSTALLED_APPS = (
	...
    'corsheaders',		# 加入这个应用描述
    ...
)
```

#### 2.2.3 添加中间件

```
MIDDLEWARE_CLASSES = (
    ...
    'corsheaders.middleware.CorsMiddleware',# 注意顺序！！！（可以放第一个） 
    'django.middleware.common.CommonMiddleware', 
    ...
)
```

### 2.2.4 允许跨域ip

```
直接允许所有主机跨域

CORS_ORIGIN_ALLOW_ALL = True 默认为False
```

#### 2.2.5允许携带cookie

```
CORS_ALLOW_CREDENTIALS = True
```

### 2.2.6 请求头和方法（直接复制到中间件的后面即可）

```
CORS_ALLOW_METHODS = (
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
    'VIEW',
)

CORS_ALLOW_HEADERS = (
    'XMLHttpRequest',
    'X_FILENAME',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
    'Pragma',
)
```

#### 2.2.7  被csrf拦截     CSRF Failed: CSRF token missing or incorrect

在所在的函数前面加上`@csrf_exempt`修饰器

```
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt
def my_view(request):
    c = {}
    # ...
    return render(request, "a_template.html", c)
```

到此就可以完美解决跨域问题啦！！！

