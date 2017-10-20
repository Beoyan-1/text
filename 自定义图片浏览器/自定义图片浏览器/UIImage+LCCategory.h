//
//  UIImage+LCCategory.h
//  test
//
//  Created by 孙海平 on 16/5/9.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GIFimageBlock)(UIImage *GIFImage);  

@interface UIImage (LCCategory)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  改变image的tintColor
 *
 *  @param tintColor 要改变的颜色
 *
 *  @return 新的image
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;


/**
 *  拉伸图片
 *
 *  @param name image名字
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizeWithImageName:(NSString *)name;
/**
 *  缩放图片
 *
 *  @param image 原图片
 *  @param size  缩放尺寸
 *
 *  @return 缩放后的图片
 */
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (UIImage*) OriginImage:(UIImage *)image scaleToWidth:(CGFloat)width;

//按高比例缩放
+ (UIImage*) OriginImage:(UIImage *)image scaleToHeight:(CGFloat)height;


#pragma mark 获取视频第一帧
+ (UIImage *)getImageWithPath:(NSString *)videoURL;
/**
 *  调整图片方向
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;


+ (UIImage *)viewSnapshot:(UIView *)view withInRect:(CGRect)rect;

//iOS根据URL获取图片尺寸
+ (CGSize)getImageSizeWithURL:(id)URL;


/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;


/**
 根据文字生成对应文字的图片

 @param str 对应的文字
 @return 对应的图片
 */
+ (UIImage *)imageWithString:(NSString *)str imageSize:(CGSize)size backColor:(UIColor *)backColor wordColor:(UIColor *)wordColor wordFont:(UIFont *)wordFont;
@end
