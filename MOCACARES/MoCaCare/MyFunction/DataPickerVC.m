//
//  DataPicker.m
//  Demo
//
//  Created by xhb on 16/9/7.
//  Copyright © 2016年 xhb. All rights reserved.
//

#import "DataPickerVC.h"

@interface DataPickerVC () <UIPickerViewDelegate, UIPickerViewDataSource>
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// 取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
/// 按约定按钮
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
/// 选择器主体
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
/// 底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewBottomLayout;
/// 选择器高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewHeightLayout;
/// 回调
@property (nonatomic, copy) blockDataCompleted completed;
@end

@implementation DataPickerVC {
    NSInteger column1Value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)dealloc {
    self.completed = nil;
}

- (void)displayWithViewController:(UIViewController *)VC
                            title:(NSString *)title
                          dataArr:(NSArray *)dataArr
                        completed:(blockDataCompleted)completed {
    [VC.navigationController addChildViewController:self];
    [VC.navigationController.view addSubview:self.view];
    self.view.frame = CGRectMake(0, 0, M_Width, M_Height);
    
    self.titleLabel.text = title;
    self.dataArr = dataArr;
    self.completed = completed;
    
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.autoresizingMask =    UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.pickerViewBottomLayout.constant = -self.pickerViewHeightLayout.constant;
    [self.view layoutIfNeeded];
    if (self.dataArr.count == 0) {
        NSLog(@"数据源为空");
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.pickerViewBottomLayout.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.pickerViewBottomLayout.constant = -_pickerViewHeightLayout.constant;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
}

- (IBAction)cancelButtonTouchUpInside:(UIButton *)sender {
    [self dismiss];
}
- (IBAction)sureButtonTouchUpInside:(UIButton *)sender {
    if (self.completed) {
        NSString *value = self.dataArr[column1Value];
        self.completed(column1Value, value);
    }
    [self dismiss];
}
- (IBAction)bgButtonTouchUpInside:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - <PickerViewDataSourceDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArr[row];
}

#pragma mark-设置下方的数据刷新
// 当选中了pickerView的某一行的时候调用
// 会将选中的列号和行号作为参数传入
// 只有通过手指选中某一行的时候才会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //获取对应列，对应行的数据
    column1Value = [pickerView selectedRowInComponent:0];
    [pickerView reloadComponent:0];
}

@end
