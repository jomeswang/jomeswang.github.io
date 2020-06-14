---
title: 解决vue的跨域问题
top: false
comments: true
categories:
  - vue
tags:
  - vue
abbrlink: a8f404b4
date: 2020-06-14 10:00:06
---

> 使用官方推荐方法进行跨域问题解决

<!--more--->

![](http://photo.jomeswang.top/20200614100745.png)

之前使用vue-jsonp  来解决跨域问题，这次使用官方方法来解决。

我的请求地址 ： *https://api.ixiaowai.cn/mcapi/mcapi.php?return=json*

首先，要在当前项目的根路径下新建一个文件,文件名是固定的 vue.config.js  （与package.json同路径）

```
module.exports = {
    devServer: {
        open: true,  // 默认启动自启浏览器
        host: 'localhost',
        port: 8001,
        https: false,
        //以上的ip和端口是我们本机的;下面为需要跨域的
        proxy: {//配置跨域
            '/api': {
                target: 'https://api.ixiaowai.cn',//这里后台的地址模拟的;应该填写你们真实的后台接口
                ws: true,
                changOrigin: true,//允许跨域
                pathRewrite: {
                    '^/api': ''//请求的时候使用这个api就可以
                }
            }
            
        }
    }
}
```

使用时：如此配置后，本地请求地址  http://localhost:8001/api//mcapi/mcapi.php?return=json

实际请求地址为： https://api.ixiaowai.cn/mcapi/mcapi.php?return=json  就是因为在 `vue.config.js`  配置好了，所以请求的时候，就就可以用   /api 来代替  https://api.ixiaowai.cn

```
   // 请求接口 后台的接口为5001 我们本地的接口为8080,所以我们需要去到vue.config.js配置跨域 https://api.ixiaowai.cn/mcapi/mcapi.php?return=json
            this.axios.get('/api/mcapi/mcapi.php?return=json')
            .then(res =>{
                // 注册成功
                alert('获取成功!')
                console.log(res)
            })
            .catch(error => {
            	console.log(error)
            })
 
        }
```

请求成功！！！！

![](http://photo.jomeswang.top/20200614102309.png)