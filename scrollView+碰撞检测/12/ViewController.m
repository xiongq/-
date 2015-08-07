//
//  ViewController.m
//  12
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
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] init];
    _collision = [[UICollisionBehavior alloc] init];
    _collision.translatesReferenceBoundsIntoBoundary = true;
    [_animator addBehavior:_gravity];
    [_animator addBehavior:_collision];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UIScrollView *one = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    //one.backgroundColor = [UIColor greenColor];
    one.contentSize = CGSizeMake(rect.size.width*4, rect.size.width);
    UILabel *qw = [[UILabel alloc]initWithFrame:CGRectMake((rect.size.width)*1.5-15, rect.size.height*0.5, 30, 20)];
    qw.text = @"123";
    one.pagingEnabled = YES;
    one.showsHorizontalScrollIndicator = NO;
    
    UIButton *fuck = [[UIButton alloc]initWithFrame:CGRectMake(rect.size.width*0.5-25, rect.size.height*0.5, 50, 20)];
    fuck.backgroundColor = [UIColor greenColor];
    [fuck setTitle:@"fuck" forState:UIControlStateNormal];
    
    [self.view addSubview:one];
    [one addSubview:qw];
    [one addSubview:fuck];
    
    
  
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
   
}

- (IBAction)tap:(id)sender {
    
    CGFloat width = self.view.bounds.size.width / 10;
    UIView* dropView = [[UIView alloc] initWithFrame:CGRectMake(rand() % 10 * width, 0, width, width)];
    dropView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:dropView];
    [_gravity addItem:dropView];
    [_collision addItem:dropView];
    //[_animator add]
}

@end
