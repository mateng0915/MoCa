//
//  NSMutableDictionary+AddNil.m
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "NSMutableDictionary+AddNil.h"

@implementation NSMutableDictionary (AddNil)

- (void)setCheckValue:(id)value forKey:(NSString *)key {
    if (value) {
        [self setValue:value forKey:key];
    } else {
//        NSLog(@"nil对象不能加入字典");
    }
}
- (void)setCheckObject:(id)obj forKey:(NSString *)key {
    if (obj) {
        [self setObject:obj forKey:key];
    } else {
//        NSLog(@"nil对象不能加入字典");
    }
}
@end
