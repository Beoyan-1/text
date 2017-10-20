//
//  ToolRoundView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/20.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "ToolRoundView.h"
#import "HXAnnotationMode.h"

@implementation ToolRoundView


- (void)drawRect:(CGRect)rect {
    
    HXAnnotationMode * model = [HXAnnotationMode annotationModeShare];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context,  rect.size.width/2,  rect.size.width/2, model.lineWidth * 12/20 + 0.5, 0, 2 * M_PI, 0);
    
    CGContextSetFillColorWithColor(context, model.color.CGColor);
    
    CGContextDrawPath(context, kCGPathFill);
    
}


@end
