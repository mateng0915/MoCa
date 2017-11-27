//
//  ModelDiscover.h
//  MoCaCare
//
//  Created by xhb on 2017/9/22.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "Model.h"
typedef NS_ENUM(NSInteger, TimeModel) {
    /// 只有1天
    TimeModelOneOff = 1,
    /// 每周特定一天重复
    TimeModelRecurring = 2,
    /// 待定
    TimeModelToBeAdvised = 3
};

@interface ModelDiscover : Model
/// id
@property (nonatomic, copy) NSString *id;
@end

#pragma mark - 活动类别
@interface ModelEventCategory : ModelDiscover
/// 图片
@property (nonatomic, copy) NSString *img;
/// 名称
@property (nonatomic, copy) NSString *name;
@end

#pragma mark - 活动
@interface ModelEvent : ModelDiscover
/// 组织人id
@property (nonatomic, copy) NSString *uid;
/// 封面(图片地址)
@property (nonatomic, copy) NSString *img;
/// 封面数据(本地图片)
@property (nonatomic, strong) NSData *imgData;
/// 活动标题
@property (nonatomic, copy) NSString *title;
/// 活动类型id
@property (nonatomic, copy) NSString *type;
/// 活动类型名称
@property (nonatomic, copy) NSString *t_name;

/// 时间模式
@property (nonatomic, assign) TimeModel time_type;
/// 指定日期
@property (nonatomic, copy) NSString *begin_time;
/// 开始时间
@property (nonatomic, copy) NSString *hour_start;
/// 结束时间
@property (nonatomic, copy) NSString *hour_end;
/// 指定星期
@property (nonatomic, copy) NSString *week;

/// 活动地点
@property (nonatomic, copy) NSString *add;
/// 活动内容
@property (nonatomic, copy) NSString *content;
/// 活动描述
@property (nonatomic, copy) NSString *desrc;
/// 问题
@property (nonatomic, strong) NSMutableArray<NSString *> *question;

/** 获取活动时间 */
- (NSString *)getTime;
@end

#pragma mark - 活动详情
@interface ModelEventDetail : ModelEvent 
/// 发布人头像
@property (nonatomic, copy) NSString *u_img;
/// 是否参加 0未参加 1已参加
@property (nonatomic, copy) NSString *ispart;
/// 是否收藏 0未收藏 1已收藏
@property (nonatomic, copy) NSString *isbook;
@end

#pragma mark - 评论
@interface ModelComment : ModelDiscover
/// 评论人id
@property (nonatomic, copy) NSString *uid;
/// 评论人名称
@property (nonatomic, copy) NSString *u_username;
/// 评论人头像
@property (nonatomic, copy) NSString *u_img;
/// 活动id
@property (nonatomic, copy) NSString *aid;
/// 评论内容
@property (nonatomic, copy) NSString *content;
/// 评论时间
@property (nonatomic, copy) NSString *c_time;
@end
