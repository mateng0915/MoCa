//
//  ServiceRecommended.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Service.h"
#import "ModelPage.h"
#import "ModelDiscover.h"
#import "ModelRecommended.h"

@interface ServiceRecommended : Service

#pragma mark - 推荐活动列表
/*
 * 推荐活动列表
 * @param
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getRecommendedList:(NSArray<ModelEventCategory *> *)categorys
                      page:(ModelPage *)page
                   success:(void (^)(NSArray<ModelEvent *> *list))success
                   failure:(FailureBlock)failure;

#pragma mark -
/*
 *
 * @param
 * @param success :成功回调
 * @param failure :失败回调
 */

@end
