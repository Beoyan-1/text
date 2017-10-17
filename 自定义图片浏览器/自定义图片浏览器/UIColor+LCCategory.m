//
//  UIColor+LCCategory.m
//  test
//
//  Created by 孙海平 on 16/8/8.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import "UIColor+LCCategory.h"

@implementation UIColor (LCCategory)
+ (UIColor*)colorWithHexString:(NSString*)hex

{
    
    NSString *cString1 = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSString * cString = [cString1 substringFromIndex:1];
    
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    
    
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    
    
    
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:1.0f];
    
}



+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha

{
    
    NSString *cString1 = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSString * cString = [cString1 substringFromIndex:1];
    
    
    
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    
    
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    
    
    
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:alpha];
    
}
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
+(NSString*)toStrByUIColor:(UIColor*)color{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"#%06x", rgb];
}
@end
