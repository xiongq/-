//
//  ViewController.m
//  txt-改实现
//
//  Created by qing on 15/7/17.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *sss;
@property (strong,nonatomic)NSMutableArray *he;
@property (strong,nonatomic)UIPageControl *pageControl;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [UIScreen mainScreen].bounds ;
    
    _sss = [[NSMutableArray alloc]init];
    _sss = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    NSString *textString = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"藏地密码1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:textString];
    NSLayoutManager *layoutManger = [[NSLayoutManager alloc]init];
    [storage addLayoutManager:layoutManger];
    /*int i = 0;
    while (YES) {
        NSTextContainer *textContainer1 = [[NSTextContainer alloc]initWithSize:CGSizeMake(rect.size.width-20, rect.size.height-40)];
        NSTextContainer *textContainer2 = [[NSTextContainer alloc]initWithSize:CGSizeMake(rect.size.width-20, rect.size.height-40)];
        [layoutManger addTextContainer:textContainer1
         ];
        NSLog(@"%lu",(unsigned long)textString.length);
        _he = [[NSMutableArray alloc]initWithObjects:textContainer1,textContainer2, nil];
        NSLog(@"%lu",(unsigned long)[_he count]);
        UITextView *book = [[UITextView alloc]initWithFrame:CGRectMake(2*rect.size.width, 20, rect.size.width, rect.size.height-20) textContainer:textContainer1 ];
        UITextView *book2 = [[UITextView alloc]initWithFrame:CGRectMake(2*rect.size.width, 20, rect.size.width, rect.size.height-20) textContainer:textContainer2 ];
        book.text = textString;
        book2.text = textString;
      //禁止滚动
        book.scrollEnabled = NO;
        book.editable = NO;
        //book.backgroundColor = [UIColor clearColor];
        book.font = [UIFont fontWithName:@"Helvetica" size:19.0];//字体和大小
        
        [_scrollView addSubview:book];
        
        
        i++;
        
        NSRange range = [layoutManger glyphRangeForTextContainer:textContainer1];
        
        if (range.length + range.location == textString.length ) {
            break;
            
        }
    }*/
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scrollView];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0 , rect.size.height-30, rect.size.width, 30)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.numberOfPages = [self.sss count];
    _pageControl.currentPage = 1;
    [self.view addSubview:_pageControl];
    //self.view.backgroundColor = [UIColor redColor];
    

    

    for (int i = 0; i < 7; i++) {
        UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(rect.size.width*(i+1), 20, rect.size.width, rect.size.height-40)];
        NSString *stex = [_sss objectAtIndex:i];
        //text.backgroundColor = [UIColor clearColor];
        text.text = stex;
        [_scrollView addSubview:text];
    }
    int aa =[_sss count];
    NSLog(@"%lu",(unsigned long)[_sss count]);
    UITextView *tex = [[UITextView alloc]initWithFrame:CGRectMake(0, 20, rect.size.width, rect.size.height-40)];
    NSString *first = [_sss objectAtIndex:(aa-1)];
    tex.text = first;
    [_scrollView addSubview:tex];
    tex = [[UITextView alloc]initWithFrame:CGRectMake(rect.size.width*(aa+1), 20, rect.size.width, rect.size.height-40)];
    NSString *seced = [_sss objectAtIndex:0];
    tex.text = seced;
    [_scrollView addSubview:tex];

    _scrollView.contentSize = CGSizeMake(rect.size.width*(aa+2), rect.size.height);
    [self.view addSubview:_scrollView];
    _scrollView.contentOffset = CGPointMake(0, 0);
    [_scrollView scrollRectToVisible:CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height) animated:NO];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender{
    CGRect rect = [UIScreen mainScreen].bounds ;
    CGFloat pagewith = rect.size.width;
    int page = floor((_scrollView.contentOffset.x - pagewith/([_sss count]+2))/pagewith)+1;
    page --;
    _pageControl.currentPage = page;
    //NSLog(@"这是小圆点%d",page);


}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect rect = [UIScreen mainScreen].bounds ;
    CGFloat pagewith = rect.size.width;
    int currenpage = floor((_scrollView.contentOffset.x - pagewith/([_sss count]+2))/pagewith)+1;
    NSLog(@"%d",currenpage);
    if (currenpage == 0)
    {
        [_scrollView scrollRectToVisible:CGRectMake(rect.size.width*[_sss count], 0, rect.size.width, rect.size.height) animated:NO];
    }else if (currenpage == ([_sss count]+1))
    {
        [_scrollView scrollRectToVisible:CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height) animated:NO];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
