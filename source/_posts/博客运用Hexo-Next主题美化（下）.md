---
title: 博客运用Hexo-Next主题美化（下）
top: false
comments: true
categories: 建站
tags:
  - webinit
  - hexo
  - next
  - leancloud
abbrlink: 42fa127b
date: 2020-01-03 10:32:35
---

​																								--转载链接见最下方

## 1，前言

​		终于要到关于建站的倒数第二篇文章了，有点心累！为自己加油鼓气！！

​		在建好自己的静态博客之后，是不是发现有点问题，如`GitHub`的加载速度过慢，没有访问量的等交互式问题，此篇就是来完善这些不足的。

<!-- more -->

## 2，博客内交互

### 		2.1，在线评论

​			设置效果：
![](http://photo.jomeswang.top/20200410190922.png)

设置方法：

1. 首先要先去[LeanCloud](https://leancloud.cn/)注册一个帐号.然后再创建一个应用.
   ![](http://photo.jomeswang.top/20200410191013.png)
   进入应用->设置->应用key,获取你的`appid` 和 `appkey` 如图所示：
   ![](http://photo.jomeswang.top/20200410191207.png)

2. 拿到`appid`和`appkey`之后，打开`themes/next/_config.yml`主题配置文件，查找`valine`，填入`appid` 和 `appkey`
   我的配置:

```yaml
valine:  
	enable: true  
	appid:  your app id  
	appkey: your app key 
	notify: false # mail notifier , https://github.com/xCss/Valine/wiki  
	verify: false # Verification code  
	placeholder: ヾﾉ≧∀≦)o来啊，快活啊!   
	guest_info: nick,mail,link  
	pageSize: 10
```



3. 最后！记得在`Leancloud -> 设置 -> 安全中心 -> Web 安全域名` 把你的域名加进去．

   刷新一下~ 是不是就能看到评论框了？还可以设置邮箱提醒哦[看这里](https://hexo.jomeswang.top/posts/84c51fe9/)

### 			2.2，字数统计，访客统计

#### 				2.2.1，不蒜子统计功能

​			`NexT`主题集成了不蒜子统计功能,以下为我的配置

```yaml
copy# Show PV/UV of the website/page with busuanzi.
# Get more information on http://ibruce.info/2015/04/04/busuanzi/
busuanzi_count:  
	# count values only if the other configs are false  
	enable: true  
	# custom uv span for the whole site  
	site_uv: true  
	site_uv_header: <i class="fa fa-user"></i>  
	site_uv_footer: 人次 
    # custom pv span for the whole site  
    site_pv: true  
    site_pv_header: <i class="fa fa-eye"></i>  
    site_pv_footer: 次  
    # custom pv span for one page only  
    page_pv: true  
    page_pv_header: <i class="fa fa-file-o"></i>  
    page_pv_footer: 次
```

- 当`enable: true`时，代表开启全局开关。若s`ite_uv、site_pv、page_pv`的值均为`false`时，不蒜子仅作记录而不会在页面上显示。
  当`site_uv: true`时，代表在页面底部显示站点的UV值。
  当`site_pv: true`时，代表在页面底部显示站点的PV值。
  当`page_pv: true`时，代表在文章页面的标题下显示该页面的PV值（阅读数）。
  `site_uv_header`和`site_uv_footer`这几个为自定义样式配置，相关的值留空时将不显示，可以使用（带特效的）font-awesome。

+ 如果你的NEXT的版本是按照上述版本安装的，还需设置`/themes/next/layout/_third-party/analytics/busuanzi-counter.swig/`中的第三行中的

```
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```

为（更改其中的域名）

```
<script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```

​			[2018/9/19] 更新

​					Next主题已经更新至`6.X`版本,不蒜子统计插件配置有变化

```yaml
文件：主题配置文件_config.ymlcopy
# Show Views/Visitors of the website/page with busuanzi.
# Get more information on http://ibruce.info/2015/04/04/busuanzi/
busuanzi_count:  
    enable: true  
    total_visitors: true  
    total_visitors_icon: user  
    total_views: true  
    total_views_icon: eye  
    post_views: false  
    post_views_icon: eye
```

------

效果图：
![](http://photo.jomeswang.top/20200410190028.png)

#### 			2.2.2,LeanCloud阅读次数统计

​			`		[2018/9/19] 更新`

1. ##### 安装

```yaml
npm install hexo-symbols-count-time --save
```

 		文件：站点配置文件`_config.yml` 

```yaml
symbols_count_time:
  symbols: true
  time: true
  total_symbols: true
  total_time: true
```

 		文件：主题配置文件`_config.yml` 

```yaml
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: true
  awl: 4 # 平均单词长度（单词的计数）。默认值:4。CN≈2 EN≈5 俄文≈6
  wpm: 275 # 每分钟的单词。默认值:275。缓慢≈200 正常≈275 快≈350
```

+ 更多请[点击这里](http://theme-next.iissnan.com/third-party-services.html#share-system)
  next升级6.X后，页面LeanCloud访问统计提示`Counter not initialized! See more at console err msg.`的问题，请查看[《Leancloud访客统计插件重大安全漏洞修复指南》](https://leaferx.online/2018/02/11/lc-security/#5acc7b329f54542bb2384a7e)

------

1. ##### 首先介绍Lean Cloud:

> [LeanCloud](https://leancloud.cn/)（aka. AVOS Cloud）提供一站式后端云服务，从数据存储、实时聊天、消息推送到移动统计，涵盖应用开发的多方面后端需求。

​		相比不蒜子的统计，LeanCloud的文章阅读量统计更加稳定靠谱，所以本人也把网站的文章内统计改为LeanCloud的了。

2. ##### 配置[LeanCloud](https://leancloud.cn/)

   在注册完成LeanCloud帐号并验证邮箱之后，我们就可以登录我们的LeanCloud帐号，进行一番配置之后拿到`AppID`以及`AppKey`这两个参数即可正常使用文章阅读量统计的功能了。

   2.1 创建应用

   2.2 我们新建一个应用来专门进行博客的访问统计的数据操作。首先，打开控制台：在出现的界面点击`创建应用`：	在接下来的页面，新建的应用名称我们可以随意输入，即便是输入的不满意我们后续也是可以更改的:这里为了演示的方便，我新创建一个取名为test的应用。创建完成之后我们点击新创建的应用的名字来进行该应用的参数配置：

   2.3 在应用的数据配置界面，左侧下划线开头的都是系统预定义好的表，为了便于区分我们新建一张表来保存我们的数据。点击左侧右上角的齿轮图标，新建Class：
   在弹出的选项中选择`创建Class`来新建Class用来专门保存我们博客的文章访问量等数据:
   点击`创建Class`之后，理论上来说名字可以随意取名，只要你交互代码做相应的更改即可，但是为了保证我们前面对NexT主题的修改兼容，此处的**新建Class名字必须为`Counter`**:

- 由于LeanCloud升级了默认的ACL权限，如果你想避免后续因为权限的问题导致次数统计显示不正常，建议在此处选择`无限制`。

  2.3 创建完成之后，左侧数据栏应该会多出一栏名为`Counter`的栏目，这个时候我们点击顶部的设置，切换到test应用的操作界面:
  在弹出的界面中，选择左侧的`应用Key`选项，即可发现我们创建应用的`AppID`以及`AppKey`，有了它，我们就有权限能够通过主题中配置好的Javascript代码与这个应用的Counter表进行数据存取操作了:

  2.4 复制`AppID`以及`AppKey`并在NexT主题的`_config.yml`文件中我们相应的位置填入即可，正确配置之后文件内容像这个样子:

```yaml
leancloud_visitors:  	
	enable: true   
	app_id: joaeuuc4hsqudUUwx4gIvGF6-gzGzoHsz   
	app_key: E9UJsJpw1omCHuS22PdSpKoh
```

  3. ##### 重新生成部署Hexo博客，

     这时应该就可以正常使用文章阅读量统计的功能了。需要特别说明的是：记录文章访问量的唯一标识符是文章的`发布日期`以及`文章的标题`，因此请确保这两个数值组合的唯一性，如果你更改了这两个数值，会造成文章阅读数值的清零重计。

4. ##### 后台管理:

   当你配置部分完成之后，初始的文章统计量显示为0，但是这个时候我们LeanCloud对应的应用的`Counter`表中并没有相应的记录，只是单纯的显示为0而已，当博客文章在配置好阅读量统计服务之后第一次打开时，便会自动向服务器发送数据来创建一条数据，该数据会被记录在对应的应用的`Counter`表中。

![](http://photo.jomeswang.top/20200410191401.png)

​		我们可以修改其中的`time`字段的数值来达到修改某一篇文章的访问量的目的（博客文章访问量快递提升人气的装逼利器）。双击具体的数值，修改之后回车即可保存。

- `url`字段被当作唯一`ID`来使用，因此如果你不知道带来的后果的话请不要修改。
- `title`字段显示的是博客文章的标题，用于后台管理的时候区分文章之用，没有什么实际作用。
- 其他字段皆为自动生成，具体作用请查阅LeanCloud官方文档，如果你不知道有什么作用请不要随意修改。

5. ##### Web安全:

   因为AppID以及AppKey是暴露在外的，因此如果一些别用用心之人知道了之后用于其它目的是得不偿失的，为了确保只用于我们自己的博客，建议开启Web安全选项，这样就只能通过我们自己的域名才有权访问后台的数据了，可以进一步提升安全性。

   选择应用的设置的`安全中心`选项卡:在`Web 安全域名`中填入我们自己的博客域名，来确保数据调用的安全:

## 3，hexo-next 添加代码块复制功能

1. ### 下载 clipboard.js

   下载第三方插件：[clipboard.js](https://github.com/zenorocha/clipboard.js), 或者[直接下载](https://raw.githubusercontent.com/zenorocha/clipboard.js/master/dist/clipboard.min.js) (右键另存为)。保存文件到 `theme/next/source/js/src` 下。

2. ### clipboard的使用

   也是在 `theme/next/source/js/src` 目录下，创建 `clipboard-use.js`，添加内容如下：

```js
/*页面载入完成后，创建复制按钮*/
!function (e, t, a) { 
  /* code */
  var initCopyCode = function(){
    var copyHtml = '';
    copyHtml += '<button class="btn-copy" data-clipboard-snippet="">';
    copyHtml += '<span>复制</span>';
    copyHtml += '</button>';
    $(".highlight .code pre").before(copyHtml);
    new ClipboardJS('.btn-copy', {
        target: function(trigger) {
            return trigger.nextElementSibling;
        }
    });
  }
  initCopyCode();
}(window, document);
```

​	在 `theme/next/source/css/_custom/custom.styl` 样式中添加如下代码：

```css
//代码块复制按钮
.highlight{
  //方便copy代码按钮（btn-copy）的定位
  position: relative;
}
.btn-copy {
    display: inline-block;
    cursor: pointer;
    background-color: #eee;
    background-image: linear-gradient(#fcfcfc,#eee);
    border: 1px solid #d5d5d5;
    border-radius: 3px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    -webkit-appearance: none;
    font-size: 13px;
    font-weight: 700;
    line-height: 20px;
    color: #333;
    -webkit-transition: opacity .3s ease-in-out;
    -o-transition: opacity .3s ease-in-out;
    transition: opacity .3s ease-in-out;
    padding: 2px 6px;
    position: absolute;
    right: 5px;
    top: 5px;
    opacity: 0;
}
.btn-copy span {
    margin-left: 5px;
}
.highlight:hover .btn-copy{
  opacity: 1;
}
```

3. ### 引用

   在 `themes/next/layout/_layout.swig` 文件中引用（`/body`）之前添加：

```js
<!-- 代码块复制功能 -->
<script type="text/javascript" src="/js/src/clipboard.min.js"></script>  
<script type="text/javascript" src="/js/src/clipboard-use.js"></script>
```

​	或者将 `clipboard.min.js` 和 `clipboard-use.js` 保存到类似七牛云上，通过引用也可（**推荐**）.

## 4，后记

​		没想到这篇写了这么长还没写完交互式的操作，那么我就放在下一篇继续写吧。

​		预告一下下一篇的精彩内容：coding page 分流和一些不足的优化哦！		加油，奥勒给！！