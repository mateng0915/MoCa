//
//  MainTabBarController.m
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MainTabBarController.h"
#import "ServiceAccount.h"
#import "AccountLoginTVC.h"
#import "PostEventVC.h"
#import "MySocket.h"

@interface MainTabBarController ()
/// 导航控制器数组
@property (nonatomic, copy) NSArray<UINavigationController *> *navArr;
@end

@implementation MainTabBarController

#pragma mark - 实例化变量
+ (instancetype)defaultTabBarController {
    static MainTabBarController *MTC;
    if (!MTC) {
        MTC = [[MainTabBarController alloc] init];
        [MTC setChildNavigationViewControllers];
    }
    return MTC;
}
 
+ (void)display {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MainTabBarController *MTC = [self defaultTabBarController]; 
    window.rootViewController = MTC;
    NSLog(@"主控制器复位");
    [MTC.navArr enumerateObjectsUsingBlock:^(UINavigationController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj popToRootViewControllerAnimated:YES];
    }];
    MTC.selectedIndex = 0;
    [MTC requestData];
}

#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.barTintColor = ThemeColorRed;
    self.tabBar.translucent = NO; // 取消透明度
    // 修改标题样式
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(MAXFLOAT, MAXFLOAT) forBarMetrics:UIBarMetricsDefault];
    
    [self requestData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 连接Socket
    [MySocket connectToService];
}
- (void)applicationDidEnterBackground {
    [MySocket connectToService];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 发布活动按钮
- (UIButton *)btnPostEvent {
    if (!_btnPostEvent) {
        CGFloat width = self.tabBar.bounds.size.height;
        _btnPostEvent = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnPostEvent.tag = TagBtnEvents;
        _btnPostEvent.frame = CGRectMake(0, 0, width, width);
        _btnPostEvent.layer.cornerRadius = width / 2.0;
        [_btnPostEvent setBackgroundImage:[UIImage imageNamed:@"icon_postEvent"] forState:UIControlStateNormal];
        _btnPostEvent.backgroundColor = ThemeColorRed;
        [_btnPostEvent addTarget:self action:@selector(btnPutActivityClick:) forControlEvents:UIControlEventTouchUpInside];
        CGPoint center = CGPointMake(M_Width / 2.0, M_Height - self.tabBar.bounds.size.height);
        _btnPostEvent.center = center;
    }
    return _btnPostEvent;
}
- (void)btnPutActivityClick:(UIButton *)sender {
//    NSLog(@"发布活动");
    self.selectedIndex = 0;
    PostEventVC *VC = [PostEventVC defaultEvent:nil];
    UINavigationController *NVC = self.navArr.firstObject;
    UIViewController *TopVC = NVC.viewControllers.lastObject;
    if ([TopVC isKindOfClass:[PostEventVC class]]) {
        NSLog(@"不用重复跳转");
    } else {
        [NVC pushViewController:VC animated:YES];
    }
}

#pragma mark — 数据请求更新用户信息
- (void)requestData {
    [ServiceAccount getUserInfoSuccess:^(ModelUser *user) {
        if (user.type.integerValue == 2) {
            if (!self.btnPostEvent.superview) {
                [M_Window addSubview:self.btnPostEvent];
            }
            ShowBtnEvents(YES);
        } else {
            ShowBtnEvents(NO);
            [self.btnPostEvent removeFromSuperview];
        }
    } failure:^{
        ShowBtnEvents(NO);
        [self.btnPostEvent removeFromSuperview];
//        AccountLoginTVC *VC = [AccountLoginTVC defaultLoginVC];
//        [self presentViewController:VC animated:YES completion:^{
//        }];
    }];
}

- (void)setNavArr:(NSArray<UINavigationController *> *)navArr {
    _navArr = navArr;
    // 设置选中背景
    CGSize size = self.tabBar.bounds.size;
    self.tabBar.selectionIndicatorImage = [self drawTabBarItemBackgroupImageWithSize:CGSizeMake(size.width / navArr.count, size.height) color:ThemeColorDarkRed];
}

#pragma mark - 绘制tabBarItem背景图片（替代背景色）
- (UIImage *)drawTabBarItemBackgroupImageWithSize:(CGSize)size color:(UIColor *)color {
    // 初始化绘图板
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 填充背景色
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    // 获取绘图板中的图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 结束绘图
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 设置子导航控制器
- (void)setChildNavigationViewControllers {
    NSMutableArray<UINavigationController *> *mNavArr = [NSMutableArray array];
    // 各视图控制器所在sb的名称
    NSArray<NSString *> *storyboardNames =
        @[@"Discover", @"Recommended",
          @"MyEvents", @"MyProfile"];
    for (int i = 0; i < 4; i ++) {
        /// 这里需要创建对应的Storyboard来初始化各个视图(用数组存放sb名)
        NSString *sbName = storyboardNames[i];
        UIViewController *VC = [UIStoryboard storyboardWithName:sbName bundle:self.nibBundle].instantiateInitialViewController;
        // 导入导航控制器
        UINavigationController *NVC = [[UINavigationController alloc] initWithRootViewController:VC];
        [mNavArr addCheckObject:NVC];
    }
    self.navArr = [mNavArr copy];
    // 设置子导航视图控制器样式
    [self setChildNavigationViewControllersStyle];
    // 添加到自控制器中
    [self setViewControllers:self.navArr];
}

- (void)setChildNavigationViewControllersStyle {
    // 底部菜单栏标题
    NSArray<NSString *> *titles_Tab =
        @[@"Discover", @"Recommended",
          @"My Events", @"My Profile"]; 
    for (int i = 0; i < self.navArr.count; i ++) {
        NSString *title_tab = titles_Tab[i];
        NSString *imgName_normal = [NSString stringWithFormat:@"icon_tabbar%d", i];
        NSString *imgName_selected = [NSString stringWithFormat:@"icon_tabbar%d", i];
        
        UIImage *img_normal = [[MyFunction createItemImageWithName:imgName_normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *img_selected = [[MyFunction createItemImageWithName:imgName_selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置导航栏样式
        UINavigationController *NVC = self.navArr[i];
        NVC.navigationBar.barTintColor = [UIColor whiteColor];
        NVC.navigationBar.tintColor = ThemeColor;
        NVC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : ThemeColor};
        NVC.navigationBar.translucent = NO;
        [MyFunction hiddenUnderHairlineWithNavigationController:NVC];
        NVC.navigationBar.hidden = YES;
        
        // 设置菜单栏
        NVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title_tab image:img_normal selectedImage:img_selected];
        // 如果不想要title，设置偏移量是图片居中
//        NVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
}

#pragma mark - 设置中间发布按钮


@end
