//
//  ServiceRecommended.m
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ServiceRecommended.h"

@implementation ServiceRecommended

#pragma mark - 推荐活动列表
+ (void)getRecommendedList:(NSArray<ModelEventCategory *> *)categorys
                      page:(ModelPage *)page
                   success:(void (^)(NSArray<ModelEvent *> *list))success
                   failure:(FailureBlock)failure {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setCheckValue:@(page.page_current) forKey:@"page"];
    if (categorys.count == 0) {
        NSLog(@"遍历类别条件为nil，搜索全部");
    }
    NSMutableArray *mArr = [NSMutableArray array];
    [categorys enumerateObjectsUsingBlock:^(ModelEventCategory * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mArr addObject:obj.id];
    }];
    [dict setCheckValue:mArr forKey:@"type"];
    
    ModelUser *user = [ModelUser defaultClearUser];
    [dict setCheckValue:user._token forKey:@"_token"];
    
    [self postURLString:@"api/event/eventRecommend" parameter:dict progress:nil success:^(NSDictionary *result) {
//        NSLog(@"%@", result);
        NSArray *arr = result[@"info"];
        NSArray<ModelEvent *> *list = [self getModelArrayWithDataArray:arr itemModelClass:[ModelEvent class]];
        success(list);
    } failure:^{
        failure();
    }];
}
@end
