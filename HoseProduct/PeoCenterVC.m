//
//  PeoCenterVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "PeoCenterVC.h"
#import "PeoCenterHeaderView.h"
#import "EditorPassVC.h"

@interface PeoCenterVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PeoCenterHeaderView *peoCenterHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PeoCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.tableHeaderView = self.peoCenterHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (PeoCenterHeaderView *)peoCenterHeaderView
{
    if (!_peoCenterHeaderView) {
        __weak __typeof(self)weakSelf = self;
        _peoCenterHeaderView = [PeoCenterHeaderView pCenterView];
        _peoCenterHeaderView.pCenterBlock = ^(NSInteger tag){
            EditorPassVC *e = [[EditorPassVC alloc] init];
            [weakSelf.navigationController pushViewController:e animated:YES];
        };
    }
    return _peoCenterHeaderView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
