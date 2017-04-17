//
//  ShareView.h
//  RiShangProject
//
//  Created by 杨振 on 16/7/6.
//  Copyright © 2016年 刘天正. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShareViewBlock)(UIButton *btn, NSString *btnTitle);

@interface ShareView : UIView

// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTopOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTopTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTopThrees;


@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Height;
@property (nonatomic, strong) ShareViewBlock shareViewBlock;

+ (instancetype)shareView;

@end
