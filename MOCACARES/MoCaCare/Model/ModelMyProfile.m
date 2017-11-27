//
//  ModelMyProfile.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ModelMyProfile.h"
#import "Service.h"

@implementation ModelMyProfile

@end

#pragma mark - 用户空间
@implementation ModelUserZone
- (void)setUser:(ModelUser *)user {
    if ([user isKindOfClass:[NSDictionary class]]) {
        NSDictionary *info = (NSDictionary *)user;
        ModelUser *user = [[ModelUser alloc] initWithDictionary:info];
        _user = user;
    }
}
- (void)setEvent:(NSArray<ModelEvent *> *)event {
    if ([event isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)event;
        NSArray<ModelEvent *> *list = [Service getModelArrayWithDataArray:arr itemModelClass:[ModelEvent class]];
        _event = [list copy];
    }
}
@end

#pragma mark - 好友列表
@implementation ModelMyInterests

@end

#pragma mark - 聊天消息
@implementation ModelChatMsg

@end

