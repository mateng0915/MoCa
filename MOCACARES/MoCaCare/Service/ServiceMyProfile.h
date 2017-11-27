//
//  ServiceMyProfile.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Service.h"
#import "ModelMyProfile.h"

typedef NS_ENUM(NSInteger, FridensType) {
    /// 志愿者好友
    FridensTypeVolunteer = 1,
    /// 组织者好友
    FridensTypeOrganization = 2
};
@interface ServiceMyProfile : Service

#pragma mark - 用户反馈
/*
 * 用户反馈
 * @param content :反馈内容
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)feedback:(NSString *)content
         success:(SuccessBlock)success
         failure:(FailureBlock)failure;


#pragma mark - 用户空间（信息页）
/*
 * 用户空间（信息页）
 * @param uid :用户id
 * @param success :成功回调 yes表示成为好友，no表示接触关系
 * @param failure :失败回调
 */
+ (void)userZone:(NSString *)uid
         success:(void (^)(ModelUserZone *zone))success
         failure:(FailureBlock)failure;

#pragma mark - 添加|删除好友
/*
 * 添加|删除好友
 * @param fid :好友id
 * @param success :成功回调 yes表示成为好友，no表示接触关系
 * @param failure :失败回调
 */
+ (void)followUser:(NSString *)fid
           success:(void (^)(BOOL statue))success
           failure:(FailureBlock)failure;

#pragma mark - 好友列表
/*
 * 好友列表
 * @param type :成功回调
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getFriendList:(FridensType)type
              success:(void (^)(NSArray<ModelMyInterests *> *list))success
              failure:(FailureBlock)failure;

#pragma mark - 发送聊天消息
/*
 * 发送聊天消息
 * @param chat :聊天数据模型
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)sendChatMsg:(ModelChatMsg *)chat
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;

#pragma mark - 聊天记录
/*
 * 聊天记录
 * @param fid :好友id
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getChatRecord:(NSString *)fid
              success:(void (^)(NSArray<ModelChatMsg *> *list))success
              failure:(FailureBlock)failure;


#pragma mark - 获取未读消息、评论
/*
 * 获取未读消息、评论
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getNoReadSuccess:(void (^)(NSString *num_msg, NSString *num_comment))success
                 failure:(FailureBlock)failure;

#pragma mark - 聊天朋友列表
/*
 * 聊天朋友列表
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getMessages:(void (^)(NSArray<ModelChatMsg *> *list))success
            failure:(FailureBlock)failure;


#pragma mark - 系统设置
/*
 * 系统设置
 * @param recommend : 推荐类型 1,2,3,4
 * @param notify :通知 1,2
 * @param receive :只接收关注的消息 1
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)systemConfigRrecommend:(NSInteger)recommend
                        notify:(NSInteger)notify
                       receive:(NSInteger)receive
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure;



@end
