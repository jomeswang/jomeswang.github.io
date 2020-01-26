---
title: vs code 一键创建vue模板
top: false
comments: true
categories:
  - 前端
tags:
  - vue
  - html
abbrlink: d67fdd5d
date: 2020-01-23 10:10:15
---

最近看视频学习vue的时候发现vs code除了使用 !+Tab 在html文件中快速创建模板之外，还可以自己定义，但是视频里面没有教，所以就自己查找了一下方法并和大家分享一下

<!-- more -->

### 第一步：文件 ——> 首选项 ——>用户代码片段

### ![img](https://img2018.cnblogs.com/blog/1749706/201908/1749706-20190804204859952-686811401.png)

 

### 第二步：搜索框中输入html.json(如果需要在别的类型的文件中可以输入对应的名字，如：vue.json)

 ![img](https://img2018.cnblogs.com/blog/1749706/201908/1749706-20190804204945312-1957895648.png)

### 第三步：输入以下代码（可根据自己的需求修改）

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
"Html5-Vue": {
        "prefix": "vue",//可以自己修改成想要的名字
        "body": [
            "<!DOCTYPE html>",
            "<html lang=\"en\">\n",
            "<head>",
            "\t<meta charset=\"UTF-8\">",
            "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
            "\t<meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">",
            "\t<title>Document</title>",
            "\t<script src=\"../vue.js\"></script>",//改成自己的vue路径
            "</head>\n",
            "<body>",
            "\t<div id=\"app\">$1</div>\n",
            "\t<script>",
            "\t\tvar vm = new Vue({",
            "\t\t\tel: '#app',",
            "\t\t\tdata: {},",
            "\t\t\tmethods: {}",
            "\t\t});",
            "\t</script>",
            "</body>\n",
            "</html>"
        ],
        "description": "自定义vue模板"
    }    
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

### 最后：在新建的html文件中输入自己定义的名字并按下 Tab（上面的代码是vue）

![img](https://img2018.cnblogs.com/blog/1749706/201908/1749706-20190804205638988-879936143.png)

![img](https://img2018.cnblogs.com/blog/1749706/201908/1749706-20190804205701382-1672019231.png)

 https://www.cnblogs.com/kusaki/p/11299689.html 

 转自网络。如有侵权，请联系删除 