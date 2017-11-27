//
//  SeeUserPageTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/20.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "SeeUserPageTVC.h"
#import "SeeUserPageInfoCell.h" 
#import "RecommendedCell.h"
#import "ViewEventVC.h"
#import "ServiceMyProfile.h"

@implementation SeeUserPageTVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendedCell" bundle:self.nibBundle] forCellReuseIdentifier:@"RecommendedCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, M_Width, 22)];
}

#pragma mark - 数据请求
- (void)requestData {
    [ServiceMyProfile userZone:self.userId success:^(ModelUserZone *zone) {
        self.zone = zone;
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

#pragma mark - <TableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 3;
    return self.zone.event.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self infoCellForRowAtIndexPath:indexPath];
    } else {
        return [self eventCellForRowAtIndexPath:indexPath];
    }
}
- (SeeUserPageInfoCell *)infoCellForRowAtIndexPath:(NSIndexPath *)indexPath {;
    NSString *ider;
    if (indexPath.row == 0) {
        ider = @"UNameCell";
    } else if (indexPath.row == 1) {
        ider = @"BtnCell";
    } else {
        ider = @"DesCell";
    }
    SeeUserPageInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ider forIndexPath:indexPath]; 
    cell.tvc = self;
    return cell;
}
- (RecommendedCell *)eventCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"RecommendedCell" forIndexPath:indexPath];
    ModelEvent *model = self.zone.event[indexPath.row];
    cell.event = model;
    return cell;
}

#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (self.zone.event.count == 0 ) {
            return 200;
        } else {
            return 60;
        }
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
        if (self.zone.event.count == 0 ) {
            if (!footer) {
                footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Footer"];
                CGRect frame = CGRectMake(0, 0, M_Width, 200);
                footer.frame = frame;
                frame.size.width /= 2.0;
                UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
                lbl.text = @"This user chooses to hide his/her past events";
                lbl.textColor = [UIColor lightGrayColor];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.numberOfLines = 0;
                lbl.center = footer.center;
                [footer addSubview:lbl];
            }
        } else {
            if (!footer) {
                footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Footer"];
                CGRect frame = CGRectMake(0, 0, M_Width, 60);
                footer.frame = frame;
                frame.origin.x = 15;
                frame.size.width = M_Width - 30;
                UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
                lbl.text = @"PAST EVENTS";
                [footer addSubview:lbl];
            }
        }
        return footer;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section != 1)
        return;
    ModelEvent *model = self.zone.event[indexPath.row];
    [ViewEventVC displayWithViewController:self
                                     event:model];
}


@end
