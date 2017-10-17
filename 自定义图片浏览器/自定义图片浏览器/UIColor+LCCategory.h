//
//  UIColor+LCCategory.h
//  test
//
//  Created by 孙海平 on 16/8/8.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LCCategory)
//通过十六进制 得到颜色 
+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha;
/**
 *  随机色
 */
+(UIColor *) randomColor;
+(NSString*)toStrByUIColor:(UIColor*)color;
@end
