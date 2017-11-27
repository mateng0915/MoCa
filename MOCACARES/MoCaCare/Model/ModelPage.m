//
//  ModelPage.m
//  MoCaCare
//
//  Created by xhb on 2017/9/25.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "ModelPage.h"

@implementation ModelPage

+ (instancetype)firstPage {
    ModelPage *page = [ModelPage new];
    page.page_current = 1;
    page.page_size = 20;
    return page;
}
@end
