//
//  HXUndoEntity.h
//  test
//
//  Created by 孙海平 on 2017/5/11.
//  Copyright © 2017年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXAnnotationBaseEntity.h"
#import "HXPointEntity.h"

typedef enum {
    HXUndoEntityOperationTypeAdd,
    HXUndoEntityOperationTypeEditor,
    HXUndoEntityOperationTypeRemov
} HXUndoEntityOperationType;
@interface HXUndoEntity : NSObject
//@property (nonatomic, strong) HXAnnotationBaseEntity * oldAnnotationEntity;
//@property (nonatomic, strong) HXAnnotationBaseEntity * currentAnnotationEntity;
//
//@property (nonatomic, assign) CGPoint oldSP;
//@property (nonatomic, assign) CGPoint oldEP;

@property (nonatomic, assign) HXUndoEntityOperationType operationType;
@property (nonatomic, strong) NSArray * AnnotationArr;
@property (nonatomic, strong) HXPointEntity * pointEntity;
@end
