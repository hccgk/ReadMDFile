

# setValue forKey 和 setObject forKey区别



- (void)setValue:(id)value forKey:(NSString *)key;

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

vk 是kvc ，v可以为nil 但是会自动调用removeObject：forKey  ； key必须为字符串

ok 是NSMutableDictionary 的一个特有方法， o 不能为nil key可以为任意类型