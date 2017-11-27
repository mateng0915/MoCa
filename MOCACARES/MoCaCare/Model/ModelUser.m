//
//  ModelUser.m
//  ThirteenWater
//
//  Created by xhb on 2017/5/31.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ModelUser.h"

static ModelUser *model;
@implementation ModelUser

#pragma mark - 实例化用户单例
+ (instancetype)defaultUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [ModelUser new];
    });
    
    model._token = [M_UserDefault valueForKey:UserToken];
    model.id = [M_UserDefault valueForKey:UserId];
    model.age = [M_UserDefault valueForKey:UserAge];
    model.email = [M_UserDefault valueForKey:UserEmail];
    model.img = [M_UserDefault valueForKey:UserIMG];
    model.is_show_email = [M_UserDefault valueForKey:PublicEmail];
    model.is_show_event = [M_UserDefault valueForKey:PublicEvent];
    model.occupation = [M_UserDefault valueForKey:UserOccupation];
    model.sex = [M_UserDefault valueForKey:UserSex];
    model.statement = [M_UserDefault valueForKey:UserStatement];
    model.type = [M_UserDefault valueForKey:UserType];
    model.username = [M_UserDefault valueForKey:UserName];
    model.recommend_type = [M_UserDefault valueForKey:SystemConfigRecommend];
    model.notify = [M_UserDefault valueForKey:SystemConfigNotify];
    model.receive = [M_UserDefault valueForKey:SystemConfigReceive];
    return model;
}
+ (instancetype)defaultClearUser {
    static ModelUser *user;
    if (!user) {
        user = [ModelUser new];
    } 
    user._token = [M_UserDefault valueForKey:UserToken];
//    if (!M_CheckStrNil(user._token)) {
//        user._token = @"0";
//    }
    return user;
}

#pragma mark - 用户登录
- (void)login {
    if (self._token) {
        [M_UserDefault setValue:self._token forKey:UserToken];
    }
    [M_UserDefault synchronize];
}

#pragma mark - 保存用户信息
- (void)saveUserInfo {
    if (M_CheckStrNil(self.id))
        [M_UserDefault setValue:self.id forKey:UserId];
    
    if (M_CheckStrNil(self.age))
        [M_UserDefault setValue:self.age forKey:UserAge];
    
    if (M_CheckStrNil(self.email))
        [M_UserDefault setValue:self.email forKey:UserEmail];
    
    if (M_CheckStrNil(self.img))
        [M_UserDefault setValue:self.img forKey:UserIMG];

    if (M_CheckStrNil(self.is_show_email))
        [M_UserDefault setValue:self.is_show_email forKey:PublicEmail];
    
    if (M_CheckStrNil(self.is_show_event))
        [M_UserDefault setValue:self.is_show_event forKey:PublicEvent];
    
    if (M_CheckStrNil(self.occupation))
        [M_UserDefault setValue:self.occupation forKey:UserOccupation];

    if (M_CheckStrNil(self.sex))
        [M_UserDefault setValue:self.sex forKey:UserSex];
 
    if (M_CheckStrNil(self.statement))
        [M_UserDefault setValue:self.statement forKey:UserStatement];
 
    if (M_CheckStrNil(self.type))
        [M_UserDefault setValue:self.type forKey:UserType];
    
    if (M_CheckStrNil(self.username))
        [M_UserDefault setValue:self.username forKey:UserName];
    
    if (M_CheckStrNil(self.recommend_type))
        [M_UserDefault setValue:self.recommend_type forKey:SystemConfigRecommend];
    
    if (M_CheckStrNil(self.notify))
        [M_UserDefault setValue:self.notify forKey:SystemConfigNotify];
    
    if (M_CheckStrNil(self.receive))
        [M_UserDefault setValue:self.receive forKey:SystemConfigReceive];
    
    [M_UserDefault synchronize];
}

#pragma mark - 退出登录
+ (void)logOut {
    [M_UserDefault removeObjectForKey:UserToken];
    [M_UserDefault removeObjectForKey:UserId];
    [M_UserDefault removeObjectForKey:UserAge];
    [M_UserDefault removeObjectForKey:UserEmail];
    [M_UserDefault removeObjectForKey:UserIMG];
    [M_UserDefault removeObjectForKey:PublicEmail];
    [M_UserDefault removeObjectForKey:PublicEvent];
    [M_UserDefault removeObjectForKey:UserOccupation];
    [M_UserDefault removeObjectForKey:UserSex];
    [M_UserDefault removeObjectForKey:UserStatement];
    [M_UserDefault removeObjectForKey:UserType];
    [M_UserDefault removeObjectForKey:UserName];
    [M_UserDefault removeObjectForKey:SystemConfigRecommend];
    [M_UserDefault removeObjectForKey:SystemConfigNotify];
    [M_UserDefault removeObjectForKey:SystemConfigReceive];
    
    [M_UserDefault synchronize];
}

#pragma mark - 获取账号主题色
+ (UIColor *)accountColor {
//    UIColor *color = [[M_UserDefault valueForKey:UserType] isEqualToString:@"2"] ? [MyFunction colorWithHexString:@"333333" alpha:1] : [MyFunction colorWithHexString:@"E2E2E2" alpha:1];
//    UIColor *color = [MyFunction colorWithHexString:@"E2E2E2" alpha:1];
    
    UIColor *color = [UIColor whiteColor];
    return color;
}
@end
