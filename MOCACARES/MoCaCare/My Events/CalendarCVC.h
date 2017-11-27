//
//  CalendarCVC.h
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelMyEvent, ModelPage;
@interface CalendarCVC : UICollectionViewController<UICollectionViewDelegateFlowLayout>

/// 星期数组
@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *> *weeks;
/// 时间格式
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
/// 数据源
@property (nonatomic, strong) NSMutableArray<ModelMyEvent *> *events;

/// 换页模型
@property (nonatomic, strong) ModelPage *page;

/** 数据请求 */
- (void)requestData;
@end
