//
//  SuperVC.m
//  HomeProperty
//
//  Created by edz on 2017/3/2.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "SuperVC.h"

@interface SuperVC ()

@end

@implementation SuperVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:KMainColor];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
}
- (void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadHtml:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:fileName
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    NSArray *arr = [htmlCont componentsSeparatedByString:@".html"];
    if (arr.count > 1) {
//        for (NSString *string in arr) {
//            NSArray *arr = [string componentsSeparatedByString:@"href=\""];
//            if (![arr.lastObject containsString:@"/"]) {
//                // 找到需要跳转的页面
//                NSLog(@"找到需要跳转的页面 ---> %@", arr.lastObject);
//            }
//        }
        for (int i = 0; i < arr.count - 1; ++i) {
            NSString *test = arr[i];
            NSArray *arr = [test componentsSeparatedByString:@"href=\""];
            ;
            self.htmlName = arr[arr.count - 1];
        }
    }
    [self loadHTMLString:htmlCont baseURL:baseURL];
    
    self.showsToolBar = NO;
    self.webView.allowsLinkPreview = YES;
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
