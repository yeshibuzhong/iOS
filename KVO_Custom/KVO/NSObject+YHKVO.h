//
//  NSObject+YHKVO.h
//  KVO
//
//  Created by 王亚辉 on 2019/1/21.
//  Copyright © 2019年  pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YHKVO)

- (void)YH_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;


@end
