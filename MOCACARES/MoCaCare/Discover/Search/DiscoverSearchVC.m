//
//  DiscoverSearchVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "DiscoverSearchVC.h"
#import "DiscoverSearchTVC.h"
#import "DiscoverVC.h"

@implementation DiscoverSearchVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ShowBtnEvents(NO);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ShowBtnEvents(YES);
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DiscoverSearchTVCSegue"]) {
        DiscoverSearchTVC *VC = segue.destinationViewController; 
        [self addChildViewController:VC];
    }
}

#pragma mark - 返回主页并搜索
- (void)searchWorld:(NSString *)key {
    // 等键盘小时后再执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.discoverVC.searchString = key;
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
