//
//  BusinessHeaderView.m
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "BusinessHeaderView.h"

@interface BusinessHeaderView()

@end

@implementation BusinessHeaderView

+ (instancetype)businessHeaderView
{
    BusinessHeaderView *b = LoadNib(@"BusinessHeaderView");
    
    return b;
}
- (IBAction)headerBtnClick:(UIButton *)sender {
    if (self.businessBlock) {
        self.businessBlock(sender.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
