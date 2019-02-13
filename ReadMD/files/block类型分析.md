# block类型分析

a. 他的存储域分为三类

​	i. NSGlobalBlock  全局区(程序的数据区)

​	ii. NSStackBlock  栈区域(只在MRC下存在),超出变量的作用域,栈上的Block和__block类型变量都被销毁.

​	iii.NSMallocBlock 堆区域, 在变量作用域结束时,变量不受影响

b. mrc时代的block在栈区,为了避免内存泄漏,所以用的copy到堆区.这就是为什么block一般都用copy.

c. __block是变量的地址被追加到block的结构中,所以能修改外部变量

d. 从栈区到堆区是,以防止超出作用域后block变量会被销毁而不能正常使用.