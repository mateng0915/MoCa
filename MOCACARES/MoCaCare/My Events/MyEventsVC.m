//
//  MyEventsVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyEventsVC.h"
#import "CalendarVC.h"
#import "MyBookmarksTVC.h"
#import "HostedByMeTVC.h" 

@interface MyEventsVC ()
/// 我的行程
@property (nonatomic, strong) CalendarVC *calendarVC;
/// 我的书签
@property (nonatomic, strong) MyBookmarksTVC *myBookmarksTVC;
/// 我举办的活动（组织者账户才有）
@property (nonatomic, strong) HostedByMeTVC *hostedByMeTVC;
/// 当前显示的子视图
@property (nonatomic, strong) UIViewController *currentVC;
/// 当前选中的视图id
@property (nonatomic, assign) NSInteger idx;
// 上方图片
@property (nonatomic, strong) UIImage *img_calendar_n;
@property (nonatomic, strong) UIImage *img_calendar_s;
@property (nonatomic, strong) UIImage *img_bookmark_n;
@property (nonatomic, strong) UIImage *img_bookmark_s;
@property (nonatomic, strong) UIImage *img_hosted_n;
@property (nonatomic, strong) UIImage *img_hosted_s;
@end

@implementation MyEventsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [ModelUser accountColor];
    ShowBtnEvents(YES);
    [self.btnHosted.superview layoutIfNeeded];
    ModelUser *user = [ModelUser defaultUser];
    /// 账号类别 1参与者2组织者
    if (user.type.integerValue == 2) {
        self.layoutBtnHostedWidth.constant = M_Width / 3.0;
    } else {
        self.layoutBtnHostedWidth.constant = 0.0;
        [self btnCalendarClick:self.btnCalendar];
    }
    [self.view layoutIfNeeded];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarVC = [[CalendarVC alloc] init];
    self.myBookmarksTVC = [[MyBookmarksTVC alloc] initWithStyle:UITableViewStyleGrouped];
    self.hostedByMeTVC = [[HostedByMeTVC alloc] initWithStyle:UITableViewStyleGrouped];
    
    self.img_calendar_n = [MyFunction createItemImageWithName:@"icon_myEvents0_n"];
    self.img_calendar_s = [MyFunction createItemImageWithName:@"icon_myEvents0_s"];
    self.img_bookmark_n = [MyFunction createItemImageWithName:@"icon_myEvents1_n"];
    self.img_bookmark_s = [MyFunction createItemImageWithName:@"icon_myEvents1_s"];
    self.img_hosted_n = [MyFunction createItemImageWithName:@"icon_myEvents2_n"];
    self.img_hosted_s = [MyFunction createItemImageWithName:@"icon_myEvents2_s"];
    
    [self updateNavImages];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.myBookmarksTVC.parentViewController) {
        [self.viewContent layoutIfNeeded];
        [self addChildViewController:self.calendarVC];
        [self addChildViewController:self.myBookmarksTVC];
        [self addChildViewController:self.hostedByMeTVC];
        
        self.calendarVC.view.frame = self.viewContent.bounds;
        self.myBookmarksTVC.tableView.frame = self.viewContent.bounds;
        self.hostedByMeTVC.tableView.frame = self.viewContent.bounds;
        
        [self.viewContent addSubview:self.calendarVC.view];
        self.currentVC = self.calendarVC;
        self.idx = 0;
    }
}

#pragma mark - 更新上方图片
- (void)updateNavImages {
    UIImage *img_calendar = self.img_calendar_n;
    UIImage *img_bookmark = self.img_bookmark_n;
    UIImage *img_hosted = self.img_hosted_n;
    if (self.idx == 0) {
        img_calendar = self.img_calendar_s;
    } else if (self.idx == 1) {
        img_bookmark = self.img_bookmark_s;
    } else {
        img_hosted = self.img_hosted_s;
    }
    [self.btnCalendar setImage:img_calendar forState:UIControlStateNormal];
    [self.btnBookmark setImage:img_bookmark forState:UIControlStateNormal];
    [self.btnHosted setImage:img_hosted forState:UIControlStateNormal];
}

#pragma mark - 按钮事件
- (IBAction)btnCalendarClick:(UIButton *)sender {
    if (self.idx == 0)
        return; 
    [self tranViewController:self.calendarVC idx:0];
    [self.calendarVC requestData];
}
- (IBAction)btnBookmarkClick:(UIButton *)sender {
    if (self.idx == 1)
        return;
    [self tranViewController:self.myBookmarksTVC idx:1];
    [self.myBookmarksTVC requestData];
}
- (IBAction)btnHostedClick:(UIButton *)sender {
    if (self.idx == 2)
        return;
    [self tranViewController:self.hostedByMeTVC idx:2];
    [self.hostedByMeTVC requestData];
}
- (void)tranViewController:(UIViewController *)VC
                       idx:(NSInteger)idx {
    self.viewNav.userInteractionEnabled = NO;
    self.idx = idx;
    [self updateNavImages];
    [self transitionFromViewController:self.currentVC toViewController:VC duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            self.viewNav.userInteractionEnabled = YES;
            self.currentVC = VC;
        }
    }];
    
}
@end
