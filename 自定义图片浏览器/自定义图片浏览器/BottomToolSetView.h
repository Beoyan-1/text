//
//  BottomToolSetView.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomToolModel.h"

typedef void(^reload)(void);

@interface BottomToolSetView : UIView


@property (nonatomic, strong) BottomToolModel * model;

@property (nonatomic, copy) reload reloadBlock;

@end
