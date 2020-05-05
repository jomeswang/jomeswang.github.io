---
title: Flask 框架的学习
top: false
comments: true
categories:
  - python
tags:
  - python
  - flask
abbrlink: d4859235
date: 2020-05-04 09:54:39
---

## 一：前言

前端时间学习了下Flask，准备在这里记录一下Flask的基础入门。

<!--more--->

## 二：内容

### 2.1 	创建并初始化

首先先安装

```
pip install flask flask_restful
```

之后创建一个hello.py

```
# 导入Flask类
from flask import Flask

#Flask类接收一个参数__name__
app = Flask(__name__)


# 装饰器的作用是将路由映射到视图函数index
@app.route('/')
def index():
    return 'Hello World'


# Flask应用程序实例的run方法启动WEB服务器
if __name__ == '__main__':
    app.run(debug = True)
```

效果图：![](http://photo.jomeswang.top/20200504101629.png)



### 2.2 	路由分发并获取请求

#### 1.使用原生api给路由传参

1. 将url中的参数提取出来

```
@app.route('/user/<int:id>')
def hello(id):
    return 'hello  %d' % id
```

![](http://photo.jomeswang.top/20200504102220.png)

2. 使用的是Http请求（get，post，put, delete）

```
# 引入request
from flask import request

@app.route('/http-method-test/', methods=['GET', 'POST', 'PUT', 'PATCH', 'DELETE']) 
def http_method_example():
    if request.method == 'GET':
        return 'Send request with `GET` method'
    elif request.method == 'POST':
        return 'Send request with `POST` method'
```

![](http://photo.jomeswang.top/20200504103146.png)

获取请求数据

request.form.get("key", type=str, default=None) 获取表单数据

request.args.get("key") 获取get请求参数

request.values.get("key") 获取所有参数

下面给出例子：

1. get请求

```
@app.route('/get_test', methods=['GET'])
def get_test():
    if request.method == 'GET':
        return request.args.get("data")
    return "I am a boy"
```

![](http://photo.jomeswang.top/20200504104723.png)

2. 同理可以获得post请求

因此使用`request.values.get("key")`最方便

#### 2.使用flask_restful 

原生和拓展的比对

原生：

![](http://photo.jomeswang.top/20200504105139.png)

拓展：

![](http://photo.jomeswang.top/20200504105158.png)

看着第二种舒服不是吗，并且满足API的Restful规则

使用：

```
# 首先引入
import  flask_restful
```

```
from flask import Flask, request
from flask_restful import reqparse, Resource, Api

# 创建一个实例对象
app = Flask(__name__)
api = Api(app)


# 该类继承自 Resource 类
class Hello(Resource):
    # 假如这个使用的是get方法就会进入这个视图函数里面
    def get(self):
        mydict = {'message': "Hello"}
        return mydict, 200


# 将Hello 这个资源类分配路由
api.add_resource(Hello, '/')

if __name__ == '__main__':
    app.run(port=4000, debug=True)
```

![](http://photo.jomeswang.top/20200505002225.png)

1. #### 使用flask_restful 获取相应值

法一：使用原生的`request.values.get()`方法获取得到值。

法二：使用reqparse 来请求解析数据

```
from flask import Flask, request
from flask_restful import reqparse, Resource, Api

# 创建一个实例对象
app = Flask(__name__)
api = Api(app)
# 使用捆绑错误选项调用RequestParser， 让错误可以一次全部输出
parser = reqparse.RequestParser(bundle_errors=True)

# 添加请求参数验证， help为类型检查错误时出现的东西
parser.add_argument("number", type=int, help='number should be int')
parser.add_argument("name", type=str)


# 该类继承自 Resource 类
class Hello(Resource):
    # 假如这个使用的是get方法就会进入这个视图函数里面
    def get(self):
        # 取出请求中所有的数据
        args = parser.parse_args()
        # 使用args[] 方法可以取出数据
        return {'number': args['number'], 'name': args['name']}, 200


# 将Hello 这个资源类分配路由
api.add_resource(Hello, '/')

if __name__ == '__main__':
    app.run(port=4000, debug=True)
```

不符合验证规则的请求

![](http://photo.jomeswang.top/20200505003359.png)

符合验证规则的请求

![](http://photo.jomeswang.top/20200505003511.png)