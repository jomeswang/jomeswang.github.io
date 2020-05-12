---
title: 数据分析之Pandas
top: false
comments: true
categories:
  - 数据分析
tags:
  - 数据分析
  - python
abbrlink: a2fd99a8
date: 2020-05-07 11:51:13
---

> Pandas的名称来自于面板数据（panel data）和Python数据分析（data analysis）。
>
> Pandas是一个强大的分析结构化数据的工具集，基于NumPy构建，提供了 **高级数据结构** 和 **数据操作工具**，它是使Python成为强大而高效的数据分析环境的重要因素之一

<!--more-->

## 一：数据结构

```python
import pandas as pd
```

Pandas有两个最主要也是最重要的数据结构： **Series** 和 **DataFrame**

### 1.1 	Series

Series是一种类似于一维数组的 **对象**，由一组数据（各种NumPy数据类型）以及一组与之对应的索引（数据标签）组成。

- 类似一维数组的对象
- 由数据和索引组成
  - 索引(index)在左，数据(values)在右
  - 索引是自动创建的

![](http://photo.jomeswang.top/20200507222352.png)

#### 1. 通过list构建Series

> ser_obj = pd.Series(range(10))

示例代码：

```python
# 通过list构建Series
ser_obj = pd.Series(range(10, 20))
print(ser_obj.head(3))

print(type(ser_obj))
```

运行结果：

```python
0    10
1    11
2    12
dtype: int64

<class 'pandas.core.series.Series'>
```

#### 2. 获取数据和索引

> ser_obj.index 和 ser_obj.values

示例代码：

```python
# 获取数据
print(ser_obj.values)

# 获取索引
print(ser_obj.index)
```

运行结果：

```python
[10 11 12 13 14 15 16 17 18 19]
RangeIndex(start=0, stop=10, step=1)
```

#### 3. 通过索引获取数据

> ser_obj[idx]

示例代码：

```python
#通过索引获取数据
print(ser_obj[0])
print(ser_obj[8])
```

运行结果：

```python
10
18
```

#### 4. 索引与数据的对应关系不被运算结果影响

示例代码：

```python
# 索引与数据的对应关系不被运算结果影响
print(ser_obj * 2)
print(ser_obj > 15)
```

运行结果：

```python
0    20
1    22
2    24
3    26
4    28
5    30
6    32
7    34
8    36
9    38
dtype: int64

0    False
1    False
2    False
3    False
4    False
5    False
6     True
7     True
8     True
9     True
dtype: bool
```

#### 5. 通过dict构建Series

示例代码：

```python
# 通过dict构建Series
year_data = {2001: 17.8, 2002: 20.1, 2003: 16.5}
ser_obj2 = pd.Series(year_data)
print(ser_obj2.head())
print(ser_obj2.index)
```

运行结果：

```python
2001    17.8
2002    20.1
2003    16.5
dtype: float64
Int64Index([2001, 2002, 2003], dtype='int64')
```

#### name属性

> 对象名：ser_obj.name
>
> 对象索引名：ser_obj.index.name

示例代码：

```python
# name属性
ser_obj2.name = 'temp'
ser_obj2.index.name = 'year'
print(ser_obj2.head())
```

运行结果：

```python
year
2001    17.8
2002    20.1
2003    16.5
Name: temp, dtype: float64
```



### 1.2 DataFrame

DataFrame是一个表格型的数据结构，它含有一组有序的列，每列可以是不同类型的值。DataFrame既有行索引也有列索引，它可以被看做是由Series组成的字典（共用同一个索引），数据是以二维结构存放的。

- 类似多维数组/表格数据 (如，excel, R中的data.frame)
- 每列数据可以是不同的类型
- 索引包括列索引和行索引

![](http://photo.jomeswang.top/20200507222658.png)

#### 1. 通过ndarray构建DataFrame

示例代码：

```python
import numpy as np

# 通过ndarray构建DataFrame
array = np.random.randn(5,4)
print(array)

df_obj = pd.DataFrame(array)
print(df_obj.head())
```

运行结果：

```python
[[ 0.83500594 -1.49290138 -0.53120106 -0.11313932]
 [ 0.64629762 -0.36779941  0.08011084  0.60080495]
 [-1.23458522  0.33409674 -0.58778195 -0.73610573]
 [-1.47651414  0.99400187  0.21001995 -0.90515656]
 [ 0.56669419  1.38238348 -0.49099007  1.94484598]]

          0         1         2         3
0  0.835006 -1.492901 -0.531201 -0.113139
1  0.646298 -0.367799  0.080111  0.600805
2 -1.234585  0.334097 -0.587782 -0.736106
3 -1.476514  0.994002  0.210020 -0.905157
4  0.566694  1.382383 -0.490990  1.944846
```

#### 2. 通过dict构建DataFrame

示例代码：

```python
# 通过dict构建DataFrame
dict_data = {'A': 1, 
             'B': pd.Timestamp('20170426'),
             'C': pd.Series(1, index=list(range(4)),dtype='float32'),
             'D': np.array([3] * 4,dtype='int32'),
             'E': ["Python","Java","C++","C"],
             'F': 'ITCast' }
#print dict_data
df_obj2 = pd.DataFrame(dict_data)
print(df_obj2)
```

运行结果：

```python
   A          B    C  D       E       F
0  1 2017-04-26  1.0  3  Python  ITCast
1  1 2017-04-26  1.0  3    Java  ITCast
2  1 2017-04-26  1.0  3     C++  ITCast
3  1 2017-04-26  1.0  3       C  ITCast
```

#### 3. 通过列索引获取列数据（Series类型）

> df_obj[col_idx] 或 df_obj.col_idx

示例代码：

```python
# 通过列索引获取列数据
print(df_obj2['A'])
print(type(df_obj2['A']))

print(df_obj2.A)
```

运行结果：

```python
0    1.0
1    1.0
2    1.0
3    1.0
Name: A, dtype: float64
<class 'pandas.core.series.Series'>
0    1.0
1    1.0
2    1.0
3    1.0
Name: A, dtype: float64
```

#### 4. 增加列数据

> df_obj[new_col_idx] = data
>
> 类似Python的 dict添加key-value

示例代码：

```python
# 增加列
df_obj2['G'] = df_obj2['D'] + 4
print(df_obj2.head())
```

运行结果：

```python
     A          B    C  D       E       F  G
0  1.0 2017-01-02  1.0  3  Python  ITCast  7
1  1.0 2017-01-02  1.0  3    Java  ITCast  7
2  1.0 2017-01-02  1.0  3     C++  ITCast  7
3  1.0 2017-01-02  1.0  3       C  ITCast  7
```

#### 5. 删除列

> del df_obj[col_idx]

示例代码：

```python
# 删除列
del(df_obj2['G'] )
print(df_obj2.head())
```

运行结果：

```python
     A          B    C  D       E       F
0  1.0 2017-01-02  1.0  3  Python  ITCast
1  1.0 2017-01-02  1.0  3    Java  ITCast
2  1.0 2017-01-02  1.0  3     C++  ITCast
3  1.0 2017-01-02  1.0  3       C  ITCast
```

## 二：索引操作

### 2.1 索引对象Index

#### 1. Series和DataFrame中的索引都是Index对象

示例代码：

```python
print(type(ser_obj.index))
print(type(df_obj2.index))

print(df_obj2.index)
```

运行结果：

```python
<class 'pandas.indexes.range.RangeIndex'>
<class 'pandas.indexes.numeric.Int64Index'>
Int64Index([0, 1, 2, 3], dtype='int64')
```

#### 2. 索引对象不可变，保证了数据的安全

示例代码：

```python
# 索引对象不可变
df_obj2.index[0] = 2
```

运行结果：

```python
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-23-7f40a356d7d1> in <module>()
      1 # 索引对象不可变
----> 2 df_obj2.index[0] = 2

/Users/Power/anaconda/lib/python3.6/site-packages/pandas/indexes/base.py in __setitem__(self, key, value)
   1402 
   1403     def __setitem__(self, key, value):
-> 1404         raise TypeError("Index does not support mutable operations")
   1405 
   1406     def __getitem__(self, key):

TypeError: Index does not support mutable operations
```

#### 常见的Index种类

- Index，索引
- Int64Index，整数索引
- MultiIndex，层级索引
- DatetimeIndex，时间戳类型

### 2.2 Series索引

#### 1. index 指定行索引名

示例代码：

```python
ser_obj = pd.Series(range(5), index = ['a', 'b', 'c', 'd', 'e'])
print(ser_obj.head())
```

运行结果：

```python
a    0
b    1
c    2
d    3
e    4
dtype: int64
```

#### 2. 行索引

> ser_obj[‘label’], ser_obj[pos]

示例代码：

```python
# 行索引
print(ser_obj['b'])
print(ser_obj[2])
```

运行结果：

```python
1
2
```

#### 3. 切片索引

> ser_obj[2:4], ser_obj[‘label1’: ’label3’]
>
> 注意，按索引名切片操作时，是包含终止索引的。

示例代码：

```python
# 切片索引
print(ser_obj[1:3])
print(ser_obj['b':'d'])
```

运行结果：

```python
b    1
c    2
dtype: int64
b    1
c    2
d    3
dtype: int64
```

#### 4. 不连续索引

> ser_obj[[‘label1’, ’label2’, ‘label3’]]

示例代码：

```python
# 不连续索引
print(ser_obj[[0, 2, 4]])
print(ser_obj[['a', 'e']])
```

运行结果：

```python
a    0
c    2
e    4
dtype: int64
a    0
e    4
dtype: int64
```

#### 5. 布尔索引

示例代码：

```python
# 布尔索引
ser_bool = ser_obj > 2
print(ser_bool)
print(ser_obj[ser_bool])

print(ser_obj[ser_obj > 2])
```

运行结果：

```python
a    False
b    False
c    False
d     True
e     True
dtype: bool
d    3
e    4
dtype: int64
d    3
e    4
dtype: int64
```

### 2. 3 DataFrame索引

#### 1. columns 指定列索引名

示例代码：

```python
import numpy as np

df_obj = pd.DataFrame(np.random.randn(5,4), columns = ['a', 'b', 'c', 'd'])
print(df_obj.head())
```

运行结果：

```python
          a         b         c         d
0 -0.241678  0.621589  0.843546 -0.383105
1 -0.526918 -0.485325  1.124420 -0.653144
2 -1.074163  0.939324 -0.309822 -0.209149
3 -0.716816  1.844654 -2.123637 -1.323484
4  0.368212 -0.910324  0.064703  0.486016
```

![](http://photo.jomeswang.top/20200507223242.png)

#### 2. 列索引

> df_obj[[‘label’]]

示例代码：

```python
# 列索引
print(df_obj['a']) # 返回Series类型
print(df_obj[[0]]) # 返回DataFrame类型
print(type(df_obj[[0]])) # 返回DataFrame类型
```

运行结果：

```python
0   -0.241678
1   -0.526918
2   -1.074163
3   -0.716816
4    0.368212
Name: a, dtype: float64
<class 'pandas.core.frame.DataFrame'>
```

#### 3. 不连续索引

> df_obj[[‘label1’, ‘label2’]]

示例代码：

```python
# 不连续索引
print(df_obj[['a','c']])
print(df_obj[[1, 3]])
```

运行结果：

```python
          a         c
0 -0.241678  0.843546
1 -0.526918  1.124420
2 -1.074163 -0.309822
3 -0.716816 -2.123637
4  0.368212  0.064703
          b         d
0  0.621589 -0.383105
1 -0.485325 -0.653144
2  0.939324 -0.209149
3  1.844654 -1.323484
4 -0.910324  0.486016
```

### 2.4  高级索引：标签、位置和混合

Pandas的高级索引有3种

#### 1. loc 标签索引

> DataFrame 不能直接切片，可以通过loc来做切片
>
> loc是基于标签名的索引，也就是我们自定义的索引名

示例代码：

```python
# 标签索引 loc
# Series
print(ser_obj['b':'d'])
print(ser_obj.loc['b':'d'])

# DataFrame
print(df_obj['a'])

# 第一个参数索引行，第二个参数是列
print(df_obj.loc[0:2, 'a'])
```

运行结果：

```python
b    1
c    2
d    3
dtype: int64
b    1
c    2
d    3
dtype: int64

0   -0.241678
1   -0.526918
2   -1.074163
3   -0.716816
4    0.368212
Name: a, dtype: float64
0   -0.241678
1   -0.526918
2   -1.074163
Name: a, dtype: float64
```

#### 2. iloc 位置索引

> 作用和loc一样，不过是基于索引编号来索引

示例代码：

```python
# 整型位置索引 iloc
# Series
print(ser_obj[1:3])
print(ser_obj.iloc[1:3])

# DataFrame
print(df_obj.iloc[0:2, 0]) # 注意和df_obj.loc[0:2, 'a']的区别
```

运行结果：

```python
b    1
c    2
dtype: int64
b    1
c    2
dtype: int64

0   -0.241678
1   -0.526918
Name: a, dtype: float64
```

#### 3. ix 标签与位置混合索引

> ix是以上二者的综合，既可以使用索引编号，又可以使用自定义索引，要视情况不同来使用，
>
> 如果索引既有数字又有英文，那么这种方式是不建议使用的，容易导致定位的混乱。

示例代码：

```python
# 混合索引 ix
# Series
print(ser_obj.ix[1:3])
print(ser_obj.ix['b':'c'])

# DataFrame
print(df_obj.loc[0:2, 'a'])
print(df_obj.ix[0:2, 0])
```

运行结果：

```python
b    1
c    2
dtype: int64
b    1
c    2
dtype: int64

0   -0.241678
1   -0.526918
2   -1.074163
Name: a, dtype: float64
```

#### 注意

> DataFrame索引操作，可将其看作ndarray的索引操作
>
> 标签的切片索引是包含末尾位置的

## 三： 函数运用

### 3.1  使用 lambda 批处理操作

#### 1. 可直接使用NumPy的函数

示例代码：

```python
# Numpy ufunc 函数
df = pd.DataFrame(np.random.randn(5,4) - 1)
print(df)

print(np.abs(df))
```

运行结果：

```python
          0         1         2         3
0 -0.062413  0.844813 -1.853721 -1.980717
1 -0.539628 -1.975173 -0.856597 -2.612406
2 -1.277081 -1.088457 -0.152189  0.530325
3 -1.356578 -1.996441  0.368822 -2.211478
4 -0.562777  0.518648 -2.007223  0.059411

          0         1         2         3
0  0.062413  0.844813  1.853721  1.980717
1  0.539628  1.975173  0.856597  2.612406
2  1.277081  1.088457  0.152189  0.530325
3  1.356578  1.996441  0.368822  2.211478
4  0.562777  0.518648  2.007223  0.059411
```

#### 2. 通过apply将函数应用到列或行上

示例代码：

```python
# 使用apply应用行或列数据
#f = lambda x : x.max()
print(df.apply(lambda x : x.max()))
```

运行结果：

```python
0   -0.062413
1    0.844813
2    0.368822
3    0.530325
dtype: float64
```

> 注意指定轴的方向，默认axis=0，方向是列

示例代码：

```python
# 指定轴方向，axis=1，方向是行
print(df.apply(lambda x : x.max(), axis=1))
```

运行结果：

```python
0    0.844813
1   -0.539628
2    0.530325
3    0.368822
4    0.518648
dtype: float64
```

#### 3. 通过applymap将函数应用到每个数据上

示例代码：

```python
# 使用applymap应用到每个数据
f2 = lambda x : '%.2f' % x
print(df.applymap(f2))
```

运行结果：

```python
       0      1      2      3
0  -0.06   0.84  -1.85  -1.98
1  -0.54  -1.98  -0.86  -2.61
2  -1.28  -1.09  -0.15   0.53
3  -1.36  -2.00   0.37  -2.21
4  -0.56   0.52  -2.01   0.06
```

### 3.2 排序

#### 1. 索引排序

> sort_index()
>
> 排序默认使用升序排序，ascending=False 为降序排序

示例代码：

```python
# Series
s4 = pd.Series(range(10, 15), index = np.random.randint(5, size=5))
print(s4)

# 索引排序
s4.sort_index() # 0 0 1 3 3
```

运行结果：

```python
0    10
3    11
1    12
3    13
0    14
dtype: int64

0    10
0    14
1    12
3    11
3    13
dtype: int64
```

> 对DataFrame操作时注意轴方向

示例代码：

```python
# DataFrame
df4 = pd.DataFrame(np.random.randn(3, 5), 
                   index=np.random.randint(3, size=3),
                   columns=np.random.randint(5, size=5))
print(df4)

df4_isort = df4.sort_index(axis=1, ascending=False)
print(df4_isort) # 4 2 1 1 0
```

运行结果：

```python
          1         4         0         1         2
2 -0.416686 -0.161256  0.088802 -0.004294  1.164138
1 -0.671914  0.531256  0.303222 -0.509493 -0.342573
1  1.988321 -0.466987  2.787891 -1.105912  0.889082

          4         2         1         1         0
2 -0.161256  1.164138 -0.416686 -0.004294  0.088802
1  0.531256 -0.342573 -0.671914 -0.509493  0.303222
1 -0.466987  0.889082  1.988321 -1.105912  2.787891
```

#### 2. 按值排序

> sort_values(by='column name')
>
> 根据某个唯一的列名进行排序，如果有其他相同列名则报错。

示例代码：

```python
# 按值排序
df4_vsort = df4.sort_values(by=0, ascending=False)
print(df4_vsort)
```

运行结果：

```python
          1         4         0         1         2
1  1.988321 -0.466987  2.787891 -1.105912  0.889082
1 -0.671914  0.531256  0.303222 -0.509493 -0.342573
2 -0.416686 -0.161256  0.088802 -0.004294  1.164138
```

### 3.3 处理缺失数据

示例代码：

```python
df_data = pd.DataFrame([np.random.randn(3), [1., 2., np.nan],
                       [np.nan, 4., np.nan], [1., 2., 3.]])
print(df_data.head())
```

运行结果：

```python
          0         1         2
0 -0.281885 -0.786572  0.487126
1  1.000000  2.000000       NaN
2       NaN  4.000000       NaN
3  1.000000  2.000000  3.000000
```

#### 1. 判断是否存在缺失值：isnull()

示例代码：

```python
# isnull
print(df_data.isnull())
```

运行结果：

```python
       0      1      2
0  False  False  False
1  False  False   True
2   True  False   True
3  False  False  False
```

#### 2. 丢弃缺失数据：dropna()

> 根据axis轴方向，丢弃包含NaN的行或列。 示例代码：

```python
# dropna
print(df_data.dropna())

print(df_data.dropna(axis=1))
```

运行结果：

```python
          0         1         2
0 -0.281885 -0.786572  0.487126
3  1.000000  2.000000  3.000000

          1
0 -0.786572
1  2.000000
2  4.000000
3  2.000000
```

#### 3. 填充缺失数据：fillna()

示例代码：

```python
# fillna
print(df_data.fillna(-100.))
```

运行结果：

```python
            0         1           2
0   -0.281885 -0.786572    0.487126
1    1.000000  2.000000 -100.000000
2 -100.000000  4.000000 -100.000000
3    1.000000  2.000000    3.000000
```

## 四：常用的统计描述方法

![](http://photo.jomeswang.top/20200507230925.png)

