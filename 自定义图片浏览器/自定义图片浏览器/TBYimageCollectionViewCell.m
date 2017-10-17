//
//  TBYimageCollectionViewCell.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/12.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TBYimageCollectionViewCell.h"
#import "HXDrawView_S.h"
#import "TBYScrollView.h"
#import "Masonry.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define maxsize 4

@interface TBYimageCollectionViewCell ()<UIScrollViewDelegate,HXDrawViewAnnotationDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView * imageScrollerView;

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) HXDrawView_S * drawView;

@property (nonatomic, assign) BOOL isCanTouch;


/**
 最开始的frame
 */
@property (nonatomic, assign) CGRect cropFrame;

/**
 最大能放大的frame
 */
@property (nonatomic, assign) CGRect largeFrame;

@property (nonatomic, strong) UIPanGestureRecognizer * twoPanGes;

@property (nonatomic, strong) UIPinchGestureRecognizer * pinchGestureRecognizer;

@end

@implementation TBYimageCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
  
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        [self.contentView addSubview:self.imageScrollerView];
        
        [self.imageScrollerView addSubview:self.imageView];
        
        [self.imageView addSubview:self.drawView];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [self.drawView addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    if (self.touchBlock) {
        
        self.touchBlock();
    }
    
}

/********* 拖拽手势 ********/
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = self.imageView;
    panGestureRecognizer.cancelsTouchesInView = YES;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        
        LCLog(@"%f",translation.x);
        LCLog(@"%f",translation.y);
        
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // bounce to original frame
        CGRect newFrame = self.imageView.frame;
        newFrame = [self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.frame = newFrame;
        }];
    }
}

/********* 捏和手势 ********/
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = self.imageView;
    
    pinchGestureRecognizer.cancelsTouchesInView = YES;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat scale = pinchGestureRecognizer.scale;
        CGPoint point = [pinchGestureRecognizer locationInView:self.drawView];
        if (pinchGestureRecognizer.scale < 0.9) {
            pinchGestureRecognizer.scale = 0.9;
        }
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        
        CGFloat dx = CGRectGetMidX(view.frame) - point.x;
        CGFloat dy = CGRectGetMidY(view.frame) - point.y;
        CGFloat x = dx * scale - dx;
        CGFloat y = dy * scale - dy;
        
        view.transform = CGAffineTransformConcat(view.transform, CGAffineTransformMakeTranslation(x, y));
        
        pinchGestureRecognizer.scale = 1;
        
    }
    
    else if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGRect newFrame = self.imageView.frame;
        newFrame = [self handleScaleOverflow:newFrame];
        newFrame = [self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:0.3 animations:^{
            
          LCLog(@"%@",NSStringFromCGRect(newFrame));
            self.imageView.frame = newFrame;
//            self.drawView.frame = self.imageView.bounds;

        }];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}

#pragma mark - private
//拖拽后恢复成正确的位置
- (CGRect)handleBorderOverflow:(CGRect)newFrame{
    
    // horizontally
    if (newFrame.origin.x > self.cropFrame.origin.x) newFrame.origin.x = self.cropFrame.origin.x;
    if (CGRectGetMaxX(newFrame) < self.cropFrame.size.width + self.cropFrame.origin.x)
        newFrame.origin.x = self.cropFrame.size.width - newFrame.size.width + self.cropFrame.origin.x;
    // vertically
    if (newFrame.origin.y > self.cropFrame.origin.y) newFrame.origin.y = self.cropFrame.origin.y;
    if (CGRectGetMaxY(newFrame) < self.cropFrame.origin.y + self.cropFrame.size.height) {
        newFrame.origin.y = self.cropFrame.origin.y + self.cropFrame.size.height - newFrame.size.height;
    }
    // adapt horizontally rectangle
    if (self.imageView.frame.size.width > self.imageView.frame.size.height && newFrame.size.height <= self.cropFrame.size.height) {
        newFrame.origin.y = self.cropFrame.origin.y + (self.cropFrame.size.height - newFrame.size.height) / 2;
    }
    return newFrame;
    
}

- (CGRect)handleScaleOverflow:(CGRect)newFrame {
    // bounce to original frame
    CGPoint oriCenter = CGPointMake(newFrame.origin.x + newFrame.size.width/2, newFrame.origin.y + newFrame.size.height/2);
    if (newFrame.size.width < self.cropFrame.size.width) {
        newFrame = self.cropFrame;
    }
//    if (newFrame.size.width > self.largeFrame.size.width) {
//        newFrame = self.largeFrame;
//    }
    newFrame.origin.x = oriCenter.x - newFrame.size.width/2;
    newFrame.origin.y = oriCenter.y - newFrame.size.height/2;
    return newFrame;
}

#pragma mark - get/set

- (void)setIconImage:(UIImage *)iconImage{
    
    _iconImage = iconImage;
    CGFloat imageWidthHeightRatio = iconImage.size.width / iconImage.size.height;
    
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    width = (iconImage.size.width > self.width) ? self.width : iconImage.size.width;
    
    height = width/imageWidthHeightRatio;
    
    if (width > self.width) {
        
        x = 0;
    }else{
        x = (self.width - width) * 0.5;
    }
   
    if (height > self.height) {
        y = 0;
    } else {
        y = (self.height - height ) * 0.5;
    }
    
    self.imageView.image = iconImage;
    self.imageView.frame = CGRectMake(x, y, width, height);
    self.drawView.frame = CGRectMake(0, 0, width, height);
    self.cropFrame = CGRectMake(x, y, width, height);
    self.largeFrame = CGRectMake(0, 0, width * maxsize, height * maxsize);
    self.imageScrollerView.contentSize = CGSizeMake(width, height);
}

#pragma mark - get/set

- (UIScrollView *)imageScrollerView{
    
    if (!_imageScrollerView) {
        _imageScrollerView = [[UIScrollView alloc] init];
        _imageScrollerView.frame = self.bounds;
        _imageScrollerView.showsHorizontalScrollIndicator = NO;
        _imageScrollerView.showsVerticalScrollIndicator = NO;
        _imageScrollerView.maximumZoomScale = 3;
        _imageScrollerView.minimumZoomScale = 1;
        _imageScrollerView.delegate = self;
        _imageScrollerView.scrollEnabled = NO;
    }
    
    return _imageScrollerView;
}

- (UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    
    return _imageView;
}

- (HXDrawView_S *)drawView{
    
    if (!_drawView) {
        
        _drawView = [[HXDrawView_S alloc] init];
        _drawView.backgroundColor = [UIColor clearColor];
        _drawView.multipleTouchEnabled = YES;
        _drawView.userInteractionEnabled = YES;
        _drawView.annotationDelegate = self;
        
    }
    return _drawView;
}


- (void)prepareForReuse{
    [super prepareForReuse];
    
    _imageScrollerView.frame = self.bounds;
    _imageScrollerView.zoomScale = 1;
    
}

@end
