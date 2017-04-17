//
//  Win10View.m
//  HoseProduct
//
//  Created by edz on 2017/3/7.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "Win10View.h"

@implementation Win10View

+ (instancetype)win10View{
    
    Win10View *win = LoadNib(@"Win10View");
    
    return win;
}

- (IBAction)headerBtnClick:(UIButton *)sender {
    if (self.win10BtnClickBlock) {
        self.win10BtnClickBlock(sender.tag);
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
