//
//  ViewController.m
//  scc
//
//  Created by qing on 15/6/25.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取当前屏幕大小
    CGRect rect = [UIScreen mainScreen].bounds;

    self.scc.contentSize = CGSizeMake(rect.size.width*5, rect.size.height);
    self.scc.pagingEnabled = YES;
    self.scc.showsHorizontalScrollIndicator = NO;
    self.n1.frame = CGRectMake(rect.size.width*0.5, rect.size.height*0.5, 30, 20);
    self.n2.frame = CGRectMake(rect.size.width*1.5, rect.size.height*0.5, 30, 20);

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.scc.contentOffset = CGPointMake(320, 0);
   
    [super viewDidAppear:YES];
}

@end
