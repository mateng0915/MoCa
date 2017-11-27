//
//  ServiceDiscover.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ServiceDiscover.h"

@implementation ServiceDiscover

#pragma mark - 发布活动
+ (void)postEvent:(ModelEvent *)event
          success:(SuccessBlock)success
          failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:event.type forKey:@"type"];
    [dict setCheckValue:event.img forKey:@"img"];
    [dict setCheckValue:event.title forKey:@"title"];
//    [dict setCheckValue:event.content forKey:@"content"];
    [dict setCheckValue:event.desrc forKey:@"desrc"];
    [dict setCheckValue:event.add forKey:@"add"];
    
    [dict setCheckValue:[@(event.time_type) description] forKey:@"time_type"];
    [dict setCheckValue:event.begin_time forKey:@"begin_time"];
    [dict setCheckValue:event.hour_start forKey:@"hour_start"];
    [dict setCheckValue:event.hour_end forKey:@"hour_end"];
    [dict setCheckValue:event.week forKey:@"week"];
    
    /// 去除没用的问题
    NSMutableArray<NSString *> *mArr = [event.question mutableCopy];
    for (NSString *question in event.question ) {
        NSString *qStr = [question stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (qStr.length == 0) 
            [mArr removeObject:question];
    }
    [dict setCheckValue:mArr forKey:@"question"];
    /// 有id则为修改发布的活动，没有则是创建新活动
    [dict setCheckValue:event.id forKey:@"aid"];
    
    [self postURLString:@"api/event/eventAdd" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *str = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:str];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 删除活动
+ (void)deleteEvent:(ModelEvent *)event
            success:(SuccessBlock)success
            failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:event.id forKey:@"aid"];
    
    [self postURLString:@"api/event/eventDel" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSString *str = result[@"msg"];
        [MyFunction displayAlertLabelWithMessage:str];
        success();
    } failure:^{
        failure();
    }];
}

#pragma mark - 活动类别列表
+ (void)getEventCategoryListSuccess:(void (^)(NSArray<ModelEventCategory *> *list))success
                            failure:(FailureBlock)failure {
    [self postURLString:@"api/event/eventTypeList" parameter:nil progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelEventCategory *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelEventCategory class]];
        success(list);
    } failure:^{
        failure();
    }];
}

#pragma mark - 活动列表(可以根据搜索结果和类别id分类) 
+ (void)getEventList:(ModelPage *)page
          categoryId:(NSString *)categoryId
              search:(NSString *)search
             success:(void (^)(NSArray<ModelEvent *> *list))success
             failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:@(page.page_current) forKey:@"page"];
    [dict setCheckValue:categoryId forKey:@"type"];
    [dict setCheckValue:search forKey:@"search"];
    [self postURLString:@"api/event/eventList" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelEvent *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelEvent class]];
        success(list);
    } failure:^{
        failure();
    }];
}

#pragma mark - 获取活动详情
+ (void)getEventDetail:(NSString *)eventId
               success:(void (^)(ModelEventDetail *event))success
               failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:eventId forKey:@"aid"];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/event/eventDetail" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSDictionary *info = result[@"info"];
        ModelEventDetail *model = [[ModelEventDetail alloc] initWithDictionary:info];
        success(model);
    } failure:^{
        failure();
    }];
}

#pragma mark - 获取活动评论列表
+ (void)getCommentListWithEventId:(NSString *)eventId
                          success:(void (^)(NSArray<ModelComment *> *list))success
                          failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; 
    [dict setCheckValue:eventId forKey:@"aid"];
    
    [self postURLString:@"api/event/commentList" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelComment *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelComment class]];
        success(list);
    } failure:^{
        failure();
    }];
}

#pragma mark - 发表评论
+ (void)submitComment:(NSString *)content
              eventId:(NSString *)eventId
              success:(SuccessBlock)success
              failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    [dict setCheckValue:eventId forKey:@"aid"];
    [dict setCheckValue:content forKey:@"content"];
    
    [self postURLString:@"api/event/commentAdd" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        success();
    } failure:^{
        failure();
    }];
}
@end
