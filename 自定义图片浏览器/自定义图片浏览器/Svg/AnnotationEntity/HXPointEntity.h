//
//  HXPointEntity.h
//  test
//
//  Created by 孙海平 on 2017/5/17.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXPointEntity : NSObject
@property (nonatomic, assign) CGPoint pointS;
@property (nonatomic, assign) CGPoint pointE;
@property (nonatomic, assign) CGPoint oldPointS;
@property (nonatomic, assign) CGPoint oldPointE;

@property (nonatomic, assign) CGPoint oldPointM;
@property (nonatomic, assign) CGPoint pointM;

//@property (nonatomic, strong) NSArray* pointArr;
//@property (nonatomic, strong) NSArray* oldPointArr;
@end
