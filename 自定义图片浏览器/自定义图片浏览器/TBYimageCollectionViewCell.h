//
//  TBYimageCollectionViewCell.h
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/12.
//  Copyright © 2017年 tby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchDraw)(void);

@interface TBYimageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage * iconImage;


@property (nonatomic, copy) touchDraw  touchBlock;
@end
