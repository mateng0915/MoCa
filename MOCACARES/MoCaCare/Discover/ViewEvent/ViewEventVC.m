//
//  ViewEventVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ViewEventVC.h"
#import "PostEventVC.h"
#import "ViewEventTVC.h"
#import "ModelDiscover.h"
#import "ModelMyEvents.h"

@implementation ViewEventVC

+ (void)displayWithViewController:(UIViewController *)VC
                            event:(ModelEvent *)event {
    if (!event) {
        [MyFunction displayAlertLabelWithMessage:@"Get activity information failed"];
        return;
    }
    ModelUser *user = [ModelUser defaultUser];
    if ([event.uid isEqualToString:user.id]) {
        // 自己发布的活动
        PostEventVC *Event = [PostEventVC defaultEvent:event];
        [VC.navigationController pushViewController:Event animated:YES];
    } else {
        ViewEventVC *Event = [UIStoryboard storyboardWithName:@"ViewEvent" bundle:VC.nibBundle].instantiateInitialViewController;
        Event.event = event;
        [VC.navigationController pushViewController:Event animated:YES];
    }
}

#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // ShowBtnEvents(NO);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ModelUser accountColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ViewEventTVCSegue"]) {
        ViewEventTVC *VC = segue.destinationViewController;
        if ([self.event isKindOfClass:[ModelMyEvent class]]) {
            VC.eventId = ((ModelMyEvent *)self.event).aid;
        } else {
            VC.eventId = self.event.id;
        }
    }
}

@end
