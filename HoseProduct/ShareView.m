//
//  ShareView.m
//  RiShangProject
//
//  Created by 杨振 on 16/7/6.
//  Copyright © 2016年 刘天正. All rights reserved.
//

#import "ShareView.h"

@interface ShareView()

@property (strong, nonatomic) NSArray *btnTitles;

@end
@implementation ShareView

+ (instancetype)shareView
{
    return LoadNib(@"ShareView");
}

- (IBAction)shareButtonClick:(UIButton *)sender {
    _btnTitles = @[@"微信好友", @"微信朋友圈", @"新浪微博", @"QQ好友", @"QQ空间", @"二维码分享", @"取消"];
    if (self.shareViewBlock) {
        self.shareViewBlock(sender, _btnTitles[sender.tag]);
    }
}

@end
