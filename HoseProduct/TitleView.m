//
//  TitleView.m
//  HoseProduct
//
//  Created by edz on 2017/3/7.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

+ (instancetype)titleView{
    TitleView *view = LoadNib(@"TitleView");
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
