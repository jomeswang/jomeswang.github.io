---
title: node-express 的学习
top: false
comments: false
categories:
  - node
tags:
  - node
  - express
abbrlink: adc804d1
date: 2020-12-26 13:55:23
---

> Node 的一个框架 ， 简洁好用是它的一个特性！！

<!--more--->

全文地址： https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/Express_Nodejs/skeleton_website

## 一： 安装 express

```
// 创建 一个空目录
mkdir myapp
cd myapp

//  初始化 npm
npm init

// 下载 npm 包
npm i express
```



## 二： 编写 js 文件

编写 index.js 文件

```
// 引入 express 包
const express = require('express')
const app = express()
const port = 3000

// 匹配路由中间件  当当请求 localhost:3000 的时候服务端会返回以下数据
app.get('/', (req, res) => {
  res.send('Hello World!')
})

// 监听端口
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
```

然后运行 

```
node index.js
```



即可打开浏览器 访问 localhost:3000 看到返回

![](http://photo.jomeswang.top/20201226140403.png)

## 三： Express 生成器

### 3.1： 安装

 可使用应用程序生成器工具 (`express`) 快速创建应用程序框架。

使用以下命令安装 `express`：

```
npm install express-generator -g
```



### 3.2 使用

```
express test_express
cd test_express
npm i
// 运行
DEBUG=test-express:* & npm start
```

然后在浏览器中输入 `http://localhost:3000/` 以访问此应用程序。

![](http://photo.jomeswang.top/20201226142259.png)

### 3.3 详细讲解

框架信息详解： https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/Express_Nodejs/skeleton_website

这个页面讲的超级详细的，我就不cv了。



### 3.4 操作数据库

与数据库交互有两种方法：

- 使用数据库的原生查询语言（例如SQL）
- 使用对象数据模型（Object Data Model，简称 ODM）或对象关系模型（Object Relational Model，简称 ORM）。 ODM / ORM 能将网站中的数据表示为 JavaScript 对象，然后将它们映射到底层数据库。一些 ORM 只适用某些特定数据库，还有一些是普遍适用的。

- [Mongoose](https://www.npmjs.com/package/mongoose)：一款为异步工作环境设计的 [MongoDB](https://www.mongodb.org/) 对象建模工具。



#### 3.4.1  安装 Mongoose 和 MongoDB 

Mongoose 像任何其他依赖项一样，使用 NPM 将其安装在您的项目（**package.json**）中 。请在项目文件夹中运行下面的命令以完成安装：

```
$ npm install mongoose
```

安装 Mongoose 会添加所有依赖项，包括 MongoDB 数据库驱动程序，但不会安装 MongoDB 本身。要安装 MongoDB 服务器，可以 [点击下载](https://www.mongodb.com/download-center) 各操作系统的安装程序在本地安装。也可以使用云端 MongoDB 实例。



#### 3.4.2  连接数据库

在  app.js 中放置如下语句

```
// 导入 mongoose 模块
const mongoose = require('mongoose');

// 设置默认 mongoose 连接
const mongoDB = 'mongodb://127.0.0.1/my_database';
mongoose.connect(mongoDB);
// 让 mongoose 使用全局 Promise 库
mongoose.Promise = global.Promise;
// 取得默认连接
const db = mongoose.connection;

// 将连接与错误事件绑定（以获得连接错误的提示）
db.on('error', console.error.bind(console, 'MongoDB 连接错误：'));
```



#### 3.4.3  定义和添加模型

模型使用 `Schema` 接口进行定义。 `Schema` 可以定义每个文档中存储的字段，及字段的验证要求和默认值。还可以通过定义静态和实例辅助方法来更轻松地处理各种类型的数据，还可以像使用普通字段一样使用数据库中并不存在的虚拟属性（稍后讨论）。

创建一个 bookModel 实例

```
const mongoose = require("mongoose")

let Schema = mongoose.Schema

// 定义模式
let BookSchema = new Schema({
  name: String,
  author: String,
  id: {type: Number, required: true}
})

// 虚拟属性， 不存在数据库中， 类似于 计算属性
BookSchema
.virtual("url")
.get(()=>{
  return "/book/"+ this.id;
})


// 使用模式“编译”模型
module.exports = mongoose.model("Book", BookSchema)
//第一个参数是为模型所创建集合的别名（Mongoose 将为 SomeModel 模型创建数据库集合），第二个参数是创建模型时使用的模式。
```



#### 3.4.4 创建， 查找， 修改记录

创建  `bookController.js` 文件

```
const { log } = require("debug")
let Book = require("../model/bookModel")

exports.create = (req, res)=>{
  //  创建
  let bookInstance = new Book({
    name: "llw",
    author: "llwnb",
    id: 23
  })
  bookInstance.save(err=>{
    if(err)
      return handleError(err)
    res.send("Hello World!!")
  })
}

exports.query = (req, res)=>{
  //  搜索
  Book.find()
      .exec((err, data)=>{
        console.log(data);
        res.send(data)
      })
}

exports.edit = (req, res)=>{
  //  只更新一个记录
  Book.where({id: 23})
  .update({$set: {name: "111111wangwang"}})
  .exec((err, data)=>{
    console.log(data)
    res.send(data)
  })
}

```



#### 3.4.5  配置路由

在 `routes/index.js` 中配置成如下形式

```
var express = require('express');
var router = express.Router();
let book_controller = require("../controllers/bookController")

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get("/create", book_controller.create)
router.get("/query", book_controller.query)
router.get("/edit", book_controller.edit)

module.exports = router;

```



之后就可以愉快的访问啦！！！！