//
//  EventCommentCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EventCommentCell.h"
#import "SeeUserPageVC.h"
#import "ServiceDiscover.h"

@implementation EventCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textViewInput.layer.borderWidth = 1.0;
    self.textViewInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textViewInput.layer.cornerRadius = 4.0;
    self.btnSend.layer.cornerRadius = 4.0;
    self.viewComment.layer.cornerRadius = 4.0;
    self.lblComment.preferredMaxLayoutWidth = M_Width - 15 * 2 - 5 * 2 - 50 - 6 - 1;
    
    self.textViewInput.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.btnHeader &&
        self.btnHeader.layer.cornerRadius == 0) {
        [self.contentView layoutIfNeeded];
        self.btnHeader.layer.masksToBounds = YES;
        self.btnHeader.layer.cornerRadius = self.btnHeader.bounds.size.width / 2.0;
    }
}

#pragma mark - 设置内容样式
- (void)setModel:(ModelComment *)model {
    if (!model)
        return;
    _model = model;
    self.lblComment.text = model.content;
    self.lblUsername.text = model.u_username;
    [self.btnHeader sd_setBackgroundImageWithURL:[Service getImageCompleteURLWithString:model.u_img] forState:UIControlStateNormal placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
}

#pragma mark - 按钮事件
- (IBAction)btnHeaderClick:(UIButton *)sender {
//    NSLog(@"个人中心");
    [SeeUserPageVC displayWithViewController:self.tvc userId:self.model.uid];
}

- (IBAction)btnSendClick:(UIButton *)sender {
    [self.tvc.tableView endEditing:YES];
    NSString *msg = self.textViewInput.text;
    if (M_CheckStrNil(msg)) {
        [ServiceDiscover submitComment:msg eventId:self.tvc.eventId success:^{
            self.textViewInput.text = @"";
            [self.tvc requestCommentList];
        } failure:^{
            
        }];
    } else {
        [MyFunction displayAlertLabelWithMessage:@"Please input your comments"];
    }
}

#pragma mark - <UITextViewDelegate>
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if ([text isEqualToString:@"\n"]){
//        //判断输入的字是否是回车，即按下return
//        NSString *msg = M_CheckStrNil(textView.text);
//        NSLog(@"%@", msg);
//        if (msg) {
//            [ServiceDiscover submitComment:msg eventId:self.tvc.eventId success:^{
//                self.textViewInput.text = @"";
//                [self.tvc requestCommentList];
//            } failure:^{
//                
//            }];
//        }
//        return NO;
//    }
//    
//    return YES;
//}
@end
