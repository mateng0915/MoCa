//
//  MyBookmarksTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/19.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelMyEvent, ModelPage;
@interface MyBookmarksTVC : UITableViewController
/// 数据源
@property (nonatomic, strong) NSMutableArray<ModelMyEvent *> *events;
/// 换页模型
@property (nonatomic, strong) ModelPage *page;

/** 数据请求 */
- (void)requestData;
@end
