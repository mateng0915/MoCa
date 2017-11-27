//
//  ServiceAccount.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ServiceAccount.h"

@implementation ServiceAccount

#pragma mark - 注册
+ (void)registerAccountType:(AccountType)accountType
                      email:(NSString *)email
                   username:(NSString *)username
                   password:(NSString *)password
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:@(accountType) forKey:@"type"];
    [dict setCheckValue:email forKey:@"email"];
    [dict setCheckValue:username forKey:@"username"];
    [dict setCheckValue:password forKey:@"password"];
    
    [self postURLString:@"api/login/register" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        NSString *token = info[@"_token"];
        ModelUser *user = [ModelUser defaultUser];
        user._token = token;
        [user login];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 登录
+ (void)loginEmail:(NSString *)email
          password:(NSString *)password
           success:(SuccessBlock)success
           failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:email forKey:@"email"];
    [dict setCheckValue:password forKey:@"password"];
    
    [self postURLString:@"api/login/login" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        NSString *token = info[@"_token"];
        ModelUser *user = [ModelUser defaultUser];
        user._token = token;
        [user login]; 
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 发送修改密码所需的身份id到注册邮箱
+ (void)sendPIDtoRegisteredEmailSuccess:(SuccessBlock)success
                                failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/login/sendVerify" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@ ", result);
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 修改密码
+ (void)setNewPassword:(NSString *)newPassword
                   PIN:(NSString *)pin
               success:(SuccessBlock)success
               failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:newPassword forKey:@"newpwd"];
    [dict setCheckValue:pin forKey:@"verify"];
    
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/login/changePwd" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 获取个人信息
+ (void)getUserInfoSuccess:(void (^)(ModelUser *user))success
                   failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    __block ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/users/userInfoGet" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        user = [[ModelUser defaultUser] initWithDictionary:info];
        [user saveUserInfo];
        success(user);
    } failure:^{
        failure();
    }];
}

#pragma mark - 修改个人信息
+ (void)eidtUserInfo:(ModelUser *)user
             success:(SuccessBlock)success
             failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:user.username forKey:@"username"];
    [dict setCheckValue:user.img forKey:@"img"];
    [dict setCheckValue:user.age forKey:@"age"];
    [dict setCheckValue:user.sex forKey:@"sex"];
    [dict setCheckValue:user.occupation forKey:@"occupation"];
    [dict setCheckValue:user.statement forKey:@"statement"];
    [dict setCheckValue:user.is_show_email forKey:@"is_show_email"];
    [dict setCheckValue:user.is_show_event forKey:@"is_show_event"];
    
    [self postURLString:@"api/users/userInfoSet" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        [user saveUserInfo];
        success();
    } failure:^{
        failure();
    }];
}

@end
