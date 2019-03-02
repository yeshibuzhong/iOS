//
//  NSObject+Exception.m
//  Test
//
//  Created by  pc on 2019/3/1.
//  Copyright © 2019  pc. All rights reserved.
//

#import "NSNull+Exception.h"
#import <objc/runtime.h>
@implementation NSNull (Exception)

#define pLog
#define JsonObjects @[@"",@0,@{},@[]]

//在.m中实现这两个方法：
-(void)noObjMethod{
    NSLog(@"未实现这个实例方法");
}
+(void)noClassMethod{
    NSLog(@"未实现这个类方法");
}
//并且重写消息转发的方法：
// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
//注意:实例方法是存在于当前对象对应的类的方法列表中
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    for (id jsonObj in JsonObjects) {
        if ([jsonObj respondsToSelector:sel]) {
#ifdef pLog
            NSLog(@"NULL出现啦！这个对象应该是_%@",[jsonObj class]);
#endif
        }
    }
    
    
    SEL aSel = NSSelectorFromString(@"noObjMethod");
    Method aMethod = class_getInstanceMethod(self, aSel);
    class_addMethod([self class], sel, method_getImplementation(aMethod), "v@:");
    return YES;
}

@end
