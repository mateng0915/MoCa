//
//  ModelPage.h
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Model.h"

@interface ModelPage : Model
/// 当前页
@property (nonatomic, assign) NSInteger page_current;
/// 总的页数
@property (nonatomic, assign) NSInteger page_total;
/// 分页大小
@property (nonatomic, assign) NSInteger page_size;

/** 实例化,当前页为默认值(第一页) */
+ (instancetype)firstPage;
@end
