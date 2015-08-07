//
//  ViewController.m
//  自动循环
//
//  Created by qing on 15/8/7.
//  Copyright (c) 2015年 qing. All rights reserved.
//
#pragma mark -------------------------read-------------------------
/**
 *  ----参考了黑马的教学视频：
 *  学习scrollview应该注意的：
 *  1.contentSize 滚动画布不是指scrollview的大小。这个不设置是无法滚动
 *  2.contentOffset是这位移位置
 *  UIPageControl注意：
 *  1.numberOfPages 总页数
 *  2.currentPage 显示第几个
 */
#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *adscroll;
@property (nonatomic, strong)UIPageControl *page;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [UIScreen mainScreen].bounds;
    /**
     初始化scrollview
     */
    _adscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 20, screen.size.width-20,screen.size.width*130/300)];/**< 尺寸比较怪异是为了匹配不同屏幕 最后的高度计算式式按照图片的比例写的130/300 */
    _adscroll.backgroundColor = [UIColor redColor];
    _adscroll.contentSize = CGSizeMake(5*_adscroll.frame.size.width, screen.size.width*130/300); /**<contentSize设置画布大小，数字5是指有5张图片 */
    _adscroll.bounces = NO;/**< 弹簧效果*/
    _adscroll.pagingEnabled = YES;/**<分页*/
    _adscroll.delegate = self;
    [self.view addSubview:_adscroll];
    /**
     *  for循环取得5张图片的名字，且将imageview加载图片添加到scrollview
     */
    for (int i = 0 ; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i + 1];
        UIImage *pic = [UIImage imageNamed:imageName];
        NSLog(@"%@",pic);
        UIImageView *adpic = [[UIImageView alloc]initWithFrame:self.adscroll.bounds];
        adpic.image = pic;
        [_adscroll addSubview:adpic];
    }
    /**
     *  这是一个类似for循环，就是遍历scrollview上所有子视图，给imageview设置frame位置
     *
     */
    
#pragma mark ------ 注意这个遍历方法 -----
    [self.adscroll.subviews enumerateObjectsUsingBlock:^(UIImageView *adpic, NSUInteger idx, BOOL *stop) {
        CGRect frame = adpic.frame; /**<获得imageview的位置，方便修改，不能直接修改结构体*/
        frame.origin.x = idx*frame.size.width;/**<修改imageview的origin.x也就是x坐标，idx指的是子视图*/
        adpic.frame = frame;/**<设置其原点位置*/
    }];
    /**
     这部分是创建pageControl--小原点
     */
    _page = [[UIPageControl alloc] init];
    _page.numberOfPages = 5;/**<总页数*/
    //[_page sizeForNumberOfPages:5];
    _page.pageIndicatorTintColor = [UIColor greenColor];/**<设置未显示的时候的颜色*/
    _page.currentPageIndicatorTintColor = [UIColor redColor];/**<显示的时候的颜色*/
    _page.center = CGPointMake(self.view.center.x, screen.size.width*130/300);/**<位置*/
    //[_page addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];/**<添加点击事件*/
    [self.view addSubview:_page];
    [self startTime];/**<调用定时器*/
}
/**
 *  更新scrollview的图片
 *  也是循环显示重要部分
 *  @param page 小圆点
 */
-(void)change:(UIPageControl *)page{
    NSLog(@"调用了");
    CGFloat x = page.currentPage * self.adscroll.bounds.size.width;/**<计算，根据小圆点位置*scroll的宽度（这里不是指画布的宽度）算出位移位置然后显示改位置的图像*/
    [_adscroll setContentOffset:CGPointMake(x, 0) animated:YES];/**<让其位移到x点位置显示*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
/**
 *  启动定时间  2s间隔，这里有个区别nstimer，一个准确，一个不确切，有其他事件产生时，它会停止，事件结束后它会启动，奖中断的时间叠加执行，这里是使用准备的nstimer
 */
- (void)startTime{
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(upView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];/**<加入循环*/
    
}
/**
 *  小圆点的循环显示更新，定时器调用该方法，该方法再调用change更新scrollview的显示，+1这个就是让它显示下一个，scrollview的位移的依据
 *   int page 的数字 0 1 2 3 4 传给change方法
 *
 */
- (void)upView{
    int page = (_page.currentPage+1) % 5;
    _page.currentPage = page;
    NSLog(@"page %d",page);
    [self change:_page];
}
#pragma mark --- 代理
/**
 *  位移结束的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /**
     *  计算小圆点应该在什么地方显示
     * 位移x/scrollview的尺寸 0 1 2 3 4
     */
    int pageTo = _adscroll.contentOffset.x/_adscroll.frame.size.width;
    NSLog(@"%d",pageTo);
    _page.currentPage = pageTo;
}
/**
 *  开始拖动调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];/**<停止计时器，这个停止后启动需要再次初始化*/
}

/**
 *  拖动结束调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTime];/**<启动计时器*/
}
@end
