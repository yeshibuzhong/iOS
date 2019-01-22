//
//  Persion.m
//  KVO
//
//  Created by  pc on 2019/1/21.
//  Copyright © 2019  pc. All rights reserved.
//

#import "Persion.h"
#import <objc/message.h>

@implementation Persion


- (void)YH_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [@"YHVKO_" stringByAppendingString:oldName];
    Class MyClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
    
    objc_registerClassPair(MyClass);
    
    class_addMethod(MyClass, @selector(setName:), <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
}

@end


