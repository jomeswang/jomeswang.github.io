---
title: node 学习
top: false
comments: true
categories:
  - node
tags:
  - node
abbrlink: f4f44d6e
date: 2020-12-25 21:41:49
---

> 终于有时间来学习 node 啦！！！

<!--more--->

## 一： Node 介绍

Node.js运行单线程，非阻塞，异步编程，这非常节省内存。

1. Node.js可以生成动态页面内容
2. Node.js可以在服务器上创建，打开，读取，写入，删除和关闭文件
3. Node.js可以收集表单数据
4. Node.js可以添加，删除，修改数据库中的数据

 

## 二： Node 的语法

### 2.1 Node  HTTP 服务

HTTP模块可以创建一个HTTP服务器，该服务器侦听服务器端口并将响应返回给客户端。

使用 url 模块来对url 进行解析 获得 url 的query 参数

```
let http = require('http');
let url = require("url")

//create a server object:
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  let queryData = url.parse(req.url, true).query   // call ?test=123 return {test: 123}
  res.write('Hello World!'); //write a response to the client
  res.end(); //end the response
}).listen(8080); //the server object listens on port 8080
```



### 2.2 Node 模块化

编写一个 返回 当前时间的 模块 并命名为 getDate.js 

```
exports.getDate = ()=>{
  return new Date()
}
```

之后创建 index.js  在里面写入以下内容  注意要与 getDate.js 在同意路径下。

```

let http = require('http');
// 析构出 getDate 函数 ， 并且通过 require 方法引入模块
let {getDate} = require("./getDate.js")

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write('Hello World!' + getDate());
  res.end();
}).listen(8080);
```



### 2.3  Node 文件操作

使用 fs 模块 来 对文件进行 增删改查

```
let http = require("http")
let fs = require("fs")

//  读取文件
let readFile = (filePath)=>{
  return new Promise((resolve, reject)=>{
    fs.readFile(filePath, (err, data)=>{
      if(err)
        reject(err)

      resolve(data)
    })
  })
}

//  创建文件
let createFile = (path, content)=>{
  //  有三种方法 
  //  1. fs.appendFile()  如果有 继续往后添加内容
  // 2. fs.open()  接受一个 path 参数， 一个打开模式
  //  3. fs.writeFile()  如果有取而代之
  return new Promise((resolve, reject)=>{
    fs.writeFile(path, content, (err)=>{
      if(err)
        reject(err)

      resolve({code: 200, errmsg:"Success"})
    })
  })
}

http.createServer((req, res)=>{
  //  创建文件 并返回文件内容
  createFile("hello.txt", "Hello, I am creating a file using writeFile method ")
        .then(()=> {
          //  重新创建文件之后 读取文件内容并返回
          readFile("hello.txt")
                .then(
                data=> {res.write(data), res.end()}
                )})
}).listen(8080)
```



### 2.4   Node 事件监听

Node.js具有一个内置的模块，称为“event”，您可以在其中创建，触发和侦听自己的事件。使用  eventEmitter 来 监听 事件的触发。

```
var events = require('events');
var eventEmitter = new events.EventEmitter();

//Create an event handler:
var myEventHandler = function () {
  console.log('I hear a scream!');
}

//Assign the event handler to an event:
eventEmitter.on('scream', myEventHandler);

//Fire the 'scream' event:
eventEmitter.emit('scream');
```

要发布事件，我们使用emit（）函数，要监听事件，我们使用on（）函数。  

同时在这一个样例中， 我们先 监听 scream 事件， 之后我们再发布， 同时发布事件的这一个过程是同步操作的。

还要再发布之前必须先去 监听。



## 三： Node 与 Mysql 交互

### 3.1 在本机中安装 mysql

https://www.mysql.com/downloads/



### 3.2 安装 mysql 驱动

```
npm i mysql
```



### 3.3 配置myql 参数

```
let con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "llw012800",
  database: "test_node"
})
```

创建 test_node 数据库  和 user 数据表

### 3.4 mysql  模块包和 mysql8.0 验证方式不兼容

`Error: ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server; consider upgrading MySQL client`

