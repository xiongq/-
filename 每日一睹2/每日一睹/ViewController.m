//
//  ViewController.m
//  每日一睹
//
//  Created by qing on 15/8/4.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *readView;
@property (strong, nonatomic) NSMutableArray *timeWeek;
- (IBAction)right:(id)sender;
- (IBAction)left:(id)sender;
@end

@implementation ViewController
{
    int bb;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self timeArray];
    _readView.scrollView.bounces = NO;
    [self thistiem];
}

/**
 *  手势向右滑动
 *
 *  @param sender right
 */
- (IBAction)right:(id)sender {
    bb = bb + 1;
    if(bb > 6) {
        bb = bb - 1;
        UIAlertView *ultimatum = [[UIAlertView alloc]initWithTitle:@"翻到最后一个了" message:@"这是7天的最后一章" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [ultimatum show];
    }
    //NSLog(@"前一天%d",bb);
    [self shuzi:&(bb) array:_timeWeek];
}
/**
 *  手势向左滑动
 *
 *  @param sender left
 */
- (IBAction)left:(id)sender {
    bb = bb - 1;
    if(bb < 0) {
        bb = bb + 1;
        UIAlertView *ultimatum = [[UIAlertView alloc]initWithTitle:@"翻到最前一个了" message:@"这是当天的" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [ultimatum show];
    }
    //NSLog(@"前一天%d",bb);
    [self shuzi:&(bb) array:_timeWeek];
}


/**
 *  将json处理，合并为html
 *
 *  @param dict 获取的json转字典再取值
 */
- (void)wedview:(NSDictionary *)dict
{
    NSString *author = dict[@"author"];
    // NSLog(@"%@",author);
    NSString *title = dict[@"title"];
    // NSLog(@"%@",title);
    NSString *content = dict[@"content"];
    // NSLog(@"%@",content);
    /**
     *  全文查找替换，也就是缩进，不懂HTML
     */
    NSString *helloe = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@"<p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"];
    //NSLog(@"%@",helloe);
    /**
     *  指定class
     */
    NSString *HTML = [NSString stringWithFormat:@"<div class=\"title\">%@</div><div class=\"author\">%@</div><div class=\"helloe\">%@</div>",title,author,helloe];
    /**
     *  获取css
     */
    NSURL *meiri = [[NSBundle mainBundle] URLForResource:@"meiri" withExtension:@"css"];
    /**
     *  套用格式
     */
    HTML = [NSString stringWithFormat:@"%@<link rel=\"stylesheet\" href=\"%@\">", HTML, meiri];
    
    /**
     *  将处理好的HTML加载到wedview
     */
    [_readView loadHTMLString:HTML baseURL:nil];
}


/**
 *  首页
 */
-(void) thistiem{
    NSDate *today = [NSDate date];/**< 获取当前时间 */
    NSDateFormatter *old = [[NSDateFormatter alloc]init];
    [old setDateFormat:@"YYYYMMdd"];/**<时间格式 */
    NSString *now = [old stringFromDate:today];/**< 转换为指定格式 */
    NSString *to1 = @"";
    NSString *temp2 = [to1 stringByAppendingFormat:@"http://api.meiriyiwen.com/v2/day?date=%@&version=4",now];
    NSURL *first = [NSURL URLWithString:temp2];
    NSURLRequest *request = [NSURLRequest requestWithURL:first];
    [self nsurlandwedview:request];
}

/**
 *  根据当前日期计算一周的日期
 */
- (void)timeArray{
    NSDate *today = [NSDate date];/**< 获取当前时间 */
    NSDateFormatter *old = [[NSDateFormatter alloc]init];
    [old setDateFormat:@"YYYYMMdd"];/**<时间格式 */
    // NSString *now = [old stringFromDate:today];/**< 转换为指定格式 */
    _timeWeek = [[NSMutableArray alloc]init];
    
    /**
     *  for循环获取一周的日期添加到数组
     */
    for (int i = 0 ; i<7; i++) {
        NSDate *yestarday = [NSDate dateWithTimeInterval:-60*60*24*i sinceDate:today];
        NSString *lost = [old stringFromDate:yestarday];
        [_timeWeek addObject:lost];
        //NSLog(@"yestarday%@",lost);
    }
    //NSLog(@"this%@",[_timeWeek objectAtIndex:0]);
}

/**
 *  传入int和数组，手势左右滑动时调用该方法发送请求加载数据
 */
-(void)shuzi:(int *)ri  array:(NSMutableArray *)timeweek {
    NSString *now = [NSString stringWithFormat:@"%@",[_timeWeek objectAtIndex:bb]];
    NSString *to1 = @"";
    NSString *temp2 = [to1 stringByAppendingFormat:@"http://api.meiriyiwen.com/v2/day?date=%@&version=4",now];
    //NSLog(@"API%@",temp2);
    NSURL *haha = [NSURL URLWithString:temp2];
    NSURLRequest *muc = [NSURLRequest requestWithURL:haha];
    [self nsurlandwedview:muc];
    
    
}

/**
 *  将返回的json放入字典
 */
- (void)nsurlandwedview:(NSURLRequest *)request {
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        /**
         *  调用方法排版后显示
         */
        [self wedview:dict];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
