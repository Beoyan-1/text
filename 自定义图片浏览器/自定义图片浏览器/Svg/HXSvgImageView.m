//
//  HXSvgImageView.m
//  HXHY
//
//  Created by 佟博研 on 2017/9/14.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXSvgImageView.h"

@implementation HXSvgImageView


- (void)drawRect:(CGRect)rect {
    
    for (HXAnnotationBaseEntity * entity in self.annotationArrM) {
        
        [entity drawAnnotaiton];
        
    }
}


@end
