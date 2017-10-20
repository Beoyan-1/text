//
//  BottomToolView.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomToolCollectionViewCell.h"

typedef void(^touchIcon)(BottomToolModel * model);

@interface BottomToolView : UIView


@property (nonatomic, copy) touchIcon touchIconBlock;

- (void)reloadColor;

@end
