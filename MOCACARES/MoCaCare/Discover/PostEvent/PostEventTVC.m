//
//  PostEventTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventTVC.h"
#import "PostEventCell.h"
#import "PostEventTitleCell.h"
#import "PostEventImageCell.h"
#import "PostEventInputCell.h"
#import "PostEventTimeCell.h"
#import "PostEventSettingCell.h"
#import "PostEventQuestinoCell.h"

#import "ServiceDiscover.h"

static NSArray *section0CellIdentifier;
@implementation PostEventTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (M_CheckStrNil(self.event.id) &&
        [self.event.uid isEqualToString:[ModelUser defaultUser].id]) {
        self.edit = YES;
    } else {
        self.edit = NO;
    }
    section0CellIdentifier =
            @[@"TitleCell", @"ImageCell",
              @"InputNameCell", @"SetCategoryCell"];
    // 获取类别数组
    [self requestCategorys];
}
- (void)setTimeModel:(TimeModel)timeModel {
    _timeModel = timeModel;
    if (self.event) {
        self.event.time_type = timeModel;
    }
}
#pragma mark - 数据请求
- (void)requestCategorys {
    [ServiceDiscover getEventCategoryListSuccess:^(NSArray<ModelEventCategory *> *list) {
        self.categorys = [list copy];
        if (!M_CheckStrNil(self.event.type)) {
            self.event.type = list.firstObject.id;
            self.event.t_name = list.firstObject.name;
        } else {
            [list enumerateObjectsUsingBlock:^(ModelEventCategory * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.id isEqualToString:self.event.type]) {
                    self.event.t_name = obj.name;
                    *stop = YES;
                }
            }];
        }
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    } failure:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return section0CellIdentifier.count;
    } else if (section == 1) {
        if (self.timeModel == TimeModelOneOff) {
            return 2;
        } else if (self.timeModel == TimeModelRecurring) {
            return 2;
        } else {
            return 1;
        }
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 2 + self.event.question.count;
    } else {
        if (self.edit)
            return 2;
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    PostEventCell *cell;
    if (section == 0) { // 标题、图片、活动名、类别（固定）
        NSString *ider = section0CellIdentifier[row];
        cell = [tableView dequeueReusableCellWithIdentifier:ider forIndexPath:indexPath];
        if (row == 3) {
            PostEventSettingCell *categoryCell = (PostEventSettingCell *)cell;
            categoryCell.lblCategory.text = self.event.t_name;
        }
    } else if (section == 1) {
        if (row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SetTimeCell" forIndexPath:indexPath];
        } else {
            if (self.timeModel == TimeModelOneOff) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"OneOffTimeCell" forIndexPath:indexPath];
            } else if (self.timeModel == TimeModelRecurring) {cell = [tableView dequeueReusableCellWithIdentifier:@"RecurringTimeCell" forIndexPath:indexPath];
            }
        }
    } else if (section == 2) {
        if (row == 0) { // 地点
            cell = [tableView dequeueReusableCellWithIdentifier:@"InputLocationCell" forIndexPath:indexPath];
        } else {    // 描述
            cell = [tableView dequeueReusableCellWithIdentifier:@"InputDesCell" forIndexPath:indexPath];
        }
    } else if (section == 3) {
        if (row == 0) { // 标题
            cell = [tableView dequeueReusableCellWithIdentifier:@"TitleQuestionCell" forIndexPath:indexPath];
        } else if (row == 1 + self.event.question.count) {
            // 增加问题
            cell = [tableView dequeueReusableCellWithIdentifier:@"AddQuestinoCell" forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"QuestinoCell" forIndexPath:indexPath];
            ((PostEventQuestinoCell *)cell).lblQuestionNumber.text = [NSString stringWithFormat:@"Question %d:", (int)row];
            ((PostEventQuestinoCell *)cell).textFiledQuestion.text = self.event.question[indexPath.row - 1];
        }
    } else {
        if (row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DeleteCell" forIndexPath:indexPath];
        }
    }
    cell.tvc = self; 
    return cell;
}


#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    if (section == 0) {
        if (row == 1) {
            if (self.event.imgData) {
                UIImage *img = [UIImage imageWithData:self.event.imgData];
                return M_Width * img.size.height / img.size.width;
            } else {
                return (M_Width - 8 * 2) * 9.0 / 16.0;
            }
        } else if (row == section0CellIdentifier.count - 1) {
            return 36;
        }
    } else if (section == 1) {
        if (row > 0)
            return 3 * 8 + 2 * 20;
    } else if (section == 3) {
        if (row == 0 || row == 1 + self.event.question.count)
            return 30.0;
    } else {
        return 60.0;
    }
    return 40.0;
}

@end
