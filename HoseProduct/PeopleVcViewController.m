//
//  PeopleVcViewController.m
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
// 裁剪圆形头像
#import "UIImageView+Cycle.h"

#import "SVProgressHUD.h"
#import "PeopleVcViewController.h"
#import "SIAlertView.h"
#import "ProgressView.h"
// AlertView
//#import "SIAlertView.h"

#import "ChangePasswordVC.h"
#import "ServeCenterVC.h"
#import "AboutVC.h"
#import "PeoCenterVC.h"         // 客服中心
#import "JGActionSheet.h"
#import "MessageVCViewController.h"
#import "MainTabBarVC.h"

// 分享
#import "ShareView.h"
//微信分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

// 测试身份证识别
#import "IDAuthViewController.h"

@interface PeopleVcViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (strong, nonatomic) UIImagePickerController *imgPickerC;//相册控制器
@property (strong, nonatomic) JGActionSheet *actionSheet;//弹出视图

// 头像视图
@property (weak, nonatomic) IBOutlet UIView *headerView;

// 分享
@property (nonatomic, strong) UIButton *backView;
@property (nonatomic, strong) ShareView *shareV;
@end

@implementation PeopleVcViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 分享
    [self showBackView];
    [self showShareView];
    
    // 添加通知
    // 设置信息已读
    Notifi_AddOb(@"MessageVCViewController", @selector(dismissMsgNumber:));
    // 测试关闭广告
    Notifi_Post(HomeCloseADView, @{@"people" : @"1"});
    
    // 头像添加首饰
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.header addGestureRecognizer:tap];
    
    
    
    if (GetObjcForKey(@"CycleImageData")) {
        self.header.image = [UIImage imageWithData:GetObjcForKey(@"CycleImageData")];
    }

    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"个人中心";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
//    [self.navigationController.navigationBar setBarTintColor:KMainColor];
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blueColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
}
- (IBAction)gotoMessageVC:(UIButton *)sender {
    
    MessageVCViewController *vc = [[MessageVCViewController alloc] init];
    
    MainTabBarVC *barVC = (MainTabBarVC *)self.tabBarController;
    UIImageView *imgView = (UIImageView *)barVC.tabBar.subviews.lastObject;
    UILabel *numberlabel = imgView.subviews.lastObject;
    vc.numberlabel = numberlabel.text;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dismissMsgNumber:(NSNotification *)n
{
    NSString *numberString = n.userInfo[@"MessageVCViewController"];
    
    // 取消消息提醒
    MainTabBarVC *barVC = (MainTabBarVC *)self.tabBarController;
    UIImageView *imgView = (UIImageView *)barVC.tabBar.subviews.lastObject;
    UILabel *label = imgView.subviews.lastObject;
    label.text = numberString;
    CGRect tabFrame = barVC.tabBar.frame;
    CGFloat x = ceilf(0.92 * tabFrame.size.width);
    CGFloat y = ceilf(0.2 * tabFrame.size.height)-3;
    ([numberString intValue] >= 10) ? (imgView.frame = CGRectMake(x, y, NumberWidth, NumberHeight)) : (imgView.frame = CGRectMake(x, y, NumberHeight, NumberHeight));
    ;
    if ([numberString intValue] == 0) {
        imgView.hidden = YES;
    }
    if ([numberString intValue] >= 100) {
        label.text = @"...";
        imgView.frame = CGRectMake(x, y, NumberHeight, NumberHeight);
        label.frame = CGRectMake(2.5, -4, NumberHeight, NumberHeight);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"===>> row =>%ld  section =>%ld", indexPath.row, indexPath.section);
    if (indexPath.section == 0) {
        // 我的订单
        self.tabBarController.selectedIndex = 1;
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            // 修改密码
            ChangePasswordVC *e = [[ChangePasswordVC alloc] init];
            [self.navigationController pushViewController:e animated:YES];
        } else if (indexPath.row == 2) {
            // 清除缓存
//            [self showOkayCancelActionSheet];
            [self showAlertActionView];
//            Alert(@"提示", @"暂无缓存需要清理");
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            // 客服中心
            PeoCenterVC *s = [[PeoCenterVC alloc] init];
            [self.navigationController pushViewController:s animated:YES];
        } else if (indexPath.row == 2) {
            // 关于神灯
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AboutVC" bundle:nil];
            AboutVC *a = sb.instantiateInitialViewController;
            [self.navigationController pushViewController:a animated:YES];
            
            // 测试身份证识别
//            IDAuthViewController *auth = [[IDAuthViewController alloc] init];
//            [self.navigationController pushViewController:auth animated:YES];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            NSLog(@"分享");
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.backView.alpha = 0.4;
                weakSelf.backView.hidden = NO;
                weakSelf.shareV.frame = CGRectMake(0, ScreenHeight - 200, ScreenWidth, 200);
                self.tabBarController.tabBar.hidden = YES;
                self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            }];
        }
    }
}
#pragma mark -------------- 分享 ------------------
- (void)dismissShareView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.backView.alpha = 0.0;
        weakSelf.shareV.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 200);
        self.tabBarController.tabBar.hidden = NO;
    } completion:^(BOOL finished) {
        weakSelf.backView.hidden = YES;
    }];
}
- (void)showBackView
{
    [self.view addSubview:self.backView];
}
- (UIButton *)backView
{
    if (!_backView) {
        _backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
        [_backView addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
        _backView.hidden = YES;
    }
    return _backView;
}
- (void)showShareView
{
    __weak ShareView *shareV = [ShareView shareView];
    shareV.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 200);
//    [shareV.cancleBtn setTitleColor:KNormalColor];
    
    shareV.shareViewBlock = ^(UIButton *btn, NSString *btnTitle){
        
        //图文分享的图片
        UIImage *shareImg;
        //无图片
        shareImg = [UIImage imageNamed:@"weichate.png"];

        if (btn.tag == 0) {
            // 微信好友
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"神灯金融房产";
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.wechatSessionData.shareText = @"房产金融抵押贷款，贴心保障，让你放心使用。";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:nil image:shareImg location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
            }];
            
        } else if (btn.tag == 1) {
            // 微信朋友圈
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"神灯金融房产";
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = @"房产金融抵押贷款，贴心保障，让你放心使用。";
            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeApp;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:shareImg location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
            
                                [SVProgressHUD showInfoWithStatus: @"分享成功"];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [SVProgressHUD dismiss];
                                });
            }];
            
        } else if (btn.tag == 2){
            // 二维码分享
            [UIView animateWithDuration:0.5 animations:^{
                shareV.codeView.frame = CGRectMake(0, 0, shareV.width, shareV.height);
            }];
            
        } else if (btn.tag == 3) {
            [UIView animateWithDuration:0.5 animations:^{
                shareV.codeView.frame = CGRectMake(0, 200, shareV.width, shareV.height);
            }];
        }
    };
    
    [self.view addSubview:shareV];
    self.shareV = shareV;
}

