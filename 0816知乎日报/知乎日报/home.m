//
//  home.m
//  知乎日报
//
//  Created by xiong on 15/8/10.
//  Copyright (c) 2015年 xiong. All rights reserved.
//  列表替换时间就可以，故事是替换id
//      代码未重构
//  待完成1.图像的自动切换，有写类似demo
//       2.下拉刷新
//       3.侧栏菜单
//       4.header显示日期（第一个header放的top5，待研究）
//       5.需要调整图像显示效果
//       6.已知bug，故事详情再次调整，图像不消失。
#define 前几天的列表 @"http://news-at.zhihu.com/api/4/stories/before/20150812?client=0"
#define 故事 @"http://news-at.zhihu.com/api/4/story/7044808"
#import "home.h"
#import <UIImageView+WebCache.h>
#import "UINavigationBar+Awesome.h"
#import "newsViewController.h"
#define NAVBAR_CHANGE_POINT -60



@interface home ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *shadView;
@property (weak, nonatomic) IBOutlet UITableView *list;
@property (strong, nonatomic) UIScrollView *top5;
@end

@implementation home

{
    NSMutableArray *titleLabel;
    NSMutableArray *imageURL;
    NSMutableArray *ga_prefixInt;
    NSMutableArray *idToInt;
    NSMutableArray *readImage;
    NSMutableArray *TimeArray;
    NSMutableArray *topid;
    NSMutableArray *topimageurl;
    NSMutableArray *toptitle;
    
    int js;
}
#pragma mark - 传值给下一页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toNews"]) {
        newsViewController *getID = [segue destinationViewController];
        getID.koID =  idToInt[_list.indexPathForSelectedRow.row];
        getID.images = imageURL[_list.indexPathForSelectedRow.row];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _list.showsVerticalScrollIndicator = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];

#pragma mark - 一些数组的初始化
    titleLabel = [[NSMutableArray alloc]init];
    imageURL = [[NSMutableArray alloc]init];
    ga_prefixInt = [[NSMutableArray alloc]init];
    idToInt = [[NSMutableArray alloc]init];
    readImage = [[NSMutableArray alloc]init];
    TimeArray = [[NSMutableArray alloc]init];
    topid = [[NSMutableArray alloc]init];
    topimageurl = [[NSMutableArray alloc]init];
    toptitle = [[NSMutableArray alloc]init];
    /**
     *  调用函数，获取一周的时间
     */
    [self timeUP];
    /**
     * 发送请求
     *
     *  @return 知乎列表API（当天）主线程请求
     */
    NSString *first = @"http://news-at.zhihu.com/api/4/stories/latest?client=0";
    NSURL *home1 = [NSURL URLWithString:first];
    NSURLRequest *request = [NSURLRequest requestWithURL:home1];
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *news1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *top = news1[@"top_stories"];
    NSLog(@"%lu",(unsigned long)top.count);
    for (int i = 0 ; i < top.count; i++) {
        NSDictionary *topStory = [top objectAtIndex:i];
        NSString *topUrl = topStory[@"image"];
        NSString *topID = topStory[@"id"];
        NSString *topTitle = topStory[@"title"];
        [topimageurl addObject:topUrl];
        [topid addObject:topID];
        [toptitle addObject:topTitle];
        NSLog(@"%@\n%@\n%@",topTitle,topID,topUrl);
    }
    NSArray *title = news1[@"stories"];
    for (int i = 0 ; i < title.count; i++) {
        NSDictionary *liebiao = [title objectAtIndex:i];
        NSArray *imageArray = liebiao[@"images"];
        NSString *title1 = liebiao[@"title"];
        NSString *storyID = liebiao[@"id"];
        NSString *imagHttp = [imageArray objectAtIndex:0];//< 获取正确的url，而不是数组，卡一天了*/
        [imageURL addObject:imagHttp];
        [titleLabel addObject:title1];
        [idToInt addObject:storyID];
    }
    
}
/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}*/
/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *date =  [TimeArray objectAtIndex:js];
    return date;
}*/
#pragma mark - tableview的委托
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat witdh = rect.size.width;
    UIView *backg = [[UIView alloc] initWithFrame:CGRectMake(0, -witdh*0.4, witdh, witdh)];
    backg.backgroundColor = [UIColor redColor];
    _top5 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -witdh*0.515, witdh, witdh)];
    /*NSString *bj = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@"jpg"];
    UIImage *test = [[UIImage alloc] initWithContentsOfFile:bj];*/
    /**
     *  do it!!!!!!!!!!!!!
     *  二调整图像显示位置
     */
    for (int i = 0 ; i < 5; i++) {
        UIImageView *no6 = [[UIImageView alloc] initWithFrame:CGRectMake(i*witdh, 0, witdh, witdh)];
        [no6 sd_setImageWithURL:[NSURL URLWithString:[topimageurl objectAtIndex:i]]];
        no6.contentMode = UIViewContentModeScaleAspectFill;
        UILabel *topTitle = [[UILabel alloc]initWithFrame:CGRectMake(i*witdh+20, witdh*0.7+20, witdh*0.8, 80)];
        topTitle.text = [toptitle objectAtIndex:i];
        topTitle.font =[UIFont fontWithName:@"Helvetica-Bold" size:20];
        topTitle.numberOfLines = 0;
        topTitle.textColor = [UIColor whiteColor];
        //topTitle.backgroundColor = [UIColor redColor];
        UIColor *light = [UIColor blackColor];
        UIColor *alp = [light colorWithAlphaComponent:0.2];
        _shadView = [[UIView alloc] initWithFrame:CGRectMake(i*witdh, 0, witdh, witdh)];
        _shadView.backgroundColor = alp;
        [_top5 addSubview:no6];
        [_top5 addSubview:_shadView];
        [_top5 addSubview:topTitle];
        _top5.showsHorizontalScrollIndicator = NO;

    }
    _top5.contentSize =CGSizeMake(5*witdh, witdh);
    _top5.pagingEnabled = YES;
    _top5.bounces = NO;
    [backg addSubview:_top5];
    /**
     *  添加手势点击调用
     */
    UITapGestureRecognizer *test = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topNew:)];
    [_top5 addGestureRecognizer:test];
    return backg;
}
/**
 *  点击第几个就调用第几个
 *
 *  @param sender 点击手势
 */
