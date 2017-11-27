//
//  PostEventImageCell.h
//  MoCaCare
//
//  Created by xhb on 2017/9/18.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "PostEventCell.h"

@interface PostEventImageCell : PostEventCell <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/// 封面
@property (weak, nonatomic) IBOutlet UIImageView *imgVThumb;
@end
