//
//  ViewController.m
//  txt1
//
//  Created by qing on 15/7/14.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"
int abc;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pagingWithTextKit];
#pragma - mark 页码
    CGRect rect = [UIScreen mainScreen].bounds;
    _kk = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, rect.size.height-20, 60,20 )];
    _kk.text = @"loading";
    _kk.font = [UIFont fontWithName:@"Helvetica"  size:12.0];
    _kk.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_kk];
    
    
}
- (void)pagingWithTextKit
    {
     CGRect rect = [UIScreen mainScreen].bounds;
    //加载txt文本
    NSString *textString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"藏地密码1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
   // NSString *extString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:textString];
    //添加排版
    NSLayoutManager *layoutManger = [[NSLayoutManager alloc]init];
    [storage addLayoutManager:layoutManger];
#pragma - mark 创建ScrollView
    UIScrollView *ScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    ScrollView.contentSize= CGSizeMake(10*rect.size.width, rect.size.height);
    ScrollView.pagingEnabled = YES;
    ScrollView.bounces = NO;
    UIColor *testColor1= [UIColor colorWithRed:222/255.0 green:184/255.0 blue:135/255.0 alpha:1];
    ScrollView.backgroundColor = testColor1;
    [self.view addSubview:ScrollView];
    ScrollView.showsHorizontalScrollIndicator = NO;
    ScrollView.delegate = self ;
   int i = 0;
    while (YES) {
       NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:CGSizeMake(rect.size.width-20, rect.size.height-40)];
        [layoutManger addTextContainer:textContainer];
        NSLog(@"%lu",(unsigned long)textString.length);
        
        
       UITextView *book = [[UITextView alloc]initWithFrame:CGRectMake(i*rect.size.width+14, 20, rect.size.width-20, rect.size.height-20) textContainer:textContainer ];

        book.text = textString;
        //禁止滚动
        book.scrollEnabled = NO;
        book.editable = NO;
        book.backgroundColor = [UIColor clearColor];
        book.font = [UIFont fontWithName:@"Helvetica" size:19.0];//字体和大小
        [ScrollView addSubview:book];
        
       
        
       
       i++;

     NSRange range = [layoutManger glyphRangeForTextContainer:textContainer];

       if (range.length + range.location == textString.length ) {
            break;

        }
        ScrollView.contentSize = CGSizeMake(i*rect.size.width+rect.size.width, rect.size.height);
        
 
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark 委托
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     CGRect rect = [UIScreen mainScreen].bounds;
    int a = scrollView.contentOffset.x/self.view.frame.size.width+1;//第几页
    int b = scrollView.contentSize.width/rect.size.width;//一共多少
    abc = b;
    _kk.text = [NSString stringWithFormat:@"%d/%d页",a,b];

}

@end
