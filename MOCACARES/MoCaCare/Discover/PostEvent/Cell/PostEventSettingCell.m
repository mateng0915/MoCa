//
//  PostEventSettingCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventSettingCell.h"
#import "DataPickerVC.h"
#import "TimePickerVC.h"

@interface PostEventSettingCell()
/// 数据选择器
@property (nonatomic, strong) DataPickerVC *dataPicker;
@end
@implementation PostEventSettingCell

#pragma mark - 懒加载
- (DataPickerVC *)dataPicker {
    if (!_dataPicker) {
        _dataPicker = [[DataPickerVC alloc] initWithNibName:@"DataPickerVC" bundle:nil];
    }
    return _dataPicker;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewCategory.layer.borderWidth = 1.0;
    self.viewCategory.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewCategory.layer.cornerRadius = 4.0;
}
- (void)setTvc:(PostEventTVC *)tvc {
    [super setTvc:tvc];
    self.lblCategory.text = self.tvc.event.t_name;
//    NSLog(@"%@", self.tvc.event.t_name);
    [self.btnPostEvent setTitle:self.tvc.edit ? @"EDIT" : @"POST" forState:UIControlStateNormal];
}

#pragma mark - 按钮事件
- (IBAction)btnCategoryClick:(UIButton *)sender {
//    NSLog(@"Category"); 
    [self.tvc.tableView endEditing:YES];
    NSMutableArray<NSString *> *mArr = [NSMutableArray array];
    [self.tvc.categorys enumerateObjectsUsingBlock:^(ModelEventCategory * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mArr addObject:obj.name];
    }];
    [self.dataPicker displayWithViewController:self.tvc title:@"Category" dataArr:mArr completed:^(NSInteger idx, NSString *dataStr) {
        ModelEventCategory *model = self.tvc.categorys[idx];
        NSLog(@"%@", dataStr);
        self.lblCategory.text = dataStr;
        self.tvc.event.t_name = dataStr;
        self.tvc.event.type = model.id;
    }];
}
- (IBAction)btnPostEventClick:(UIButton *)sender {
//    NSLog(@"Post");
    [self.tvc.tableView endEditing:YES];
    sender.userInteractionEnabled = NO;
    if (M_CheckStrNil(self.tvc.event.id)) {
        // 修改活动
        // 上传活动内容
        [ServiceDiscover postEvent:self.tvc.event success:^{
            sender.userInteractionEnabled = YES;
            [self.tvc.navigationController popViewControllerAnimated:YES];
        } failure:^{
            sender.userInteractionEnabled = YES;
        }];
    } else {
        // 增加活动
        // 上传封面
        [Service uploadImage:self.tvc.event.imgData imageName:@"event" success:^(NSString *imgUrl) {
            self.tvc.event.img = imgUrl;
            // 上传活动内容
            [ServiceDiscover postEvent:self.tvc.event success:^{
                sender.userInteractionEnabled = YES;
                [self.tvc.navigationController popViewControllerAnimated:YES];
            } failure:^{
                sender.userInteractionEnabled = YES;
            }];
        } failure:^{
            sender.userInteractionEnabled = YES;
        }];
    }
}

- (IBAction)btnDeleteEventClick:(UIButton *)sender {
    ModelUser *user = [ModelUser defaultUser];
    if (![user.id isEqualToString:self.tvc.event.uid]) {
        [MyFunction displayAlertLabelWithMessage:@"You don‘t have permission"];
        return;
    } 
    [MyFunction displayAlertWithViewController:self.tvc title:nil message:@"Are you sure delete event?" sure:^(UIAlertAction *action) {
        sender.userInteractionEnabled = NO;
        [ServiceDiscover deleteEvent:self.tvc.event success:^{
            sender.userInteractionEnabled = YES;
            [self.tvc.navigationController popToRootViewControllerAnimated:YES];
        } failure:^{
            sender.userInteractionEnabled = YES;
        }];
    } cancel:nil];
}
@end
