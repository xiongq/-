//
//  ViewController.h
//  12
//
//  Created by qing on 15/6/25.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (strong, nonatomic) UIDynamicAnimator* animator;
@property (strong, nonatomic) UIGravityBehavior* gravity;
@property (strong, nonatomic) UICollisionBehavior* collision;

@end

