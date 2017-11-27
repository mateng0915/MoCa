//
//  ViewEventTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEventDetail, ModelComment;
@interface ViewEventTVC : UITableViewController

/// 活动id
@property (nonatomic, copy) NSString *eventId;
/// 活动详情数据模型
@property (nonatomic, strong) ModelEventDetail *model;
/// 评论数组
@property (nonatomic, copy) NSArray<ModelComment *> *commentList;

/** 获取活动详情 */
- (void)requestEventDetail;
/** 获取评论列表 */
- (void)requestCommentList;
@end
