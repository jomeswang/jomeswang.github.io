---
title: 博客运用Hexo-Next主题美化（中）
top: false
comments: true
categories: 建站
tags:
  - webinit
  - next
  - hexo
abbrlink: 604c19d3
date: 2020-01-02 19:08:57
---

​																								------转载链接见最下方

## 1，前言

​	大家是不是因为那个博客宠物才找到这篇博客的呢！！好，现在我为大家揭开谜底！为你们开启博客的精彩世界！

<!-- more -->

## 2，炫酷特效

### 			2.1，博客小宠物

​				效果如图：[![lNWCkT.md.png](https://s2.ax1x.com/2020/01/03/lNWCkT.md.png)](https://imgchr.com/i/lNWCkT)

​				1.输入如下命令获取  `live2d`  ：

```nginx
npm install --save hexo-helper-live2d  
```

​				2 输入以下命令，下载相应的模型，将  `packagename`  更换成模型名称即可，更多模型选择请[点击此处](https://github.com/xiazeyu/live2d-widget-models)，各个模型的预览请[访问原作者的博客](https://huaji8.top/post/live2d-plugin-2.0/) .

```yacas
npm install packagename
```

​				3.打开站点目录下的 `_config.yml` 文件，在最末尾添加如下代码：

```tcl
live2d:
    enable: true
    scriptFrom: local
    model: 
    use: live2d-widget-model-haruto #模型选择
    display: 
    position: right  #模型位置
    width: 150       #模型宽度
    height: 300      #模型高度
    mobile: 
    show: false      #是否在手机端显示
    react:
    opacity: 0.7       #设置透明度
```

### 2.2，点击爱心效果

1. 在 `themes\hexo-theme-spfk\source\js` 下新建文件 `love.js`，在 `love.js` 文件中添加以下代码： 

   打开（[点此](https://github.com/jomeswang/mid.git)）获取其中`love.js`中的代码

2. ​	在 `themes\hexo-theme-spfk\layout\layout.ejs` 文件末尾添加以下代码： 

   ```js
   <!-- 页面点击小红心 -->
   <script type="text/javascript" src="/js/love.js"></script>
   ```

   3.完成以上操作后，当我们点击鼠标的时候就可以看见爱心的特效了 

### 2.3，点击烟花

  1. 在 `\themes\material-x\source\js` 目录下新建一个 `fireworks.js` 的文件，里面写入以下代码： 

     

  2. 然后在 `\themes\material-x\layout\layout.ejs` 文件中写入以下代码： 

     ```js
     <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas> 
     <script type="text/javascript" src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script> 
     <script type="text/javascript" src="/js/fireworks.js"></script>
     ```

### 2.4， 添加鼠标点击显示字体效果

  1. 在 `themes/hexo-theme-spfk/source/js` 下新建文件 `click_show_text.js`，在 `click_show_text.js` 文件中添加以下代码： 

     ​			打开（[点此](https://github.com/jomeswang/mid.git)）获取其中 `click_show_text.js` 中的代码

​	2.其中的社会主义核心价值观可以根据你自己的创意替换为其他文字

如果想要每次点击显示的文字为不同颜色，可以将其中 `color` 值进行如下更改：

```js
"color": "rgb(" + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + ")"
```

3. 然后在 `themes\hexo-theme-spfk\layout\layout.ejs` 文件末尾添加以下代码： 

   ```js
   <!--单击显示文字-->
   <script type="text/javascript" src="/js/click_show_text.js"></script>
   ```

   [![ltLxfI.md.png](https://s2.ax1x.com/2020/01/02/ltLxfI.md.png)](https://imgchr.com/i/ltLxfI)

### 2.5，添加彩色滚动变换字体

​			打开（[点此](https://github.com/jomeswang/mid.git)）获取其中 **添加彩色滚动变换字体.js** 中的代码，将其复制到自己想要有字的地方。[点击此处查看](https://blog.csdn.net/weixin_34194087/article/details/94545902)next主题的目录框架。

### 2.6，浏览器网页标题恶搞

​			**当**用户访问你的博客时点击到了其他网页，我们可以恶搞一下网页标题，呼唤用户回来，首先在目录 `themes\material-x\source\js` 下新建一个 `FunnyTitle.js` 文件，在里面填写如下代码： 

```js
// 浏览器搞笑标题
var OriginTitle = document.title;
var titleTime;
document.addEventListener('visibilitychange', function () {
    if (document.hidden) {
        $('[rel="icon"]').attr('href', "/funny.ico");
        document.title = '╭(°A°`)╮ 页面崩溃啦 ~';
        clearTimeout(titleTime);
    }
    else {
        $('[rel="icon"]').attr('href', "/favicon.ico");
        document.title = '(ฅ>ω<*ฅ) 噫又好啦 ~' + OriginTitle;
        titleTime = setTimeout(function () {
            document.title = OriginTitle;
        }, 2000);
    }
});

```

 其中 `funny.ico` 是用户切换到其他标签后你网站的图标，`favicon.ico` 是正常图标，然后在 `themes\material-x\layout\layout.ejs` 文件中添加如下代码： 

```js
<!--浏览器搞笑标题-->
<script type="text/javascript" src="/js/FunnyTitle.js"></script>
```

## 3，背景和网页图标和动画

### 	3.1，自动更换背景图片

​			修改 `themes\next\source\css\ _custom\custom.styl` 文件，添加以下代码：

```css
body {
    background:url(https://source.unsplash.com/random/1600x900);
    background-repeat: no-repeat;
    background-attachment:fixed;
    background-position:50% 50%;
}
```

> 如果不喜欢这个网址提供的图片做背景，可以修改`url()`里面的路径。`repeat`、`attachment`、`position`就是调整图片的位置、不重复出现、不滚动等等。

### 3.2，静态背景

​	打开博客根目录 `/themes/next/source/css/_custom/custom.styl` 文件，编辑如下：

```css
// Custom styles.
body { 
    background-image: url(/images/background.png);
    background-attachment: fixed; // 不随屏幕滚动而滚动
    background-repeat: repeat; // 如果背景图不够屏幕大小则重复铺，改为no-repeat则表示不重复铺
    background-size: contain; // 等比例铺满屏幕
}
```

然后将背景图命名为 `background.png` 并放入主题根目录 `source/images` 下。

### 3.3，更换网页图标

在 [EasyIcon](http://www.easyicon.net/) 中找一张（32*32）的 `ico` 图标，或者去别的网站下载或者制作，并将图标名称改为`favicon.ico`，然后把图标放在 `/themes/next/source/images` 里，并且修改主题配置文件：

```css
# Put your favicon.ico into `hexo-site/source/` directory.
favicon: /favicon.ico
```

### 3.4，hexo载入动画效果

​		设置方法：
编辑`themes/netx/_config.yml`找到`motion`,将`enable`的值，改成`true`

```tcl
# Use velocity to animate everything.
motion:  
	enable: true  
	async: false  
	transition:    
	# Transition variants:    
	# fadeIn | fadeOut | flipXIn | flipXOut | flipYIn | flipYOut | flipBounceXIn | flipBounceXOut | flipBounceYIn | flipBounceYOut    
	# swoopIn | swoopOut | whirlIn | whirlOut | shrinkIn | shrinkOut | expandIn | expandOut    
	# bounceIn | bounceOut | bounceUpIn | bounceUpOut | bounceDownIn | bounceDownOut | bounceLeftIn | bounceLeftOut | bounceRightIn | bounceRightOut    
	# slideUpIn | slideUpOut | slideDownIn | slideDownOut | slideLeftIn | slideLeftOut | slideRightIn | slideRightOut    
	# slideUpBigIn | slideUpBigOut | slideDownBigIn | slideDownBigOut | slideLeftBigIn | slideLeftBigOut | slideRightBigIn | slideRightBigOut   
    # perspectiveUpIn | perspectiveUpOut | perspectiveDownIn | perspectiveDownOut | perspectiveLeftIn | perspectiveLeftOut | perspectiveRightIn | perspectiveRightOut    
    post_block: fadeIn #主页载入效果    
    post_header: bounceRightIn #文章标题载入效果    
    post_body: slideDownIn    
    coll_header: bounceLeftIn    
    # Only for Pisces | Gemini.    
    sidebar: bounceLeftIn #侧边栏载入效果
```

`#`号里都是载入效果，有时间可以自己多试一试！

详情请[点击查看](http://itwalking.top/page/a92117.html)动画效果

## 4，文章内部优化

### 	4.1，修改``代码块自定义样式

​			效果：![lNJci8.png](https://s2.ax1x.com/2020/01/02/lNJci8.png)

设置方法：
打开`themes/next/source/css/_custom/custom.styl`,向里面加入：(颜色可以自己定义)

```css
// Custom styles
code {    
    color: #ff7600;    
    background: #fbf7f8;    
    margin: 2px;
}
// 大代码块的自定义样式
.highlight, pre {    
    margin: 5px 0;   
    padding: 5px;    
    border-radius: 3px;
}
.highlight, code, pre {    
    border: 1px solid #d6d6d6;
}
```

### 4.2，修改文章内链接文本样式

​		效果：[![lNYpo6.md.png](https://s2.ax1x.com/2020/01/02/lNYpo6.md.png)](https://imgchr.com/i/lNYpo6)

设置方法：
修改文件`themes/next/source/css/_common/components/post/post.styl`，在末尾添加如下`css`样式，：

```css
// 文章内链接文本样式
.post-body p a{  
    color: #0593d3;  
    border-bottom: none;  
    border-bottom: 1px solid #0593d3;  
    &:hover {    
        color: #fc6423;    
        border-bottom: none;   
        border-bottom: 1px solid #fc6423;  
    }
}
```

其中选择`.post-body`是为了不影响标题，选择`p`是为了不影响首页“阅读全文”的显示样式,颜色可以自己定义。

### 4.3，主页文章添加阴影效果

效果：

![lNtT8U.png](https://s2.ax1x.com/2020/01/02/lNtT8U.png)

​		设置方法：
打开`themes/next/source/css/_custom/custom.styl`,在里面加入：

```css
// 主页文章添加阴影效果 
.post {   
    margin-top: 0px;   
    margin-bottom: 0px;   
    padding: 0px;   
    -webkit-box-shadow: 0 0 5px rgba(202, 203, 203, .5);   
    -moz-box-shadow: 0 0 5px rgba(202, 203, 204, .5);  
}
```

### 4.4，文章置顶

​		效果：[![lNU86e.md.png](https://s2.ax1x.com/2020/01/02/lNU86e.md.png)](https://imgchr.com/i/lNU86e)

设置方法：
首先安装插件：

```css
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-pin-top --save
```

然后在需要置顶的文章的`Front-matter`中加上`top: true`即可。

### 4.5，结尾添加“本文结束”标记

​		设置方法：
在路径`themes/next/layout/_macro`中新建`passage-end-tag.swig`文件,并添加以下内容：

```html
<div>    
	{% if not is_index %}        
        <div style="text-align:center;color: #ccc;font-size:14px;">            
        -------------本文结束           
        <i class="fa fa-paw"></i>           
        感谢您的阅读-------------        
        </div>   
        {% endif %}
</div>
```

接着打开`themes/next/layout/_macro/post.swig`文件，在`post-body`之后，`post-footer`之前添加如下代码,(大概在350行左右的位置)：

```vue
<div>  
    {% if not is_index %}    
    	{% include 'passage-end-tag.swig' %}  
    {% endif %}
</div>
```

然后打开主题配置文件`_config.yml`,在末尾添加：

```css
# 文章末尾添加“本文结束”标记
passage_end_tag:  
	enabled: true
```

### 4.6，修改结尾#标签

​	设置效果：

​			[![lNdtit.md.png](https://s2.ax1x.com/2020/01/02/lNdtit.md.png)](https://imgchr.com/i/lNdtit)

​		设置方法：
修改模板`themes/next/layout/_macro/post.swig`搜索`rel=”tag”`，将后面的`#`换成

```html
<i class="fa fa-tag"></i>
```

### 4.7，优化选择的文字样式

​	效果：[![lNdzeH.md.png](https://s2.ax1x.com/2020/01/02/lNdzeH.md.png)](https://imgchr.com/i/lNdzeH)

​		设置方法：
打开`themes\next\source\css\_custom\custom.styl`文件，将下面的代码添加进去。

```css
::selection {      
    background-color: rgb(255, 241, 89);       
    color: #555;
}
```

## 5，一些便利的小工具

### 	5.1，增加阅读百分比并回到顶处

- 打开 `themes/next/_config.yml` ,搜索关键字 `scrollpercent` ,把 `false` 改为 `true` ，如下：

```css
# Scroll percent label in b2t button  
	scrollpercent: true
```

- 如果想把 top 按钮放在侧边栏,打开 `themes/next/_config.yml` ,搜索关键字 `b2t` ,把 `false` 改为 `true` ，如下：

```css
# Back to top in sidebar  
	b2t: true   
# Scroll percent label in b2t button  
	scrollpercent: true
```

### 		5.2，站内搜索

​				设置方法：
​		安装`hexo-generator-searchdb`插件

```css
npm install hexo-generator-searchdb --save
```



编辑`_config.yml`站点配置文件，新增以下内容到任意位置：

```css
search:  
	path: search.xml  
	field: post  format: html  
	limit: 10000
```



编辑`themes/next/_config.yml` 主题配置文件，启用本地搜索功能,将`local_search:`下面的`enable:`的值，改成`true`

```css
# Local search
local_search:  
		enable: true
```

### 5.3，md模板设置

​		你是在站点文件夹根目录用`hexo new `新建的文章，那么其实它就是将文章的模版文件		`~/scaffolds/post.md`复制了一份到`~/blog/source/_posts/`下，所以这也意味着：

​		你可以直接通过在`~/blog/source/_posts/`下新建`.md`结尾的文件来写新的文章。
​		你可以通过自定义文章的模版文件，从而每次命令行新建的文章都会有你自定义的内容。
​		下面是我的`post.md`内容

```yaml
title: {{ title }}
date: {{ date }}
categories:
/* 分类，支持多级，比如：
- technology
- computer
*/
tags:
/* 标签** 多个可以这样写
- 标签1
- 标签2*/
comments:
/* 是否开启评论** 默认值是 true** 要关闭写 false*/
top: true
/* 文章置顶** true就是开启，flase就是关闭置顶。*/
password:
/* 文章密码，参考本文"1.20.文章加密访问"** 需配置好，否则请勿添加！*/
```

### 5.4，隐藏网页底部 powered By Hexo / 强力驱动

​		设置方法：

​		打开`themes/next/layout/_partials/footer.swig`，使用隐藏符号之间的代码即可，约24-43行或者直接将这段代码删除。 

[![lNsUWn.md.png](https://s2.ax1x.com/2020/01/02/lNsUWn.md.png)](https://imgchr.com/i/lNsUWn)

### 			5.5，设置分页显示

​			设置方法

​			打开`_config.yml`主站配置文件,找到`index_generator:`,设置成如下代码:

```yml
index_generator:  
	path: ''  
	per_page: 6  
	order_by: -date
archive_generator:  
	per_page: 20  
	yearly: true  
	monthly: true
tag_generator:  
	per_page: 10
```

​		说明:`index_generator:`是设置主页显示多少篇文章开始分页,`archive_generator:`是设置归档主页显示多少篇文章开始分页,`tag_generator:`是指底分页条显示多少个分页的链接.

### 			5.6，文章加密访问

​				效果：[![lNsj6P.md.gif](https://s2.ax1x.com/2020/01/02/lNsj6P.md.gif)](https://imgchr.com/i/lNsj6P)

​				 设置方法：

​	打开`themes/next/layout/_partials/head.swig`文件。在

`  <meta name="theme-color" content="{{ theme.android_chrome_color }}">  `下面插入代码： 

```js
<script>
    (function () {
        if ('{{ page.password }}') {
            if (prompt('请输入文章密码') !== '{{ page.password }}') {
                alert('密码错误！');
                if (history.length === 1) {
                    location.replace("http://xxxxxxx.xxx"); // 这里替换成你的首页
                } else {
                    history.back();
                }
            }
        }
    })();
</script>
```

### 5.7，Fork me on the  Github

​		点击[这里](https://github.blog/2008-12-19-github-ribbons/)或[这里](http://tholman.com/github-corners/)挑选自己喜欢的样式，并复制代码然后粘贴刚才复制的代码到`themes/next/layout/_layout.swig`文件中

​		(放在`  <div class="headband"></div>  `的下面)，并把`href`改为你的`github`地址 。

## 6，相关链接

### 6，1：优化全：

1，

 [https://zealot.top/Hexo-Github%E6%90%AD%E5%BB%BA%E8%87%AA%E5%B7%B1%E7%9A%84%E5%8D%9A%E5%AE%A22.html#more](https://zealot.top/Hexo-Github搭建自己的博客2.html#more) 

2， https://www.cnblogs.com/zhangxiaochn/p/Hexo_Theme_Next.html

### 6，2：基础

​	1， https://www.jianshu.com/p/b20fc983005f 	

​	2， https://www.cnblogs.com/zhangxiaochn/p/Hexo_Theme_Next.html 

### 6，3：其他

​	1，博客人物： https://itrhx.blog.csdn.net/article/details/85420403 

​	2，fork me on the github: https://blog.csdn.net/fly_wt/article/details/86674138 

​	3，Hexo博客NexT主题美化之显示当前浏览进度: https://blog.csdn.net/weixin_34342905/article/details/88218109 	

​	4，更换网站图标： https://blog.csdn.net/Olivia_Vang/article/details/92976637 