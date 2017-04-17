//
//  ProgressView.h
//  ZhongYingRenShou
//
//  Created by 杨振 on 16/5/20.
//  Copyright © 2016年 seerkey_joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef void (^FinishedProgress)();

@interface ProgressView : UIView

// 完成回调
@property (nonatomic, strong) FinishedProgress finishedProgress;

@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithIndex:(int)index;
@end
