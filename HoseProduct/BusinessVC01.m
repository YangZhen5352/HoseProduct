//
//  BusinessVC01.m
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "BusinessVC01.h"

@interface BusinessVC01 ()

@end

@implementation BusinessVC01

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:0 target:self action:@selector(backTo)];
//    [self.navigationController.navigationBar setBarTintColor:KMainColor];
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    [self loadHtml:@"admissioncondition"];
}
- (void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
