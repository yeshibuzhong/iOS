//
//  ViewController.m
//  Runtime_01
//
//  Created by 王亚辉 on 2019/2/11.
//  Copyright © 2019年 王亚辉. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    Person *p = [[Person alloc] init];
    [p sendMessage:@"message"];
    
//    objc_msgSend(p, @selector(sendMessage:), @"message");
    
    NSDictionary* dict = [[NSNull alloc] init];
    [dict objectForKey:@"123"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
