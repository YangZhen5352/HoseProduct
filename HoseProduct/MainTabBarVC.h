//
//  MainTabBarVC.h
//  HoseProduct
//
//  Created by edz on 2017/3/6.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeVC.h"
#import "OrderVC.h"
#import "BusinessVC.h"
#import "PeopleVcViewController.h"

@interface MainTabBarVC : UITabBarController

@property (nonatomic, strong) UIImageView *peopleCenterInfo;
@property (nonatomic, strong) UILabel *peopleCenterNumber;

@end
