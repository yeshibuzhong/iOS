//
//  Persion.m
//  KVO
//
//  Created by  pc on 2019/1/21.
//  Copyright © 2019  pc. All rights reserved.
//

#import "Persion.h"

@implementation Persion

- (instancetype)init {
    self = [super init];
    if (self) {
        _dog = [[Dog alloc] init];
    }
    return self;
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"dog"]) {
        keyPaths = [NSSet setWithObjects:@"_dog.age", @"_dog.height", nil];
    }
    return keyPaths;
}

//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"age"])
//    {
//        return NO;
//    }
//    return YES;
//}

@end



@implementation Dog


@end
