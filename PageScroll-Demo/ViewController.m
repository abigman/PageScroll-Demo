//
//  ViewController.m
//  PageScroll-Demo
//
//  Created by JieLee on 15/3/27.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "ViewController.h"
#import "KBView.h"

#define kTabHeight 0
#define kStatusBarHeight 64
#define KDevice_Width [[UIScreen mainScreen] bounds].size.width
#define KDevice_Height [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (nonatomic, strong) MSTabScrollView *tabScrollView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld周", [self getCurrentWeek] - 10];
    [self createPageScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.tabScrollView resetPageViewContentSize];
}

- (void)createPageScrollView {
    
    self.titleArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat pageHeight = KDevice_Height - kStatusBarHeight;
    CGFloat pageWidth = KDevice_Width;
    
    self.tabScrollView = [[MSTabScrollView alloc]initWithPageWidth:pageWidth  PageHeight:pageHeight Delegate:self];
    self.tabScrollView.tabSelectedColor = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1];
    
    self.tabScrollView.tabBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.tabScrollView.selectedTabIndex = [self getCurrentWeekDay] - 1;
    
    [self.tabScrollView handleLayout];
    [self.view addSubview:self.tabScrollView];
    
    
    //使用自动布局，非自动布局时去掉
    NSDictionary *metrics = @{@"TopHeight":@(kStatusBarHeight),@"BottomHeight":@(kTabHeight)};
    [self.tabScrollView setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                                 Format2:@"V:|-TopHeight-[view]-BottomHeight-|"
                                                 metrics:metrics
                                               superView:self.view];
}


#pragma mark - MSTabScrollViewDelegate

- (NSInteger)NumberOfTabInTabScrollView:(UIScrollView *)tabScrollView {
    return self.titleArray.count;
}

- (UIView *)tabScrollView:(UIScrollView *)tabScrollView pageViewForTabIndex:(NSInteger)tabIndex {
    
    KBView *pageView = [[KBView alloc] init];
    pageView = [KBView viewWithArr:@[@"信号与系统\n1-15\n杨会玉\n尔雅楼402", @"数学建模\n1-4\n王磊\n尔雅楼402", @"信号与系统\n1-15\n杨会玉\n尔雅楼402", @"数学建模\n1-4\n王磊\n尔雅楼402", @"信号与系统\n1-15\n杨会玉\n尔雅楼402"]];
 

    return pageView;
}

- (NSString *)tabScrollView:(UIScrollView *)tabScrollView titleForTabIndex:(NSInteger)tabIndex {
    if (tabIndex < self.titleArray.count) {
        return self.titleArray[tabIndex];
    }
    return nil;
}


#pragma mark - 适应设备旋转时增加以下部分代码
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationPortrait];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationLandscape];
        default:
            break;
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}


#pragma mark - 两个扩展方法

- (NSInteger)getCurrentWeek {
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekOfYear;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return [dateComponent weekOfYear];
}

- (NSInteger)getCurrentWeekDay {
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return [dateComponent weekday];
}

@end
