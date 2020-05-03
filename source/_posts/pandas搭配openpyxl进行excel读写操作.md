---
title: pandas搭配openpyxl进行excel读写操作
top: false
comments: true
categories:
  - 数据分析
tags:
  - pandas
  - openpyxl
abbrlink: 7af05105
date: 2020-05-01 20:39:12
---

## 一：前言

因为有个项目需要批量处理excel 文件，进行分组导出并求和。因此我就想到使用pandas 来进行数据的处理， 使openpyxl 来进行数据的保存，以及导出excel文件并且对excel 文件进行格式化以及美化操作。

<!-- more -->

## 二：步骤

### 2.1 使用pandas进行分组求和

有着像这样的数据

![](http://photo.jomeswang.top/20200501212229.png)

我要做的就n是将每个客户的数据导出到独立的文件夹中，并计算金额

首先，使用

```
data_g = data.groupby("客户名称")
```

这样就可以分出每一个客户了。

```
data_g_sum = data_g["金额"].sum()
```

保存写入数据

```
for i in data_g:
    i[1].to_excel(dir) # dir为目标xlsx文件路径
```



### 2.2  使用openpyxl 进行打开文件并保存文件

#### 2.2.1 如果使用未创建的excel 需要先创建

```
from openpyxl import Workbook

wb = Workbook() # 创建一个Workbook对象
ws = wb.active # 选取wb对象中活动的对象，默认为第一个sheet

# 或者 ws1 = wb.create_sheet("Sheet", 0) 插入第一张sheet
```

#### 2.2.2 如果打开已经存在的文件

```
wb = openpyxl.load_workbook(dir)
sheet = wb.active
```

#### 2.2.3 保存文件

```
#使用
wb.save(dir)  # dir 为输出的xlsx文件路径
```



### 2.3  增删改查单元格的值

#### 2.3.1 一个单元格的值

```
1. 方法一
# 直接使用列名
ws['A4'] = 4

2. 方法二
# 使用 cell 方法，传入行列（注意全部从1开始数），还可以传入value 值
d = ws.cell(row=4, column=2, value=10)
```

#### 2.3.2 多个单元格的值

```
一：使用切片方式
cell_range = ws['A1':'C2']

二：使用列名
colC = ws['C']
col_range = ws['C:D']
row10 = ws[10]
row_range = ws[5:10]

三：使用Worksheet.columns  || Worksheet.rows 来产生可迭代对象 
 tuple(ws.rows)
((<Cell Sheet.A1>, <Cell Sheet.B1>, 
(<Cell Sheet.A2>, <Cell Sheet.B2>, 
(<Cell Sheet.A3>, <Cell Sheet.B3>, 
(<Cell Sheet.A4>, <Cell Sheet.B4>, 
(<Cell Sheet.A5>, <Cell Sheet.B5>, 
(<Cell Sheet.A6>, <Cell Sheet.B6>, 
(<Cell Sheet.A7>, <Cell Sheet.B7>, 
(<Cell Sheet.A8>, <Cell Sheet.B8>, 
(<Cell Sheet.A9>, <Cell Sheet.B9>)

for 循环再用.value方法取值
（注意好像不能用这个改变他的格式）
```

#### 2.3.3 增加/删除 行列

1. 插入行列

ws.insert_rows(n) # 在第n行插入一行

ws.insert_cols(m,n) # 从第m列开始插入n列

2. 删除行列

ws.delete_cols(m, n) # 从第m列开始，删除n列

ws.delete_rows(n) # 删除第n行

上述两种方式**删除行（列）后，下（后）面的表格将自动上（前）移**。



#### 2.4  单元格格式

首先先引入

```
import openpyxl
from openpyxl.styles import Font, PatternFill, Border, Side, Alignment
```



#### 2.4.1 字体

```
# 设置单元格字体样式
"""
Font(
    name=None,      # 字体名，可以用字体名字的字符串
    strike=None,    # 删除线，True/False
    color=None,     # 文字颜色
    size=None,      # 字号
    bold=None,      # 加粗, True/False
    italic=None,    # 倾斜，Tue/False
    underline=None # 下划线, 'singleAccounting', 'double', 'single', 'doubleAccounting'
)
"""
# 1) 创建字体对象
font1 = Font(
        size=20,
        italic=True,
        color='ff0000',
        bold=True,
        strike=True
)
# 2) 设置指定单元格的字体
# 单元格对象.font = 字体对象
sheet['B2'].font = font1
```

#### 2.4.2 对齐样式

```
1）创建对象
al = Alignment(
        horizontal='right',     # 水平方向:center, left, right
        vertical='top'       # 垂直方向: center, top, bottom
)
# 2） 设置单元格的对齐方式
sheet['B2'].alignment = al
```

#### 2.4.3  设置边框样式

```
1）设置边对象（四个边的边可以是一样的也可以不同，如果不同就创建对个Side对象）
side = Side(border_style='thin', color='000000')
# 2) 设置边框对象
# 这儿的left、right、top、bottom表示的是边框的四个边，这儿四个边使用的是一个边对象
bd = Border(left=side, right=side, top=side, bottom=side)
# 3）设置单元格的边框
sheet['B2'].border = bd
```

#### 2.4.4  *设置单元格的宽度和高度* 

```
1. # 设置指定列的宽度
sheet.column_dimensions['A'].width = 20
2. # 设置指定行的高度
sheet.row_dimensions[1].height = 45
```

#### 2.4.5 格式化字符串

```
form openpyxl import numbers
sheet.cell(row=cell + 2, column=1).number_format = numbers.FORMAT_DATE_YYYYMMDD2
```

其他格式：请看[这里](https://openpyxl.readthedocs.io/en/stable/_modules/openpyxl/styles/numbers.html#NumberFormat)

### 2.5 Worksheet 的其他属性

Worksheet 

title：表格的标题
max_row：表格的最大行
min_row：表格的最小行
max_column：表格的最大列
min_column：表格的最小列
rows：按行获取单元格(Cell对象) - 生成器
columns：按列获取单元格(Cell对象) - 生成器
values：按行获取表格的内容(数据) - 生成器

## 三：总结

太累了，写这篇，这篇大致汇总了大部分需要用到的openpyxl的属性如果还要看看其他的属性，可以到[官方文档](https://openpyxl.readthedocs.io/en/stable/tutorial.html)去查阅。

