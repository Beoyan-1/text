//
//  ColorCollectionViewCell.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/18.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@interface ColorCollectionViewCell()

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UIView * colorView;


@end

@implementation ColorCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.backView];
        
        [self.contentView addSubview:self.colorView];
        
    }
    return self;
}


#pragma mark - layoutSubviews
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.contentView);
        
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
    }];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
        
        make.size.mas_equalTo(CGSizeMake(adaptWidth(16), adaptWidth(16)));
        
    }];
    
}

#pragma mark - get/set

- (void)setColorModel:(BottomColorModel *)colorModel{
    _colorModel = colorModel;
    
    self.colorView.backgroundColor = colorModel.color;
    
    if (colorModel.isSelect) {
        
        self.backView.hidden = NO;
        
    }else{
        
        self.backView.hidden = YES;
    }
}


- (UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.borderColor = [UIColor whiteColor].CGColor;
        _backView.layer.borderWidth = 1.5;
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIView *)colorView{
    
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.layer.cornerRadius = 2;
        _colorView.layer.masksToBounds = YES;
    }
    
    return _colorView;
}


@end
