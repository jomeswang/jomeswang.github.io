---
title: Typescript interface 和 type 的区别
top: false
comments: false
categories:
  - Typescript
tags:
  - Typescript
abbrlink: cd0b2548
date: 2020-12-20 15:19:16
---

> 学习学习学习！！！！！

<!--more--->

首先，interface只能表示function，object和class类型，type除了这些类型还可以表示其他类型，例如

```
interface A{name:string;
            add:()=>void;
}
interface B{():void}
 
type C=()=>number;
type D=string;
type E={name:string,age:number}
```

interface可以合并同名接口，type不可以

```
interface A{name:string}
interface A{age:number}
var x:A={name:'xx',age:20}
```

interface可以继承interface，继承type，使用extends关键字，type也可继承type，也可继承interface，使用&

```
interface A{name:string}
interface B extends A{age:number}
 
type C={sex:string}
 
interface D extends C{name:string}
 
type E={name:string}&C
 
type F ={age:number}&A
```

还有类可以实现接口，也可以实现type

```
interface A{name:string;add:()=>void}
type B={age:number,add:()=>void}
 
class C implements A{
    name:'xx'
    add(){console.log('类实现接口')}
}
 
class D implements B{
    age:20
    add(){console.log('类实现type')}
}
```

