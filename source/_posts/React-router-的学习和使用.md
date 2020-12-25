---
title: React-router 的学习和使用
top: false
comments: true
categories:
  - react
tags:
  - react-router
  - react
abbrlink: d32c71e
date: 2020-12-24 11:43:12
---

> 在React 中 处处皆组件！！ Router 这也是一个组件，有点不怎么好用

<!--more-->

## 一： 安装 react-router-dom

```
npm install react-router-dom
```



## 二: 简单使用方法

` 在 src/app.js 中 用以下代码 `

```
import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  useRouteMatch,
  useParams,
  NavLink 
} from "react-router-dom";

import "./App.css"

export default function App() {
  return (
    <Router>
      <div>
        <ul>
          <li>
            <NavLink activeClassName="hurray" to="/">Home</NavLink>
          </li>
          <li>
            <NavLink activeClassName="hurray" to="/about">About</NavLink>
          </li>
          <li>
            <NavLink activeClassName="hurray" to="/topics">Topics</NavLink>
          </li>
        </ul>

        <Switch>
          <Route path="/about">
            <About />
          </Route>
          <Route path="/topics">
            <Topics />
          </Route>
          <Route exact  path="/">
            <Home />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

function Home() {
  return <h2>Home</h2>;
}

function About() {
  return <h2>About</h2>;
}

function Topics() {
  let match = useRouteMatch();

  return (
    <div>
      <h2>Topics</h2>

      <ul>
        <li>
          <NavLink activeClassName="hurray" to={`${match.url}/components`}>Components</NavLink>
        </li>
        <li>
          <NavLink activeClassName="hurray" to={`${match.url}/props-v-state`}>
            Props v. State
          </NavLink>
        </li>
      </ul>

      {/* The Topics page has its own <Switch> with more routes
          that build on the /topics URL path. You can think of the
          2nd <Route> here as an "index" page for all topics, or
          the page that is shown when no topic is selected */}
      <Switch>
        <Route path={`${match.path}/:topicId`}>
          <Topic />
        </Route>
        <Route path={match.path}>
          <h3>Please select a topic.</h3>
        </Route>
      </Switch>
    </div>
  );
}

function Topic() {
  let { topicId } = useParams();
  return <h3>Requested topic ID: {topicId}</h3>;
}
```



## 三： Router 详解

### 3.1  Router 的引入

每个React Router应用程序的核心应该是路由器组件。对于Web项目，react-router-dom提供<BrowserRouter>和<HashRouter>路由器。两者之间的主要区别是它们存储URL和与Web服务器通信的方式。

因此需要在 把根组件包囊在 router 组件内部

```
import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";

function App() {
  return <h1>Hello React Router</h1>;
}

ReactDOM.render(
  <BrowserRouter>
    <App />
  </BrowserRouter>,
  document.getElementById("root")
);
```



### 3.2 Router 的匹配

使用 Switch， Route 这两个组件 来匹配路由。

<Switch>的独特之处在于它专门呈现一条路由。使用<div>的话，每个与位置匹配的<Route>都将包含在内。

```
import React from "react";
import ReactDOM from "react-dom";
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";

function App() {
  return (
    <div>
      <Switch>
        {/* If the current URL is /about, this route is rendered
            while the rest are ignored */}
        <Route path="/about">
          <About />
        </Route>

        {/* Note how these two routes are ordered. The more specific
            path="/contact/:id" comes before path="/contact" so that
            route will render when viewing an individual contact */}
        <Route path="/contact/:id">
          <Contact />
        </Route>
        <Route path="/contact">
          <AllContacts />
        </Route>

        {/* If none of the previous routes render anything,
            this route acts as a fallback.

            Important: A route with path="/" will *always* match
            the URL because all URLs begin with a /. So that's
            why we put this one last of all */}
        <Route path="/">
          <Home />
        </Route>
      </Switch>
    </div>
  );
}

ReactDOM.render(
  <Router>
    <App />
  </Router>,
  document.getElementById("root")
);
```



### 3.3 路由跳转

React Router提供了一个<Link>组件来在您的应用程序中创建链接。无论在何处呈现<Link>，锚点（<a>）都将呈现在HTML文档中。

```
<Link to="/">Home</Link>
// <a href="/">Home</a>


//The <NavLink> is a special type of <Link> that can style itself as “active” when its to prop matches the current location.
<NavLink to="/react" activeClassName="hurray">
  React
</NavLink>

// When the URL is /react, this renders:
// <a href="/react" className="hurray">React</a>

// When it's something else:
// <a href="/react">React</a>
```

