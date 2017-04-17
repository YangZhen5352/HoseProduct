//
//  AdCenterView.h
//  HomeProperty
//
//  Created by edz on 2017/3/4.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AdDetailBlock)();
typedef void (^AdCloseBlock)();

@interface AdCenterView : UIView

@property (nonatomic, copy) AdDetailBlock adDetailBlock;
@property (nonatomic, copy) AdCloseBlock adCloseBlock;

+ (instancetype)centerView;
@end
