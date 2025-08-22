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

