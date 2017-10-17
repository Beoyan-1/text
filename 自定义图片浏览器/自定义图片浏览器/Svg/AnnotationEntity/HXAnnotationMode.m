//
//  HXAnnotationMode.m
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationMode.h"

@implementation HXAnnotationMode
#pragma mark get/set
- (UIColor *)color
{
    if (!_color) {
        _color = [UIColor blackColor];
    }
    return _color;
}
- (CGFloat)lineWidth
{
    if (!_lineWidth) {
        _lineWidth = 4;
        _lineWidth = 4;
    }
    return _lineWidth;
}
- (HXAnnotationModeType)type
{
    if (!_type) {
        _type = HXAnnotationModeTypeLine;
    }
    return _type;
}
+(instancetype)annotationModeShare
{
    static HXAnnotationMode * mode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mode = [[HXAnnotationMode alloc]init];
    });
    return mode;
}

@end
