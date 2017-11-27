//
//  ViewEventVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEvent;
@interface ViewEventVC : UIViewController
/// 活动id
@property (nonatomic, strong) ModelEvent *event;

/*
 * 显示活动详情
 * @param VC :上一页
 * @param eventId :活动id
 */
+ (void)displayWithViewController:(UIViewController *)VC
                            event:(ModelEvent *)event;
@end
