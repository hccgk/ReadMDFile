# NSOperation

多线程中的一种高阶函数,是在ios2时候出来的,在ios4和gcd一起又重新改写了.gcd开始多核时代的来临,NSOperation也开始了多核的支持



使用方法:

1.创建任务 [`main`方法或`start`方法 都是控方法,需要子类实现,OC提供了2个子类可以用(NSBlockOperation,NSInvocationOperation)]

2.交给队列来执行

##NSOperation子类创建任务

```objective-c
//创建一个NSBlockOperation对象，传入一个block
NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    for (int i = 0; i < 100; i++)
    {
        NSLog(@"Task1 %@ %d", [NSThread currentThread], i);
    }
}];
/*
创建一个NSInvocationOperation对象，指定执行的对象和方法
该方法可以接收一个参数即object
*/
NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"Hello, World!"];

```

##NSOperationQueue 队列

```objective-c
@property NSInteger maxConcurrentOperationCount;
```

maxConcurrentOperationCount的值决定了是串行还是并发

```objective-c
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:2];

    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 100; i++)
        {
            NSLog(@"Task1 %@ %d", [NSThread currentThread], i);
        }
    }];
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"Hello, World!"];

    [queue addOperation:operation];
    [queue addOperation:invocationOperation];

```



