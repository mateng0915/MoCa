//
//  NSMutableArray+AddNil.h
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AddNil)

/** 替换 addObject ,添加前检查nil防止崩溃
 * @param obj :要加入的对象
 */
- (void)addCheckObject:(id)obj;
@end
