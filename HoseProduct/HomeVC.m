//
//  HomeVC.m
//  HoseProduct
//
//  Created by edz on 2017/3/6.
//  Copyright © 2017年 edz. All rights reserved.
//
#import "MJRefresh.h"
#import "MJRefreshGifHeader.h"

#import "HomeVC.h"
#import "SDCycleScrollView.h"   // 轮播视图
#import "Win10View.h"           // win10视图xib
#import "PeopleHomeCell.h"      // 客户中心cell
#import "TitleView.h"           // nav搜索视图
#import "PeopleCenterView.h"    // 客户中心xib

#import "RevolvingLonaVC.h"     // 周转贷
#import "DirectLoanVC.h"        // 直投贷
#import "BusinessVC01.h"        // 准入条件
#import "PriceHandeVC.h"        // 询价助手
#import "CommitCellVC.h"        // 提交订单
#import "MysuggestionVC.h"      // 我要投诉
#import "CommonQuestionVC.h"    // 常见问题
#import "ProductIntroduceVC.h"  // 联系我们
#import "InstructionVC.h"       // 使用说明

#import "AdCenterView.h"        // 添加中心广告视图
#import "AdMinddleVC.h"         // 点击广告的详情视图控制器

#define PushVC(Class) Class *c = [[Class alloc] init];\
[weakSelf.navigationController pushViewController:c animated:YES];

@interface HomeVC ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

// mj
@property (nonatomic, strong) NSMutableArray *headerImages;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

// navSearch
@property (nonatomic, strong) TitleView *titleVi;

// tableView的header
@property (nonatomic, strong) UIView *headerView;

// banner
@property(nonatomic,strong)SDCycleScrollView *cycleSV; //轮播图
@property(nonatomic,strong)NSArray *cycleArr;   //图片Url数组
// win10视图
@property (nonatomic, strong) Win10View *win10View;

// peopleCenter
@property (nonatomic, strong) UIView *peopleCenterView;

// AdCenter
@property (nonatomic, strong) AdCenterView *adCenterView;
@property (nonatomic, strong) UIView *backView;
@end

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (NSMutableArray *)headerImages
{
    if (!_headerImages) {
        _headerImages = [NSMutableArray array];
        for (int i = 1; i <= 60; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
            [_headerImages addObject:image];
        }
    }
    return _headerImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试mj刷新
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新 <自定义gif图片>
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
//    gifHeader.stateLabel.hidden = YES;
//    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    //1.2.3 自定义刷新状态文字
    [gifHeader setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [gifHeader setTitle:@"松开进行刷新状态" forState:MJRefreshStatePulling];
    [gifHeader setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [gifHeader setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    [gifHeader setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    // 设置字体
    gifHeader.stateLabel.font = [UIFont systemFontOfSize:15];
    gifHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    gifHeader.stateLabel.textColor = [UIColor grayColor];
    gifHeader.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    
    [gifHeader setImages:@[self.headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:self.headerImages duration:0.5 forState:MJRefreshStateRefreshing];
    tableView.mj_header = gifHeader;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新 <自定义gif图片>
    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        });
    }];
    gifFooter.stateLabel.hidden = YES;
    gifFooter.refreshingTitleHidden = YES;
    [gifFooter setImages:@[self.headerImages[0]] forState:MJRefreshStateIdle];
    [gifFooter setImages:self.headerImages duration:0.5 forState:MJRefreshStateRefreshing];
    tableView.mj_footer = gifFooter;
    
    // 设置搜索栏
    self.navigationItem.titleView = self.titleVi;
    // 设置header
    self.tableView.tableHeaderView = self.headerView;
    // 设置cell高度
    self.tableView.rowHeight = 80;
    // 关闭反弹效果
//    self.tableView.bounces = NO;
    NSLog(@"--> %@", [self.navigationController.navigationBar subviews]);
    
    // 创建广告视图
    [self.view addSubview:self.backView];
    [self.view addSubview:self.adCenterView];
    
    // 添加通知：关闭广告
    Notifi_AddOb(HomeCloseADView, @selector(closeAdView:));
}
- (void)closeAdView:(NSNotification *)n
{
    // 关闭广告
    [UIView animateWithDuration:0.3 animations:^{
        self.adCenterView.alpha = 0;
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        self.adCenterView.hidden = YES;
        self.backView.hidden = YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PeopleHomeCell *cell = [PeopleHomeCell peopleHomeCell:tableView];
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offY = scrollView.contentOffset.y;
    
    if ((offY > 30) || (offY < -30)) {
        self.navigationItem.titleView = nil;
    } else {
        self.navigationItem.titleView = self.titleVi;
    }
    // 取消键盘
    [self.titleVi resignFirstResponder];
}

#pragma mark - 懒加载
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenWidth/2 + 270 + 70)];
        // 设置轮播图片
        self.cycleArr = @[@"banner003.png", @"banner002.png", @"banner001.png"];
        self.cycleSV.imageURLStringsGroup = self.cycleArr;
        
        // 轮播图
        [_headerView addSubview:self.cycleSV];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleSV.frame), ScreenWidth, 290)];
        backView.backgroundColor = RGB(240, 240, 240, 1.0);
        [_headerView addSubview:backView];
        // 设置win10
        [_headerView addSubview:self.win10View];
        
        // 客户中心
        [_headerView addSubview:self.peopleCenterView];
    }
    return _headerView;
}
//轮播图
- (SDCycleScrollView *)cycleSV{
    
    if (!_cycleSV) {
        
        _cycleSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2) delegate:self placeholderImage:LOADIMAGE(@"bigPicture.png")];
        _cycleSV.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleSV.currentPageDotColor = KMainColor;
        _cycleSV.pageDotColor = [UIColor lightGrayColor];
        _cycleSV.autoScrollTimeInterval = 3.0;
    }
    return _cycleSV;
}

