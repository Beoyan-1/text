//
//  HXAnnotationMode.m
//  test
//
//  Created by 孙海平 on 2017/4/19.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXAnnotationMode.h"





@implementation HXAnnotationMode

@synthesize colorType = _colorType;


#pragma mark get/set
- (UIColor *)color
{
    if (!_color) {
        _color = redBackgroundColor;
    }
    return _color;
}
- (CGFloat)lineWidth
{
    if (!_lineWidth) {
        _lineWidth = 4;
    }
    return _lineWidth;
}
//- (HXAnnotationModeType)type
//{
//    if (!_type) {
//        _type = HXAnnotationModeTypeNul;
//    }
//    return _type;
//}

- (void)setColorType:(HXAnnotationColorType)colorType{
    
    _colorType = colorType;
    
    switch (colorType) {
            
        case HXRedColorType:
            
            _color = redBackgroundColor;
            
            break;
        case HXOrangeColorType:
            
            _color = kUIColorFromRGB(0xffaa5f);
            
            break;
        case HXYellorColorType:
            
            _color = kUIColorFromRGB(0xffe596);
            break;
        case HXGreenColorType:
            
            _color = kUIColorFromRGB(0x32d7b6);
            break;
        case HXBlueColorType:
            
            _color = kUIColorFromRGB(0x5ec6fb);
            break;
        case HXPurpleColorType:
            
            _color = kUIColorFromRGB(0xbe9cd2);
            break;
        case HXWhiteColorType:
            
            _color = kUIColorFromRGB(0xeeeff3);
            break;
        case HXGrayColorType:
            
            _color = kUIColorFromRGB(0x93999d);
            break;
        case HXBlackColorType:
            
            _color = kUIColorFromRGB(0x1b1b1b);
            break;

        default:
            break;
    }
}

//- (HXAnnotationColorType)colorType{
//    
//    
//    if (!_colorType) {
//        
//        _colorType = HXRedColorType;
//    }
//    return _colorType;
//}


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
