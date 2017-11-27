//
//  NSMutableDictionary+AddNil.h
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (AddNil)

/** 替换 setObject: forKey: ,添加前检查nil防止崩溃
 * @param value :要加入的值
 * @param key :要加入的键
 */
- (void)setCheckValue:(id)value forKey:(NSString *)key;

/** 替换 setObject: forKey: ,添加前检查nil防止崩溃
 * @param obj :要加入的对象
 * @param key :要加入的键
 */
- (void)setCheckObject:(id)obj forKey:(NSString *)key;
@end
