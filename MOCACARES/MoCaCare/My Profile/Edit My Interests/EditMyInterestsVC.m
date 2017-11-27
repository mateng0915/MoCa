//
//  EditMyInterestsVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EditMyInterestsVC.h"
#import "EditMyInterestsTVC.h"

@interface EditMyInterestsVC ()
/// 视图控制器——志愿者
@property (nonatomic, strong) EditMyInterestsTVC *IndividualsTVC;
/// 视图控制器——组织者
@property (nonatomic, strong) EditMyInterestsTVC *OrganizationsTVC;
// 上方图片
@property (nonatomic, strong) UIImage *img_individuals_n;
@property (nonatomic, strong) UIImage *img_individuals_s;
@property (nonatomic, strong) UIImage *img_organizations_n;
@property (nonatomic, strong) UIImage *img_organizations_s;
@end

@implementation EditMyInterestsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // ShowBtnEvents(NO);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
    
    self.btnBack.tintColor = [UIColor darkTextColor];
    [self.btnBack setImage:[MyFunction createItemImageWithName:@"icon_back"] forState:UIControlStateNormal];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Edit My Interests" bundle:self.nibBundle];
    self.IndividualsTVC = [sb instantiateViewControllerWithIdentifier:@"EditMyInterestsTVC"];
    self.IndividualsTVC.type = FridensTypeVolunteer;
    self.OrganizationsTVC = [sb instantiateViewControllerWithIdentifier:@"EditMyInterestsTVC"];
    self.OrganizationsTVC.type = FridensTypeOrganization;
    
    self.img_individuals_n = [MyFunction createItemImageWithName:@"icon_myIntersts0_n"];
    self.img_individuals_s = [MyFunction createItemImageWithName:@"icon_myIntersts0_s"];
    self.img_organizations_n = [MyFunction createItemImageWithName:@"icon_myIntersts1_n"];
    self.img_organizations_s = [MyFunction createItemImageWithName:@"icon_myIntersts1_s"];
    
    [self updateNavImages];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.IndividualsTVC.parentViewController) {
        [self addChildViewController:self.IndividualsTVC];
        [self addChildViewController:self.OrganizationsTVC];
        [self.viewContent layoutIfNeeded];
        self.IndividualsTVC.tableView.frame = self.viewContent.bounds;
        self.OrganizationsTVC.tableView.frame = self.viewContent.bounds;
        [self.viewContent addSubview:self.IndividualsTVC.tableView];
    } 
}

#pragma mark - 更新上方图片
- (void)updateNavImages { 
    UIImage *img_individuals = self.img_individuals_n;
    UIImage *img_organizations = self.img_organizations_n;
    if (self.idx == 0) {
        img_individuals = self.img_individuals_s;
    } else { 
        img_organizations = self.img_organizations_s;
    }
    [self.btnIndividuals setImage:img_individuals forState:UIControlStateNormal];
    [self.btnOrganizations setImage:img_organizations forState:UIControlStateNormal];
}

#pragma mark - 按钮事件
- (IBAction)btnBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnIndividualsClick:(UIButton *)sender {
    if (self.idx == 0)
        return;
    self.idx = 0;
    [self transitionFromViewController:self.OrganizationsTVC toViewController:self.IndividualsTVC];
}
- (IBAction)btnOrganizationsClick:(UIButton *)sender {
    if (self.idx == 1)
        return;
    self.idx = 1;
    [self transitionFromViewController:self.IndividualsTVC toViewController:self.OrganizationsTVC];
}
- (void)transitionFromViewController:(UITableViewController *)VC1
                    toViewController:(UITableViewController *)VC2 {
    self.viewNav.userInteractionEnabled = NO;
    VC1.tableView.alpha = 0;
    VC2.tableView.alpha = 0;
    [self updateNavImages];
    
    [self transitionFromViewController:VC1 toViewController:VC2 duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        VC2.tableView.alpha = 1;
    } completion:^(BOOL finished) { 
        self.viewNav.userInteractionEnabled = YES; 
    }];
}
@end
