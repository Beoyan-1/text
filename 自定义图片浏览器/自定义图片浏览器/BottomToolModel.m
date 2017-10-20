//
//  BottomToolModel.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomToolModel.h"

@implementation BottomToolModel


- (UIColor *)selectColor{
    
//    if (!_selectColor) {
    
        _selectColor = [HXAnnotationMode annotationModeShare].color;
        
//    }
    
    return _selectColor;
}

- (NSString *)iconImage{
    
    
    if (!_iconImage) {
        
        
        switch (self.svgType) {
            case svgsettype:
                
                _iconImage = @"Cooperation_SettingIn_btn";
                break;
            case svgbrushtype:
                
                _iconImage = @"Cooperation_DrawIn_btn";
                
                break;
            case svgshapetype:
                
                _iconImage = @"Cooperation_ShapeIn_btn";
                break;
            case svgcharactertype:
                _iconImage = @"Cooperation_TextIn_btn";
                
                break;
            case svglasertype:
                
                _iconImage = @"Cooperation_LaserIn_btn";
                
                break;
            case svgannotationtype:
                
                _iconImage = @"Cooperation_BlankIn_btn";
                break;
                
            default:
                break;
        }
        
    }
    
    return _iconImage;
}


- (NSString *)descStr{
    
    
    if (!_descStr) {
        
        switch (self.svgType) {
            case svgsettype:
                
                _descStr = @"设置";
                break;
                
            case svgbrushtype:
                _descStr = @"画笔";
                
                break;
                
            case svgshapetype:
                _descStr = @"形状";
                
                break;
                
            case svgcharactertype:
                _descStr = @"文字";
                
                break;
                
            case svglasertype:
                _descStr = @"激光笔";
                
                break;
            case svgannotationtype:
                
                _descStr = @"注释";
                
                break;
                
            default:
                break;
        }
        
    }
    return _descStr;
}



@end
