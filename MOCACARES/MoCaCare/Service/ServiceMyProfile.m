//
//  ServiceMyProfile.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ServiceMyProfile.h"

@implementation ServiceMyProfile

#pragma mark - 用户反馈
+ (void)feedback:(NSString *)content
         success:(SuccessBlock)success
         failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:content forKey:@"content"];
    
    [self postURLString:@"api/public/feedback" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        [MyFunction displayAlertLabelWithMessage:@"Thank you for your feedback"];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 用户空间（信息页）
+ (void)userZone:(NSString *)uid
         success:(void (^)(ModelUserZone *zone))success
         failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:uid forKey:@"uid"];
    
    [self postURLString:@"api/users/userSpace" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        ModelUserZone *model = [[ModelUserZone alloc] initWithDictionary:info];
        success(model);
    } failure:^{
        failure();
    }];
}

#pragma mark - 添加好友
+ (void)followUser:(NSString *)fid
           success:(void (^)(BOOL statue))success
           failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:fid forKey:@"fid"];
    
    [self postURLString:@"api/chat/friendAdd" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        NSInteger flag = [result[@"info"] integerValue];
        success(flag == 1); 
    } failure:^{
        failure();
    }];
}

#pragma mark - 好友列表
+ (void)getFriendList:(FridensType)type
              success:(void (^)(NSArray<ModelMyInterests *> *list))success
              failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:[@(type) description] forKey:@"type"];
    
    [self postURLString:@"api/chat/friendList" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelMyInterests *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelMyInterests class]];
        success(list);
    } failure:^{
        failure();
    }];
}


#pragma mark - 发送聊天消息
+ (void)sendChatMsg:(ModelChatMsg *)chat
            success:(SuccessBlock)success
            failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:chat.sid forKey:@"sid"];
    [dict setCheckValue:chat.msg forKey:@"msg"];
    
    [self postURLString:@"api/chat/sendMsg" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 聊天记录
+ (void)getChatRecord:(NSString *)fid
              success:(void (^)(NSArray<ModelChatMsg *> *list))success
              failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:fid forKey:@"sid"];
    
    [self postURLString:@"api/chat/chatList" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelChatMsg *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelChatMsg class]];
        success(list);
    } failure:^{
        failure();
    }];
}


#pragma mark - 获取未读消息、评论
+ (void)getNoReadSuccess:(void (^)(NSString *num_msg, NSString *num_comment))success
                 failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/chat/getNoRead" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        if (![info isKindOfClass:[NSDictionary class]]) {
            success(@"0", @"0");
        } else {
            NSString *num_msg = [info[@"new_msg"] description];
            NSString *num_comment = [info[@"new_comment"] description];
            success(num_msg, num_comment);
        }
    } failure:^{
        failure();
    }];
}

#pragma mark - 聊天朋友列表
+ (void)getMessages:(void (^)(NSArray<ModelChatMsg *> *list))success
            failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/chat/chatFriend" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelChatMsg *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelChatMsg class]];
        success(list);
    } failure:^{
        failure();
    }];
}


#pragma mark - 系统设置
+ (void)systemConfigRrecommend:(NSInteger)recommend
                        notify:(NSInteger)notify
                       receive:(NSInteger)receive
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    if (recommend != 0)
        [dict setCheckValue:@(recommend) forKey:@"recommend"];
    if (notify != 0)
        [dict setCheckValue:@(notify) forKey:@"notify"];
    if (receive != 0)
        [dict setCheckValue:@(receive) forKey:@"receive"];
    
    [self postURLString:@"api/public/systemConfig" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        success();
    } failure:^{
        failure();
    }];
}
@end
