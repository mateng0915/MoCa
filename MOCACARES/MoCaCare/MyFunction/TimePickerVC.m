//
//  TimePackerVC.m
//  GouMei
//
//  Created by xhb on 16/12/26.
//  Copyright © 2016年 youmijia. All rights reserved.
//

#import "TimePickerVC.h"

@interface TimePickerVC ()
/// 底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// 选择器主体
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
/// 选择器类型
@property (nonatomic, assign) PickerType type;
/// 回调
@property (nonatomic, copy) blockTimeCompleted completed;
@end

@implementation TimePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)dealloc {
    self.completed = nil;
}

- (IBAction)buttonClick:(UIButton *)sender {
    [self dismiss];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.type == PickerTypeDate) {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    } else if (self.type == PickerTypeTime) {
        [formatter setDateFormat:@"hh:mm"];
    } else {
        [formatter setDateFormat:@"yyyy/MM/dd hh:mm"];
    }
    
    if (self.completed) {
        self.completed([formatter stringFromDate:self.datePicker.date]);
    }
    [self dismiss];
}

- (void)displayWithViewController:(UIViewController *)VC
                            title:(NSString *)title
                             type:(PickerType)type
                        cmopleted:(blockTimeCompleted)completed {
    [VC.navigationController addChildViewController:self];
    [VC.navigationController.view addSubview:self.view];
    self.view.frame = CGRectMake(0, 0, M_Width, M_Height);
    
    self.type = type;
    self.completed = completed;
    self.bottomLayout.constant = -250;
    [self.view layoutIfNeeded];
    
    self.titleLabel.text = title;
//    [self.datePicker setMinimumDate:[NSDate date]];
    if (type == PickerTypeDate) {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    } else if (type == PickerTypeTime) {
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    } else {
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
        
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        self.bottomLayout.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss { 
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.bottomLayout.constant = -250;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
}
@end
