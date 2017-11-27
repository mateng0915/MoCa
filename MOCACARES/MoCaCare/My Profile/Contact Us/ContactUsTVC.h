//
//  ContactUsTVC.h
//  MoCaCare
//
//  Created by xhb on 2017/9/15.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsTVC : UITableViewController
/// 输入框
@property (weak, nonatomic) IBOutlet UITextView *textView;
/// 按钮——提交
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

/** 提交反馈 */
- (IBAction)btnSubmitClick:(UIButton *)sender;
@end
