//
//  MainTabBarVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/6.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MainTabBarVC.h"
#import "SuperNaviVC.h"

#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:nil]]
#define SetTabBar(title, imgName, selectImgName) [[UITabBarItem alloc] initWithTitle:title image:[LOADIMAGE(imgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[LOADIMAGE(selectImgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]

@interface MainTabBarVC ()

@end

@implementation MainTabBarVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpController:0];
    
    [self.tabBar addSubview:self.peopleCenterInfo];
}
- (UIImageView *)peopleCenterInfo
{
    if (!_peopleCenterInfo) {
        _peopleCenterInfo = [[UIImageView alloc] init];
        _peopleCenterInfo.backgroundColor = [UIColor redColor];
        _peopleCenterInfo.layer.masksToBounds = YES;
        _peopleCenterInfo.layer.cornerRadius = NumberHeight/2;
        CGRect tabFrame = self.tabBar.frame;
        CGFloat x = ceilf(0.92 * tabFrame.size.width);
        CGFloat y = ceilf(0.2 * tabFrame.size.height)-3;
        
        [_peopleCenterInfo addSubview:self.peopleCenterNumber];
        self.peopleCenterNumber.frame = CGRectMake(4, 0, NumberHeight, NumberHeight);
        
        int Width = NumberHeight;
        int tempNum = [self.peopleCenterNumber.text intValue];
        if (tempNum >= 10 && tempNum <= 99) {
            Width = 23;
        } else if (tempNum >= 100) {
            self.peopleCenterNumber.text = @"...";
            self.peopleCenterNumber.frame = CGRectMake(2.5, -4, NumberHeight, NumberHeight);
        }
        _peopleCenterInfo.frame = CGRectMake(x, y, Width, NumberHeight);
        if (tempNum == 0) {
            _peopleCenterInfo.frame = CGRectMake(x, y, 0, 0);
        }
        if (tempNum == -1) {
            [UIView animateWithDuration:0.5 animations:^{
                _peopleCenterInfo.frame = CGRectMake(x, y, 0, 0);
            }];
        }
    }
    return _peopleCenterInfo;
}
- (UILabel *)peopleCenterNumber
{
    if (!_peopleCenterNumber) {
        _peopleCenterNumber = [[UILabel alloc] init];
        _peopleCenterNumber.textColor = [UIColor whiteColor];
        _peopleCenterNumber.font = [UIFont systemFontOfSize:13];
        _peopleCenterNumber.text = [NSString stringWithFormat:@"%ld", GetIntegerForKey(@"peopleCenterNumber")];
    }
    return _peopleCenterNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpController:(NSInteger)index{
    
    HomeVC *home = [[HomeVC alloc] init];
    SuperNaviVC *navHome = [[SuperNaviVC alloc] initWithRootViewController:home];
    navHome.tabBarItem = SetTabBar(@"首页", @"首页icon@2x.png", @"首页icon2@2x.png");
    
    OrderVC *order = [[OrderVC alloc] init];
    SuperNaviVC *navOrder = [[SuperNaviVC alloc] initWithRootViewController:order];
    navOrder.tabBarItem = SetTabBar(@"我的订单", @"订单icon@2x.png", @"订单icon2@2x.png");
    
    BusinessVC *business = [[BusinessVC alloc] init];
    SuperNaviVC *navBusiness = [[SuperNaviVC alloc] initWithRootViewController:business];
    navBusiness.tabBarItem = SetTabBar(@"业务流程", @"流程icon@2x.png", @"流程icon2@2x.png");
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PeopleVc" bundle:nil];
    PeopleVcViewController *people = sb.instantiateInitialViewController;
    SuperNaviVC *navPeople = [[SuperNaviVC alloc] initWithRootViewController:people];
    navPeople.tabBarItem = SetTabBar(@"个人中心", @"个人中心icon@2x.png", @"个人中心icon2@2x.png");
    
    // 添加控制器
    self.viewControllers = @[navHome, navOrder, navBusiness, navPeople];
    
    // 默认所选下角标
    self.selectedIndex = index;
    
    // 设置选中字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor,NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    
    // 设置未选中字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(102, 102, 102, 1),NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    // 设置底栏图片
    [[UITabBar appearance] setBackgroundImage:LOADIMAGE(@"矩形 2@2x.png")];
    
}
@end
