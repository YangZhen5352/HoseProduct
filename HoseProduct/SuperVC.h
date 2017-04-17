//
//  SuperVC.h
//  HomeProperty
//
//  Created by edz on 2017/3/2.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXWebViewController.h"

@interface SuperVC : AXWebViewController

@property (nonatomic, copy) NSString *htmlName;
- (void)loadHtml:(NSString *)fileName;

@end
