//
//  AdFirstDetaileVC.m
//  HomeProperty
//
//  Created by edz on 2017/3/4.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "AdFirstDetaileVC.h"
#import "MainTabBarVC.h"

@interface AdFirstDetaileVC ()

@end

@implementation AdFirstDetaileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)close:(UIButton *)sender {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YYMainVC" bundle:nil];
    MainTabBarVC *mainVc = [[MainTabBarVC alloc] init];
    window.rootViewController = mainVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
