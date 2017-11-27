//
//  PostEventQuestinoCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventCell.h"

@interface PostEventQuestinoCell : PostEventCell

/// 问题编号
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionNumber;
/// 问题描述
@property (weak, nonatomic) IBOutlet UITextField *textFiledQuestion;

/** 增加问题 */
- (IBAction)btnAddQuestionClick:(UIButton *)sender;
@end
