//
//  PostEventVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventVC.h"
#import "PostEventTVC.h"
#import "ModelDiscover.h"

@interface PostEventVC()
/// 内容控制器
@property (nonatomic, weak) PostEventTVC *tvc;
/// 活动
@property (nonatomic, strong) ModelEvent *event; 
@end
@implementation PostEventVC

/** 实例化变量 */
+ (instancetype)defaultEvent:(ModelEvent *)event {
    PostEventVC *VC = [UIStoryboard storyboardWithName:@"PostEvent" bundle:nil].instantiateInitialViewController;
    VC.event = event;
    return VC;
}

#pragma mark - 视图加载
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
    self.view.backgroundColor = [ModelUser accountColor];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostEventTVCSegue"]) {
        self.tvc = segue.destinationViewController;
        if (!self.event) {
            self.event = [ModelEvent new];
            self.event.time_type = TimeModelOneOff;
        }
        if (self.event.question.count == 0)
            self.event.question = [@[@""] mutableCopy];
        
        self.tvc.event = self.event; 
        self.tvc.timeModel = self.event.time_type;
    }
}

@end
