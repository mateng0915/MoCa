//
//  CalendarCell.h
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridView.h"
#import "CalendarCVC.h"

@class ModelMyEvent;
@interface CalendarCell : UICollectionViewCell
/// 容器
@property (nonatomic, weak) CalendarCVC *cvc;
/// 网格
@property (nonatomic, strong) GridView *grid;
/// 数据模型
@property (nonatomic, copy) NSArray<ModelMyEvent *> *events;
/// 数据模型(字典，用活动id获取对应的活动)
@property (nonatomic, copy) NSDictionary *eventsDict;
/// 星期
@property (nonatomic, copy) NSArray<NSString *> *week;
/// 星期字符串
@property (nonatomic, copy) NSDictionary *shortWeek;
/// 月份字符串
@property (nonatomic, copy) NSDictionary *shortMonth;
/// 日期格式
@property (nonatomic, strong) NSDateFormatter *formatter;

@end
