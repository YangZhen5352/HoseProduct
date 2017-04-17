//
//  YYAdViewController.m
//  NEWs
//
//  Created by 杨振 on 15/11/23.
//  Copyright © 2015年 yangzhen5352. All rights reserved.
//

#import "YYAdViewController.h"
#import "MainTabBarVC.h"
#import "AdFirstDetaileVC.h"

@interface YYAdViewController ()
@property (nonatomic, strong) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UIView *adView;

@end

@implementation YYAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)timerAction {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YYMainVC" bundle:nil];
    MainTabBarVC *mainVc = [[MainTabBarVC alloc] init];
    
    window.rootViewController = mainVc;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)toAdDetailView:(UIButton *)sender {
    
    [self.timer invalidate];
    
    AdFirstDetaileVC *mainVc = [[AdFirstDetaileVC alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = mainVc;
}
- (IBAction)colseAd:(UIButton *)sender {
    
    [self.timer invalidate];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YYMainVC" bundle:nil];
    MainTabBarVC *mainVc = [[MainTabBarVC alloc] init];
    window.rootViewController = mainVc;
}


@end
