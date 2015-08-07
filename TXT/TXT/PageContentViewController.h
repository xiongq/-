//
//  PageContentViewController.h
//  TXT
//
//  Created by qing on 15/7/13.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageview;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
