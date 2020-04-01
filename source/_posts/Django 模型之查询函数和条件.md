---
title: Django 模型之查询函数和条件
top: false
comments: true
categories:
  - python
tags:
  - python
  - django
abbrlink: 8a5cf313
date: 2020-03-11 19:56:24
---

Django 模型之查询函数和条件

<!-- more -->

## 1. 查询函数

通过模型类.objects属性可以调用如下函数，实现对模型类对应的数据表的查询。

| 函数名   | 功能                                     | 返回值                   | 说明                                                         |
| -------- | ---------------------------------------- | ------------------------ | ------------------------------------------------------------ |
| get      | 返回表中满足条件的一条且只能有一条数据。 | 返回值是一个模型类对象。 | 参数中写查询条件。1) 如果查到多条数据，则抛异常MultipleObjectsReturned。2)查询不到数据，则抛异常：DoesNotExist。 |
| all      | 返回模型类对应表格中的所有数据。         | 返回值是QuerySet类型     | 查询集                                                       |
| filter   | 返回满足条件的数据。                     | 返回值是QuerySet类型     | 参数写查询条件。                                             |
| exclude  | 返回不满足条件的数据。                   | 返回值是QuerySet类型     | 参数写查询条件。                                             |
| order_by | 对查询结果进行排序。                     | 返回值是QuerySet类型     | 参数中写根据哪些字段进行排序。                               |

### get   示例：

例：查询图书id为3的图书信息。

BookInfo.objects.get(id = 3)

### all   方法示例：

例：查询图书所有信息。

BookInfo.objects.all()

### filter   方法示例：

条件格式：

​	模型类属性名__条件名=值

查询图书评论量为34的图书的信息：

```
BookInfo.objects.filter(bcomment__exact=34)
BookInfo.objects.filter(bcomment=34)
```

### 查询条件

#### a)判等条件名:exact。

例：查询编号为1的图书。

BookInfo.objects.get(id=1)

#### b)模糊查询

例：查询书名包含'传'的图书。contains

BookInfo.objects.filter(btitle__contains='传')

例：查询书名以'部'结尾的图书 endswith 开头:startswith

BookInfo.objects.filter(btitle__endswith='部')

#### c)空查询 isnull

例：查询书名不为空的图书。isnull 

select * from booktest_bookinfo where btitle is not null;

BookInfo.objects.filter(btitle__isnull=False)

#### d)范围查询  in

例：查询id为1或3或5的图书。

select * from booktest_bookinfo where id in (1,3,5);

BookInfo.objects.filter(id__in = [1,3,5])

#### e)比较查询  gt(greate than) lt(less  than) gte(equal) 大于等于

lte 小于等于

例：查询id大于3的图书。

Select * from booktest_bookinfo where id>3;

BookInfo.objects.filter(id__gt=3)

#### f)日期查询

例：查询1980年发表的图书。

BookInfo.objects.filter(bpub_date__year=1980)

例：查询1980年1月1日后发表的图书。

from datetime import date

BookInfo.objects.filter(bpub_date__gt=date(1980,1,1))

#### g)exclude方法示例：

例：查询id不为3的图书信息。

BookInfo.objects.exclude(id=3)

#### h)order_by方法示例：

作用：进行查询结果进行排序。

例：查询所有图书的信息，按照id从小到大进行排序。

BookInfo.objects.all().order_by('id')

例：查询所有图书的信息，按照id从大到小进行排序。

BookInfo.objects.all().order_by('-id')

例：把id大于3的图书信息按阅读量从大到小排序显示。

BookInfo.objects.filter(id__gt=3).order_by('-bread')

## **2.** F对象

作用：用于类属性之间的比较。

### 使用之前需要先导入：

`from django.db.models import F`

例：查询图书阅读量大于评论量图书信息。

BookInfo.objects.filter(bread__gt=F('bcomment'))

例：查询图书阅读量大于2倍评论量图书信息。

BookInfo.objects.filter(bread__gt=F('bcomment')*2)

## **3.** Q对象

作用：用于查询时条件之间的逻辑关系。not and or，可以对Q对象进行 &|~ 操作。

### 使用之前需要先导入：

`from django.db.models import Q`

例：查询id大于3且阅读量大于30的图书的信息。

```
BookInfo.objects.filter(id__ gt=3, bread__gt=30)

BookInfo.objects.filter(Q(id__gt=3)&Q(bread__gt=30))
```

例：查询id大于3或者阅读量大于30的图书的信息。

```
BookInfo.objects.filter(Q(id__gt=3)|Q(bread__gt=30))
```

例：查询id不等于3图书的信息。

```
BookInfo.objects.filter(~Q(id=3))
```



## **4.** 聚合函数

作用：对查询结果进行聚合操作。

`sum count avg max min`

***\*aggregate：调用这个函数来使用聚合。\**** ***\*返回值是一个字典\****

***\*使用前需先导入\*******\*聚合类\*******\*：\**** 

`from django.db.models import Sum,Count,Max,Min,Avg`

例：查询所有图书的数目。

BookInfo.objects.all().aggregate(Count('id'))

{'id__count': 5}

***\*count函数\**** ***\*返回值是一个数字\****

作用：统计满足条件数据的数目。

例：统计所有图书的数目。

BookInfo.objects.all().count()

BookInfo.objects.count()

例：统计id大于3的所有图书的数目。

BookInfo.objects.filter(id__gt=3).count()

小结:

![](http://photo.jomeswang.top/20200331171513.png)

***参考文档：***

​	http://python.usyiyi.cn/translate/django_182/ref/models/querysets.html

