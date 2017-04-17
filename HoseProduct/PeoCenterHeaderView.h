//
//  PeoCenterHeaderView.h
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PCenterBlock)(NSInteger tag);

@interface PeoCenterHeaderView : UIView
@property (nonatomic, copy) PCenterBlock pCenterBlock;
+ (instancetype)pCenterView;
@end
