//
//  EventOperateCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventOperateCell.h"
#import <MapKit/MapKit.h>
#import "ServiceMyEvents.h"

@implementation EventOperateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnBookmark.layer.cornerRadius = 4.0;
    self.btnParticipate.layer.cornerRadius = 4.0;
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelEventDetail *)model {
    if (!model)
        return;
    _model = model;
//    NSLog(@"isbook = %@ ispart = %@",model.isbook, model.ispart);
    if (model.isbook.integerValue == 1) {
        self.btnBookmark.backgroundColor = MarkYColor;
    } else {
        self.btnBookmark.backgroundColor = MarkNColor;
    }
    if (model.ispart.integerValue == 1) {
        self.btnParticipate.backgroundColor = MarkYColor;
    } else {
        self.btnParticipate.backgroundColor = ThemeColorRed;
    }
}

#pragma mark - 按钮事件
- (IBAction)btnBookmarkClick:(UIButton *)sender {
//    NSLog(@"Bookmark");
    sender.userInteractionEnabled = NO;
    [ServiceMyEvents setEventWithId:self.tvc.eventId type:OperateEnevtTypeMark success:^(BOOL statue) {
        sender.userInteractionEnabled = YES;
        self.tvc.model.isbook = statue ? @"1" : @"0";
        [self.tvc.tableView beginUpdates];
        [self.tvc.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [self.tvc.tableView endUpdates];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }];
}

- (IBAction)btnParticipateClick:(UIButton *)sender {
//    NSLog(@"Participate");
    sender.userInteractionEnabled = NO;
    [ServiceMyEvents setEventWithId:self.tvc.eventId type:OperateEnevtTypeJoin success:^(BOOL statue) {
        sender.userInteractionEnabled = YES;
        [self.tvc.tableView beginUpdates];
        self.tvc.model.ispart = statue ? @"1" : @"0";
        [self.tvc.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [self.tvc.tableView endUpdates];
    } failure:^{
        sender.userInteractionEnabled = YES;
    }]; 
    
    /* // 使用系统自带的地图导航
    double lat_start = 0, lat_end = 0;
    double lon_start = 0, lon_end = 0;
    CLLocationCoordinate2D coordStart = CLLocationCoordinate2DMake(lat_start, lon_start);
    // 起点
    MKMapItem *itemStart = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordStart addressDictionary:nil]];
    // 终点
    CLLocationCoordinate2D coordEnd = CLLocationCoordinate2DMake(lat_end, lon_end);
    MKMapItem *itmeEnd = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordEnd addressDictionary:nil]];
    itmeEnd.name = @"Goal";
    
    NSArray *items = @[itemStart, itmeEnd];
    
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
     
     */
}
@end
