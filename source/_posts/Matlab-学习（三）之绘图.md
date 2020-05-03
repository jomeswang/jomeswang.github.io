---
title: Matlab 学习（三）之绘图
top: false
comments: true
categories:
  - Matlab
tags:
  - Matlab
  - Matlab学习特辑
abbrlink: fa3c0602
date: 2020-04-19 23:17:37
---

## 一：二维绘图

<!--more-->

### 1.1 plot 直角系绘图

首先要先绘图，日常绘图就要先描点，然后连点成线。在Matlab中绘图也是如此。

1. #### plot(x,y)

>  这里 x, y 都是向量，以 x 中的元素为横坐标， y 中的元素为纵坐标，作平面曲线。
> 向量 x, y 的长度必须相同。

![](http://photo.jomeswang.top/20200420115634.png)

2. #### plot(y)

   > 即以下标为横坐标，y 中的元素为纵坐标，等价于：
>
   > x=[1:length(y)];  plot(x,y);

3. #### plot(x,A)

    > 这里 x 是向量，A是矩阵。若 x 的长度与 A 的行数相等，则将 x与 A中的各列相对应，绘制多条平面曲线；否则，若 x  的长度与 A的列数相等，则将 x 与 A 中的各行相对应，绘制多条平面曲线。 。
    >  x的长度必须等于 A 的行数或列数。

   ![](http://photo.jomeswang.top/20200420115915.png)

4. #### plot(x,y,string)

   > 其中 string 是用 单引号 括起来的字符串，用来指定图形的属性（点、线的形状和颜色）
   
   | **线型**                                                     | **点标记**                                                   | **颜色**                                                     |
   | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | **-**-   实线<br/>:   虚线<br/>-.  点划线<br/>--  间断线<br/>     空白 | .   点<br/>o   小圆圈<br/>x   叉子符<br/>+   加号<br/>*   星号<br/>s   方格<br/>d   菱形<br/>^   朝上三角<br/>v   朝下三角<br/>>   朝右三角<br/><   朝左三角<br/>p   五角星<br/>h   六角星 | y   黄色 <br/>m   棕色  <br/>c   青色<br/>r   红色<br/>g   绿色<br/>b   蓝色<br/>w   白色<br/>k   黑色 |

![](http://photo.jomeswang.top/20200420120452.png)

### 1.2 极坐标作图

> polar(theta,r, string)

> 以 theta 为极角， r 是极径作图，string 与上面的一样（可选）

![](http://photo.jomeswang.top/20200420121119.png)

### 1.3 对数图

>  按指数规律变化的数据可用对数坐标表示

1. semilogx(x,y)

   创建单对数坐标图，x 轴为对数坐标，y轴为线性坐标

2. semilogy(x,y)

   创建单对数坐标图，x 轴为线性坐标，y轴为对数坐标

3. loglog(x,y)

   创建双对数坐标图，x 轴、y轴均为对数坐标

![](http://photo.jomeswang.top/20200420131213.png)

4. ### 图表

   **MATLAB includes a whole family of bar graphs and pie charts**
   bar(x) – vertical bar graph
   barh(x) – horizontal bar graph
   bar3(x) – 3-D vertical bar graph
   bar3h(x) – 3-D horizontal bar graph
   pie(x) – pie chart
   pie3(x) – 3-D pie chart

   ![](http://photo.jomeswang.top/20200420131801.png)

5. ### 双y轴图

   >  将两个二维曲线输出到同一坐标图中 

+ plotyy(x1,y1,x2,y2)

+ plotyy(x1,y1,x2,y2,function)

   function是指定的绘图函数，可取 plot, stem, semilogx, semilogy, loglog等

![](http://photo.jomeswang.top/20200420133346.png)

## 二：图像属性

### 2.1 添加标题

> title('text', 'Property1',  value1,  ' Property2', value2, ...)
>
> Property: linewidth, markersize, fontsize, fontweight, fontname, …

![](http://photo.jomeswang.top/20200420142426.png)

### 2.2 添加坐标轴标注

> xlabel('text')
>
> ylabel('text')

![](http://photo.jomeswang.top/20200420142355.png)

### 2.3坐标轴控制

> axis([xmin, xmax, ymin, ymax, zmin, zmax])
>
> 作用：指定坐标轴的显示范围

 其它调用方式：

axis auto       	自动模式，使得图形的坐标满足图中的一切元素
axis equal  	各坐标轴采用等长刻度
axis square 	使绘图区域为正方形
axis on/off	恢复/取消对坐标轴的一切设置
axis manual	以当前的坐标限制图形的绘制（多图时）
  …  …                更多参见 axis 的联机帮助

### 2.4绘制多个函数图像

1. plot(x1,y1,s1,x2,y2,s2, ... ,xn,yn,sn)

   s1，s2,..属性选项，可以省略

2. hold on

   ```
   hold on
   plot(x1,y1,s1)
   plot(x2,y2,s2)
   ...
   plot(xn,yn,sn)
   hold off
   ```

### 2.5 添加图例

> legend(string1,string2, ...)

```
>> x = 0 : pi/10 : 4*pi;
>> y1 = cos(x); 
>> y2 = sin(x);
>> plot(x,y1,x,y2);
>> legend('cos(x)','sin(x)');
```

![](http://photo.jomeswang.top/20200420142042.png)

### 2.6 添加文本

>  在任何指定的地方添加文本
>
> text(x,y,string) % 该函数需要事先设定放置的位置
>
> gtext(string)  % 改函数可以在图像中用鼠标选择放置的位置

![](http://photo.jomeswang.top/20200420141910.png)

### 2.7划分绘图窗口

> subplot(m,n,p)
>
> 将一个绘图窗口分割成 m*n 个子区域，并 按行 从左至右 依次编号 ，p 表示第 p 个绘图子区域。

### 2.8 其他相关命令

![](http://photo.jomeswang.top/20200420140747.png)

## 三：三维视图

### 3.1 三维曲线

>  plot3（x,y,z）
>
> 设三维曲线的参数方程为：x=x(t)，y=y(t)，z=z(t)，
>  plot3 只能绘制参数方程表示的三维曲线 
>  plot3 的用法与 plot 类似

```
>> t = 0 : pi/100 : 10*pi;
>> x = sin(t); 
>> y = cos(t); 
>> z = 2*t;
>> plot3(x,y,z);
```

![](http://photo.jomeswang.top/20200420143602.png)

### 3.2 三维曲面

![](http://photo.jomeswang.top/20200420143706.png)

1. ####  网格生成函数 ：[ X, Y ] =  meshgrid(x,y)（）

   > **meshgrid用于从数组a和b产生网格。生成的网格矩阵A和B大小是相同的。它也可以是更高维的。这里的大小指的是，size()函数的大小，size()函数返回的是一个向量， 那么size(A) = size(B).**
   >
   > 若 x = y, 则可简写为：  [ X, Y ] = meshgrid(x)
   >
   > [A,B]=Meshgrid(a,b)
   > 生成size(b)Xsize(a)大小的矩阵A和B。它相当于a从一行重复增加到size(b)行，把b转置成一列再重复增加到size(a)列。
   >
   > 因此命令等效于：
   >
   > ```
   > `A=ones(size(b))*a;``B=b'*ones(size(a))`
   > ```

![](http://photo.jomeswang.top/20200420145229.png)

2. #### 绘图命令 mesh(X,Y,Z)

> 绘制由矩阵 X, Y, Z  所确定的曲面网格图

![](http://photo.jomeswang.top/20200420145703.png)

+  显式方程：z=z(x,y), a=< x >=b, c=< y >=d

  > x=a:hx:b; y=c:hy:d;
  > [X,Y]=meshgrid(x,y);
  > Z=z(X,Y);
  > mesh(X,Y,Z)	

+  参数方程：x=x(u,v),y=y(u,v),x=z(u,v)  a=< u >=b, c=< v >=d

  > u=a:hu:b; y=c:hv:d;
  > [U,V]=meshgrid(u,v);
  > X=x(U,V); Y=y(U,V); Z=z(U,V);
  > mesh(X,Y,Z)

#### 3. meshc,meshz![](http://photo.jomeswang.top/20200420150258.png)

4.  空间曲面其它作图命令 

    surf(X,Y,Z)    绘制由矩阵 X,Y,Z 所确定的曲面图，参数含义同 mesh

> mesh 绘制网格图，surf 绘制表面着色的曲面图

![](http://photo.jomeswang.top/20200420151304.png)

 contour(X,Y,Z)     绘制由矩阵 X,Y,Z 所确定的等高线

pcolor(X,Y,Z)      绘制由矩阵 X,Y,Z 所确定的伪色图（带栅格的二维阴影图）

## 四：符号画图

> 符号作图时要注意 使用 单引号！

![](http://photo.jomeswang.top/20200420152037.png)

![](http://photo.jomeswang.top/20200420152117.png)

![](http://photo.jomeswang.top/20200420152137.png)