---
title: 将django查询的查询集转化为json的三种方式
top: false
comments: true
categories:
  - python
tags:
  - django
abbrlink: '640e5544'
date: 2020-03-31 22:09:55
---

## 一：前言

今天把工具箱的后台修一修，把前端vue到后台django的数据get方式弄好了，但其中有些坑，我再这里记录一下。

<!-- more -->

## 二：过程

### 2.1 django查询出来的数据转为json

#### 2.1.1 第一种方式

 利用seriallizers
这个方法，官网的解释说：将复杂的数据结构变成json、xml或者其他的格式 

```
import json
from django.core import serializers
def area2(request,id):
 
    data = {}
    province  = serializers.serialize("json",AreaInfo.objects.filter(parea__isnull=True))
    data["data"] = json.loads(province)
 
    return JsonResponse(data,safe=False)
```

![](http://photo.jomeswang.top/20200331221609.png)

#### 2.1.2，使用list，这也是最最简单的（最推荐）

```
def area2(request,id):
 
    data = {}
    province = AreaInfo.objects.filter(parea__isnull=True).values()
    data["data"] = list(province)
 
    return JsonResponse(data,safe=False)
```

或者

```
def area2(request,id):
	data={data:list(AreaInfo.objects.filter(parea__isnull=True).values())}
	return JsonResonse(data, safe = False )
```

![](http://photo.jomeswang.top/20200331221924.png)

#### 2.1.3  第三种方法比较原始，利用for循环拼装 

```
def area2(request,id):
 
    data = AreaInfo.objects.filter(parea__isnull=True)
    list=[]
    for province in data:
        list.append([province.id,province.title])
    data={'data':list}
 
    return JsonResponse(data,safe=False)
```

## 三：总结

这个问题之前搞过，现在又忘了，写一个博客来记录一下。