//
//  ViewController.m
//  TXT
//
//  Created by qing on 15/7/13.
//  Copyright (c) 2015年 qing. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UITextView *txtreader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [UIScreen mainScreen].bounds;
    _shuju = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"漂流瓶的故事" ofType:@"txt" ]  encoding:NSUTF8StringEncoding error:nil];
    _pageTitles = @[@"_shuju", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    //_pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    PageContentViewController *startViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.view bringSubviewToFront:_startAgainButton];
    [self.pageViewController didMoveToParentViewController:self];
}
- (IBAction)startWalkthroug:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *)viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index -= 1;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *)viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index += 1;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    //pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}
@end
