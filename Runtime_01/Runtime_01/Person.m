//
//  Person.m
//  Runtime_01
//
//  Created by 王亚辉 on 2019/2/11.
//  Copyright © 2019年 王亚辉. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

void sendMessage(id self, SEL _cmd, NSString *message) {
    NSLog(@"%@", message);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *metnodName = NSStringFromSelector(sel);
    if ([metnodName isEqualToString:@"sendMessage:"]) {
       return class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
    }
    return NO;
}

@end