![](http://photo.jomeswang.top/20201226020304.png)

解决方法：

导致这个错误的原因是，目前，最新的mysql模块并未完全支持MySQL 8的“caching_sha2_password”加密方式，而“caching_sha2_password”在MySQL 8中是默认的加密方式。因此，下面的方式命令是默认已经使用了“caching_sha2_password”加密方式，该账号、密码无法在mysql模块中使用。

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
Query OK, 0 rows affected (0.12 sec)
```

### 解决方法

解决方法是从新修改用户root的密码，并指定mysql模块能够支持的加密方式：

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
Query OK, 0 rows affected (0.12 sec)
```

上述语句，显示指定了使用“mysql_native_password”的加密方式。这种方式是在mysql模块能够支持。

### 3.5 mysql 交互 全部代码

```
let http = require("http")
const { reject, result } = require("lodash")
let mysql = require("mysql")

let con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "llw012800",
  database: "test_node"
})

let queryDB = (sql)=>{
  return new Promise((resolve, reject)=>{
    con.query(sql, (err, result)=>{
      // console.log(result)
      if(err)
        reject(err)
      resolve(result)
    })
  })
}


try {
  con.connect((err)=>{
    if(err)
      throw err;
    //  插入语法
    let sql = "INSERT INTO user (name, address) VALUES ('Michelle', 'Blue Village 1')"
    queryDB(sql)
          .then(res=>{
            console.log(res)
            //  取出数据表的数据
            queryDB("SELECT * FROM user LIMIT 1")
            .then(res=>{
              console.log(res)
              //  这里是 update 数据表记录的方法
              let updateSql = "UPDATE user SET address ='szdx', name='llw' WHERE id=2 "
              queryDB(updateSql)
              .then(res=>{
                console.log(res)
              })
            })
          })
  })
} catch (error) {
  console.error(error);
}


```



## 四： Node 与 Mongodb 进行交互

### 4.1 安装 mongodb 

 安装 Windows 版本的  https://www.mongodb.com/try/download/community?tck=docs_server

### 4.2  安装mongodb 模块

Download and install mongodb package:

```
npm install mongodb
```

### 4.3   创建 数据库和数据表

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  //  如果不存在 数据库 数据集合 会自动创建
  var dbo = db.db("mydb");
  dbo.createCollection("customers", function(err, res) {
    if (err) throw err;
    console.log("Collection created!");
    db.close();
  });
});
```



### 4.4    插入一条记录

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  var myobj = { name: "Company Inc", address: "Highway 37" };
  dbo.collection("customers").insertOne(myobj, function(err, res) {
    if (err) throw err;
    console.log("1 document inserted");
    db.close();
  });
});
```

### 4.5   插入多条记录

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  var myobj = [
    { name: 'John', address: 'Highway 71'},
    { name: 'Peter', address: 'Lowstreet 4'},
    { name: 'Amy', address: 'Apple st 652'},
    { name: 'Hannah', address: 'Mountain 21'},
    { name: 'Michael', address: 'Valley 345'},
    { name: 'Sandy', address: 'Ocean blvd 2'},
    { name: 'Betty', address: 'Green Grass 1'},
    { name: 'Richard', address: 'Sky st 331'},
    { name: 'Susan', address: 'One way 98'},
    { name: 'Vicky', address: 'Yellow Garden 2'},
    { name: 'Ben', address: 'Park Lane 38'},
    { name: 'William', address: 'Central st 954'},
    { name: 'Chuck', address: 'Main Road 989'},
    { name: 'Viola', address: 'Sideway 1633'}
  ];
  dbo.collection("customers").insertMany(myobj, function(err, res) {
    if (err) throw err;
    console.log("Number of documents inserted: " + res.insertedCount);
    db.close();
  });
});
```



### 4.6     查找一个数据

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  dbo.collection("customers").findOne({}, function(err, result) {
    if (err) throw err;
    console.log(result.name);
    db.close();
  });
});
```

### 4.7    查找多个数据

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  var query = { address: "Park Lane 38" };
  dbo.collection("customers").find(query).toArray(function(err, result) {
    if (err) throw err;
    console.log(result);
    db.close();
  });
});
```

### 4.8   更新一条数据

```
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/";

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("mydb");
  var myquery = { address: "Valley 345" };
  var newvalues = { $set: {name: "Mickey", address: "Canyon 123" } };
  dbo.collection("customers").updateOne(myquery, newvalues, function(err, res) {
    if (err) throw err;
    console.log("1 document updated");
    db.close();
  });
});
```



9. ### 更新多条数据

   ```
   var MongoClient = require('mongodb').MongoClient;
   var url = "mongodb://127.0.0.1:27017/";
   
   MongoClient.connect(url, function(err, db) {
     if (err) throw err;
     var dbo = db.db("mydb");
     var myquery = { address: /^S/ };
     var newvalues = {$set: {name: "Minnie"} };
     dbo.collection("customers").updateMany(myquery, newvalues, function(err, res) {
       if (err) throw err;
       console.log(res.result.nModified + " document(s) updated");
       db.close();
     });
   });
   ```

   