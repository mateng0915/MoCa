//
//  PostEventQuestinoCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventQuestinoCell.h"

@implementation PostEventQuestinoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblQuestionNumber.layer.cornerRadius = 4.0;
}

- (void)setTvc:(PostEventTVC *)tvc {
    [super setTvc:tvc];
    NSIndexPath *indexPath = [self.tvc.tableView indexPathForCell:self];
    if (self.tvc.event.question.count > indexPath.row - 1) {
        NSString *str = self.tvc.event.question[indexPath.row - 1];
        self.textFiledQuestion.text = str;
    }
}
#pragma mark - 按钮事件
- (IBAction)btnAddQuestionClick:(UIButton *)sender {
    [self.tvc.event.question addObject:@""];
    [self.tvc.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tvc.event.question.count inSection:3];
    [self.tvc.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tvc.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tvc.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self.tvc.tableView endUpdates];
}

#pragma mark - 键盘监听
- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.textFiledQuestion &&
        M_CheckStrNil(self.textFiledQuestion.text)) {
        NSIndexPath *indexPath = [self.tvc.tableView indexPathForCell:self];
        [self.tvc.event.question setObject:self.textFiledQuestion.text atIndexedSubscript:indexPath.row - 1];
    }
}
@end
