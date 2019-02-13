# weak实现原理

首先是,ios runtime 里面维护一个weak表,是一张哈希表

	Key是所致对象的地址

	Value 是地址数组



初始化, 调用objc_initWeak函数 设置一个新的指针指向对象地址

添加引用, objc_initWeak函数调用 objc_storeWeak函数更新指针指向,创建引用表

释放时候,调用clearDeallocating,根据key获取所有地址数组然后把数组数据设为nil,最后把这个记录删除.