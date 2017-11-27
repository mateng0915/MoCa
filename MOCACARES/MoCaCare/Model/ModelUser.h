//
//  ModelUser.h
//  ThirteenWater
//
//  Created by xhb on 2017/5/31.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Model.h"
 
/// 用户令牌
#define UserToken @"UserToken"
/// 用户id
#define UserId @"UserId"
/// 年龄
#define UserAge @"UserAge"
/// 邮箱
#define UserEmail @"UserEmail"
/// 头像
#define UserIMG @"UserIMG"
/// 是否公开邮箱 0否1是
#define PublicEmail @"PublicEmail"
/// 是否公开活动 0否1是
#define PublicEvent @"PublicEvent"
/// 职业
#define UserOccupation @"UserOccupation"
/// 性别 1男2女
#define UserSex @"UserSex"
/// 自我描述
#define UserStatement @"UserStatement"
/// 账号类别 1参与者2组织者
#define UserType @"UserType"
/// 用户名
#define UserName @"UserName"
/// 系统设置-推荐类型
#define SystemConfigRecommend @"SystemConfigRecommend"
/// 系统设置-通知
#define SystemConfigNotify @"SystemConfigNotify"
/// 系统设置-只接收关注的消息 
#define SystemConfigReceive @"SystemConfigReceive"

@interface ModelUser : Model
#pragma mark - 主要成员变量
/// 用户令牌
@property (nonatomic, copy) NSString *_token;
/// 用户id
@property (nonatomic, copy) NSString *id;
/// 年龄
@property (nonatomic, copy) NSString *age;
/// 邮箱
@property (nonatomic, copy) NSString *email;
/// 头像
@property (nonatomic, copy) NSString *img;
/// 是否公开邮箱 0否1是
@property (nonatomic, copy) NSString *is_show_email;
/// 是否公开活动 0否1是
@property (nonatomic, copy) NSString *is_show_event;
/// 职业
@property (nonatomic, copy) NSString *occupation;
/// 性别 1男2女
@property (nonatomic, copy) NSString *sex;
/// 自我描述、简介
@property (nonatomic, copy) NSString *statement;
/// 账号类别 1参与者2组织者
@property (nonatomic, copy) NSString *type;
/// 用户名
@property (nonatomic, copy) NSString *username;
/// 系统设置-推荐类型
@property (nonatomic, copy) NSString *recommend_type;
/// 系统设置-通知
@property (nonatomic, copy) NSString *notify;
/// 系统设置-只接收关注的消息
@property (nonatomic, copy) NSString *receive;

#pragma mark - 函数
/** 实例化用户单例 */
+ (instancetype)defaultUser;
/** 实例化用户单例,该单例只有token,方便用户上传编辑信息 */
+ (instancetype)defaultClearUser;

/** 登录 */
- (void)login;

/** 保存用户信息 */
- (void)saveUserInfo;

/** 退出登录 */
+ (void)logOut;

/** 获取账号主题色 */
+ (UIColor *)accountColor;
@end
