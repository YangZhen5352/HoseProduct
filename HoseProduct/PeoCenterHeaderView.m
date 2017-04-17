//
//  PeoCenterHeaderView.m
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "PeoCenterHeaderView.h"

@implementation PeoCenterHeaderView
+ (instancetype)pCenterView
{
    PeoCenterHeaderView *p = LoadNib(@"PeoCenterHeaderView");
    return p;
}
- (IBAction)editorPassword:(UIButton *)sender {
    if (self.pCenterBlock) {
        self.pCenterBlock(sender.tag);
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
