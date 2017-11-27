//
//  EditImgVC.h
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditCompleted)(UIImage *editImage);
@interface EditImgVC : UIViewController<UIScrollViewDelegate>

/// 图片容器
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
/// 按钮容器
@property (weak, nonatomic) IBOutlet UIView *v_btn;
/// 改变交互开关
@property (weak, nonatomic) IBOutlet UISwitch *switchBounds;

/// 贝塞尔曲线
@property (nonatomic, strong) UIBezierPath *bezier;

/** 改变交互 */
- (IBAction)switchBoundsClick:(UISwitch *)sender;

/** 取消操作 */
- (IBAction)btnCancelClick:(UIButton *)sender;
/** 完成裁剪 */
- (IBAction)btnChooseClick:(UIButton *)sender;
 

/*
 * 显示界面
 * @param VC :上一页
 * @param img :要编辑的图片
 * @param completed :编辑完成回调
 */
+ (void)displayWithViewController:(UIViewController *)VC
                        sourceImg:(UIImage *)img
                        completed:(EditCompleted)completed;
@end
