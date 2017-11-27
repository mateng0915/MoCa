//
//  PostEventImageCell.m
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventImageCell.h"
#import "UIImageView+WebCache.h"
#import "EditImgVC.h"

@implementation PostEventImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThumb:)];
    [self.imgVThumb addGestureRecognizer:tap];
    self.imgVThumb.userInteractionEnabled = YES;
}
- (void)setTvc:(PostEventTVC *)tvc {
    [super setTvc:tvc];
    if (self.imgVThumb) {
        if (M_CheckStrNil(self.tvc.event.img)) {
            [self.imgVThumb sd_setImageWithURL:[Service getImageCompleteURLWithString:self.tvc.event.img] placeholderImage:nil options:SDWebImageRetryFailed];
        } else if (self.tvc.event.imgData) {
            self.imgVThumb.image = [UIImage imageWithData:self.tvc.event.imgData];
        } else {
            self.imgVThumb.image = nil;
        }
    }
}

#pragma mark - 选择图片上传
- (void)tapThumb:(UITapGestureRecognizer *)gesture {
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
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self.tvc presentViewController:alert animated:YES completion:nil];
}
- (void)openAlbum {
    // NSLog(@"打开相册");
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.tvc presentViewController:picker animated:YES completion:^{
            ShowBtnEvents(NO);
        }];
    }
}
- (void)openCamera {
    // NSLog(@"打开相机");
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera; 
        [self.tvc presentViewController:picker animated:YES completion:^{
            ShowBtnEvents(NO);
        }];
    } else {
        NSLog(@"模拟器无法打开照相机,请在真机中使用");
    }
}
//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:^{
            [EditImgVC displayWithViewController:self.tvc sourceImg:image completed:^(UIImage *editImage) {
                self.imgVThumb.image = editImage;
                //先把图片转成NSData
                self.tvc.event.imgData = UIImageJPEGRepresentation(editImage, 1.0);
//                self.tvc.event.imgData = UIImagePNGRepresentation(image);
                [self.tvc.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }]; 
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
