---
title: 初始化React 项目 使用webpack和Babel
top: false
comments: true
categories:
  - react
tags:
  - webpack
abbrlink: 1a1b343a
date: 2020-12-23 16:55:52
---

> 今天建react 项目的时候发现

<!--more--->

在一个典型的React项目中，我们使用Babel和Webpack。 Babel用于将JSX和ES6转换为纯ES5代码。 Webpack用作捆绑程序。在这一篇文章中，我们从头开始对React 项目的建立。

首先 创建一个 `react-starter` 的文件夹。 之后在文件夹内部操作。

## 一： 初始化 Package.json 文件夹

在Node项目中，package.json文件存储有关项目的信息，例如其名称，许可证，脚本，依赖项等。我们可以使用这一条命令来创建package.json文件。

```
npm init -y
```

-y标志用于设置默认值。现在，在项目文件夹中创建了一个package.json文件，内容如下。

```
{
  "name": "react-starter",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

## 二： 创建 资源文件夹

因此，首先在根目录中创建一个文件夹src。现在，该文件夹将包含所有使用JSX编写的React组件代码，使用SCSS编写的样式以及用于呈现React组件的模板HTML。当我们构建项目时，所有的JSX将被转换为JavaScript，所有的SCSS将被转换为纯CSS，HTML将使用所需的文件引用进行更新，并复制到/ dist文件夹中。

创建一个 `src/index.html` 文件

```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>React Starter</title>
</head>
<body>
  <div id="root"></div>
</body>
</html>
```

关于此index.html源文件的几点要点。即将创建的React组件将呈现在div标签内。目前，我们在html中看不到任何对JavaScript或CSS文件的引用。这些将在构建步骤中添加到生成的html文件中。怎么样？我们稍后会看到。



## 三： React 组件

 `src/index.js`  中创建一个 这样的一个文件  写入以下内容

```
import React from "react";
import ReactDOM from "react-dom";

const App = () => {
  return <h1>Hello React 16,Webpack 4 & Babel 7!</h1>;
};