#pragma mark -------------- 分享 ------------------


- (void)showAlertActionView
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"清除缓存" andMessage:@"包括图片和数据缓存资源"];
    [alertView addButtonWithTitle:@"确认"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                               // 初始化进度条 <显示清理进度>
                              ProgressView *progress = [[ProgressView alloc] initWithIndex:2];
                              progress.finishedProgress = ^{
                                  // 完成回调
                              };
                              [self.view addSubview:progress];
                              
                              // 不现实进度
//                              MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                              hud.mode = MBProgressHUDModeCustomView;
//                              UIView *v = [[UIView alloc] init];
//                              v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ok01@2x.png"]];
//                              v.frame = CGRectMake(0, 0, 40, 30);
//                              hud.customView = v;
//                              hud.labelText = @"清理完成";
//                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
//                              dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                                  // Do something...
//                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
//                              });
                              
                          }];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Button3 Clicked");
                          }];
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}
/**
 *  ActionSheet 效果
 */
- (void)showOkayCancelActionSheet {
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *destructiveButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"包括图片和数据缓存资源" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark --------------------- 访问相册相机 ------------------------

- (void)tap:(UITapGestureRecognizer *)tap{
    //头像！Q
    [self.actionSheet showInView:self.view animated:YES];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSData *data;
    
    //获得编辑后的image
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    data = UIImageJPEGRepresentation(image, 0.5);
    
    //模态回去
    [picker dismissViewControllerAnimated:YES completion:^{
        //更新头像
        [self.header clipCycleImageData:data borderWidth:10 borderColor:[UIColor whiteColor]];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消");
    }];
}
#pragma mark - 压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -
#pragma mark - 懒加载
- (UIImagePickerController *)imgPickerC{
    
    if (!_imgPickerC) {
        _imgPickerC = [[UIImagePickerController alloc] init];
        _imgPickerC.delegate = self;
        _imgPickerC.allowsEditing = YES;
    }
    return _imgPickerC;
}

- (JGActionSheet *)actionSheet{
    
    if (!_actionSheet) {
        
        _actionSheet = [[JGActionSheet alloc] initWithSections:@[[JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"拍照",@"从手机相册选择"] buttonStyle:JGActionSheetButtonStyleDefault],[JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel]]];
        
        __weak typeof(self) weakSelf = self;
        
        [_actionSheet setButtonPressedBlock:^(JGActionSheet *actionSheet, NSIndexPath *indexPath) {
            
            //选择的下角标
            NSInteger section = indexPath.section;
            NSInteger row = indexPath.row;
            
            //拍照
            if (section == 0 && row == 0) {
                
#pragma mark - 检测是模拟器还是真机
#if TARGET_IPHONE_SIMULATOR
                
                Alert(@"提示", @"相机启动失败，请检查相机是否正常。");
#else
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    weakSelf.imgPickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [weakSelf presentViewController:weakSelf.imgPickerC animated:YES completion:^{
                        [actionSheet dismissAnimated:YES];
                    }];
                }
#endif
            }
            
            //从手机相册中选取
            if (section == 0 && row == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                weakSelf.imgPickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [weakSelf presentViewController:weakSelf.imgPickerC animated:YES completion:^{
                    [actionSheet dismissAnimated:YES];
                }];
            }
            
            //取消按键
            if (section == 1 && row == 0) {
                [actionSheet dismissAnimated:YES];
            }
        }];
        
        [_actionSheet setOutsidePressBlock:^(JGActionSheet *actionSheet) {
            [actionSheet dismissAnimated:YES];
        }];
        
    }
    return _actionSheet;
}


@end
