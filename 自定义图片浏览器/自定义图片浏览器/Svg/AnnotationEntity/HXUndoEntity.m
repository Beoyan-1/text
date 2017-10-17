//
//  HXUndoEntity.m
//  test
//
//  Created by 孙海平 on 2017/5/11.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import "HXUndoEntity.h"

@implementation HXUndoEntity
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pointEntity = [[HXPointEntity alloc]init];
    }
    return self;
}
@end
