//
//  ShapeCollectionViewCell.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/19.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "ShapeCollectionViewCell.h"

@interface  ShapeCollectionViewCell()

@property (nonatomic, strong) UIImageView * iconImageView;

@end


@implementation ShapeCollectionViewCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
    }
    return self;
}

#pragma mark - layoutSubviews

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
    }];
    
}


#pragma mark - get/set

- (void)setShapeModel:(BottomShapeModel *)shapeModel{
    _shapeModel = shapeModel;
    
    if (shapeModel.isSelect) {
        
        self.iconImageView.image = [[UIImage imageNamed:shapeModel.iconNameStr] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        
        self.iconImageView.tintColor = [UIColor whiteColor];
        
    }else{
        
         self.iconImageView.image = [[UIImage imageNamed:shapeModel.iconNameStr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    }
    
    
}

- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
    }
    
    return _iconImageView;
}

@end
