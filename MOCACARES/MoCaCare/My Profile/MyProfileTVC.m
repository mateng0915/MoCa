//
//  MyProfileTVC.m
//  MoCaCare
//
//  Created by xhb on 2017/9/14.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "MyProfileTVC.h"
#import "DXBadgeButton.h"
#import "ServiceAccount.h"
#import "ServiceMyProfile.h"
#import "UIImageView+WebCache.h"

@implementation MyProfileTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ModelUser *user = [ModelUser defaultUser];
    [self.imgVPortrait sd_setImageWithURL:[Service getImageCompleteURLWithString:user.img] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
    self.lblName.text = user.username;
    self.lblDes.text = user.statement;
    self.lblIdentity.text = user.occupation;
    [self.tableView reloadData];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat width = M_Width - 20.0 * 2 - 1;
//    self.lblName.preferredMaxLayoutWidth = width;
//    self.lblIdentity.preferredMaxLayoutWidth = width;
//    self.lblDes.preferredMaxLayoutWidth = width;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 44.0;
    
    self.badgeNotifications.didDisappearBlock = ^(DXBadgeButton *badgeButton) {
        badgeButton.hidden = YES;
    };
    self.badgeMessages.didDisappearBlock = ^(DXBadgeButton *badgeButton) {
        badgeButton.hidden = YES;
    };
    self.imgVPortrait.image = [MyFunction creatImageWithColor:PlaceholderColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHader:)];
    [self.imgVPortrait addGestureRecognizer:tap];
    self.imgVPortrait.userInteractionEnabled = YES;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.imgVPortrait.layer.cornerRadius == 0) {
        [self.imgVPortrait.superview layoutIfNeeded];
        self.imgVPortrait.layer.masksToBounds = YES;
        self.imgVPortrait.layer.cornerRadius = self.imgVPortrait.bounds.size.width / 2.0;
    }
}
#pragma mark - 数据请求 
- (void)requestData {
    [ServiceMyProfile getNoReadSuccess:^(NSString *num_msg, NSString *num_comment) {
        self.badgeNotifications.hidden = NO;
        self.badgeNotifications.badgeString = num_comment;
        if (!M_CheckStrNil(num_comment) ||
            num_comment.integerValue == 0) {
            self.badgeNotifications.hidden = YES;
        }
        
        self.badgeMessages.hidden = NO;
        self.badgeMessages.badgeString = num_msg;
        if (!M_CheckStrNil(num_msg) ||
            num_msg.integerValue == 0) {
            self.badgeMessages.hidden = YES;
        }
    } failure:^{
        
    }];
}

#pragma mark - 界面跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"NotificationsSegue"]) {
        [self.badgeNotifications hiddenBadgeButton:YES];
    }
    if ([segue.identifier isEqualToString:@"MessageSegue"]) {
        [self.badgeMessages hiddenBadgeButton:YES];
    }
}

#pragma mark - 切换头像
- (void)tapHader:(UITapGestureRecognizer *)gesture {
    ShowBtnEvents(NO);
//    NSLog(@"选择照片");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }];
    [alert addAction:album];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    [alert addAction:camera];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ShowBtnEvents(YES);
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)openAlbum {
    // NSLog(@"打开相册");
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)openCamera {
    // NSLog(@"打开相机");
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟器无法打开照相机,请在真机中使用");
    }
}
//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [Service uploadImage:data imageName:@"头像" success:^(NSString *imgUrl) {
            ModelUser *user = [ModelUser defaultClearUser];
            user.img = imgUrl;
            [ServiceAccount eidtUserInfo:user success:^{
                [self.imgVPortrait sd_setImageWithURL:[Service getImageCompleteURLWithString:imgUrl] placeholderImage:[MyFunction creatImageWithColor:PlaceholderColor] options:SDWebImageRetryFailed];
                [user saveUserInfo];
                ShowBtnEvents(YES);
            } failure:^{
                
            }];
            [picker dismissViewControllerAnimated:YES completion:nil];
        } failure:^{
            ShowBtnEvents(YES);
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // NSLog(@"您取消了选择图片");
    ShowBtnEvents(YES);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>
#pragma mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat height = 0;
        CGFloat lblWidth = M_Width - 20 * 2 - 1;
        height = 8 * 4 + 15 + 1 + M_Width / 3.0;
//        height += [self.lblName autolayoutHeighWithWidth:lblWidth];
//        height += [self.lblIdentity autolayoutHeighWithWidth:lblWidth];
//        height += [self.lblDes autolayoutHeighWithWidth:lblWidth];
        height += [MyFunction getLabelSizeWithMessage:self.lblName.text fontSize:20 labelWidth:lblWidth].height + 4;
        height += [MyFunction getLabelSizeWithMessage:self.lblIdentity.text fontSize:13 labelWidth:lblWidth].height;
        height += [MyFunction getLabelSizeWithMessage:self.lblDes.text fontSize:15 labelWidth:lblWidth].height;
        return height;
    }
    return 44.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
} 
@end
