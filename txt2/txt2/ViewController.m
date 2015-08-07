//
//  ViewController.m
//  txt2
//
//  Created by qing on 15/7/15.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *textString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"藏地密码1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:textString];
    NSLayoutManager *layout = [NSLayoutManager new];
    [storage addLayoutManager:layout];
    
    CGSize size = CGSizeMake(self.view.frame.size.width-10,   self.view.frame.size.height-40);
    NSTextContainer *textContainer1 = [[NSTextContainer alloc] initWithSize:size];
    [layout addTextContainer:textContainer1];
   /* NSTextContainer *textContainer2 = [[NSTextContainer alloc] initWithSize:size];
    [layout addTextContainer:textContainer2];
    NSTextContainer *textContainer3 = [[NSTextContainer alloc] initWithSize:size];
    [layout addTextContainer:textContainer3];
    NSTextContainer *textContainer4 = [[NSTextContainer alloc] initWithSize:size];
    [layout addTextContainer:textContainer4];*/

    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width-20, 41*(self.view.frame.size.height-40)) textContainer:textContainer1];
    [layout addTextContainer:textContainer1];
    textview.layer.borderWidth = 1;
    textview.scrollEnabled = YES;
    textview.editable = NO;
    [self.view addSubview:textview];
    /*int i = 0;
    while (YES) {
        i++;
        NSTextContainer *sw = [[NSTextContainer alloc]initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
        [layout addTextContainer:sw];

        if (i == 41) {
            break;
        }
        NSLog(@"%d",i);
        NSString *wo = [[NSString alloc]initWithFormat:@"%dfff",i ];

    }*/
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
