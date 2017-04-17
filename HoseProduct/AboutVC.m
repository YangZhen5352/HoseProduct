//
//  AboutVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *cell01;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell;

@end

@implementation AboutVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
}
- (void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:self action:@selector(backTo)];
    [self.navigationController.navigationBar setBarTintColor:KMainColor];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blueColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 21.png"]forBarMetrics:UIBarMetricsDefault];
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell01.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"===> %ld  -> %ld", indexPath.row, indexPath.section);
    if (indexPath.row == 1) {
        [self showOkayCancelAlert];
    }
}
/**
 *  CancelAlert 普通弹框
 */
- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"给神灯房产评分", nil);
    NSString *message = NSLocalizedString(@"感谢您使用神灯房产，如果喜欢我们的产品，给个好评吧～～", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"下次再说", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"好，支持下", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Cancel\" alert's cancel action occured.");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay\" alert's other action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
