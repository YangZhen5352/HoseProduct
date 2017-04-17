//
//  MessageVCViewController.m
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MessageVCViewController.h"
#import "MessageCell01.h"

@interface MessageVCViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 已读消息列表
@property (nonatomic, strong) NSMutableArray *readMsg;

@end

@implementation MessageVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView.rowHeight = 200;
    
    // 获取已经查看的消息列表
    if (GetObjcForKey(@"readMsg")) {
        NSArray *arr = GetObjcForKey(@"readMsg");
        self.readMsg = [arr mutableCopy];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell01 *cell = [MessageCell01 messageCell01:tableView];
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < self.readMsg.count; ++i) {
        if (indexPath.row == [self.readMsg[i] integerValue]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"已查看";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });

            return;
        }
    }
    self.numberlabel = [NSString stringWithFormat:@"%d", [self.numberlabel intValue] - 1];
    Notifi_Post(@"MessageVCViewController", @{@"MessageVCViewController" : self.numberlabel});
    
    [self.readMsg addObject:@(indexPath.row)];
    SetObjcForKey(self.readMsg, @"readMsg");
}

#pragma mark - 懒加载
- (NSMutableArray *)readMsg
{
    if (!_readMsg) {
        _readMsg = [NSMutableArray array];
    }
    return _readMsg;
}
@end
