//
//  ViewController.m
//  txt3
//
//  Created by qing on 15/7/15.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"
CGSize vsize;
int d;

int swidth;
int sheight;
@interface ViewController ()
@property (retain, nonatomic) UIPageControl *pagecontrol;
@property (retain, nonatomic) NSMutableArray *textcontainerarray;
@property (retain, nonatomic) NSMutableArray *bookarray;
@property (retain, nonatomic) NSArray *dth;
@property (strong, nonatomic) UIScrollView *backview;
@property (strong, nonatomic) NSTextContainer *container1;
@property (strong, nonatomic) NSTextContainer *container2;
@property (strong, nonatomic) NSTextContainer *container3;
@property (strong, nonatomic) UITextView  *book1;
@property (strong, nonatomic) UITextView  *book2;
@property (strong, nonatomic) UITextView  *book3;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    vsize = CGSizeMake(self.view.frame.size.width-20,   self.view.frame.size.height-40);
    
    swidth = self.view.frame.size.width;
    sheight = self.view.frame.size.height;
    //获取文本
    NSString *textString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"藏地密码1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    //创建nstext容器
    NSTextStorage *strong = [[NSTextStorage alloc]initWithString:textString];
    NSLayoutManager *layout = [NSLayoutManager new];
    [strong addLayoutManager:layout];
    _container1 = [[NSTextContainer alloc] initWithSize:vsize];
    _container2 = [[NSTextContainer alloc] initWithSize:vsize];
    _container3 = [[NSTextContainer alloc] initWithSize:vsize];
    [layout addTextContainer:_container1];
    [layout addTextContainer:_container2];
    [layout addTextContainer:_container3];
    _book1 = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, swidth-20, sheight-40) textContainer:_container1];
    _book2 = [[UITextView alloc]initWithFrame:CGRectMake(swidth+10, 20, swidth-20, sheight-40) textContainer:_container2];
    _book3 = [[UITextView alloc]initWithFrame:CGRectMake(swidth*2+10, 20, swidth-20, sheight-40) textContainer:_container3];
    _book1.editable = NO;
    _book2.editable = NO;
    _book3.editable = NO;
    _book1.scrollEnabled = NO;
    _book3.scrollEnabled = NO;
    _book2.scrollEnabled = NO;
    _backview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, swidth, sheight)];
    _backview.scrollEnabled = YES;
    _backview.pagingEnabled = YES;
    _backview.contentSize = CGSizeMake(swidth*3, sheight);
    [_backview addSubview:_book1];
    [_backview addSubview:_book2];
    [_backview addSubview:_book3];
    _backview.bounces = NO;
    _backview.delegate = self;
    [self.view addSubview:_backview];
    NSRange rangge = [layout glyphRangeForTextContainer:_container1];
    NSLog(@"单页%lu",(unsigned long)rangge.length);
    NSLog(@"整个文本%lu",(unsigned long)strong);    
        
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (void)scrollviewWidth{
    [_backview setContentSize:CGSizeMake(swidth*10, sheight)];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"减速完成");
    int t = self.backview.contentOffset.x;
    int u = swidth;
    int i = t/u;
    //int o = (int)self.backview.contentOffset.x/(int)swidth;
    int g = i % 3;
    if (g == 2) {
        [self scrollviewWidth];
    }
    
}

@end
