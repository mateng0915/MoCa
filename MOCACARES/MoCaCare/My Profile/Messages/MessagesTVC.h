//
//  MessagesTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelChatMsg;
@interface MessagesTVC : UITableViewController
/// 数据源
@property (nonatomic, copy) NSArray<ModelChatMsg *> *msgs;

/** 数据请求 */
- (void)requestData;
@end
