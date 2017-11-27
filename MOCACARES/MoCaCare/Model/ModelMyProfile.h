//
//  ModelMyProfile.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Model.h"
#import "ModelDiscover.h"

@interface ModelMyProfile : Model
/// id
@property (nonatomic, copy) NSString *id;
@end

#pragma mark - 用户空间
@interface ModelUserZone : ModelMyProfile
/// 用户信息
@property (nonatomic, strong) ModelUser *user;
/// 是否已是好友0不是1是
@property (nonatomic, copy) NSString *is_friend;
/// 活动列表
@property (nonatomic, copy) NSArray<ModelEvent *> *event; 
@end

#pragma mark - 好友列表 (Interestes)
@interface ModelMyInterests : ModelMyProfile
/// 自己的id
@property (nonatomic, copy) NSString *uid;
/// 好友id
@property (nonatomic, copy) NSString *fid;
/// 好友类型 1个人 2组织
@property (nonatomic, copy) NSString *type;
/// 1好友关系 0非好友关系
@property (nonatomic, copy) NSString *status;
/// 成为好友的时间
@property (nonatomic, copy) NSString *c_time;
/// 好友头像
@property (nonatomic, copy) NSString *u_img;
/// 好友昵称
@property (nonatomic, copy) NSString *u_username;
/// 好友简介
@property (nonatomic, copy) NSString *u_statement;
@end

#pragma mark - 聊天消息
@interface ModelChatMsg : ModelMyProfile
#pragma mark - Chat
/// 发送者用户id
@property (nonatomic, copy) NSString *fid;
/// 接收者用户id
@property (nonatomic, copy) NSString *sid;
/// 消息内容
@property (nonatomic, copy) NSString *msg;
/// 发送时间
@property (nonatomic, copy) NSString *c_time;
/// 消息状态 0删除 1正常
@property (nonatomic, copy) NSString *status;
/// 发送者用户名
@property (nonatomic, copy) NSString *f_username;
/// 发送者用户头像
@property (nonatomic, copy) NSString *f_img;
/// 接收者用户名
@property (nonatomic, copy) NSString *s_username;
/// 接收者用户头像
@property (nonatomic, copy) NSString *s_img;

/// 自己发出去的消息
@property (nonatomic, assign) BOOL msgBelongSelf;

#pragma mark - Messages
/// 聊天好友id
@property (nonatomic, copy) NSString *uid;
/// 发送时间
@property (nonatomic, copy) NSString *u_time;
/// 聊天好友名字
@property (nonatomic, copy) NSString *name;
/// 聊天好友头像
@property (nonatomic, copy) NSString *img;
/// 未读消息数量
@property (nonatomic, copy) NSString *no_read;
/// 是否有未读消息数量
@property (nonatomic, copy) NSString *is_read;
/// 简介
@property (nonatomic, copy) NSString *statement;
@end


