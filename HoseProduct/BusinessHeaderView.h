//
//  BusinessHeaderView.h
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BusinessBlock)(NSInteger tag);

@interface BusinessHeaderView : UIView

@property (nonatomic, copy) BusinessBlock businessBlock;

+ (instancetype)businessHeaderView;

@end
