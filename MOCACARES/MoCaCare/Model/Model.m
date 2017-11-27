//
//  Model.m
//  Mentor
//
//  Created by xhb on 16/9/3.
//  Copyright © 2016年 Suzhou Youmiga Network Technology Co., Ltd. All rights reserved.
//

#import "Model.h"

#import <objc/runtime.h>

@implementation Model

- (void)setValue:(id)value forKey:(NSString *)key {
    if (![value isKindOfClass:[NSString class]] &&
        ![value isKindOfClass:[NSDictionary class]] &&
        ![value isKindOfClass:[NSArray class]]) {
        value = [value description];
    }
    if ([value isKindOfClass:[NSNull class]] ||
        !value) {
#if DEBUG
//        NSLog(@"%@对应的值为nil或null, 默认设置成空", key);
#endif
        value = nil;
    }
//    NSLog(@"%@ 对应的属性 %@ 不是字符串, 转成字符串", key, value);
    [super setValue:value forKey:key]; 
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"对象【%@】找不到该成员变量:【%@】", self.class, key);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        static NSInteger modelId = 0;
        modelId += 1;
        self.modelId = modelId;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]]) { 
            NSLog(@"\n----------\n%@\n----------", [NSString stringWithFormat:@"初始化数据模型【%@】失败,初始化的字典结构有问题 %@ ", [self class], [dictionary class]]);
            return nil;
        }
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}


/** 打印对象属性信息 */
- (void)logModelInfo {
    if (!self ||
        [self isKindOfClass:[NSNull class]]) {
        NSLog(@"本对象为空 ：%@", self);
        return;
    }
    unsigned int numVars; // 成员变量个数
    objc_property_t *propertys; // 成员变量信息
    
    // 判断父类是否还有参数
    if (![NSStringFromClass(self.superclass) isEqualToString:NSStringFromClass([NSObject class])]) {
        propertys = class_copyPropertyList(self.superclass, &numVars);
        NSLog(@"\n发现父类(%@)不是NSObject，检查父类是否还有成员变量\n", NSStringFromClass(self.superclass));
        [self logModelInfoWithPropertys:propertys numVars:numVars];
    }
    propertys = class_copyPropertyList([self class], &numVars);
    [self logModelInfoWithPropertys:propertys numVars:numVars];
    
}
- (void)logModelInfoWithPropertys:(objc_property_t *)propertys numVars:(unsigned int)numVars {
    NSMutableString *propertyStr = [NSMutableString string];
    NSString *key;
    id value;
    NSString *type;
    // 获取注册类的属性列表，第一个参数是类，第二个参数是属性变量的数目
    
    for (int i = 0; i < numVars; i ++) {
        // 通过循环获取单个属性
        objc_property_t thisProperty = propertys[i];
        // 获取属性名
        key = [NSString stringWithUTF8String:property_getName(thisProperty)];
        value = [self valueForKey:key];
        // 获取类型
        type = NSStringFromClass([value class]); 
        [propertyStr appendString:[NSString stringWithFormat:@"\nkey = %@, \tvalue = %@", key, value]];
    }
    NSLog(@"%@", propertyStr);
}
@end
