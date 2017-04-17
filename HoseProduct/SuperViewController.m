//
//  SuperViewController.m
//  HoseProduct
//
//  Created by edz on 2017/3/6.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:self action:@selector(backTo)];
    [self.navigationController.navigationBar setBarTintColor:KMainColor];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blueColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 21.png"]forBarMetrics:UIBarMetricsDefault];
    
}
- (void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
