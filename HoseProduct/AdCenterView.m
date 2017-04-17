//
//  AdCenterView.m
//  HomeProperty
//
//  Created by edz on 2017/3/4.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "AdCenterView.h"

@interface AdCenterView()



@end

@implementation AdCenterView

+ (instancetype)centerView{
    AdCenterView *center = LoadNib(@"AdCenterView");
    
    return  center;
}

- (IBAction)toDetaileView:(UIButton *)sender {
    if (self.adDetailBlock) {
        self.adDetailBlock();
    }
}
- (IBAction)closeView:(UIButton *)sender {
    if (self.adCloseBlock) {
        self.adCloseBlock();
    }
}

@end
