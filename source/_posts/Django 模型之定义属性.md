---
title: Django  模型之定义属性
top: false
comments: true
categories:
  - python
tags:
  - python
  - django
abbrlink: 8427434f
date: 2020-03-11 19:56:24
---
Django 模型之定义属性

Django根据属性的类型确定以下信息：

- 当前选择的数据库支持字段的类型

- 渲染管理表单时使用的默认html控件

- 在管理站点最低限度的验证

  <!-- more -->

django会为表创建自动增长的主键列，每个模型只能有一个主键列，如果使用选项设置某属性为主键列后django不会再创建自动增长的主键列。

默认创建的主键列属性为id，可以使用pk代替，pk全拼为primary key。

> 注意：pk是主键的别名，若主键名为id2，那么pk是id2的别名。

属性命名限制：

- 不能是python的保留关键字。
- 不允许使用连续的下划线，这是由django的查询方式决定的，在第4节会详细讲解查询。
- 定义属性时需要指定字段类型，通过字段类型的参数指定选项，语法如下：

```
属性=models.字段类型(选项)
```

#### 字段类型

使用时需要引入django.db.models包，字段类型如下：

- AutoField：自动增长的IntegerField，通常不用指定，不指定时Django会自动创建属性名为id的自动增长属性。
- BooleanField：布尔字段，值为True或False。
- NullBooleanField：支持Null、True、False三种值。
- CharField(max_length=字符长度)：字符串。
  - 参数max_length表示最大字符个数。
- TextField：大文本字段，一般超过4000个字符时使用。
- IntegerField：整数。
- DecimalField(max_digits=None, decimal_places=None)：十进制浮点数。
  - 参数max_digits表示总位数。
  - 参数decimal_places表示小数位数。
- FloatField：浮点数。
- DateField[auto_now=False, auto_now_add=False])：日期。
  - 参数auto_now表示每次保存对象时，自动设置该字段为当前时间，用于"最后一次修改"的时间戳，它总是使用当前日期，默认为false。
  - 参数auto_now_add表示当对象第一次被创建时自动设置当前时间，用于创建的时间戳，它总是使用当前日期，默认为false。
  - 参数auto_now_add和auto_now是相互排斥的，组合将会发生错误。
- TimeField：时间，参数同DateField。
- DateTimeField：日期时间，参数同DateField。
- FileField：上传文件字段。
- ImageField：继承于FileField，对上传的内容进行校验，确保是有效的图片。

#### 选项

通过选项实现对字段的约束，选项如下：

- null：如果为True，表示允许为空，默认值是False。
- blank：如果为True，则该字段允许为空白，默认值是False。
- **对比：null是数据库范畴的概念，blank是表单验证范畴的**。
- db_column：字段的名称，如果未指定，则使用属性的名称。
- db_index：若值为True, 则在表中会为此字段创建索引，默认值是False。
- default：默认值。
- primary_key：若为True，则该字段会成为模型的主键字段，默认值是False，一般作为AutoField的选项使用。
- unique：如果为True, 这个字段在表中必须有唯一值，默认值是False。

#### 综合演示

修改booktest/models.py中的模型类，代码如下：

```
from django.db import models

#定义图书模型类BookInfo
class BookInfo(models.Model):
    #btitle = models.CharField(max_length=20)#图书名称
    btitle = models.CharField（max_length=20, db_column='title')#通过db_column指定btitle对应表格中字段的名字为title
    bpub_date = models.DateField()#发布日期
    bread = models.IntegerField(default=0)#阅读量
    bcomment = models.IntegerField(default=0)#评论量
    isDelete = models.BooleanField(default=False)#逻辑删除

#定义英雄模型类HeroInfo
class HeroInfo(models.Model):
    hname = models.CharField(max_length=20)#英雄姓名
    hgender = models.BooleanField(default=True)#英雄性别
    isDelete = models.BooleanField(default=False)#逻辑删除
    #hcomment = models.CharField(max_length=200)#英雄描述信息
    hcomment = models.CharField(max_length=200, null=True, blank=False) #hcomment对应的数据库中的字段可以为空，但通过后台管理页面添加英雄信息时hcomment对应的输入框不能为空
    hbook = models.ForeignKey('BookInfo')#英雄与图书表的关系为一对多，所以属性定义在英雄模型类中
```

然后生成迁移文件并执行迁移命令，最后查看test2数据库中的内容。