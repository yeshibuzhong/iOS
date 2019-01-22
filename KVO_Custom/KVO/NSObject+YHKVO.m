//
//  NSObject+YHKVO.m
//  KVO
//
//  Created by 王亚辉 on 2019/1/21.
//  Copyright © 2019年  pc. All rights reserved.
//

#import "NSObject+YHKVO.h"
#import <objc/message.h>

static const char * YH_observer = "yh_observer";
static const char * YH_getter = "yh_getter";
static const char * YH_settter = "yh_settter";

@implementation NSObject (YHKVO)

- (void)YH_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [@"YHKVONotifying_" stringByAppendingString:oldName];
    Class MyClass = objc_getClass(newName.UTF8String);
    if (!MyClass) {
        MyClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
        //注册类
        objc_registerClassPair(MyClass);
    }
    
    //set方法首字母大写
    NSString *keyPathChange = [[[keyPath substringToIndex:1] uppercaseString] stringByAppendingString:[keyPath substringFromIndex:1]];
    NSString *setNameStr = [NSString stringWithFormat:@"set%@", keyPathChange];
    SEL setSEL = NSSelectorFromString([setNameStr stringByAppendingString:@":"]);
    
    //添加set方法
    Method getMethod = class_getInstanceMethod([self class], @selector(keyPath));
    const char *types = method_getTypeEncoding(getMethod);
    
    /**
     *class 给那个类添加方法
     *sel 方法编号
     *imp 方法实现(函数指针)
     *type返回值类型以及参数
     */
    class_addMethod(MyClass, setSEL, (IMP)setMethod, types);

    //修改isa指针
    object_setClass(self, MyClass);
    
    //保存方法
    objc_setAssociatedObject(self, YH_observer, observer, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, YH_settter, setNameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, YH_getter, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

void setMethod(id self, SEL _cmd, id newVlaue) {
    NSString *setName = objc_getAssociatedObject(self, YH_settter);
    NSString *getName = objc_getAssociatedObject(self, YH_getter);

    Class class = [self class];//获取当前类型
    
    object_setClass(self, class_getSuperclass(class));//修改isa指针到父类
    
    //调用原类get, 获取旧值
    id oldValue = objc_msgSend(self, NSSelectorFromString(getName));
    //调用原类,设置新值
    objc_msgSend(self, NSSelectorFromString([setName stringByAppendingString:@":"]), newVlaue);
    
    id observer = objc_getAssociatedObject(self, YH_observer);
    
    NSMutableDictionary * change = [NSMutableDictionary dictionary];
    if (newVlaue) {
        change[NSKeyValueChangeNewKey] = newVlaue;
    }
    if (oldValue) {
        change[NSKeyValueChangeOldKey] = oldValue;
    }
    
    if (observer) {
        objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), getName, self, change, nil);
    }
    
    //修改回子类
    object_setClass(self, class);
    
}

@end
