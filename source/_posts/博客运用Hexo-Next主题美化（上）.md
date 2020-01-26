---
title: 博客运用Hexo-Next主题美化（上）
top: false
comments: true
categories: 建站
tags:
  - webinit
  - hexo
  - next
abbrlink: 5da98e54
date: 2020-01-02 16:32:04
---

​																										--此篇文章有转载，转载url放在最后方

## 1、前言

上篇文章已经在Windows上将个人博客个搭建好了(如果还不知道怎么搭建的，[可以戳这里](https://jomeswang.github.io/2020/01/02/博客运用Hexo-Next主题美化（上）/)，可是大家有没有发现，搭建的Hexo博客使用的是默认主题，而且不咋好看，跟那些大神们的个人博客相比，还差了很多，不过不要紧，看完这篇文章，你也可以拥有那些炫酷吊炸天的效果。废话少说，那就直接开始吧。

<!-- more -->

## 2、设置主题

Hexo给我们提供了很多的主题供我们选择，你可以在[更多主题](https://link.jianshu.com?t=https://hexo.io/themes/)里选择一款你喜欢的，我选来选去选了一个比较经典的**Next**主题，你想看下效果的话可以[戳这里](https://link.jianshu.com?t=http://hydcoder.github.io)。下面就已设置Next主题为例来看看怎么安装和设置主题。

### 2.1、安装主题

首先你需要打开你上次生成的Hexo目录，然后右键**打开Git Bash here**,输入：



```ruby
$ git clone https://github.com/iissnan/hexo-theme-next themes/next
```

> 如果你选择的是别的主题的话，只需要把URL换一下，和themes/next换成themes/你的主题名称 (themes/next是安装目录，themes/next代表安装在你的Hexo目录下的themes目录下的next文件夹下)

### 2.2、设置主题

这样就安装完了，不过不要以为这样就可以了哦，我们还需要启用Next主题，所以需要到**站点配置文件**里去设置一把，找到 theme 字段，并将其值更改为 next。



```ruby
theme: next
```

> 说明：在 Hexo 中有两份主要的配置文件，其名称都是 _config.yml。 其中，一份位于站点根目录下，主要包含 Hexo 本身的配置；另一份位于主题目录下，这份配置由主题作者提供，主要用于配置主题相关的选项。为了描述方便，所以一般在描述的时候，将前者称为 站点配置文件， 后者称为 主题配置文件。

### 2.3、验证主题

设置完了，没有看到效果总是不放心对不对，那就先在本地预览一下吧。
 先输入



```undefined
hexo clean
```

清除下 Hexo 的缓存。然后再输入



```undefined
hexo g && hexo s
```

接着你就可以打开[http://localhost:4000/](https://link.jianshu.com?t=http://localhost:4000/)验证效果了。是不是已经有效果了？

到此为止，你已经成功安装并启用了 NexT 主题。

## 3、修改Hexo 站点配置文件

我们找到上次生成的Hexo目录，找到站点配置文件_config.yml，可以用vscode打开(上次部署到Github上的时候，已经改过这个文件的，还记得吗？)。



```bash
# Hexo Configuration
## Docs: https://hexo.io/docs/configuration.html
## Source: https://github.com/hexojs/hexo/
# Site 网站
title: hydcoder's blog   #网站标题
subtitle: 爱好游戏的码农   #网站副标题
description: 以梦为马，明日天涯。。。  #网站描述
author: hydcoder   #博主的名字
language: zh-Hans  #网站使用的语言
timezone:      #网站时区。Hexo 默认使用您电脑的时区

# 侧边栏头像设置(可以放到图床上引用哦)
avatar: http://q1.qlogo.cn/g?b=qq&nk=493654134&s=5
```

先对网站的一些设置进行设置，至于其他的设置，等说到再贴。(因为整个文件确实有点长。。。)

## 4、Hexo 主题配置文件

其实这个文件的配置才是重点，因为你们想要的吊炸天的效果差不多都与这个文件有关。
 打开**Hexo目录/themes/next/_config.yml**文件,

### 4.1、开启侧边栏社交链接



```csharp
# Social links
social:
  GitHub: https://github.com/hydcoder
  Weibo: https://weibo.com/3180967953/profile?rightmod=1&wvr=6&mod=personinfo
  # 等等

social_icons:
  enable: true
  # Icon Mappings.
  GitHub: github
  Weibo: weibo
```

反正我就只设置了这两个，你们有多少可以设置多少哈。。。

### 4.2、开启打赏功能



```undefined
reward_comment: 坚持原创技术分享，您的支持将鼓励我继续创作！
wechatpay: 你的微信收款码链接
alipay: 你的支付宝收款码链接
```

### 4.3、开启友情链接



```cpp
links_title: Links
links:
  MacTalk: http://macshuo.com/
  Title: http://example.com/
```

### 4.4、开启订阅微信公众号



```jsx
wechat_subscriber:
enabled: true
qcode: /uploads/wechat-qcode.jpg
description: 欢迎您扫一扫上面的微信公众号，订阅我的博客！
```

### 4.5、选择 Scheme



```bash
# Schemes
#scheme: Muse
#scheme: Mist
scheme: Pisces
#scheme: Gemini
```

更多请参考[next主题文档](https://link.jianshu.com?t=http://theme-next.iissnan.com/theme-settings.html)

## 5、设置侧边栏设置圆形可旋转头像

找到**生成的Hexo目录\themes\next\source\css_common\components\sidebar下的sidebar-author.styl**，将里面的css样式内容全部替换为：



```css
.site-author-image {
  margin: 0 auto;
  padding: $site-author-image-padding;
  max-width: $site-author-image-width;
  height: $site-author-image-height;
  border: $site-author-image-border-width solid $site-author-image-border-color;

  border-radius: 50%;
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  transition: 1.4s all;
}

.site-author-image:hover {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -transform: rotate(360deg);
}

.site-author-name {
  margin: $site-author-name-margin;
  text-align: $site-author-name-align;
  color: $site-author-name-color;
  font-weight: $site-author-name-weight;
}

.site-description {
  margin-top: $site-description-margin-top;
  text-align: $site-description-align;
  font-size: $site-description-font-size;
  color: $site-description-color;
}
```

## 6、设置首页不显示全文(只显示预览)和设置语言

### 6.1、首页不显示全文

​	打开**主题配置文件**_config.yml，ctrl + F搜索找到"auto_excerpt"，可以看见

```xml
# Automatically Excerpt. Not recommand.
# Please use <!-- more --> in the post to control excerpt accurately.
auto_excerpt:
enable: false
length: 150
```

把enable改为对应的false改为true，length就是预览显示的文字长度，你可以根据你的需要进行更改，然后重新部署(hexo clean && hexo g && hexo s)，再进主页，你就发现你首页的文章多了一个**阅读全文**的按钮。

### 6.2、设置语言

​		打开站点配置文件，搜索 `language`，找到如下代码：

```php+HTML
Copyauthor:
language:
timezone:
```

在 `language` 后面输入 `zh-CN`。

注意：冒号后面必须有一个空格。

## 7、添加动态背景

先上张图

![img](https://s2.ax1x.com/2020/01/02/lt3FO0.gif)

网站动态背景(非常占Cpu不是特别推荐)

记得第一次在别人的博客里看到这个动态背景的时候觉得好好玩，当时觉得自己可以玩一天，哈哈。。。现在你只需要稍微设置一下，你的博客也能马上拥有这个效果咯。

打开**生成的Hexo目录\themes\next/layout/_layout.swig文件**，
 在 < /body>上面添加代码(注意不要放在< /head>的后面)



```xml
{% if theme.canvas_nest %}
<script type="text/javascript" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>
{% endif %}
```

打开主题配置文件（在theme-next里面的那个_config.yml），在里面找到并修改如下代码：(可以放在最后面)



```bash
# --------------------------------------------------------------
# background settings
# --------------------------------------------------------------
# add canvas-nest effect
# see detail from https://github.com/hustcc/canvas-nest.js
canvas_nest: true
```

就这么简单，再运行 hexo clean，然后运行 hexo g,然后运行 hexo s，最后打开浏览器在浏览器的地址栏输入 localhost:4000 就能看到效果了。是不是很好玩。。。

什么？线条太多了？没事，来看看怎么让线条变少点

在上一步修改的主题配置文件中，把刚才的那些代码改成下面这样：



```xml
{% if theme.canvas_nest %}
<script type="text/javascript"
color="0,0,255" opacity='0.7' zIndex="-2" count="99" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>
{% e
```

怎么样，是不是少了很多了？没事，你开心就好(*▽*)

> 配置项说明
>  color ：线条颜色, 默认: '0,0,0'；三个数字分别为(R,G,B)
>  opacity: 线条透明度（0~1）, 默认: 0.5
>  count: 线条的总数量, 默认: 150
>  zIndex: 背景的z-index属性，css属性用于控制所在层的位置, 默认: -1

## 8、分类和标签设置

这里主要说的是在编写文章的时候，怎么给文章设置标签和分类。

首先通过**hexo n "name"**命令来新建一个页面，在source/_posts目录下找到刚才新建的name.md文件，用vscode打开。



```css
title: name
date: 2014-08-05 11:15:00 
tags: 
---
```

页面默认就是长这样的，可以编辑标题、日期、标签和内容，但是没有分类的选项。我们可以手动加入categories:项,但是下次创建新的页面的时候还是没有，所以我们直接打开scaffolds/post.md文件，在tages:上面加入categories:,保存后，重新执行hexo n 'name'命令，会发现新建的页面里有categories:项了。

> scaffolds目录下，是新建页面的模板，执行新建命令时，是根据这里的模板页来完成的，所以可以在这里根据你自己的需求添加一些默认值。

### 8.1、标签列表初始化

​	首先打开主题下的配置文件_config.yml，然后搜索menu找到如下配置项，将about、tags、categories前的#号去掉，就开启了关于、标签和分类标签，当然还有其他菜单项也可以开启

```js
menu:(注意空格即/之后的空格，标准如about其他像这样改)
  home: / || home
  about: /about/|| user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat
```

重新生成部署后，可以看到新增的菜单项，但是单击后会报如下错误

```clike
Cannot GET /about/
Cannot GET /tags/
Cannot GET /categories/
```

这是因为你还需运行如下命令新建相关页面

```shell
hexo new page "about"
hexo new page "tags"
hexo new page "categories"
```

运行结果如下，会再source文件下创建about、tags、categories文件夹，每个文件夹下还会创建一个index.md文件表示关于、标签页分类页面，编辑这三个MarkDown文件可以自定义这三个页面的内容

```gas
D:\hexo\blog>hexo new page "about"`
`INFO  Created: D:\hexo\blog\source\about\index.md`

`D:\hexo\blog>hexo new page "tags"`
`INFO  Created: D:\hexo\blog\source\tags\index.md`

`D:\hexo\blog>hexo new page "categories"`
`INFO  Created: D:\hexo\blog\source\categories\index.md`
```

还差最后一步，打开各页面对应的index.md文件，编辑如下内容，title和date是默认生成的，增加type即可

---

title: about
date: 2019-06-25 19:16:1

type: "about"

---

title: about
date: 2019-06-25 19:16:17

type: "tags"

---

title: about
date: 2019-06-25 19:16:17
type: "categories"

------



### 8.2、设置分类列表

在我们编辑文章的时候，直接在categories:项填写属于哪个分类，但如果分类是中文的时候，路径也会包含中文。

比如分类我们设置的是：



```undefined
categories: 开车
```

那在生成页面后，分类列表就会出现**开车**这个选项，他的访问路径是：



```jsx
*/categories/开车
```

我们都知道，有时候中文路径可能会出现一些奇奇怪怪的问题，所以我们需要路径名和分类名分别设置。

打开站点配置文件_config.yml，找到如下位置做更改：



```bash
# Category & Tag
default_category: uncategorized
category_map:
    开车: drive
    生活: life
    其他: other
tag_map:
```

> 在这里category_map:是设置分类的地方，每行一个分类，冒号前面是分类名称，后面是访问路径。
>  可以提前在这里设置好一些分类，当编辑的文章填写了对应的分类名时，就会自动的按照对应的路径来访问。

### 8.3、设置标签

在编辑文章的时候，tags:后面是设置标签的地方，如果有多个标签的话，可以用下面两种办法来设置：
 第一种：



```css
tages: [标签1,标签2,...标签n]
```

第二种：



```undefined
 tages: 
- 标签1
- 标签2
...
- 标签n
```



------

## 9、总结

​	以上就是就是一些主题优化的一些基础操作喽！请观看下一篇文章，下一篇文章更精彩哦，有着回动的小宠物等着你哦！耐心打下去，可使你的博客靓丽不少哦！



附上参考链接：

1. https://www.jianshu.com/p/b20fc983005f        ------初级版
2.  https://www.cnblogs.com/zhangxiaochn/p/Hexo_Theme_Next.html    -----ZhangXiao's Blog