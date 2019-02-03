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
    _p.array = [NSMutableArray array];

    
    [_p addObserver:self forKeyPath:NSStringFromSelector(@selector(array)) options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", _p.array);
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 0;
    a++;
    
    [[self.p mutableArrayValueForKey:@"array"] addObject:[NSString stringWithFormat:@"%d", a]];
  
}

@end
