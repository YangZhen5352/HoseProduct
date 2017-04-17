//
//  ProgressView.m
//  ZhongYingRenShou
//
//  Created by 杨振 on 16/5/20.
//  Copyright © 2016年 seerkey_joker. All rights reserved.
//

#import "ProgressView.h"


@interface ProgressView()

@property (nonatomic, strong) UIView        * messView1;
@property (nonatomic, copy) NSString        * filePath;

@property (nonatomic, assign) CGFloat         percentage;
@property (nonatomic, strong) MBProgressHUD * HUD;
@property (nonatomic, strong) UIView        * backgroundView;
@property (nonatomic, assign) BOOL            isTimer;

@property (nonatomic, strong) NSTimer       * connectionTimer;
@property (nonatomic, strong) NSTimer       * connectionTimer02;
@property (nonatomic, strong) NSTimer       * connectionTimer03;
@end

// 进度区域
#define Timer01 0.5
#define Timer02 0.9
#define Timer03 1.0

// 进度数度 快 -> 慢
//  0.01 ------ 1.0
#define TimeInterval01 0.2
#define TimeInterval02 0.05
#define TimeInterval03 0.6

@interface ProgressView()

@property (nonatomic, strong) NSArray *timeRange;
@property (nonatomic, strong) NSArray *timeInterval;

@property (nonatomic, strong) NSArray *tRanges;
@property (nonatomic, strong) NSArray *tIntervals;

@end

@implementation ProgressView
// WithTime:(NSInteger)index
- (instancetype)initWithIndex:(int)index
{
    self = [super init];
    if (self) {
        self.index = index;
        self.tIntervals = self.timeInterval[self.index];
        self.tRanges = self.timeRange[self.index];
        
        self.frame = CGRectMake(4, -35, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        [self progress];
    }
    return self;
}
- (void)progressWithTimer01:(NSTimer *)timer
{
    
    self.percentage += 0.01;
    
    self.HUD.progress = self.percentage;
    if (self.percentage >= [self.tRanges[0] floatValue]) {
        
        //关闭定时器
        [self.connectionTimer setFireDate:[NSDate distantFuture]];
        [self.connectionTimer invalidate];
        self.connectionTimer = nil;
        
        [self.connectionTimer02 setFireDate:[NSDate distantPast]];
        self.connectionTimer02 = [NSTimer scheduledTimerWithTimeInterval: [self.tIntervals[1] floatValue]  target:self selector:@selector(progressWithTimer02:) userInfo:nil repeats:YES];
    }
}
- (void)progressWithTimer02:(NSTimer *)timer
{
    self.percentage += 0.01;
    
    self.HUD.progress = self.percentage;
    if (self.percentage >= [self.tRanges[1] floatValue]) {
        
        //关闭定时器
        [self.connectionTimer02 setFireDate:[NSDate distantFuture]];
        [self.connectionTimer02 invalidate];
        self.connectionTimer02 = nil;
        
        [self.connectionTimer03 setFireDate:[NSDate distantPast]];
        self.connectionTimer03 = [NSTimer scheduledTimerWithTimeInterval: [self.tIntervals[2] floatValue]  target:self selector:@selector(progressWithTimer03:) userInfo:nil repeats:YES];
    }
}
- (void)progressWithTimer03:(NSTimer *)timer
{
    self.percentage += 0.01;
    
    self.HUD.progress = self.percentage;
    if (self.percentage >= [self.tRanges[2] floatValue]) {
        
        [self.backgroundView removeFromSuperview];
        [self.HUD hide:YES];
        [self.HUD removeFromSuperview];
        
        //关闭定时器
        [self.connectionTimer03 setFireDate:[NSDate distantFuture]];
        [self.connectionTimer03 invalidate];
        self.connectionTimer03 = nil;
        
        if (self.finishedProgress) {
            self.finishedProgress();
        }
        
        self.isTimer = YES;
    }
}
- (void)progress
{
    // 创建进度条
    if (!self.isTimer) {
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(-4, 35, 1024, 768)];
        vi.backgroundColor = [UIColor blackColor];
        vi.userInteractionEnabled = NO;
        vi.alpha = 0.2;
        [self addSubview:vi];
        [self sendSubviewToBack:vi];
        self.backgroundView = vi;
        
        //初始化进度条
        MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self];
        [self addSubview:HUD];
        [self bringSubviewToFront:HUD];
        HUD.tag=1000;
        HUD.mode = MBProgressHUDModeDeterminate;
        HUD.labelText = @"清理中...";
        HUD.square = YES;
        [HUD show:YES];
        self.HUD = HUD;
    }
    
    [self.connectionTimer setFireDate:[NSDate distantPast]];
    self.connectionTimer = [NSTimer scheduledTimerWithTimeInterval: [self.tIntervals[self.index] floatValue] target:self selector:@selector(progressWithTimer01:) userInfo:nil repeats:YES]; 
}

#pragma mark----------- lazy -------------------
// 进度数度
- (NSArray *)timeInterval
{
    if (!_timeInterval) {
        _timeInterval = [NSArray arrayWithObjects:@[@(0.2), @(0.05), @(0.6)],
                         @[@(0.05), @(0.3), @(0.05)],
                         @[@(0.01), @(0.03), @(0.01)],
                         nil];
    }
    return _timeInterval;
}

// 范围
- (NSArray *)timeRange
{
    if (!_timeRange) {
        _timeRange = [NSArray arrayWithObjects:@[@(0.5), @(0.8), @(1.0)], // 慢
                      @[@(0.3), @(0.5), @(1.0)], // 中
                      @[@(0.5), @(0.7), @(1.0)], // 快
                      nil];
    }
    return _timeRange;
}
@end
