---
title: '搜索引擎下拉菜单关键词 接口API '
top: false
comments: false
categories:
  - vue
tags:
  - vue
  - jsonp
  - api
abbrlink: 287c1b7e
date: 2020-02-20 21:19:07
---

今天 Deshun 搜集整理了各大搜索引擎和电商平台的下拉关键词接口，方便做SEO和店铺优化的小伙伴们参考，搜索词以前端为例。

<!-- more -->

各大搜索引擎智能提示API（jsonp实现跨域自动补全建议）更新时间为2019年2月28日，亲测可用，去除不可用的接口，新增一些接口。

### 谷歌（Google）

谷歌API接口地址1：http://clients1.google.com/complete/search?hl=zh&output=toolbar&q=前端

谷歌API接口地址2：http://suggestqueries.google.com/complete/search?output=toolbar&hl=zh&q=前端

谷歌API接口地址2：http://suggestqueries.google.com/complete/search?client=youtube&q=前端&jsonp=window.google.ac.h 会直接下载。

返回结果：

![搜索引擎下拉菜单关键词 接口API （百度、淘宝长尾词）最新 SEO资料 第2张](https://www.w3h5.com/zb_users/upload/2019/02/201902281551347345797376.png)

### 百度（Baidu）

百度API接口地址1：http://suggestion.baidu.com/su?wd=前端

也有人会这样写：http://suggestion.baidu.com/su?wd=前端&p=3&cb=window.bdsug.sug

返回结果：

```
window.bdsug.sug({q:"前端",p:false,s:["前端工程师","前端学习路线","前端开发","前端框架","前端面试题","前端面试","前端面试题及答案","前端开发工具","前端ui框架","前端性能优化"]});
```

### 搜狗（Sougou） 

搜狗API接口地址1：http://w.sugg.sogou.com/sugg/ajaj_json.jsp?key=前端&type=web

返回结果：

```
window.sogou.sug(["前端",["前端开发","前端框架","前端面试题","前端工程师","前端培训","前端和后端","前端招聘","前端开发培训","前端开发工具","前端和后端的区别"],["0;0;0;0","1;0;0;0","2;0;0;0","3;0;0;0","4;0;0;0","5;0;0;0","6;0;0;0","7;0;0;0","8;0;0;0","9;0;0;0"],["","","","","","","","","",""],["0"],"","suglabId_1"],-1);
```

### 360搜索（so） 

360搜索API接口地址：https://sug.so.360.cn/suggest?callback=suggest_so&word=qianduan 测试只支持英文，不过可以支持拼音。

360搜索API接口地址：https://sug.so.360.cn/suggest?encodein=utf-8&encodeout=utf-8&format=json&word=前端&callback=window.so.sug 测试支持汉字。

返回结果：

```
suggest_so({q:"qianduan",p:true,s:["前端","前端培训机构","前端开发需要学什么","前段","钱端","前端开发","前端工程师","前端框架","嵌段","前端面试题"]});
```

### 必应（Bing） 

必应搜索API接口地址：https://api.bing.com/qsonhs.aspx?type=cb&q=前端 返回的是 json 格式。

必应搜索API接口地址：https://api.bing.com/qsonhs.aspx?type=cb&q=前端&cb=window.bing.sug

返回结果：

```
if(typeof window.bing.sug == 'function') window.bing.sug({"AS":{"Query":"前端","FullResults":1,"Results":[{"Type":"AS","Suggests":[{"Txt":"前端切版","Type":"AS","Sk":"","HCS":0.0355},{"Txt":"前端工程師","Type":"AS","Sk":"AS1"},{"Txt":"前端工程師 薪水","Type":"AS","Sk":"AS2"},{"Txt":"前端科技股份有限公司","Type":"AS","Sk":"AS3"},{"Txt":"前端 英文","Type":"AS","Sk":"AS4"},{"Txt":"前端 框架","Type":"AS","Sk":"AS5"},{"Txt":"前端工程師 ptt","Type":"AS","Sk":"AS6"},{"Txt":"前端開發 windows","Type":"AS","Sk":"AS7"}]}]}}/* pageview_candidate */);
```

### 淘宝（Taobao） 

淘宝搜索API接口地址：https://suggest.taobao.com/sug?code=utf-8&q=前端&callback=window.taobao.sug

返回结果：

```
KISSY.Suggest.callback({"result":[["前端播放器","10122"],["前端视频教程 2018","3080"],["前端开发","18144"],["前端开发书籍","13391"],["前端净水器","63525"],["前端开发视频","8932"],["前端过滤器","69083"],["前端耳机","40712"],["前端视频","3535"],["前端教程","22974"]]})
```

### 一淘（etao） 

一淘搜索API接口地址：https://suggest.taobao.com/sug?area=etao&code=utf-8&callback=KISSY.Suggest.callback&q=前端

返回结果：

```
KISSY.Suggest.callback({"result":[["前端播放器","10122"],["前端视频教程 2018","3080"],["前端开发","18144"],["前端开发书籍","13391"],["前端净水器","63525"],["前端开发视频","8932"],["前端过滤器","69083"],["前端耳机","40712"],["前端视频","3535"],["前端教程","22974"]]})
```

### 京东（JD）

京东查价接口：http://p.3.cn/prices/mgets?skuIds=J_100002308919&type=1 红色部分为商品ID

返回结果：

```
[{"id":"J_100002308919","m":"6000.00","op":"3299.00","p":"3299.00"}]
```

### 搜索建议使用方式：

以百度为例，API返回的是JSONP数据，JSONP是跨域访问的一种方式。由于服务器返回的JavaScript代码可以直接引用，通过回调函数的方式就可以间接的获取服务器的数据。

下面是一个回调搜索建议的例子，window.baidu.sug 返回的是一个json对象

```
<script type="text/javascript">
    window.onload = function() {
        //组装查询地址
        var sugurl = "http://suggestion.baidu.com/su?wd=#content#&cb=window.baidu.sug";
        var content = "关键字";
        sugurl = sugurl.replace("#content#", content);
        //定义回调函数
        window.baidu = {
            sug: function(json) {
                console.log(json)
            }
        }
        //动态添加JS脚本
        var script = document.createElement("script");
        script.src = sugurl;
        document.getElementsByTagName("head")[0].appendChild(script);
    }
</script>
```

控制台打印的结果：如果要将结果保存在一个字符串数组中，只需要 var arr = json.s 即可。


