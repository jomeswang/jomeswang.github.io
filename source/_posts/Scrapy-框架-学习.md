---
title: Scrapy 框架 学习
top: false
comments: true
categories:
  - 爬虫
tags:
  - Scrapy
abbrlink: 99bbd8d6
date: 2020-07-13 20:38:43
---

> Scrapy是用纯Python实现一个为了爬取网站数据、提取结构性数据而编写的应用框架，用途非常广泛。

<!--more-->

![](http://photo.jomeswang.top/20200713205713.png)

- `Scrapy Engine(引擎)`: 负责`Spider`、`ItemPipeline`、`Downloader`、`Scheduler`中间的通讯，信号、数据传递等。
- `Scheduler(调度器)`: 它负责接受`引擎`发送过来的Request请求，并按照一定的方式进行整理排列，入队，当`引擎`需要时，交还给`引擎`。
- `Downloader（下载器）`：负责下载`Scrapy Engine(引擎)`发送的所有Requests请求，并将其获取到的Responses交还给`Scrapy Engine(引擎)`，由`引擎`交给`Spider`来处理，
- `Spider（爬虫）`：它负责处理所有Responses,从中分析提取数据，获取Item字段需要的数据，并将需要跟进的URL提交给`引擎`，再次进入`Scheduler(调度器)`，
- `Item Pipeline(管道)`：它负责处理`Spider`中获取到的Item，并进行进行后期处理（详细分析、过滤、存储等）的地方.
- `Downloader Middlewares（下载中间件）`：你可以当作是一个可以自定义扩展下载功能的组件。
- `Spider Middlewares（Spider中间件）`：你可以理解为是一个可以自定扩展和操作`引擎`和`Spider`中间`通信`的功能组件（比如进入`Spider`的Responses;和从`Spider`出去的Requests）

## 一：爬虫步骤

制作 Scrapy 爬虫 一共需要4步：

- 新建项目 (scrapy startproject xxx)：新建一个新的爬虫项目
- 明确目标 （编写items.py）：明确你想要抓取的目标
- 制作爬虫 （spiders/xxspider.py）：制作爬虫开始爬取网页
- 存储内容 （pipelines.py）：设计管道存储爬取内容

1. scrapy startproject test

2. scrapy genspider 爬虫名 爬虫域名

   ![](http://photo.jomeswang.top/20200714133339.png)



## 二：Scrapy项目基本流程

### 2.1 默认的Scrapy项目结构

使用全局命令startproject创建项目，在project_name文件夹下创建一个名为project_name的Scrapy项目。

> scrapy startproject myproject

虽然可以被修改，但所有的Scrapy项目默认有类似于下边的文件结构:



```undefined
scrapy.cfg
myproject/
    __init__.py
    items.py
    pipelines.py
    settings.py
    spiders/
        __init__.py
        spider1.py
        spider2.py
        ...
```

scrapy.cfg 存放的目录被认为是 项目的根目录 。该文件中包含python模块名的字段定义了项目的设置。

### 2.2  定义要抓取的数据

Item 是保存爬取到的数据的容器；其使用方法和python字典类似， 并且提供了额外保护机制来避免拼写错误导致的未定义字段错误。
 类似在ORM中做的一样，您可以通过创建一个 scrapy.Item 类， 并且定义类型为 scrapy.Field 的类属性来定义一个Item。
 首先根据需要从dmoz.org（DMOZ网站是一个著名的开放式分类目录（Open DirectoryProject），由来自世界各地的志愿者共同维护与建设的最大的全球目录社区）获取到的数据对item进行建模。 我们需要从dmoz中获取名字，url，以及网站的描述。 对此，在item中定义相应的字段。编辑items.py 文件:



```python
import scrapy

class DmozItem(scrapy.Item):
    title = scrapy.Field()
    link = scrapy.Field()
    desc = scrapy.Field()
```

### 2.3  使用项目命令genspider创建Spider

> scrapy genspider [-t template] <name> <domain>

在当前项目中创建spider。
 这仅仅是创建spider的一种快捷方法。该方法可以使用提前定义好的模板来生成spider。您也可以自己创建spider的源码文件。



```python
$ scrapy genspider -l
Available templates:
  basic
  crawl
  csvfeed
  xmlfeed

$ scrapy genspider -d basic
import scrapy

class $classname(scrapy.Spider):
    name = "$name"
    allowed_domains = ["$domain"]
    start_urls = (
        'http://www.$domain/',
        )

    def parse(self, response):
        pass

$ scrapy genspider -t basic example example.com
Created spider 'example' using template 'basic' in module:
  mybot.spiders.example
```

### 2.4  编写提取item数据的Spider

Spider是用户编写用于从单个网站(或者一些网站)爬取数据的类。
 其包含了一个用于下载的初始URL，如何跟进网页中的链接以及如何分析页面中的内容， 提取生成 item 的方法。
 为了创建一个Spider，您必须继承 scrapy.Spider 类，且定义以下三个属性:

> - name: 用于区别Spider。 该名字必须是唯一的，您不可以为不同的Spider设定相同的名字。
> - start_urls: 包含了Spider在启动时进行爬取的url列表。 因此，第一个被获取到的页面将是其中之一。 后续的URL则从初始的URL获取到的数据中提取。
> - parse() 是spider的一个方法。 被调用时，每个初始URL完成下载后生成的 Response 对象将会作为唯一的参数传递给该函数。 该方法负责解析返回的数据(response data)，提取数据(生成item)以及生成需要进一步处理的URL的 Request 对象。



```python
import scrapy

class DmozSpider(scrapy.spider.Spider):
    name = "dmoz"   #唯一标识，启动spider时即指定该名称
    allowed_domains = ["dmoz.org"]
    start_urls = [
        "http://www.dmoz.org/Computers/Programming/Languages/Python/Books/",
        "http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/"
    ]

    def parse(self, response):
        filename = response.url.split("/")[-2]
        with open(filename, 'wb') as f:
            f.write(response.body)
```

### 2.5  进行爬取

执行项目命令crawl，启动Spider：

> scrapy crawl dmoz

在这个过程中：
 **Scrapy为Spider的 start_urls 属性中的每个URL创建了 scrapy.Request 对象，并将 parse 方法作为回调函数(callback)赋值给了Request。**
 **Request对象经过调度，执行生成 scrapy.http.Response 对象并送回给spider parse() 方法。**

### 2.6  通过选择器提取数据

**Selectors选择器简介：**
 Scrapy提取数据有自己的一套机制。它们被称作选择器(seletors)，因为他们通过特定的 XPath 或者 CSS 表达式来“选择” HTML文件中的某个部分。
 XPath 是一门用来在XML文件中选择节点的语言，也可以用在HTML上。 CSS 是一门将HTML文档样式化的语言。选择器由它定义，并与特定的HTML元素的样式相关连。

**XPath表达式的例子和含义：**

> - /html/head/title: 选择HTML文档中 <head> 标签内的 <title> 元素
> - /html/head/title/text(): 选择上面提到的 <title> 元素的文字
> - //td: 选择所有的 <td> 元素
> - //div[@class="mine"]: 选择所有具有 class="mine" 属性的 div 元素

**提取数据：**
 观察HTML源码并确定合适的XPath表达式。
 在查看了网页的源码后，您会发现网站的信息是被包含在 第二个 <ul> 元素中。
 我们可以通过这段代码选择该页面中网站列表里所有 <li> 元素:
 response.xpath('//ul/li')

Item 对象是自定义的python字典。 您可以使用标准的字典语法来获取到其每个字段的值。
 一般来说，Spider将会将爬取到的数据以 Item 对象返回。所以为了将爬取的数据返回，我们最终的代码将是:



```python
import scrapy

from tutorial.items import DmozItem

class DmozSpider(scrapy.Spider):
    name = "dmoz"
    allowed_domains = ["dmoz.org"]
    start_urls = [
        "http://www.dmoz.org/Computers/Programming/Languages/Python/Books/",
        "http://www.dmoz.org/Computers/Programming/Languages/Python/Resources/"
    ]

    def parse(self, response):
        for sel in response.xpath('//ul/li'):
            item = DmozItem()
            item['title'] = sel.xpath('a/text()').extract()
            item['link'] = sel.xpath('a/@href').extract()
            item['desc'] = sel.xpath('text()').extract()
            yield item
```

现在对dmoz.org进行爬取将会产生 DmozItem 对象。

