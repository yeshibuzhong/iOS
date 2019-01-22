//
//  ViewController.m
//  KVO
//
//  Created by  pc on 2019/1/21.
//  Copyright © 2019  pc. All rights reserved.
//

#import "ViewController.h"
#import "Persion.h"

@interface ViewController ()

@property (nonatomic, strong) Persion *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _p = [[Persion alloc] init];
    [_p addObserver:self forKeyPath:@"dog" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
//    [_p addObserver:self forKeyPath:@"dog.height" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
//    [_p addObserver:self forKeyPath:NSStringFromSelector(@selector(age)) options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
//    [_p addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew) context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%ld", _p.dog.height);
    NSLog(@"%ld", _p.dog.age);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 0;
    a++;
//    //将要修改
//    [_p willChangeValueForKey:NSStringFromSelector(@selector(age))];
//    _p.age= a; //注释掉此行可以正常收到监听回调, 但是没有任何结果
//    //已经修改
//    [_p didChangeValueForKey:NSStringFromSelector(@selector(age))];
    
    _p.age = a;
    _p.dog.height = a;
    _p.dog.age = a;
}

@end
