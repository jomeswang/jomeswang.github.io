---
title: 'JS 之 apply，call, bind的运用'
top: false
comments: false
categories:
  - JS
tags:
  - JS
abbrlink: 4c61acf0
date: 2020-12-27 18:16:35
---

> 回炉重造喽

<!--more-->

+  call 会l立即调用该函数，并允许您一个一个地传递参数。
+ Apply立即调用该函数，并允许您将参数作为数组传递。
+ Bind返回一个新函数，允许您传入this和任意数量的参数。

**Call**

```js
var person1 = {firstName: 'Jon', lastName: 'Kuperman'};
var person2 = {firstName: 'Kelly', lastName: 'King'};

function say(greeting) {
    console.log(greeting + ' ' + this.firstName + ' ' + this.lastName);
}

say.call(person1, 'Hello'); // Hello Jon Kuperman
say.call(person2, 'Hello'); // Hello Kelly King
```

**Apply**

```js
var person1 = {firstName: 'Jon', lastName: 'Kuperman'};
var person2 = {firstName: 'Kelly', lastName: 'King'};

function say(greeting) {
    console.log(greeting + ' ' + this.firstName + ' ' + this.lastName);
}

say.apply(person1, ['Hello']); // Hello Jon Kuperman
say.apply(person2, ['Hello']); // Hello Kelly King
```

**Bind**

```js
var person1 = {firstName: 'Jon', lastName: 'Kuperman'};
var person2 = {firstName: 'Kelly', lastName: 'King'};

function say() {
    console.log('Hello ' + this.firstName + ' ' + this.lastName);
}

var sayHelloJon = say.bind(person1);
var sayHelloKelly = say.bind(person2);

sayHelloJon(); // Hello Jon Kuperman
sayHelloKelly(); // Hello Kelly King
```



总而言之：

bind 会有点不同。它会返回一个新函数。 Call and Apply立即执行当前功能。

同时 bind 还可以做许多事情比如： 

我们可以使用它来管理上面的示例中的函数。我们可以采用一个简单的hello函数并将其转换为helloJon或helloKelly。我们还可以将其用于诸如onClick之类的事件，这些事件我们不知道何时触发，但我们知道我们希望它们具有什么上下文。

```

function hello(name, date){
  console.log(`${name} was working here!!  on ${date}`)
}

let helloWang = hello.bind(this, "wangwang");

helloWang(new Date())

// log
// wangwang was working here!!  on Sun Dec 27 2020 21:35:24 GMT+0800 (GMT+08:00)

```

