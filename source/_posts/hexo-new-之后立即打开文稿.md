---
title: hexo new 之后立即打开文稿
top: false
comments: false
categories:
  - hexo
tags:
  - hexo
abbrlink: 788e682d
date: 2020-01-28 13:38:20
---

## 一：开发者的解决方案

Hexo 的 GitHub 项目里，有人提出了类似的需求：

 [hexo开发者的解决方案](https://github.com/hexojs/hexo/issues/1007) 

Tommy 指出，可以在 Hexo 目录下的 scripts 目录（若没有，则新建一个blog/scripts）中创建一个 JavaScript （openNewFile）脚本，监听 hexo new 这个动作。并在检测到 hexo new 之后，执行编辑器打开的命令。

具体目录如下：

 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191008141004878.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3RpYW54aW50aWFuZGlzaGVuZw==,size_16,color_FFFFFF,t_70) 

 Tommy 给出的js代码如下： 

```js
var spawn = require('child_process').spawn;

// Hexo 2.x 版本号
hexo.on('new', function(path){
  spawn('vi', [path]);
});

// Hexo 3.x 版本号
hexo.on('new', function(data){
  spawn('vi', [data.path]);
});

```

 **vi替换为你的文本编辑器的绝对路径** 

## 二：编码实战

### 使用Typora打开新建的markdown文档

openNewFile.js中的代码

```
var spawn = require('child_process').spawn;
hexo.on('new', function(data){
    spawn('C:/Program Files/Typora/Typora.exe ', [data.path]);
});
```

 此时命令行执行新建文章的代码`hexo new "the title of your blog"`，系统使用我指定的文本编辑器Typora.exe打开了新建的 Markdown 文稿。 

[参考文章](https://blog.csdn.net/tianxintiandisheng/article/details/102381391)