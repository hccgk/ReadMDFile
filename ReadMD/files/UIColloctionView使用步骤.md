#UIColloctionView

[参考链接]https://blog.csdn.net/LVXIANGAN/article/details/73826108

里面涉及数学三角形与弧度相关的知识





## 一般整体思路

A. 初始化时候初始整个视图的大小

B.可以定义一个UICollectionViewFlowLayout 对布局进行初步的布局,当然也可以使用代理里面的方法

C.单个代理`delegate`,`dataSource` ios1.0多了一个UICollectionViewDataSourcePrefetching 代理方法`prefetchDataSource`,ios!11才有的`dragDelegate`,`dropDelegate`

D.用的多的就是数据源,代理,还有FlowLayout`UICollectionViewDelegateFlowLayout`