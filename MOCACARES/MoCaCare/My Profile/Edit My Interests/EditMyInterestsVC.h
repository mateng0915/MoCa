//
//  EditMyInterestsVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMyInterestsVC : UIViewController

/// 自定义导航视图
@property (weak, nonatomic) IBOutlet UIView *viewNav;
/// 按钮——志愿者们
@property (weak, nonatomic) IBOutlet UIButton *btnIndividuals;
/// 按钮——组织者们
@property (weak, nonatomic) IBOutlet UIButton *btnOrganizations;
/// 列表父容器
@property (weak, nonatomic) IBOutlet UIView *viewContent;
/// 返回按阿牛
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

/// 当前列表索引
@property (nonatomic, assign) NSInteger idx;

/** 返回上个界面 */
- (IBAction)btnBackClick:(UIButton *)sender;
/** 查看志愿者列表 */
- (IBAction)btnIndividualsClick:(UIButton *)sender;
/** 查看组织者列表 */
- (IBAction)btnOrganizationsClick:(UIButton *)sender;
@end
