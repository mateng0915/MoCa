//
//  RecommendedVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "RecommendedVC.h"
#import "RecommendedTVC.h"
#import "MenuVC.h"
#import "ModelDiscover.h"
#import "ServiceDiscover.h"

@interface RecommendedVC ()
/// 菜单
@property (nonatomic, strong) MenuVC *menu;
/// 内容
@property (nonatomic, weak) RecommendedTVC *tvc;
@end

@implementation RecommendedVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ShowBtnEvents(YES);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
    [self requestCategorys];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RecommendedTVCSegue"]) {
        self.tvc = segue.destinationViewController;
    }
}

#pragma mark - 数据请求
- (void)requestCategorys {
    [ServiceDiscover getEventCategoryListSuccess:^(NSArray<ModelEventCategory *> *list) {
        self.categorys = [list copy];
        // 默认选择全部类型
        self.selectedCategorys = [list mutableCopy];
    } failure:^{
        
    }];
}

#pragma mark - 按钮事件
- (IBAction)btnMenuClick:(UIButton *)sender {
//    NSLog(@"菜单");
    if (!self.menu)
        self.menu = [[MenuVC alloc] init];
    
    [self.menu displayWithViewController:self categorys:self.categorys selectedCategorys:self.selectedCategorys selectMenu:^(NSArray<ModelEventCategory *> *selectedCategorys) {
        self.selectedCategorys = [selectedCategorys mutableCopy];
        // 类别替换记得清空数据
        self.tvc.categorys = [selectedCategorys copy];
        self.tvc.events = [NSMutableArray array];
        [self.tvc requestData];
//        NSLog(@"选中以下类别：%@", selectedCategorys);
    }];
}

@end
