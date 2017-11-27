//
//  RecommendedTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelEvent, ModelEventCategory, ModelPage;
@interface RecommendedTVC : UITableViewController
/// 数据源
@property (nonatomic, strong) NSMutableArray<ModelEvent *> *events;
/// 类别id数组
@property (nonatomic, copy) NSArray<ModelEventCategory *> *categorys;
/// 换页模型
@property (nonatomic, strong) ModelPage *page;
 
/** 请求数据 */
- (void)requestData;
@end
