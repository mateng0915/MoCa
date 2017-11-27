//
//  ChatTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelChatMsg;
@interface ChatTVC : UITableViewController
/// 数据源
@property (nonatomic, strong) NSMutableArray<ModelChatMsg *> *dataArr;

/// 聊天对象id
@property (nonatomic, copy) NSString *chatUserId;

/** 请求数据 */
- (void)requestData;
@end
