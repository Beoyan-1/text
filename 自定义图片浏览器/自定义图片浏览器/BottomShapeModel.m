//
//  BottomShapeModel.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/19.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomShapeModel.h"

@implementation BottomShapeModel

- (instancetype)initWithShapeType:(HXAnnotationModeType)type{
    
    if (self = [super init]) {
        
        self.type = type;
        
    }
    return self;
}


- (void)setType:(HXAnnotationModeType)type{
    
    _type = type;
    
    switch (type) {
            
        case HXAnnotationModeTypeLine:
            
            
            _iconNameStr = @"Cooperation_DrawIn_btn01";
            
            break;
            
        case HXAnnotationModeTypeArrow:
            
            _iconNameStr = @"Cooperation_ShapeIn_btn03";
            
            break;
        case HXAnnotationModeTypeCustom:
            
            _iconNameStr = @"Cooperation_DrawIn_btn02";
            
            
            break;
        case HXAnnotationModeTypeRectangular:
            
            _iconNameStr = @"Cooperation_ShapeIn_btn01";
            
            break;
        case HXAnnotationModeTypeRound:
            
            _iconNameStr = @"Cooperation_ShapeIn_btn02";
            
            break;
            
        default:
            break;
    }
    
    
}

@end
