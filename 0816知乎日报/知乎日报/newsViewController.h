//
//  newsViewController.h
//  知乎日报
//
//  Created by xiong on 15/8/11.
//  Copyright (c) 2015年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsViewController : UIViewController
@property NSMutableArray *stoyid;
@property NSString *koID;
@property NSURL *images;
@property UIWebView *topStory;
@end
