//
//  Model.h
//  Mentor
//
//  Created by xhb on 16/9/3.
//  Copyright © 2016年 Suzhou Youmiga Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

/// 数据模型ID
@property (nonatomic, assign) NSInteger modelId;

/* 父类自带方法 */
- (void)setValue:(id)value forKey:(NSString *)key;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

/** 实例化方法,请保证字典的key能和对象的成员变量匹配 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
 

/** 打印对象属性信息 */
- (void)logModelInfo;
@end
