//
//  Person.m
//  Runtime_01
//
//  Created by 王亚辉 on 2019/2/11.
//  Copyright © 2019年 王亚辉. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
#import "Student.h"

@implementation Person

void sendMessage(id self, SEL _cmd, NSString *message) {
    NSLog(@"Person--%@", message);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sendMessage:)) {
        return class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
    }
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(sendMessage:)) {
        return [Student new];
    } else {
        return [super forwardingTargetForSelector:aSelector];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(sendMessage:)) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:@"];
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
    Student *stu = [Student new];
    if ([stu respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:stu];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector");
}

@end
