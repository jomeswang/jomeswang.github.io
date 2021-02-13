---
title: JS Generator 生成器和迭代器
top: false
comments: true
categories:
  - JS
tags:
  - JS
abbrlink: d567a06f
date: 2020-12-30 13:41:00
---

> JS的 生成器真的是一个神奇的东西， yield 和  function*（）

<!--more--->

在 JavaScript 中，**迭代器**是一个对象，它定义一个序列，并在终止时可能返回一个返回值。 更具体地说，迭代器是通过使用 `next()` 方法实现 [Iterator protocol](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#The_iterator_protocol) 的任何一个对象，该方法返回具有两个属性的对象： `value`，这是序列中的 next 值；和 `done` ，如果已经迭代到序列中的最后一个值，则它为 `true` 。如果 `value` 和 `done` 一起存在，则它是迭代器的返回值。

一旦创建，迭代器对象可以通过重复调用next（）显式地迭代。 迭代一个迭代器被称为消耗了这个迭代器，因为它通常只能执行一次。 在产生终止值之后，对next（）的额外调用应该继续返回{done：true}。

The [`next()`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Generator/next) 方法也接受一个参数用于修改生成器内部状态。传递给 `next()` 的参数值会被yield接收。要注意的是，传给第一个 `next()` 的值会被忽略。

```

function * generatorFunction(){
  yield;
  foo(yield "I am a good boy!!")
  
}

function foo(x){
  console.log("Hello !!", x);
}

let generator = generatorFunction()
console.log(generator.next());  //  { value: undefined, done: false }
console.log(generator.next());  //  { value: 'I am a good boy!!', done: false }
console.log(generator.next(23)); // { value: undefined, done: true } 23 will be transpoted to yield yield "I am a good boy!!" as the x in the foo fuc
```

