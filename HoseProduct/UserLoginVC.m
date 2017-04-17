//
//  UserLoginVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/9.
//  Copyright © 2017年 edz. All rights reserved.
//
#import "UIImageView+Cycle.h"

#import "UserLoginVC.h"
#import "MainTabBarVC.h"
#import "NSString+YY_NSPredicate.h"
#import "KeychainTool.h"
#import "YYAdViewController.h"


@interface UserLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerBackView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation UserLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerBackView.layer.masksToBounds = YES;
    self.headerBackView.layer.cornerRadius = 10;
    
    if (GetObjcForKey(@"CycleImageData")) {
        self.imgView.image = [UIImage imageWithData:GetObjcForKey(@"CycleImageData")];
    }
}
- (IBAction)loginClick:(UIButton *)sender {
    
    //登录失败
    if (![NSString validateMobile:self.userName.text]) {
        if (self.userName.text.length > 4) {
            if (!([[self.userName.text substringToIndex:3] isEqual:@"177"])) {
                Alert(@"提示", @"请输入正确的手机号");
                return;
            }
        } else {
            Alert(@"提示", @"请输入正确的手机号");
            return;
        }
    }
    
    if (![NSString validatePassword:self.password.text]) {
        Alert(@"提示", @"请输入8-20位密码");
        return;
    }
    if (![self.password.text isEqual:[KeychainTool readKeychainValue:Password]]) {
        Alert(@"提示", @"输入的密码错误，请重新输入");
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeIndeterminate;
//      UIView *v = [[UIView alloc] init];
//      v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ok01@2x.png"]];
//      v.frame = CGRectMake(0, 0, 40, 30);
//      hud.customView = v;
      hud.labelText = @"登陆成功";
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          
          //    SetBoolForKey(YES, @"userLogin");
          UIWindow *window = [UIApplication sharedApplication].keyWindow;
          UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Ad" bundle:nil];
          YYAdViewController *ad = sb.instantiateInitialViewController;
          window.rootViewController = ad;
          
          // 登陆成功 保存用户名和密码
          [KeychainTool saveKeychainValue:self.userName.text key:UserName];
          [KeychainTool saveKeychainValue:self.password.text key:Password];
          
          // Do something...
          [MBProgressHUD hideHUDForView:self.view animated:YES];
      });
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        // 用户名
    }
    else if (textField.tag == 1) {
        // 密码
    }
}


@end
