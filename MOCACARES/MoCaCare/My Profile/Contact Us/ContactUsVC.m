//
//  ContactUsVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ContactUsVC.h"

@interface ContactUsVC ()

@end

@implementation ContactUsVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // ShowBtnEvents(NO);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
} 


@end
