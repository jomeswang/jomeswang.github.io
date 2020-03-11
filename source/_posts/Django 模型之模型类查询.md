---
title: Django 模型之模型类查询
top: false
comments: true
categories:
  - python
tags:
  - python
  - django
abbrlink: b97af40
date: 2020-03-11 19:56:24
---

Django 模型之模型类查询

<!-- more -->

## **1.** ***\*查询集\****

all, filter, exclude, order_by调用这些函数会产生一个查询集，QuerySet类对象可以继续调用上面的所有函数。

### ***\*1.1\**** ***\*查询集特性\****

1） 惰性查询：只有在实际使用查询集中的数据的时候才会发生对数据库的真正查询。

2） 缓存：当使用的是同一个查询集时，第一次使用的时候会发生实际数据库的查询，然后把结果缓存起来，之后再使用这个查询集时，使用的是缓存中的结果。

### ***\*2.2\**** ***\*限制查询集\****

可以对一个查询集进行取下标或者切片操作来限制查询集的结果。

对一个查询集进行切片操作***\*会产生一个新的查询集\****，下标不允许为负数。

取出查询集第一条数据的两种方式:

| 方式         | 说明                                             |
| ------------ | ------------------------------------------------ |
| b[0]         | 如果b[0]不存在，会抛出IndexError异常             |
| b[0:1].get() | 如果b[0:1].get()不存在，会抛出DoesNotExist异常。 |

***\*exists:判断一个查询集中是否有数据。True False\****

## **2.** ***\*模型类关系\****

### 1） 一对多关系 

例：图书类-英雄类 

models.ForeignKey() 定义在多的类中。

### 2） 多对多关系  

例：新闻类-新闻类型类 体育新闻 国际新闻

models.ManyToManyField() 定义在哪个类中都可以。

### 3） 一对一关系   

例：员工基本信息类-员工详细信息类. 员工工号

models.OneToOneField定义在哪个类中都可以。

## **3.** 关联查询（一对多）

### ***\*11.1 查询和对象关联的数据\****

在一对多关系中，一对应的类我们把它叫做一类，多对应的那个类我们把它叫做多类，我们把多类中定义的建立关联的类属性叫做关联属性。

例：查询id为1的图书关联的英雄的信息。

​	b=BookInfo.objects.get(id=1)

​	b.heroinfo_set.all()

***\*通过模型类查询：\****

​	HeroInfo.objects.filter(hbook__id=1)

例：查询id为1的英雄关联的图书信息。

​	h = HeroInfo.objects.get(id=1)

​	h.hbook

***\*通过模型类查询：\****

​	BookInfo.objects.filter(heroinfo__id=1)

***\*格式：\****

![img](file:///C:\Users\Administrator\AppData\Local\Temp\ksohtml9048\wps2.jpg) 

由一类的对象查询多类的时候：

​	一类的对象.多类名小写_set.all() #查询所用数据

由多类的对象查询一类的时候：

​	多类的对象.关联属性  #查询多类的对象对应的一类的对象

由多类的对象查询一类对象的id时候：

​	多类的对象. 关联属性_id

### ***\*11.2\**** ***\*通过模型类实现关联查询\****

[![8CbAY9.md.png](https://s2.ax1x.com/2020/03/10/8CbAY9.md.png)](https://imgchr.com/i/8CbAY9) 

例：查询图书信息，要求图书关联的英雄的描述包含'八'。

```
BookInfo.objects.filter(heroinfo__hcomment__contains='八')
```

例：查询图书信息，要求图书中的英雄的id大于3.

```
BookInfo.objects.filter(heroinfo__id__gt=3)
```

例：查询书名为“天龙八部”的所有英雄。

```
HeroInfo.objects.filter(hbook__btitle='天龙八部')
```

通过多类的条件查询一类的数据：

​	`一类名.objects.filter(多类名小写__多类属性名__条件名)` 

通过一类的条件查询多类的数据：

​	`多类名.objects.filter(关联属性__一类属性名__条件名)`

## **4.** ***\*插入、更新和删除\****

调用一个模型类对象的save方法的时候就可以实现对模型类对应数据表的插入和更新。

调用一个模型类对象的delete方法的时候就可以实现对模型类对应数据表数据的删除。

## **5.** ***\*自关联\****

[![8CbZS1.png](https://s2.ax1x.com/2020/03/10/8CbZS1.png)](https://imgchr.com/i/8CbZS1) 

自关联是一种特殊的一对多的关系。

案例：显示广州市的上级地区和下级地区。

地区表：id, atitle, aParent_id;

对于地区信息、分类信息等数据，表结构非常类似，每个表的数据量十分有限，为了充分利用数据表的大量数据存储功能，可以设计成一张表，内部的关系字段指向本表的主键，这就是自关联的表结构。

打开booktest/models.py文件，定义AreaInfo类。

> 说明：关系属性使用self指向本类，要求null和blank允许为空，因为一级数据是没有父级的。

```
#定义地区模型类，存储省、市、区县信息
class AreaInfo(models.Model):
    atitle=models.CharField(max_length=30)#名称
    aParent=models.ForeignKey('self',null=True,blank=True)#关系
```

## **6.** ***\*管理器\****

BookInfo.objects.all()->objects是一个什么东西呢？

答：objects是Django帮我自动生成的管理器对象，通过这个管理器可以实现对数据的查询。

objects是models.Manger类的一个对象。自定义管理器之后Django不再帮我们生成默认的objects管理器。

### ***\*14.1 自定义模型管理器类\****

1) 自定义一个管理器类，这个类继承models.Manger类。

2) 再在具体的模型类里定义一个自定义管理器类的对象。

### ***\*14.2\**** ***\*自定义管理器类的应用场景\****

1） 改变查询的结果集。

比如调用BookInfo.books.all()返回的是没有删除的图书的数据。

2） 添加额外的方法。

管理器类中定义一个方法帮我们操作模型类对应的数据表。

使用self.model()就可以创建一个跟自定义管理器对应的模型类对象。

.在管理器类中定义创建对象的方法

对模型类对应的数据表进行操作时，推荐将这些操作数据表的方法封装起来，放到模型管理器类中。

a）打开booktest/models.py文件，定义方法create。

```
class BookInfoManager(models.Manager):
    ...
    #创建模型类，接收参数为属性赋值
    def create_book(self, title, pub_date):
        #创建模型类对象self.model可以获得模型类
        book = self.model()
        book.btitle = title
        book.bpub_date = pub_date
        book.bread=0
        book.bcommet=0
        book.isDelete = False
        # 将数据插入进数据表
        book.save()
        return book
```

b）为模型类BookInfo定义管理器books语法如下

```
class BookInfo(models.Model):
    ...
    books = BookInfoManager()
```

c）调用语法如下：

```
调用：book=BookInfo.books.create_book("abc",date(1980,1,1))
```

***\*小结:\****

[![8CbKeO.png](https://s2.ax1x.com/2020/03/10/8CbKeO.png)](https://imgchr.com/i/8CbKeO) 

## 7.元选项

在模型类中定义类Meta，用于设置元信息，如使用db_table自定义表的名字。

数据表的默认名称为：

```
<app_name>_<model_name>
例：
booktest_bookinfo
```

**例：指定BookInfo模型类生成的数据表名为bookinfo。**

在BookInfo模型类中添加如下内容，代码如下：

```
#定义图书模型类BookInfo
class BookInfo(models.Model):
    ...

    #定义元选项
    class Meta:
      db_table='bookinfo' #指定BookInfo生成的数据表名为bookinfo
```