- (void)topNew:(UITapGestureRecognizer *)sender{
    CGFloat offset = _top5.contentOffset.x;
    CGFloat witdh = self.view.frame.size.width;
    for (int i = 0; i < 5; i++) {
        if (offset == i*witdh) {
            [self top5new:i];
        }
    }
}
- (void)top5new: (int)sender{
    /**
     *  跳转到新闻页面
     *  sender是，判读点击的是哪个页面，返回数值，再去去相应的id传给下一个页面发送请求
     */
    newsViewController *wed = [self.storyboard instantiateViewControllerWithIdentifier:@"newsV"];
    wed.koID = [topid objectAtIndex:sender];
    [self.navigationController pushViewController:wed animated:YES];

}
/**
 *  返回herderview的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.frame.size.width*0.485;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleLabel.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_list dequeueReusableCellWithIdentifier:@"list"];
    UILabel *header = (UILabel *)[cell viewWithTag:210];
    UIImageView *iconNews = (UIImageView *)[cell viewWithTag:211];
    [iconNews sd_setImageWithURL:[NSURL URLWithString:imageURL[indexPath.row]]];
    header.text = titleLabel[indexPath.row];
    return cell;
}
#pragma mark - 委托到底部加载

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat frame = scrollView.frame.size.height;
    CGFloat cententsize = scrollView.contentSize.height;
    /**
     *  offset是原点位移量 frame是值scroll的高度，不是scroll上面东西的高度（可以选择添加一个数值不到底部就开是发送请求），cententsize这个就是scroll上面图层的高度了
     */
    if (offset + frame >= cententsize) {
        //[self timeUP];
        /**
         *  只访问一周的文章，所以>6后再减1，是保证在最后的时候一直读最后一天
         */
        js = js + 1;
        if (js > 6) {
          //  js = js -1;
        }else{
            [self olddaynews];
        }
    };
}
#pragma mark - 一周时间
/**
 *  计算一周的时间
 */
- (void)timeUP{
    NSDate *today = [NSDate date];
    NSDateFormatter *testDay = [[NSDateFormatter alloc] init];
    [testDay setDateFormat:@"YYYYMMdd"];
    for (int i = 0; i < 7; i++) {
        NSDate *oldDay = [NSDate dateWithTimeInterval:-60*60*24*i sinceDate:today];
        NSString *time = [testDay stringFromDate:oldDay];
        [TimeArray addObject:time];
        }
}
#pragma mark - 取出对应天数的图片链接和标题
/**
 *  取出对应天数的图片链接和标题
 */
- (void)olddaynews{
    NSString *times = [TimeArray objectAtIndex:js];
    if (js < 6) {
    NSString *ruls = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/stories/before/%@?client=0",times];
    NSLog(@"%@",ruls);
    NSURL *oldNewsURL = [NSURL URLWithString:ruls];
    NSURLSession *sion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *DataTask = [sion dataTaskWithURL:oldNewsURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",json[@"date"]);
        NSArray *oldnews = json[@"stories"];
        for (int i = 0 ; i < oldnews.count; i++) {
            NSDictionary *liebao = [oldnews objectAtIndex:i];
            NSArray *oldImages = liebao[@"images"];
            NSString *herder =  liebao[@"title"];
            NSString *storyID = liebao[@"id"];
            NSString *imageHttp = [oldImages objectAtIndex:0];
            [imageURL addObject:imageHttp];
            [titleLabel addObject:herder];
            [idToInt addObject:storyID];
            }
        /**
         *  主线程刷新ui
         */
            dispatch_async(dispatch_get_main_queue(), ^{
                /**
                 *  doit，还得研究下没必要重载整个tableview
                 */
                [_list reloadData];
                NSLog(@"reload");
                });
         }];
        /**
         *  发送
         */
        [DataTask resume];
    }
    
}
#pragma mark - 委托调整navi渐变颜色，使用了第三方
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY =  scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    /**
     *  不让他露底
     *
     *  @param 0    x轴位移
     *  @param -170 图片显示区域
     *
     *  @return 位移限制
     */
    
#pragma mark - 下拉不让其漏出底色
    if (offsetY  < -180) {
        _list.contentOffset = CGPointMake(0, -180);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
