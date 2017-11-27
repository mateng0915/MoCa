//
//  ServiceMyEvents.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ServiceMyEvents.h"

@implementation ServiceMyEvents

#pragma mark - 我发布的活动（组织者才有该功能）
+ (void)getMyPostEvents:(ModelPage *)page
                success:(void (^)(NSArray<ModelEvent *> *list))success
                failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:@(page.page_current) forKey:@"page"];
    
    [self postURLString:@"api/event/eventMyPublish" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelEvent *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelEvent class]];
        success(list);
    } failure:^{
        failure();
    }];
}

#pragma mark - 收藏/参加活动
+ (void)setEventWithId:(NSString *)eventId
                  type:(OperateEnevtType)type
               success:(void (^)(BOOL statue))success
               failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:eventId forKey:@"aid"];
    [dict setCheckValue:@(type) forKey:@"type"];
    
    [self postURLString:@"api/event/eventBook" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result); 
        NSString *msg = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:msg];
        NSInteger flag = [result[@"info"] integerValue];
        success(flag == 1);
    } failure:^{
        failure();
    }];
}

#pragma mark - 收藏/参加活动列表
+ (void)getMyEventsWithType:(OperateEnevtType)type
                       page:(ModelPage *)page
                    success:(void (^)(NSArray<ModelMyEvent *> *list))success
                    failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:@(type) forKey:@"type"];
    [dict setCheckValue:@(page.page_current) forKey:@"page"];
    
    [self postURLString:@"api/event/eventMyBook" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelMyEvent *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelMyEvent class]];
        success(list);
    } failure:^{
        failure();
    }];
}
@end
