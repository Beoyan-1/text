//
//  BottomColorModel.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/19.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomColorModel.h"

@implementation BottomColorModel


- (instancetype)initWithColorType:(HXAnnotationColorType)colorType {
    self = [super init];
    if (self) {
        
        self.colorType = colorType;
    }
    return self;
}

- (void)setColorType:(HXAnnotationColorType)colorType{
    
    _colorType = colorType;
    
    switch (colorType) {
            
        case HXRedColorType:
            
            _color = redBackgroundColor;
            
            break;
        case HXOrangeColorType:
            
            _color = kUIColorFromRGB(0xffa5f);
            
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
@end
