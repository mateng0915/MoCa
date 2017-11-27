//
//  ModelMyEvents.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Model.h"
#import "ModelDiscover.h"

@interface ModelMyEvents : Model 
/// id
@property (nonatomic, copy) NSString *id;
@end

#pragma mark - 我
@interface ModelMyEvent : ModelEvent
/// 活动id
@property (nonatomic, copy) NSString *aid;
@end
 
