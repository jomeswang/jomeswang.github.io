---
title: JS 对象与函数 学习二
top: false
comments: false
categories:
  - js
tags:
  - js
abbrlink: b3fdae5d
date: 2020-12-17 15:50:17
---

> 每天都要学习哈！！！！

<!--more-->

## 一：函数

### 1.1 Function() 构造器

正如您在之前的例子中看到的，JavaScript 函数是通过 function 关键词定义的。

函数也可以通过名为 Function() 的内建 JavaScript 函数构造器来定义。

大多数情况下，您可以避免在 JavaScript 中使用 new 关键词。

### 1.2  函数提升

在本教程中稍早前，您已经学到了“提升”（hoisting）。

Hoisting 是 JavaScript 将*声明*移动到当前作用域顶端的默认行为。

Hoisting 应用于变量声明和函数声明。

正因如此，JavaScript 函数能够在声明之前被调用：

### 1.3  箭头函数

箭头函数允许使用简短的语法来编写函数表达式。

您不需要 function 关键字、return 关键字和花括号。

实例

```
// ES5
var x = function(x, y) {
  return x * y;
}

// ES6
const x = (x, y) => x * y;
```

### 1.4  函数参数

在本教程中稍早的时间，您已经学到了函数可以拥有*参数*：

```
functionName(parameter1, parameter2, parameter3) {
    要执行的代码
}
```

*函数参数（parameter）*指的是在函数定义中列出的*名称*。

*函数参数（argument）*指的是传递到函数或由函数接收到的真实*值*。

### 1.5   arguments 对象

JavaScript 函数有一个名为 arguments 对象的内置对象。

arguments 对象包含函数调用时使用的参数数组。

这样，您就可以简单地使用函数来查找（例如）数字列表中的最高值：

```
x = findMax(1, 123, 500, 115, 44, 88);

function findMax() {
    var i;
    var max = -Infinity;
    for (i = 0; i < arguments.length; i++) {
        if (arguments[i] > max) {
            max = arguments[i];
        }
    }
    return max;
}
```

### 1.6    JavaScript call() 方法

call() 方法是预定义的 JavaScript 方法。

它可以用来调用所有者对象作为参数的方法。

通过 call()，您能够使用属于另一个对象的方法。

本例调用 person 的 fullName 方法，并用于 person1：

```
var person = {
    fullName: function() {
        return this.firstName + " " + this.lastName;
    }
}
var person1 = {
    firstName:"Bill",
    lastName: "Gates",
}
var person2 = {
    firstName:"Steve",
    lastName: "Jobs",
}
person.fullName.call(person1);  // 将返回 "Bill Gates"
```

不同之处是：

call() 方法分别接受参数。

apply() 方法接受数组形式的参数。



闭包？？





## 二：  什么是 DOM？

DOM 是一项 W3C (World Wide Web Consortium) 标准。

DOM 定义了访问文档的标准：

> “W3C 文档对象模型（DOM）是中立于平台和语言的接口，它允许程序和脚本动态地访问、更新文档的内容、结构和样式。”

W3C DOM 标准被分为 3 个不同的部分：

- Core DOM - 所有文档类型的标准模型
- XML DOM - XML 文档的标准模型
- HTML DOM - HTML 文档的标准模型





### 2.1  查找HTML元素

- 通过 id 查找 HTML 元素
- 通过标签名查找 HTML 元素
- 通过类名查找 HTML 元素
- 通过 CSS 选择器查找 HTML 元素
- 通过 HTML 对象集合查找 HTML 元素

### 2.2  通过 CSS 选择器查找 HTML 元素

如果您需要查找匹配指定 CSS 选择器（id、类名、类型、属性、属性值等等）的所有 HTML 元素，请使用 querySelectorAll() 方法。

### 2.3   事件

HTML 事件的例子：

- 当用户点击鼠标时
- 当网页加载后
- 当图像加载后
- 当鼠标移至元素上时
- 当输入字段被改变时
- 当 HTML 表单被提交时
- 当用户敲击按键时



### 2.4  JavaScript HTML DOM 事件监听器

addEventListener() 方法为指定元素指定事件处理程序。

您能够通过使用 removeEventListener() 方法轻松地删除事件监听器。

语法

```
element.addEventListener(event, function, useCapture);
```

第一个参数是事件的类型（比如 "click" 或 "mousedown"）。

第二个参数是当事件发生时我们需要调用的函数。

第三个参数是布尔值，指定使用事件冒泡还是事件捕获。此参数是可选的。

**注意：**请勿对事件使用 "on" 前缀；请使用 "click" 代替 "onclick"。

你能够通过使用“useCapture”参数来规定传播类型：默认值是 false，将使用冒泡传播，如果该值设置为 true，则事件使用捕获传播。

#### 2.5   DOM 节点

根据 W3C HTML DOM 标准，HTML 文档中的所有事物都是节点：

- 整个文档是文档节点
- 每个 HTML 元素是元素节点
- HTML 元素内的文本是文本节点
- 每个 HTML 属性是属性节点
- 所有注释是注释节点

### 2.6  节点关系

节点树中的节点彼此之间有一定的等级关系。

- 术语（父、子和同胞，parent、child 以及 sibling）用于描述这些关系。

通过 JavaScript，您可以使用以下节点属性在节点之间导航：

- parentNode
- childNodes[*nodenumber*]
- firstChild
- lastChild
- nextSibling
- previousSibling

### 2.6  节点属性

#### 2.6.1  InnerHTML

在本教程中，我们使用 innerHTML 取回 HTML 元素的内容。

#### 2.6.2  nodeValue 属性

nodeValue 属性规定节点的值。

- 元素节点的 nodeValue 是 undefined
- 文本节点的 nodeValue 是文本文本
- 属性节点的 nodeValue 是属性值

### 2.7  创建新 HTML 元素（节点）

```
<div id="div1">
<p id="p1">这是一个段落。</p>
<p id="p2">这是另一个段落。</p>
</div>

<script>
var para = document.createElement("p");
var node = document.createTextNode("这是新文本。");
para.appendChild(node);

var element = document.getElementById("div1");
element.appendChild(para);
</script>
```

### 2.8   创建新 HTML 元素 - insertBefore()

### 2.9   删除已有 HTML 元素

如需删除某个 HTML 元素，您需要知晓该元素的父：

```
<div id="div1">
<p id="p1">这是一个段落。</p>
<p id="p2">这是另一个段落。</p>
</div>

<script>
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.removeChild(child);
</script>
```

### 2.10   替换 HTML 元素

如需替换元素的，请使用 replaceChild() 方法：





## 三： BOM 操作  

### 3.1     浏览器对象模型（Browser Object Model (BOM)）

不存在浏览器对象模型（BOM）的官方标准。

现代的浏览器已经（几乎）实现了 JavaScript 交互相同的方法和属性，因此它经常作为 BOM 的方法和属性被提到。

一些其他方法： 

- window.open() - 打开新窗口
- window.close() - 关闭当前窗口
- window.moveTo() -移动当前窗口
- window.resizeTo() -重新调整当前窗口

setTimeout(*function*, *milliseconds*)

在等待指定的毫秒数后执行函数。

setInterval(*function*, *milliseconds*)

等同于 setTimeout()，但持续重复执行该函数。