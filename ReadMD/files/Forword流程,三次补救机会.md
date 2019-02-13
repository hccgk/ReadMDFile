# Forword流程,三次补救机会

最终使用的中间的那个方法进行补救

```objective-c
- (id)forwardingTargetForSelectorSwizzled:(SEL)selector{    
    NSMethodSignature* sign = [self methodSignatureForSelector:selector];    
    if (!sign) {        
        id stub = [[UnrecognizedSelectorHandle new] autorelease];        
        class_addMethod([stub class], selector, (IMP)unrecognizedSelector, "v@:");        
        return stub;
    }    
    return [self forwardingTargetForSelectorSwizzled:selector];
}
```

* 第一个方法resolveInstanceMethod: 会污染当前实例
* 第三个方法 需要多次调用 methodSignatureForSelector: 和 forwardInvocation 2个方法,但是第一个方法返回后还要执行 resolveInstanceMethod 方法,所以繁杂





参考链接:https://mp.weixin.qq.com/s/4dYVbddHrozKpf_GtnyQfA