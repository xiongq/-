//
//  ViewController.m
//  工具栏
//
//  Created by qing on 15/6/30.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)change:(id)sender {
    self.hah.text = @"变化";
}

- (IBAction)返回:(id)sender {
    self.hah.text =@"返回";
}
- (IBAction)SAVE:(id)sender {
    self.hah.text =@"HOW";
}

- (IBAction)ADD:(id)sender {
   self.hah.text =@"HOW MUCH?"; 
}
@end
