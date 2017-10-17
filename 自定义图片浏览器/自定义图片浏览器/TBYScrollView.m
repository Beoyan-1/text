//
//  TBYScrollView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TBYScrollView.h"

@implementation TBYScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    
    return YES;
}


- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }

    
        return YES;
    
    
} 

@end
