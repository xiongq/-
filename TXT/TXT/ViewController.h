//
//  ViewController.h
//  TXT
//
//  Created by qing on 15/7/13.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) NSString *shuju;

@property (weak, nonatomic) IBOutlet UIButton *startAgainButton;

@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong,nonatomic) NSArray *pageTitles;
@property (strong,nonatomic)  NSArray *pageImages;

@end

