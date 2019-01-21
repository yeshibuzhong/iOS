//
//  Persion.h
//  KVO
//
//  Created by  pc on 2019/1/21.
//  Copyright © 2019  pc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Dog;

@interface Persion : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) Dog *dog;

@end

@interface Dog : NSObject

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger age;

@end


NS_ASSUME_NONNULL_END
