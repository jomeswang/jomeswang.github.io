---
title: node Koa2 学习
top: false
comments: true
categories:
  - node
tags:
  - node
  - koa2
abbrlink: '9e6407'
date: 2020-12-26 17:32:43
---

> 新的世界的大门又将向我们打开

<!--more-->

## 一： 简介

Express是目前最流行的Node.js框架之一。 Koa是由Express背后的团队创建的新的Web框架。它旨在成为Express的现代且更加简约的版本。它的一些特征是它的支持和对新JavaScript功能（例如生成器和async / await）的依赖。 Koa也没有附带任何中间件，尽管可以使用自定义插件和现有插件进行扩展。



## 二：  引入和使用

router 功能需要自己引入

```
npm i koa koa-router
```

并且最后还要将router 挂载上去。

```
const Koa = require('koa');
const app = new Koa();
const Router = require("koa-router")
const router = new Router()

// logger

app.use(async (ctx, next) => {
  await next();
  const rt = ctx.response.get('X-Response-Time');
  console.log(`${ctx.method} ${ctx.url} - ${rt}`);
});

// x-response-time

app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.set('X-Response-Time', `${ms}ms`);
});

// response

// app.use(async ctx => {
//   ctx.body = 'Hello World';
// });

router.get("/:id", async (ctx)=>{
  ctx.body =  "get" + ctx.params.id 
})
app.use(router.routes());   /*启动路由*/
app.use(router.allowedMethods());
app.listen(3000);
```

