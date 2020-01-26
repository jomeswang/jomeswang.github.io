---
title: hexo博客提交百度和谷歌收录
top: false
comments: true
categories:
  - 建站
tags:
  - hexo
  - next
  - 博客收录
abbrlink: 13e5520f
date: 2020-01-19 23:34:26
---

一个网站的SEO对一个网站非常重要，[SEO](https://link.jianshu.com?t=https://baike.baidu.com/item/SEO/102990?fr=aladdin)指的是搜索引擎优化。通过搜索引擎优化，可以提高网站的网站关键词排名以及博客文章的曝光度。一般来说，我们针对百度和Google这两个搜索引擎进行优化，提高对网站资源的索引量，使我们的文章更容易被发现。虽然我的博客的主要读者是我自己，但也不妨碍我做些优化，对吧！接下来向大家展示如何使博客被百度和Google收录。

<!-- more -->

## 1.	站点地图

站点地图即[sitemap](https://link.jianshu.com?t=https://baike.baidu.com/item/sitemap/6241567?fr=aladdin)， 是一个页面，上面放置了网站上需要搜索引擎抓取的所有页面的链接。站点地图可以告诉搜索引擎网站上有哪些可供抓取的网页，以便搜索引擎可以更加智能地抓取网站。

### 1.1	生成站点地图

安装百度和Google的站点地图生成插件：

```undefined
npm install hexo-generator-baidu-sitemap --save
npm install hexo-generator-sitemap --save
```

### 1.2	修改配置文件

修改站点配置文件`_config.yml`，添加以下内容：

```css
# 自动生成sitemap
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```

### 1.3	生成和部署

执行生成和部署命令：

```undefined
hexo g
hexo d
```

此时，进入`public`目录，你会发现里面有`sitemap.xml`和`baidusitemap.xml`两个文件，这就是生成的站点地图。里面包含了网站上所有页面的链接，搜索引擎通过这两个文件来抓取网站页面。

> - sitemap.xml用来提交给Google
> - baidusitemap.xml用来提交给百度

## 2.	百度站长平台

通过百度站长平台进行链接提交，增加网站的索引量。我的这篇文章：[Hexo博客之速度优化](https://link.jianshu.com?t=http://fengdi.org/2017/08/07/Hexo博客之速度优化.html) 已经提到过Github对百度爬虫进行了屏蔽，因此百度爬取不到Github上的页面，如果你按照这篇文章同时部署到Coding上，那百度就可以抓取到，因为此时百度抓取的是位于Coding上的博客网页。

注册并登录百度站长平台：[百度站长平台](https://link.jianshu.com?t=http://zhanzhang.baidu.com/)

### 2.1	添加站点

选择添加站点：

![img](https:////upload-images.jianshu.io/upload_images/5635196-9bca3b38a6c1685d.png?imageMogr2/auto-orient/strip|imageView2/2/w/982/format/webp)

### 2.2	验证站点

进行站点验证：

![img](https:////upload-images.jianshu.io/upload_images/5635196-51233e024040d8d7.png?imageMogr2/auto-orient/strip|imageView2/2/w/982/format/webp)

这里我们选择`文件验证`，下载验证文件到本地，放置在`themes/next/source`目录下。执行生成和部署命令：

```undefined
hexo g
hexo d
```

点击完成验证即可。

### 2.3	链接提交

百度站长平台的链接提交方式分为自动提交和手动提交两种，此处只讲自动提交，手动提交按照要求操作即可。

#### 2.3.1	主动推送

主动推送最为快速的提交方式，是被百度收录最快的推送方式。主动推送可以通过安装插件实现：

```undefined
npm install hexo-baidu-url-submit --save
```

修改站点配置文件`_config.yml`，添加以下内容：

```bash
baidu_url_submit:
  count: 5 ## 提交最新的五个链接
  host: www.hui-wang.info ## 百度站长平台中注册的域名
  token: your_token ## 准入秘钥
  path: baidu_urls.txt ## 文本文档的地址， 新链接会保存在此文本文档里
```

其次，记得查看`_config.yml`文件中url的值， 必须包含是百度站长平台注册的域名， 比如:

```csharp
# URL
url: http://fengdi.org
root: /
permalink: :year/:month/:day/:title.xml
```

最后，加入新的deployer:

```bash
deploy:
- type: git ## 这是我原来的deployer
  repo:
  branch:
- type: baidu_url_submitter ## 添加这里内容即可
```

其主动推送的实现原理如下：

- 新链接的产生， `hexo generate` 会产生一个文本文件，里面包含最新的链接

- 新链接的提交， `hexo deploy` 会从上述文件中读取链接，提交至百度搜索引擎

  

  #### 2.3.2	自动推送

安装自动推送JS代码的网页，在页面被访问时，页面URL将立即被推送给百度。

修改主题目录下的`layout/post.swig`文件，末尾添加自动推送代码，代码如下：

```html
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';        
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
```

#### 2.3.3	sitemap提交

我们之前已经说过如何生成sitemap文件，这时就需要我们生成的sitemap文件了。

![img](https:////upload-images.jianshu.io/upload_images/5635196-cfb7e4bd12e2deb8.png?imageMogr2/auto-orient/strip|imageView2/2/w/981/format/webp)

输入以下内容到输入框里：

```cpp
http://fengdi.org/baidusitemap.xml
```

输入验证码后，提交即可。一般情况下，百度会在一个小时内处理该文件，并提取其中的url。

## 3.	Google网站站长

在提交Google之前，要解决一个大家都知道的问题，关于如何登录Google。这里就不再说了，相信你们有办法。

### 3.1	添加站点

登录[Google网站站长](https://link.jianshu.com?t=https://www.google.com/webmasters/#?modal_active=none)，进入`Search Console`，点击`添加属性`进行站点添加：

![img](https:////upload-images.jianshu.io/upload_images/5635196-9a7ce99e3aaaf1a9.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### 3.2	验证站点

同百度平台一样，下载Google验证文件，放到source下`themes/next/source`目录中：

![img](https:////upload-images.jianshu.io/upload_images/5635196-2a7e8f527d0b1b42.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

重新生成和部署：

```undefined
hexo g
hexo d
```

部署完成之后，进行验证即可。

### 3.3	添加站点地图

在`抓取`里面，点击`站点地图`，进行添加：

![img](https:////upload-images.jianshu.io/upload_images/5635196-7071aa22f10e2c28.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

## 4	总结

好了，到这里文章就结束了。如果你之前没有把网站部署到Coding上，你的网站百度是爬取不到的，关于如何部署请参阅：[Hexo博客之速度优化](https://link.jianshu.com?t=http://fengdi.org/2017/08/07/Hexo博客之速度优化.html)

剩下的就是好好写文章，文章的质量同样影响收录的奥，加油啦！

参考文章：[Hexo博客提交百度和Google收录]( https://www.jianshu.com/p/f8ec422ebd52 )