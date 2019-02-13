#isKindOfClass,isMemberOfClass

1、isKindOfClass可用于判断对象是否是一个类的成员，或者是该派生类的成员
2、isMemberOfClass可用于判断对象是否是当前类的成员



----

说白了就是isKindOfClass 他的子类都可以是这个父类的类型,是否是属于这个class的类或者派生类--子类

isMemberOfClass 只是当前类,子类是不是父类的member,答案是:不是.所谓的严格的判断类