ReactDOM.render(<App />, document.getElementById("root"));
```



下载如下NPM包：

```
npm install react react-dom --save
```



## 四：配置Webpack 

到目前为止，我们的源代码位于/ src文件夹中。我们没有可以部署到服务器的任何文件。如果仅将index.html和index.js复制到nginx或Apache之类的Web服务器，会发生什么情况？它只是在浏览器中呈现index.html。由于没有引用index.js，因此将其忽略。

因此，我们需要有人缝制两个文件并将其设置为可在/ dist文件夹中进行部署。有人是Webpack。 Webpack是捆绑器。简单来说，我们可以说Webpack将项目的所有依赖项都包装到一个捆绑文件中，并将其放置在/ dist文件夹中。

这是我们为什么要安装Webpack。

```
npm install --save-dev webpack
```

安装webpack程序包后，我们需要向webpack提供操作说明。为此，我们需要在项目根目录中创建webpack.config.js文件。 Webpack总是检查此文件以了解如何捆绑项目。

在项目根目录中创建webpack.config.js文件。粘贴以下内容。

```
var path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js'
  }
};
```



## 五： 运行 webpack

让我们在 package.json 中创建相应的脚本吧！

```
"scripts": {
  "start": "webpack"
}
```

然后再 输入 

```
npm run start
```

来启动项目。

但会产生这样的一个错误

```
One CLI for webpack must be installed.
...
You need to install 'webpack-cli' to use webpack via CLI.
```

这一个错误 告诉我们， 我们需要去安装 这样的一个包  `webpack-cli`

```
npm i webpack-cli -g
```

 这里需要全局安装才行！！！！

之后我们 再次使用  `npm start`  命令来启动

但是 报了以下的错误

```
Module parse failed: Unexpected token (5:9)
You may need an appropriate loader to handle this file type, currently no loaders are configured to process this file. See https://webpack.js.org/concepts#loaders
```

 说 webpack不认识 这样的 jsx 语法。

 所以需要有一个工具， 来将 JSX 的语法转为 JS的语法。 因此 我们就有了 Babel 的这样一个工具。



## 六： 配置Babel 

Babel是一个编译器，这意味着它可以将一种类型的代码转换为另一种类型。在我们的项目中，我们使用Babel将JSX转换为JavaScript。

Babel可以单独使用，也可以将JSX转换为JavaScript。但是，我们已经完成了将文件捆绑到Webpack的工作。因此，为了使webpack使用Babel处理JSX文件，Webpack需要babel-loader。

babel-loader只是将Babel功能加载到webpack。它没有任何其他权力。因此，为了使babel-loader正常工作，我们需要安装核心babel软件包@ babel / core。我们还需要安装@ babel / preset-env @ babel / preset-react分别将ES6和JSX转换为ES5。

```
npm i @babel/core babel-loader @babel/preset-env @babel/preset-react --save-dev
```

现在 所有的 Babel 包都已经安装好了， 但是 我们 还没有告诉 webpack 去加载这一个 Babel 去加载JS 文件， 因此 我们需要在 `webpack.config.js` 中去添加以下内容

```
module: {
  rules: [
    {
      test: /\.(js|jsx)$/,
      exclude: /node_modules/,
      use: {
        loader: "babel-loader"
      }
    } 
  ]
}
```

上面的代码在webpack配置文件中设置了一条规则。该规则适用于.js或.jsx文件，不包括node_modules文件夹中的文件。由于存在此规则，因此每当webpack需要将JavaScript文件或JSX文件添加到包中时，它都会使用babel来转译代码，然后将输出添加到包中。



Webpack使用babel-loader调用babel。 Babel需要知道它需要具备的所有功能，换句话说，需要定义所有预设。为此，我们在项目根目录中创建一个`.babelrc`文件，并添加以下文本。

```
{ "presets": ["@babel/preset-env", "@babel/preset-react"] }
```

现在让我们转到终端并运行npm start。这次，webpack成功创建了bundle.js并将其放置在/ dist文件夹中。我们可以在控制台中看到类似下面的输出。

![](http://photo.jomeswang.top/20201223190635.png)



## 七： 配置 HtmlWebpackPlugin 来产生 html 文件

目前的状态是，我们现在在/ dist文件夹中有一个bundle.js。 但 dist文件夹中没有要部署的HTML文件。在构建过程中，我们希望Webpack在/ dist文件夹中创建一个HTML文件来加载bundle.js文件。 HtmlWebpackPlugin是一个webpack插件，可以在此处为我们提供帮助。首先使用以下命令安装它：

```
npm install --save-dev html-webpack-plugin
```

当我们安装好之后，我们需要去 修改  `webpack.config.js` 文件来加载这一个插件

```
var HtmlWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
  entry: './src/index.js',
  //...
  module: { /*...*/ },
  plugins: [new HtmlWebpackPlugin({
    template: './src/index.html'
  })]
}
```

在这里，我们将HtmlWebpackPlugin添加到webpack.config.js中的plugins数组。插件接受模板选项，我们可以在其中指定已创建的源模板html文件。

现在，当我们运行npm start时，webpack在/ dist文件夹中同时创建bundle.js和index.html。生成的index.html文件包含对bundle.js的引用。

我们可以在浏览器中打开index.html文件来查看我们的React组件！



## 八： 配置 Webpackdevserver

我们的项目运行良好。但是在开发过程中，每次我们需要运行webpack命令并等待构建完成。然后在浏览器中打开html文件以查看输出。这很费时间。Webpack有自己的Web服务器，称为webpack-dev-server。如果源文件中有任何文件更改，它将自动以新更改刷新浏览器。首先让我们安装webpack-dev-server。

```
npm i webpack-dev-server --save-dev
```

然后我们修改    `package.json` 文件来加载这一个配置。

```
"scripts": {
  "start": "webpack serve",
  "build": "webpack"
}
```

然后还要  `webpack.config.js`  修改端口号和配置热重载  在  里面添加多这一个属性 与 plugins 并列。

```
  devServer: {
    open: true,
    port: 3000,
    hot: true,
  }
```

之后 就可以在 命令行中输入 `npm start` 来运行啦。

##  九： 总结

现在我们有了一个代码库，可以开始尝试任何React项目。这只是一个开始。在投入实际生产之前，可以做很多改进。





博文源地址：  https://backbencher.dev/create-react-starter-webpack-babel

仓库代码： https://github.com/jomeswang/react-webpack-babel-test