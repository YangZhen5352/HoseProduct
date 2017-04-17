//
//  PriceHandeVC.m
//  HomeProperty
//
//  Created by edz on 2017/3/3.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "PriceHandeVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface PriceHandeVC ()

@end

@implementation PriceHandeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    clearButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [clearButton setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    
    SetObjcForKey(@"inquiry_assistant", @"GoBackWebURL");
    [self loadHtml:@"inquiry_assistant"];
}
- (void)goBack
{
    NSString *currentWebURL = GetObjcForKey(@"CurrentWebURL");
    if (currentWebURL.length > 0) {
        NSLog(@"currentWebURL -> %@", currentWebURL);
    }
    NSString *goBackWebURL = GetObjcForKey(@"GoBackWebURL");
    if (goBackWebURL.length > 0) {
        NSLog(@"goBackWebURL -> %@", goBackWebURL);
        [self loadHtml: goBackWebURL];
    }
}

@end
