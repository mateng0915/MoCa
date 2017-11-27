//
//  ServiceAccount.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Service.h"

typedef NS_ENUM(NSInteger, AccountType) {
    /// 志愿者
    AccountTypeVolunteer = 1,
    /// 组织者
    AccountTypeOrganization
};

@interface ServiceAccount : Service

#pragma mark - 注册
/*
 * 注册
 * @param accountType : 账户类型
 * @param email : 邮箱
 * @param username :用户名
 * @param password :密码
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)registerAccountType:(AccountType)accountType
                      email:(NSString *)email
                   username:(NSString *)username
                   password:(NSString *)password
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure;


#pragma mark - 登录
/*
 * 登录
 * @param email : 邮箱
 * @param password :密码
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)loginEmail:(NSString *)email
          password:(NSString *)password
           success:(SuccessBlock)success
           failure:(FailureBlock)failure;


#pragma mark - 发送修改密码所需的身份id到注册邮箱
/*
 * 发送修改密码所需的身份id到注册邮箱
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)sendPIDtoRegisteredEmailSuccess:(SuccessBlock)success
                                failure:(FailureBlock)failure;

#pragma mark - 修改密码
/*
 * 修改密码
 * @param newPassword :新密码
 * @param pin :个人身份号码（通过注册邮箱获得）
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)setNewPassword:(NSString *)newPassword
                   PIN:(NSString *)pin
               success:(SuccessBlock)success
               failure:(FailureBlock)failure;

#pragma mark - 获取个人信息
/*
 * 获取个人信息
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)getUserInfoSuccess:(void (^)(ModelUser *user))success
                   failure:(FailureBlock)failure;

#pragma mark - 修改个人信息
/*
 * 修改个人信息
 * @param user :用户模型
 * @param success :成功回调
 * @param failure :失败回调
 */
+ (void)eidtUserInfo:(ModelUser *)user
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;

@end
