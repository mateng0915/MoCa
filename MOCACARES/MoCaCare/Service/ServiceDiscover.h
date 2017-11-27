//
//  ServiceDiscover.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Service.h"
#import "ModelDiscover.h"
#import "ModelPage.h"

@interface ServiceDiscover : Service

#pragma mark - 发布活动
/*
 * 发布活动
 * @param event :活动数据模型
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)postEvent:(ModelEvent *)event
          success:(SuccessBlock)success
          failure:(FailureBlock)failure;


#pragma mark - 删除活动
/*
 * 删除活动
 * @param
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)deleteEvent:(ModelEvent *)event
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;

#pragma mark - 活动类别列表
/*
 * 活动类别列表
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getEventCategoryListSuccess:(void (^)(NSArray<ModelEventCategory *> *list))success
             failure:(FailureBlock)failure;

#pragma mark - 活动列表(可以根据搜索结果和类别id分类)
/*
 * 活动列表(可以根据搜索结果和类别id分类)
 * @param page :分页
 * @param categoryId :活动分类id,如果为空,则就是全部分类
 * @param search :搜索,如果不为空,则按搜索条件来筛选活动
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getEventList:(ModelPage *)page
          categoryId:(NSString *)categoryId
              search:(NSString *)search
             success:(void (^)(NSArray<ModelEvent *> *list))success
             failure:(FailureBlock)failure;


#pragma mark - 获取活动详情
/*
 * 活动列表(可以根据搜索结果和类别id分类)
 * @param eventId :活动id
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getEventDetail:(NSString *)eventId
               success:(void (^)(ModelEventDetail *event))success
               failure:(FailureBlock)failure;

#pragma mark - 获取活动评论列表
/*
 * 获取活动评论列表
 * @param
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getCommentListWithEventId:(NSString *)eventId
                          success:(void (^)(NSArray<ModelComment *> *list))success
                          failure:(FailureBlock)failure;

#pragma mark - 发表评论
/*
 * 发表评论
 * @param content :评论内容
 * @param eventId :活动id
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)submitComment:(NSString *)content
              eventId:(NSString *)eventId
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;


#pragma mark -
/*
 *
 * @param
 * @param success :成功回调
 * @param failure :失败回调
 */


@end
