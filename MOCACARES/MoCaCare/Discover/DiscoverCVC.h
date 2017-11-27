//
//  DiscoverCVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelEvent, ModelPage;
@interface DiscoverCVC : UICollectionViewController

/// 是否显示查询结果
@property (nonatomic, assign) BOOL showSearchResult;
/// 普通数据 | 查询结果
@property (nonatomic, strong) NSMutableArray<ModelEvent *> *events;
/// 换页符号
@property (nonatomic, strong) ModelPage *page;
/// 当前类别
@property (nonatomic, copy) NSString *currentCategoryId;
/// 当前关键词
@property (nonatomic, copy) NSString *currentSearchStr;

/*
 * huoqu
 * @param cid :类型id
 * @param search :搜索关键词
 * @param clear :是否清空之前的数据
 */
- (void)requestCategoryId:(NSString *)cid
                   search:(NSString *)search
              clearEvents:(BOOL)clear;
@end
