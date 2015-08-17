//
//  newsViewController.m
//  知乎日报
//
//  Created by xiong on 15/8/11.
//  Copyright (c) 2015年 xiong. All rights reserved.
//

#import "newsViewController.h"
#import <UIImageView+WebCache.h>
#import <UINavigationController+FDFullscreenPopGesture.h>


@interface newsViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *newsStory;
@property (strong, nonatomic) UIImageView *firstImage;
@property (strong, nonatomic) UILabel *herder;
@property (strong, nonatomic) UILabel *sourece;
@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) UIView *shadView;
@property (strong, nonatomic) NSString *body;
@end

@implementation newsViewController{

    BOOL add;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    _statusBarView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_statusBarView];
    _statusBarView.hidden = YES;
    add = YES;
    _newsStory.delegate = self;
    _newsStory.scrollView.delegate = self;
    _firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -70, self.view.frame.size.width, self.view.frame.size.width)];
    _firstImage.clipsToBounds = YES;
    UIColor *light = [UIColor blackColor];
    UIColor *gra = [light colorWithAlphaComponent:0.2];
    _shadView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, self.view.frame.size.width, self.view.frame.size.width+80)];
    _shadView.backgroundColor = gra;
    [_firstImage addSubview:_shadView];
    [_newsStory.scrollView addSubview:_firstImage];
    /**
     标题
     */
    _herder = [[UILabel alloc]initWithFrame:CGRectMake(10, _firstImage.frame.size.width*0.32, 260, 80)];
    _herder.numberOfLines = 0;
    _herder.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    //_herder.adjustsFontSizeToFitWidth = YES;
    _herder.textColor = [UIColor whiteColor];
    [self.newsStory.scrollView addSubview:_herder];
    /**
     *  图片版权
     */
    CGFloat iphone5 = self.view.frame.size.width;
    if (iphone5 == 320) {
        _sourece = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, self.view.frame.size.width*0.53, 140 , 30)];
    }else{
        _sourece = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, self.view.frame.size.width*0.45, 140 , 30)];}
    NSLog(@"%f",self.view.frame.size.width*0.45);
    _sourece.font =[UIFont fontWithName:@"Helvetica" size:8];
    _sourece.textAlignment = NSTextAlignmentRight;
    _sourece.textColor = [UIColor whiteColor];
    [self.newsStory.scrollView addSubview:_sourece];
    NSString *story = _koID;
    NSString *URL = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story/%@",story];
    NSURL *webURL = [NSURL URLWithString:URL];
    NSURLSession *sion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *DataTask = [sion dataTaskWithURL:webURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
        { NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //NSLog(@"%@",json);
            /**
             *  正文
             */
            _body = json[@"body"];
            /**
             *  CSS格式
             */
            NSArray *css = json[@"css"];
            /**
             *  图片版权
             */
            NSString *source = json[@"image_source"];
            /**
             *  标题
             */
            NSString *title = json[@"title"];
            
            /**
             *  转发URL
             */
            //NSURL *share = json[@"share_url"];
            
                [_firstImage sd_setImageWithURL:json[@"image"]];
                NSString *from = [NSString stringWithFormat:@"图片：%@",source];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _sourece.text = from;
                    _herder.text = [NSString stringWithFormat:@"%@",title];
                });
                NSURL *cssui = [css objectAtIndex:0];
                
                _body = [NSString stringWithFormat:@"%@<link rel=\"stylesheet\" href=\"%@\">", _body, cssui];
                [_newsStory loadHTMLString:_body baseURL:nil];
            
            

                              }];
    [DataTask resume];
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat ScrollOffset = _newsStory.scrollView.contentOffset.y;
    CGFloat imageHeight = _firstImage.frame.size.height;
   NSLog(@"-------%f", ScrollOffset);
        _firstImage.frame = CGRectMake(0, ScrollOffset/2-self.view.frame.size.width*0.197, self.view.frame.size.width, self.view.frame.size.width*0.8-ScrollOffset/2);
        _shadView.frame = CGRectMake(0, -70, self.view.frame.size.width, _firstImage.frame.size.height+72);
        _firstImage.contentMode = UIViewContentModeCenter;
        _firstImage.contentMode = UIViewContentModeScaleAspectFill;
    /**
     *  设置一个bool值，view创建时隐藏，将bool = yes；
     *  当位移>图片宽度时候 bool = yes；
     *  当位移<图片宽度时候检查bool值，如果=no，就隐藏这个view
     *  避免反复执行
     */
    if (ScrollOffset > imageHeight) {
        //NSLog(@"%f%f",ScrollOffset, imageHeight);
        if (add == YES) {
            _statusBarView.hidden = NO;
            add = NO;
            }
                }else if (add == NO){
                    //NSLog(@"hiden******");
                    _statusBarView.hidden = YES;
                    add = YES;
                    }
    if (ScrollOffset  < -147) {
        _newsStory.scrollView.contentOffset = CGPointMake(0, -147);
    }
}

/*- (UIStatusBarStyle)preferredStatusBarStyle
{
    return 1;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}*/

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
