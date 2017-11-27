//
//  NSMutableArray+AddNil.m
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "NSMutableArray+AddNil.h"

@implementation NSMutableArray (AddNil)

- (void)addCheckObject:(id)obj {
    if (obj) {
        [self addObject:obj];
    } else {
        NSLog(@"nil对象不能加入数组");
    }
}
@end
