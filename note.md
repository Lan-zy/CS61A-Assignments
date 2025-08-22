# lecture 22 Composition
## linked list
```python
isinstance(instance,class)

class link:
    empty=()

    def __init__(self,first,rest=empty):
        assert rest is Link.empty or isinstance(rest,Link)
        self.first=first 
        self.rest=rest
```
## linked list processing
多用递归
## tree class
```python
class Tree:
    def __init__(self,label,branches=[]):
        self.label=label
        #这里要assert一下branch里是否都是tree
        self.branches=branches
    def __repr__(self):
        if self.branches:
            str_branch=', '+repr(self.branches)
        else:
            str_branch=''
        return 'Tree({0}{1})'.format(repr(self.label),str_branch) 
    def __str__(self):
        return '/n'.join(self.indented)
    def indented(self):
        lines=[]
        for b in self.branches:
            for line in b.indented():
                lines.append(' '+line)
        return [str(self.label)]+lines
```
# lecture 23 Efficiency
## memorization
```python
#这是一个递归函数调用次数计数装饰器
def count(f):
    def counted(n):
        counted.call_count+=1 #属于函数的静态本地变量
        return f(n)
    counted.call_count=0
    return counted


#这是一个缓存装饰器
def memo(f):
    cache={}
    def memorized(n):
        if n not in cache:
            cache[n]=f(n)
        return cache[n]
    return memorized
```
## 对数时间与线性时间

# lecture 24 Decomposition
## modular design
餐厅搜索索工具
```python
#参数key是规定所排序key值的函数
sorted(iterable, /, *,key=None, reverse=false) #默认升序
```

# lecture 25 Data Example
## list in environment diagram
`list_a.extend(list_b) #将listb中所有的元素加到lista中`
list是可变对象，因此name都是通过引用传递
但是`list()`函数做的事情是创建一个新的列表

# lecture 28 Scheme
## 基础语法：表达式
```scheme
(operator arg1 arg2 ...)

e.g.

>(+ 1 2)
3

>(zero? 2)
#f //means false
```
## special form
IF expression: `(if <predicate> <consequent> <alternative>)`  
AND and OR: `(and <e1> <e2> <e3> ...) （or <e1> <e2> ...)`  
bind new value to symbols:
DEFINE: `(define <symbols> <expression>)`  
define a new procedure: `(define (<symbol> <formal parameters>) <body>)`
## lambda expression
`(lambda (<formal-parameters>) <body>)`
## orther special form
```scheme
#cond多路条件
(cond ((> x 10) (print 'big))
      ((> x 5) (print 'medium))
      (else (print 'small)))  
#begin将多个语句组合到一个语句（适用于空间有限的情况）
(begin <exp1> <exp2>)
#let仅在本句内定义临时变量，用完即扔
(define c 
    (let ((a 3) (b (+ 2 2))) 
              (sqrt (+ (* a a) (* b b)))
    )
)
```
# lecture 29 Scheme Lists
scheme的list是链表
## list syntax
```scheme
cons
car: reture the first element of a list 
cdr: return the rest
nil: empty

>(cons 1 (cons 2 nil))
(1 2)
>(define x (cons 1 (cons 2 nil)))
>(car x)
1
>(cdr x)
(2)

>(draw x)

>(null? nil)
#t
```
## symbolic programming
引用符号，一个单引号 
```scheme
> (define a 1)
> (list a 2)
(1 2)
> (list 'a 2)
(a 2)
```

## list processing 
**append**: (append s t)  t无数量限制
**map**: (map f s)  
**filter**: (filter f s)  
**apply**: (apply f s) #将所有元素一起作为一个参数

# lecture 30 Calculator
## exception
可以使用try语句块制作要测试函数的安全函数
## parsing
解释器  
- 将文本通过词法分析拆分成一个个有效的单元
- 再通过语法分析把单元转化为表达式 
- scheme解释其中语法分析把单元装入tree中，进行递归解释
## interactive interpreter
enter-evaluate-print loop
- 打印一个启动提示
- 读取用户输入的文本
- 将文本解析为表达式或语句
- 评估表达式
- 报错
  - 通过在每个小方法内raise对应的error实现，在主循环中使用try
  - 词法分析阶段ValueError（不合理的值）
  - 语法分析阶段SyntaxError
  - 评估阶段TypeError（和接收期望的值不同）
- 打印结果并进入下一次循环

# lecture 31 Interpreter
## read函数
将'\<expression>转换为(quote \<expression>)
## lambda
解释器需要给函数定义frame
## structure of interpreter
eval和apply相互递归，apply需要新建环境，将信息回传给eval
## define函数可以翻译为define symbol和lambda函数

# lecture 32 Tail Calls
## 尾调用与尾递归可以减少空间开销

# lecture 33 Programs as Data
## quasiquotation 可以用于生成代码
`==quasiquote  
,==unquote  
可以将字符串内部分替换为代码（scheme程序本质就是一串list）

# lecture 34 Macros（scheme的宏）
在表达式评估之前自定义的宏的主体已被评估
```scheme
(define-macro (twice expr)
  (list 'begin expr expr))
```
宏返回可评估的list，可直接执行，可以用于写装饰器

# lecture 35 SQL
## select statement
```sql
create table <table name> as
    select <expr> as <name>, <expr> as <name> union
    select <expr> as <name>, <expr> as <name>;
//union 不能保证行的顺序

select <colums> from <table>;

<colums>:
    可以计算，用列名代替其下值
```

# lecture 36 Table
## jion two table
普通的jion是全排列两个表格，需要使用where来设置条件
```sql
select * from parents, dogs
    where child=name
```
## jion table with itself
给table取别名
```sql
select a.child as first, b.child as second
    from parents as a, from parents as b
    where a.parent=b.parent and a.child<b.child
```
## jion multiple table
```sql
选出和毛型相同的祖孙
select grandog from grandparents, dogs as c, dogs as d
    where grandog = c.name and
          granpup = d.name and //这两行将祖孙表中的狗和毛型表匹配
          c.fur=d.fur
```

## numerical expression
符号基本与python一致，等于是单个等号

## string expression
双引号框住字符串  
连接字符串："hello" || " world"

# lecture 37 Aggregation聚合
## aggregate function
max(<column name>)  
min()    
sum()  
avg()  
count(): count rows  
distinct: remove the repeated ones
## 
```sql
> select max(weights), kind from animals
12000|t-rex
```
## group
聚合是在组上进行的
```sql
select <columns> from <table> group by <expr> having <expr>
//having语句用于筛选分出的group
  e.g. having count(*) > 1
```

# lecture 38 Database
## 创建空表格并插入，更新，删除
```sql
#create

create table <name>(<column>,)
if exist //存在才操作
e.g.
create table primes(n UNIQUE, prime DEFAULT 1) //unique代表n的值不重复，default代表默认值是1
-------------------
#insert

INSERT INTO primes VALUES (2,1), (3,1);

INSERT INTO primes(n) VALUES (4), (5), (6), (7)
-------------------
#update

UPDATE primes SET prime=0 WHERE n>2 and n%2=0
-------------------
#delete

DELETE FROM primes where WHERE prime=0
```
## python and SQL
