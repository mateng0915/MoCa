//
//  ServiceMyEvents.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Service.h"
#import "ModelDiscover.h"
#import "ModelMyEvents.h"
#import "ModelPage.h"

typedef NS_ENUM(NSInteger, OperateEnevtType) {
    /// 参加活动
    OperateEnevtTypeJoin = 1,
    /// 收藏活动
    OperateEnevtTypeMark
};
@interface ServiceMyEvents : Service

#pragma mark - 我发布的活动（组织者才有该功能）
/*
 * 我发布的活动（组织者才有该功能）
 * @param page :页数
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getMyPostEvents:(ModelPage *)page
                success:(void (^)(NSArray<ModelEvent *> *list))success
                failure:(FailureBlock)failure;

#pragma mark - 收藏/参加活动
/*
 * 收藏/参加活动
 * @param eventId :活动id
 * @param type :操作类型
 * @param success :成功回调 yes表示参与，no表示取消参与
 * @param failure :失败回调
 */
+ (void)setEventWithId:(NSString *)eventId
                  type:(OperateEnevtType)type
               success:(void (^)(BOOL statue))success
               failure:(FailureBlock)failure;


#pragma mark - 收藏/参加活动列表
/*
 * 收藏/参加活动列表
 * @param type :获取活动的类型
 * @param page :页数
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getMyEventsWithType:(OperateEnevtType)type
                       page:(ModelPage *)page
                    success:(void (^)(NSArray<ModelMyEvent *> *list))success
                    failure:(FailureBlock)failure;



@end
