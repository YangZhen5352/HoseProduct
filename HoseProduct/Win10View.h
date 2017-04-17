//
//  Win10View.h
//  HoseProduct
//
//  Created by edz on 2017/3/7.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Win10BtnClickBlock)(NSInteger tag);
@interface Win10View : UIView

@property (nonatomic, copy) Win10BtnClickBlock win10BtnClickBlock;
+ (instancetype)win10View;

@end
