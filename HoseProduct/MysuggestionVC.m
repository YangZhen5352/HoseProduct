//
//  MysuggestionVC.m
//  HomeProperty
//
//  Created by edz on 2017/3/3.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MysuggestionVC.h"

@interface MysuggestionVC ()

@end

@implementation MysuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadHtml:@"my_suggestion"];
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