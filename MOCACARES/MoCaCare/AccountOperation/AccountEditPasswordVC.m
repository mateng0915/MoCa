//
//  AccountEditPasswordVC.m
//  MoCaCare
//
//  Created by xhb on 2017/10/12.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AccountEditPasswordVC.h"

@interface AccountEditPasswordVC ()

@end

@implementation AccountEditPasswordVC

+ (instancetype)defalutType:(EditPasswortType)type {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AccountOperation" bundle:nil];
    NSString *ider = (type == EditPassword ? @"EditPasswordVC" : @"EditPasswordCompletedVC");
    AccountEditPasswordVC *VC = [sb instantiateViewControllerWithIdentifier:ider];
    return VC;
}

#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
}

@end
