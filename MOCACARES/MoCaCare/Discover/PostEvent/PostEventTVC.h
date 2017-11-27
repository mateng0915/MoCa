//
//  PostEventTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDiscover.h"

@interface PostEventTVC : UITableViewController
/// 是否是编辑模式
@property (nonatomic, assign) BOOL edit;
/// 活动时间是否有规律
@property (nonatomic, assign) TimeModel timeModel;
/// 数据模型
@property (nonatomic, strong) ModelEvent *event;
/// 类别ID
@property (nonatomic, copy) NSArray<ModelEventCategory *> *categorys;
@end
