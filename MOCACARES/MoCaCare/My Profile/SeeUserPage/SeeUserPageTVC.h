//
//  SeeUserPageTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelUserZone;
@interface SeeUserPageTVC : UITableViewController
/// 用户id
@property (nonatomic, copy) NSString *userId;
/// 数据源
@property (nonatomic, strong) ModelUserZone *zone;

/** 请求数据 */
- (void)requestData;
@end
