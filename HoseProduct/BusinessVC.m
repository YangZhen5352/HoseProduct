//
//  BusinessVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "BusinessVC.h"
#import "BusinessHeaderView.h"

#import "BusinessVC01.h"
#import "BusinessVC02.h"
#import "BusinessVC03.h"

@interface BusinessVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BusinessHeaderView *businessHeaderView;
@end

@implementation BusinessVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:nil action:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"业务洽谈";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 21.png"]forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBarTintColor:KMainColor];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    self.tableView.tableHeaderView = self.businessHeaderView;
    
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"businessID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark - 懒加载
- (BusinessHeaderView *)businessHeaderView
{
    if (!_businessHeaderView) {
        _businessHeaderView = [BusinessHeaderView businessHeaderView];
        __weak __typeof(self)weakSelf = self;
        _businessHeaderView.businessBlock = ^(NSInteger tag){
            switch (tag) {
                case 0:
                {
                    BusinessVC01 *b = [[BusinessVC01 alloc] init];
                    [weakSelf.navigationController pushViewController:b animated:YES];
                }
                    break;
                case 1:
                {
                    BusinessVC02 *b = [[BusinessVC02 alloc] init];
                    [weakSelf.navigationController pushViewController:b animated:YES];
                }
                    break;
                case 2:
                {
                    BusinessVC03 *b = [[BusinessVC03 alloc] init];
                    [weakSelf.navigationController pushViewController:b animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _businessHeaderView;
}

@end
