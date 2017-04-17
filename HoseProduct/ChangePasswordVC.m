//
//  ChangePasswordVC.m
//  RiShangProject
//
//  Created by 刘天正 on 16/7/6.
//  Copyright © 2016年 刘天正. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "UserLoginVC.h"
#import "KeychainTool.h"
#import "NSString+YY_NSPredicate.h"

@interface ChangePasswordVC ()


@property (weak, nonatomic) IBOutlet UIImageView *background;//背景


@property (weak, nonatomic) IBOutlet UITextField *oldPassword;//旧密码


@property (weak, nonatomic) IBOutlet UITextField *correctPassword;//新密码


@property (weak, nonatomic) IBOutlet UITextField *checkPassword;//确认密码


@property (weak, nonatomic) IBOutlet UIButton *changeBtn;//修改按键


//修改事件
- (IBAction)changeSuccessBtnHandle:(id)sender;


@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"退出登陆" style:UIBarButtonItemStylePlain target:self action:@selector(goBackLogin)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = leftBar;
}
- (void)goBackLogin
{
    [self showOkayCancelActionSheet];
}

- (IBAction)changeSuccessBtnHandle:(id)sender
{
    NSLog(@" Password ---> %@", [KeychainTool readKeychainValue:Password]);
    if (![self.oldPassword.text isEqual:[KeychainTool readKeychainValue:Password]]) {
        Alert(@"提示", @"愿密码输入错误，请重新输入");
        return;
    }
    if (![NSString validatePassword:self.correctPassword.text]) {
        Alert(@"提示", @"请输入8-20位密码");
        return;
    }
    if (![self.correctPassword.text isEqual:self.checkPassword.text]) {
        Alert(@"提示", @"新密码输入不一致，请重新输入");
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"修改成功";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [KeychainTool saveKeychainValue:self.checkPassword.text key:Password];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserLoginVC" bundle:nil];
        UserLoginVC *u = sb.instantiateInitialViewController;
        window.rootViewController = u;
        
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

/**
 *  ActionSheet 效果
 */
- (void)showOkayCancelActionSheet {
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *destructiveButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登陆" message:@"退出程序清除缓存数据" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"退出中...";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserLoginVC" bundle:nil];
            UserLoginVC *u = sb.instantiateInitialViewController;
            window.rootViewController = u;
            
            // Do something...
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
