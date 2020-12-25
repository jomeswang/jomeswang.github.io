---
title: 为react 项目添加 scss 和 ts
top: false
comments: false
categories:
  - react
tags:
  - react
  - webpack
  - sass
  - typescript
abbrlink: f84ce3f2
date: 2020-12-23 19:33:55
---

> # How to Set Up a React Project Using Webpack, TypeScript, and Sass

<!--more--->

![Image for post](https://miro.medium.com/max/5472/0*QJHASp4Lqspc4Gt8)

Photo by [Artem Sapegin](https://unsplash.com/@sapegin?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)

I’ve always used [Create-React-App](https://github.com/facebook/create-react-app) (CRA) when I needed to make a project. I needed to make another React project, but this time I didn’t want to use CRA. I was stuck with many problems and it took a lot of time to get through them. So, let me tell you what I did and how I got through it.

## Prior reading

If you aren’t aware of what Webpack is, go to the [official Webpack site](https://webpack.js.org/concepts/) and read about it.

# React Project Setup

First, you need to install some packages for the Webpack or React.

```
npm i -D webpack webpack-cli @babel/core @babel/preset-env @babel/preset-react babel-loadernpm i -S react react-dom
```

Webpack is the code bundler for JavaScript, CSS and HTML files. It reduces the size of your project by putting everything into a few files.

```
touch webpack.config.js
```

Now, create the configuration file for Webpack. This will be used automatically by the Webpack once you run the program.

```
const path = require('path');module.exports = {
  entry: path.resolve(__dirname, 'src', 'index.jsx'),
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  mode: "development",
  resolve: {
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        use: ['babel-loader']
      }
    ]
  }
};
```

- `entry` — the file to be used at first once Webpack starts to work.
- `output `— the file to be exported by the Webpack process.
- `resolve.extensions` — the file extensions to be used by Webpack.
- `module` — the rules Webpack will use when it works on the files.

We will check if Webpack can recognize the React files before adopting TypeScript.

```
mkdir src dist
touch src/index.jsx
```

And write this code into `index.jsx`:

```
import React from 'react';
import ReactDOM from 'react-dom';const App = () => {
  return <h1>Hello Wepack!</h1>;
};ReactDOM.render(<App />, document.getElementById('root'));
```

This is the simple first React component, which prints “Hello Webpack!”. You need to use `react-dom` to hook React components into the HTML file. But we don’t have any HTML files yet.

```
npm i -D html-webpack-plugin html-loadermkdir public
touch public/index.html
```

<iframe src="https://medium.com/media/b478c684c8d3b465a2a5e196e4cbfea7" allowfullscreen="" frameborder="0" height="369" width="680" title="medium_index.html" class="t u v iz aj" scrolling="auto" style="box-sizing: inherit; position: absolute; top: 0px; left: 0px; width: 680px; height: 369px;"></iframe>

To make Webpack recognize and use this file, add more information in `webpack.config.js`:

<iframe src="https://medium.com/media/39b3679dc7831e68c98e5e9475034e6e" allowfullscreen="" frameborder="0" height="391" width="680" title="" class="t u v iz aj" scrolling="auto" style="box-sizing: inherit; position: absolute; top: 0px; left: 0px; width: 680px; height: 391px;"></iframe>

And add the script in `package.json`.

```
"scripts": {
  "build": "webpack"
}
```

If you run this script, you’ll see the following error:

![Image for post](https://miro.medium.com/max/60/1*xr5cmCeXHG4OVkuA47OPvA.png?q=20)

![Image for post](https://miro.medium.com/max/1392/1*xr5cmCeXHG4OVkuA47OPvA.png)

Webpack gives you an error, but why?

This is because you didn’t let Babel know what plugins it should use to transpile your React code to the plain JavaScript code.

```
touch .babelrc
```

Write this in `.babelrc`:

```
{
  "presets": ["@babel/preset-env", "@babel/preset-react"]
}
```

`@babel/preset-env` lets you use the latest JavaScript without having a headache of what plugins you should use. `@babel/preset-react` is a plugin that can interpret the JSX syntax and transforms it into JavaScript DOM syntax.

One thing you ought to remember is that Babel reads the “presets” configuration from the right to the left. So, React JSX should be transformed into DOM syntax first by `@babel/preset-react`, then it can be transformed into the appropriate JavaScript version by `@babel/preset-env`.

```
npm i -D webpack-dev-server
```

Now, let’s see if the code can be run successfully. Install the package that allows you to run your code in the dev server. Add this to `webpack.config.js`:

```
module.exports = {
  ...,
  devServer: {
    contentBase: path.resolve(__dirname, 'dist'),
    port: 8888
  }
}
```

To run the dev server more conveniently, add the new script:

```
// package.json"scripts": {
  ...,
  "dev": "webpack-dev-server --open"
}
```

Now if you run the script, your code should be run well on port 8888.

```
npm run dev
```

![Image for post](https://miro.medium.com/max/60/1*ugyMi_bCjdtSXBr_87mbiA.png?q=20)

![Image for post](https://miro.medium.com/max/476/1*ugyMi_bCjdtSXBr_87mbiA.png)

The code should be run successfully

# Use SASS

Now, it’s time to adopt the SASS in the project. For this, you should install the appropriate loader for SASS.

```
npm i -D style-loader css-loader sass-loader node-sass
```

- `style-loader `— Inject CSS to the DOM
- `css-loader `— Takes the CSS files and returns the CSS with `imports` and `url(...)` for Webpack
- `sass-loader` — Takes the Sass/SCSS file and compiles to the CSS
- `node-sass `— You need this is the required package to load your SCSS files

And add this to your `webpack.config.js`:

<iframe src="https://medium.com/media/9a7530ecbcd6ca4ee7932980fc37cc8e" allowfullscreen="" frameborder="0" height="457" width="680" title="" class="t u v iz aj" scrolling="auto" style="box-sizing: inherit; position: absolute; top: 0px; left: 0px; width: 680px; height: 456.984px;"></iframe>

In case you want to use the module system with SASS, add `modules: true` in the `options` property that will allow you to use it.

Create the SASS file.

```
touch src/index.scss
```

It will be very simple:

```
// index.scss
.title { 
  color: red;
}// index.jsx
...
import styles from './index.scss';
```

All you need to do is to add it as the class name of the DOM:

```
<h1 className={styles.title}>Hello Webpack!</h1>
```

Now you can see the color is changed:

![Image for post](https://miro.medium.com/max/60/1*WrEF2WajeUaFpiuTY705jA.png?q=20)

![Image for post](https://miro.medium.com/max/472/1*WrEF2WajeUaFpiuTY705jA.png)

The color is changed

# Use TypeScript

Install Typescript and its loader for Webpack.

```
npm i -D typescript ts-loader @types/react @types/react-dom
```

There are a few changes in `webpack.config.js` to use TypeScript.

First, you should change the loader for `.jsx`.

```
{
  test: /\.tsx?$/,
  use: ['ts-loader']
}
```

`.jsx` → `.tsx` and `babel-loader` → `ts-loader` .

Secondly, change the extensions:

```
resolve: {
  extensions: ['.js', '.ts', '.tsx']
}
['.js', '.jsx']` → `['.js', '.ts', '.tsx']
```

You should still need `'.js'` so that Webpack can recognize the transpiled JavaScript files.

Finally, change the entry point:

```
entry: path.resolve(__dirname, 'src', 'index.tsx')
'index.jsx'` → `'index.tsx'
```

And change the file name to `index.tsx`.

Then you’ll encounter this error:

![Image for post](https://miro.medium.com/max/60/1*gHYdGc-E7pQrAdU6w-Rclg.png?q=20)

![Image for post](https://miro.medium.com/max/956/1*gHYdGc-E7pQrAdU6w-Rclg.png)

This is because TypeScript in your project doesn’t know where `index.scss` is. You can resolve this problem simply by creating the configuration file for TypeSciprt and a little extra setup.

```
touch tsconfig.json
```

TypeScript automatically looks for `tsconfig.json` from the root directory of your project, unless you specify its location.

<iframe src="https://medium.com/media/54c8c85e1d0f71b3bf362cc8dddac213" allowfullscreen="" frameborder="0" height="457" width="680" title="medium_typescript_webpack_config.json" class="t u v iz aj" scrolling="auto" style="box-sizing: inherit; position: absolute; top: 0px; left: 0px; width: 680px; height: 456.984px;"></iframe>

Create a new folder and make a file in it.

```
mkdir src/typings
touch src/typings/scss.d.ts
```

`scss.d.ts` is a typed file. TypeScript can read and understand what types it should also remember.

```
// scss.d.ts
declare module '*.css' {
  const content: { [className: string]: string; };
  export default content;
}declare module '*.scss' {
  const content: { [className: string]: string; };
  export default content;
}
```

Now, you’ll see the error is gone. Now run the server and see if the result is the same.

# Bonus — Hash ClassNames

In development mode, it would be quite inconvenient to work with the CSS class names transformed into the hash strings.

![Image for post](https://miro.medium.com/max/60/1*qPIcxN0EA7SXMjiCupVUHw.png?q=20)

![Image for post](https://miro.medium.com/max/566/1*qPIcxN0EA7SXMjiCupVUHw.png)

Hash strings always get in the way of your working journey

Actually, you can tell Webpack not to create a hash name for CSS.

Change the `module` part of `css-loader` in `webpack.config.js` as follows.

```
{
  loader: 'css-loader',
    options: {
      modules: {
        localIdentName: '[local]'
      }
    }
}
```

Now you’ll see the non-hash strings.

![Image for post](https://miro.medium.com/max/60/1*_k5Zft_4aF-0sWo5KyhCrA.png?q=20)

![Image for post](https://miro.medium.com/max/432/1*_k5Zft_4aF-0sWo5KyhCrA.png)

Now it’s much better!