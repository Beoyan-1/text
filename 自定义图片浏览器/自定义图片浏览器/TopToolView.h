//
//  TopToolView.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^leftBlock)(void);
typedef void(^rightBlock)(void);
typedef void(^cancleBlock)(void);
typedef void(^moreBlock)(void);

@interface TopToolView : UIView


@property (nonatomic, copy) leftBlock leftBlock;

@property (nonatomic, copy) rightBlock rightBlock;

@property (nonatomic, copy) cancleBlock cancleBlock;

@property (nonatomic, copy) moreBlock moreBlock;

@end
