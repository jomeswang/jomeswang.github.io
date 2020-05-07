---
title: 数据分析之Numpy
top: false
comments: true
categories:
  - 数据分析
tags:
  - python
  - 数据分析
abbrlink: aaadb207
date: 2020-05-06 22:13:57
---

>  **NumPy数组是一个多维的数组对象（矩阵），称为**`ndarray`**，具有矢量算术运算能力和复杂的广播能力，并具有执行速度快和节省空间的特点。** 

<!--more-->

## 一：前言

学习Pandas之前先学习numpy，为什么呢？因为numpy的格式为数组样式的，Pandas以Numpy作为基础库，基于Numpy制作的数据分析库。

## 二：内容

### 2.1 数组的创建

> #### ndarray拥有的属性：
>
> 1. `ndim属性`：维度个数
> 2. `shape属性`：维度大小
> 3. `dtype属性`：数据类型

1. #### ndarray的随机创建

![](http://photo.jomeswang.top/20200506231845.png)

> 通过随机抽样 (numpy.random) 生成随机数据。

![](http://photo.jomeswang.top/20200506232326.png)

2. #### ndarray的序列创建

##### 1. `np.array(collection)`

> collection 为 序列型对象(list)、嵌套序列对象(list of list)。

```
In [4]: np.array([range(10), range(10)])
Out[4]:
array([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
       [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]])

```

##### 2. `np.zeros()`

> 指定大小的全0数组。注意：第一个参数是元组，用来指定大小，如(3, 4)。

##### 3. `np.ones()`

> 指定大小的全1数组。注意：第一个参数是元组，用来指定大小，如(3, 4)。

##### 4. `np.empty()`

> 初始化数组，不是总是返回全0，有时返回的是未初始的随机值（内存里的随机值）

##### 5. `np.arange()` 和 `reshape()`

> arange() 类似 python 的 range() ，创建一个一维 ndarray 数组。
>
> reshape() 将 重新调整数组的维数。

##### 6.  `random.shuffle()`

> random.shuffle() 将打乱数组序列（类似于洗牌）。

#### 3. ndarray的数据类型

##### 1. `dtype`参数

> 指定数组的数据类型，类型名+位数，如float64, int32

##### 2. `astype`方法

> 转换数组的数据类型

示例代码（1、2）：

```python
# 初始化3行4列数组，数据类型为float64
zeros_float_arr = np.zeros((3, 4), dtype=np.float64)
print(zeros_float_arr)
print(zeros_float_arr.dtype)

# astype转换数据类型，将已有的数组的数据类型转换为int32
zeros_int_arr = zeros_float_arr.astype(np.int32)
print(zeros_int_arr)
print(zeros_int_arr.dtype)
```

运行结果：

```python
[[ 0.  0.  0.  0.]
 [ 0.  0.  0.  0.]
 [ 0.  0.  0.  0.]]
float64

[[0 0 0 0]
 [0 0 0 0]
 [0 0 0 0]]
int32
```

### 2.2. ndarray的矩阵运算

#### 2.2.1 矩阵的加减乘除

符合矩阵规则的矩阵运算

#### 2.2.2 矩阵运算（点运算）的广播

![](http://photo.jomeswang.top/20200506233924.png)

#### 2.2.3 矩阵的取值（索引和切片）

##### 1. 一维数组的索引与切片

> 与Python的列表索引功能相似

示例代码（1）：

```python
# 一维数组
arr1 = np.arange(10)
print(arr1)
print(arr1[2:5])
```

运行结果：

```python
[0 1 2 3 4 5 6 7 8 9]
[2 3 4]
```

##### 2. 多维数组的索引与切片：

> arr[r1:r2, c1:c2]
>
> arr[1,1] 等价 arr[1][1]
>
> [:] 代表某个维度的数据

示例代码（2）：

```python
# 多维数组
arr2 = np.arange(12).reshape(3,4)
print(arr2)

print(arr2[1])

print(arr2[0:2, 2:])

print(arr2[:, 1:3])
```

运行结果：

```python
[[ 0  1  2  3]
 [ 4  5  6  7]
 [ 8  9 10 11]]

[4 5 6 7]

[[2 3]
 [6 7]]

[[ 1  2]
 [ 5  6]
 [ 9 10]]
```

##### 3. 条件索引

> 布尔值多维数组：arr[condition]，condition也可以是多个条件组合。
>
> 注意，多个条件组合要使用 **& |** 连接，而不是Python的 **and or**。

示例代码（3）：

```python
# 条件索引

# 找出 data_arr 中 2005年后的数据
data_arr = np.random.rand(3,3)
print(data_arr)

year_arr = np.array([[2000, 2001, 2000],
                     [2005, 2002, 2009],
                     [2001, 2003, 2010]])

is_year_after_2005 = year_arr >= 2005
print(is_year_after_2005, is_year_after_2005.dtype)

filtered_arr = data_arr[is_year_after_2005]
print(filtered_arr)

#filtered_arr = data_arr[year_arr >= 2005]
#print(filtered_arr)

# 多个条件
filtered_arr = data_arr[(year_arr <= 2005) & (year_arr % 2 == 0)]
print(filtered_arr)
```

运行结果：

```python
[[ 0.53514038  0.93893429  0.1087513 ]
 [ 0.32076215  0.39820313  0.89765765]
 [ 0.6572177   0.71284822  0.15108756]]

[[False False False]
 [ True False  True]
 [False False  True]] bool

[ 0.32076215  0.89765765  0.15108756]

#[ 0.32076215  0.89765765  0.15108756]

[ 0.53514038  0.1087513   0.39820313]
```

#### 2.2.4 ndarray的维数转换

> 二维数组直接使用转换函数：transpose()
>
> 高维数组转换要指定维度编号参数 (0, 1, 2, …)，注意参数是元组

示例代码：

```python
arr = np.random.rand(2,3)    # 2x3 数组
print(arr)    
print(arr.transpose()) # 转换为 3x2 数组


arr3d = np.random.rand(2,3,4) # 2x3x4 数组，2对应0，3对应1，4对应3
print(arr3d)
print(arr3d.transpose((1,0,2))) # 根据维度编号，转为为 3x2x4 数组
```

运行结果：

```python
# 二维数组转换
# 转换前：
[[ 0.50020075  0.88897914  0.18656499]
 [ 0.32765696  0.94564495  0.16549632]]

# 转换后：
[[ 0.50020075  0.32765696]
 [ 0.88897914  0.94564495]
 [ 0.18656499  0.16549632]]


# 高维数组转换
# 转换前：
[[[ 0.91281153  0.61213743  0.16214062  0.73380458]
  [ 0.45539155  0.04232412  0.82857746  0.35097793]
  [ 0.70418988  0.78075814  0.70963972  0.63774692]]

 [[ 0.17772347  0.64875514  0.48422954  0.86919646]
  [ 0.92771033  0.51518773  0.82679073  0.18469917]
  [ 0.37260457  0.49041953  0.96221477  0.16300198]]]
```

### 2.3 ndarray的元素处理

#### 2.3.1 元素计算函数

1. `ceil()`: 向上最接近的整数，参数是 number 或 array
2. `floor()`: 向下最接近的整数，参数是 number 或 array
3. `rint()`: 四舍五入，参数是 number 或 array
4. `isnan()`: 判断元素是否为 NaN(Not a Number)，参数是 number 或 array
5. `multiply()`: 元素相乘，参数是 number 或 array
6. `divide()`: 元素相除，参数是 number 或 array
7. `abs()`：元素的绝对值，参数是 number 或 array
8. `where(condition, x, y)`: 三元运算符，x if condition else y

示例代码（1、2、3、4、5、6、7）：

```python
# randn() 返回具有标准正态分布的序列。
arr = np.random.randn(2,3)

print(arr)

print(np.ceil(arr))

print(np.floor(arr))

print(np.rint(arr))

print(np.isnan(arr))

print(np.multiply(arr, arr))

print(np.divide(arr, arr))

print(np.where(arr > 0, 1, -1))
```

运行结果：

```python
# print(arr)
[[-0.75803752  0.0314314   1.15323032]
 [ 1.17567832  0.43641395  0.26288021]]

# print(np.ceil(arr))
[[-0.  1.  2.]
 [ 2.  1.  1.]]

# print(np.floor(arr))
[[-1.  0.  1.]
 [ 1.  0.  0.]]

# print(np.rint(arr))
[[-1.  0.  1.]
 [ 1.  0.  0.]]

# print(np.isnan(arr))
[[False False False]
 [False False False]]

# print(np.multiply(arr, arr))
[[  5.16284053e+00   1.77170104e+00   3.04027254e-02]
 [  5.11465231e-03   3.46109263e+00   1.37512421e-02]]

# print(np.divide(arr, arr))
[[ 1.  1.  1.]
 [ 1.  1.  1.]]

# print(np.where(arr > 0, 1, -1))
[[ 1  1 -1]
 [-1  1  1]]
```

#### 2.3.2 元素统计函数

1. `np.mean()`, `np.sum()`：所有元素的平均值，所有元素的和，参数是 number 或 array
2. `np.max()`, `np.min()`：所有元素的最大值，所有元素的最小值，参数是 number 或 array
3. `np.std()`, `np.var()`：所有元素的标准差，所有元素的方差，参数是 number 或 array
4. `np.argmax()`, `np.argmin()`：最大值的下标索引值，最小值的下标索引值，参数是 number 或 array
5. `np.cumsum()`, `np.cumprod()`：返回一个一维数组，每个元素都是之前所有元素的 累加和 和 累乘积，参数是 number 或 array
6. 多维数组默认统计全部维度，`axis`参数可以按指定轴心统计，值为`0`则按列统计，值为`1`则按行统计。

示例代码：

```python
arr = np.arange(12).reshape(3,4)
print(arr)

print(np.cumsum(arr)) # 返回一个一维数组，每个元素都是之前所有元素的 累加和

print(np.sum(arr)) # 所有元素的和

print(np.sum(arr, axis=0)) # 数组的按列统计和

print(np.sum(arr, axis=1)) # 数组的按行统计和
```

运行结果：

```python
# print(arr)
[[ 0  1  2  3]
 [ 4  5  6  7]
 [ 8  9 10 11]]

# print(np.cumsum(arr)) 
[ 0  1  3  6 10 15 21 28 36 45 55 66]

# print(np.sum(arr)) # 所有元素的和
66

# print(np.sum(arr, axis=0)) # 0表示对数组的每一列的统计和
[12 15 18 21]

# print(np.sum(arr, axis=1)) # 1表示数组的每一行的统计和
[ 6 22 38]
```

#### 2.3.3 元素判断函数

1. `np.any()`: 至少有一个元素满足指定条件，返回True
2. `np.all()`: 所有的元素满足指定条件，返回True

示例代码：

```python
arr = np.random.randn(2,3)
print(arr)

print(np.any(arr > 0))
print(np.all(arr > 0))
```

运行结果：

```python
[[ 0.05075769 -1.31919688 -1.80636984]
 [-1.29317016 -1.3336612  -0.19316432]]

True
False
```

#### 2.3.4 元素去重排序函数

`np.unique()`:找到唯一值并返回排序结果，类似于Python的set集合

示例代码：

```python
arr = np.array([[1, 2, 1], [2, 3, 4]])
print(arr)

print(np.unique(arr))
```

运行结果：

```python
[[1 2 1]
 [2 3 4]]

[1 2 3 4]
```

## 三：总结

大家一步步来尝试一下吧！！接下将是Pandas大餐。