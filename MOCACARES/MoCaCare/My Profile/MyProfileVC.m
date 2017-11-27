//
//  MyProfileVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyProfileVC.h"

@implementation MyProfileVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ShowBtnEvents(YES);
    self.view.backgroundColor = [ModelUser accountColor];
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
}

@end
