//
//  EditImgVC.m
//  MoCaCare
//
//  Created by xhb on 2017/10/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "EditImgVC.h"

@interface EditImgVC ()
/// 回调
@property (nonatomic, copy) EditCompleted completed;
/// 原图片
@property (nonatomic, strong) UIImage *sourceImg;
/// 原图片容器
@property (nonatomic, strong) UIImageView *icon_source;
/// 裁剪范围
@property (nonatomic, strong) UIView *cutView;
/// 裁剪框大小
@property (nonatomic, assign) CGRect cutFrame;
@end

@implementation EditImgVC

+ (void)displayWithViewController:(UIViewController *)VC sourceImg:(UIImage *)img completed:(EditCompleted)completed {
    EditImgVC *Edit = [[EditImgVC alloc] initWithNibName:@"EditImgVC" bundle:VC.nibBundle];
    Edit.hidesBottomBarWhenPushed = YES;
    Edit.sourceImg = img;
    Edit.completed = completed;
    [VC.navigationController pushViewController:Edit animated:YES];
}
#pragma mark - 视图加载 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    ShowBtnEvents(NO);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.switchBounds.on = NO;
    self.v_btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.scroView.delegate = self;
    self.icon_source = [[UIImageView alloc] initWithImage:self.sourceImg];
    // 裁剪框
    self.cutView = [[UIView alloc] init];
    self.cutView.backgroundColor = [UIColor clearColor];
    [self updateUserInteractionEnabled];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.icon_source.superview) {
        [self.scroView layoutIfNeeded];
        self.scroView.maximumZoomScale = 3.0;
        self.scroView.minimumZoomScale = 1.0;
        self.scroView.zoomScale = 1.0;
        
        self.icon_source.frame = CGRectMake(0, 0, M_Width, M_Width * self.sourceImg.size.height / self.sourceImg.size.width);
        self.icon_source.center = self.view.center;
        [self.scroView addSubview:self.icon_source];
        self.cutView.frame = CGRectMake(0, 0, M_Width, M_Height);
        [self.view addSubview:self.cutView];
        [self.view bringSubviewToFront:self.v_btn];
        [self.view bringSubviewToFront:self.switchBounds];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.cutView addGestureRecognizer:pan];
        
        // 绘制贝塞尔曲线
        self.bezier = [UIBezierPath bezierPath];
        [self drawCutViewTop:M_Height / 2.0 - M_Width / 2.0
                        left:0
                       right:M_Width
                      bottom:M_Height / 2.0 + M_Width / 2.0];
        [self updateCutView];
    }
}

- (void)drawCutViewTop:(CGFloat)top
                  left:(CGFloat)left
                 right:(CGFloat)right
                bottom:(CGFloat)bottom {
    static CGFloat t, l, r, b;
    t = top != 0 ? top : t;
    l = left != 0 ? left : l;
    r = right != 0 ? right : r;
    b = bottom != 0 ? bottom : b;
    [self.bezier removeAllPoints];
    [self.bezier moveToPoint:CGPointMake(l, t)];
    [self.bezier addLineToPoint:CGPointMake(r, t)];
    [self.bezier addLineToPoint:CGPointMake(r, b)];
    [self.bezier addLineToPoint:CGPointMake(l, b)];
    [self.bezier addLineToPoint:CGPointMake(l, t)];
    self.cutFrame = CGRectMake(l, t, r - l, b - t);
    [self updateCutView];
}
- (void)updateCutView {
    [self.cutView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = self.bezier.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = 1;
    [self.cutView.layer addSublayer:shapeLayer];
}

#pragma makr - 按钮操作
- (void)pan:(UIPanGestureRecognizer *)sender {
//    static CGPoint start;
    if (sender.state == UIGestureRecognizerStateBegan) {
//        start = [sender locationInView:self.cutView];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [sender locationInView:self.view];
//        point.x -= start.x;
//        point.y -= start.y;
        BOOL L = point.x < M_Width / 2.0;
        BOOL T = point.y < M_Height / 2.0;
        CGFloat margin = 15;
        CGFloat x = L ? point.x - margin : point.x + margin;
        CGFloat y = T ? point.y - margin : point.y + margin;
        x = x < 0 ? 0 : x;
        x = x > M_Width ? M_Width : x;
        y = y < 0 ? 0 : y;
        y = y > M_Height - 44 ? M_Height -44 : y;
        [self drawCutViewTop:T ? y : 0
                        left:L ? x : 0
                       right:L ? 0 : x
                      bottom:T ? 0 : y];
    }
}
- (IBAction)switchBoundsClick:(UISwitch *)sender {
    [self updateUserInteractionEnabled];
}
- (void)updateUserInteractionEnabled {
    if (self.switchBounds.on) {
        self.cutView.userInteractionEnabled = YES;
        self.scroView.userInteractionEnabled = NO;
    } else {
        self.cutView.userInteractionEnabled = NO;
        self.scroView.userInteractionEnabled = YES;
    }
}
- (IBAction)btnCancelClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnChooseClick:(UIButton *)sender {
    // 移除边框
    [self.cutView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    NSLog(@"%@", NSStringFromCGRect(self.cutFrame));
    // 全屏截图，包括window
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 你需要的区域起点,宽,高;
    UIImage * image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([viewImage CGImage], self.cutFrame)];
    if (self.completed) {
        self.completed(image);
    }                                                     
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UIScrollViewDelegate>
#pragma mark <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.icon_source;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //缩放过程中实时改变数值
    [scrollView setContentSize:self.icon_source.frame.size];
    CGSize size = scrollView.contentSize;
    CGPoint center;
    if (size.height > [UIScreen mainScreen].bounds.size.height) {
        center = CGPointMake(size.width/2.0, size.height/2.0);
    } else {
        center = CGPointMake(size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    }
    self.icon_source.center = center;
}
@end
