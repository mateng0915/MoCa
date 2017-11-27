//
//  MessagesVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MessagesVC.h"

@implementation MessagesVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // ShowBtnEvents(NO);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
}


@end