//url数组
- (NSArray *)cycleArr{
    
    if (!_cycleArr) {
        _cycleArr = [NSArray array];
    }
    return _cycleArr;
}
- (Win10View *)win10View{
    if (!_win10View) {
        _win10View = [Win10View win10View];
        _win10View.frame = CGRectMake(10, CGRectGetMaxY(self.cycleSV.frame) + 10, ScreenWidth - 20, 270);
        _win10View.layer.masksToBounds = YES;
        _win10View.layer.cornerRadius = 8;
        __weak __typeof(self)weakSelf = self;
        _win10View.win10BtnClickBlock = ^(NSInteger tag){
            NSLog(@"++>> %ld", tag);
            switch (tag) {
                case 0: //询价助手
                {
                    PushVC(PriceHandeVC)
                }
                    break;
                case 1: //提交订单
                {
                    PushVC(CommitCellVC)
                }
                    break;
                case 2: //周转贷
                {
                    PushVC(RevolvingLonaVC)
                }
                    break;
                case 3: //直投贷
                {
                    PushVC(DirectLoanVC)
                }
                    break;
                case 4: //准入条件
                {
                    PushVC(BusinessVC01)
                }
                    break;
                case 5: //更多
                {
                    weakSelf.tabBarController.selectedIndex = 2;
                }
                    break;
                case 6: //我要投诉
                {
                    PushVC(MysuggestionVC)
                }
                    break;
                case 7: //常见问题
                {
                    PushVC(CommonQuestionVC)
                }
                    break;
                case 8: //使用说明
                {
                    PushVC(InstructionVC)
                }
                    break;
                case 9: //联系我们
                {
                    PushVC(ProductIntroduceVC)
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _win10View;
}
- (UIView *)peopleCenterView{
    if (!_peopleCenterView) {
        _peopleCenterView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.win10View.frame) + 10, ScreenWidth - 20, 50)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-10, 49, ScreenWidth, 1.0)];
        line.backgroundColor = RGB(230, 230, 230, 1.0);
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, ScreenWidth, 1.0)];
        line1.backgroundColor = RGB(230, 230, 230, 1.0);
        [_peopleCenterView addSubview:[PeopleCenterView peopleCenterView]];
        [_peopleCenterView addSubview:line];
        [_peopleCenterView addSubview:line1];
        
    }
    return _peopleCenterView;
}
- (TitleView *)titleVi
{
    if (!_titleVi) {
        _titleVi = [TitleView titleView];
    }
    return _titleVi;
}
// 中心广告视图
- (AdCenterView *)adCenterView{
    if (!_adCenterView) {
        __weak __typeof(self)weakSelf = self;
        _adCenterView = [AdCenterView centerView];
        _adCenterView.size = CGSizeMake(200, 300);
        _adCenterView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _adCenterView.adDetailBlock = ^(){
            
            AdMinddleVC *ad = [[AdMinddleVC alloc] init];
            [weakSelf.navigationController pushViewController:ad animated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.adCenterView.hidden = YES;
                weakSelf.backView.hidden = YES;
            });
        };
        _adCenterView.adCloseBlock = ^(){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.adCenterView.alpha = 0;
                weakSelf.backView.alpha = 0;
            } completion:^(BOOL finished) {
                weakSelf.adCenterView.hidden = YES;
                weakSelf.backView.hidden = YES;
            }];
        };
    }
    return _adCenterView;
}
// 中心广告背景底色图
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.5;
    }
    return _backView;
}
@end
