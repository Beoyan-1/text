//
//  BottomToolCollectionViewCell.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "BottomToolCollectionViewCell.h"

@interface BottomToolCollectionViewCell()


/**
 图标
 */
@property (nonatomic, strong) UIImageView * iconImageView;

/**
 描述
 */
@property (nonatomic, strong) UILabel * descLabel;

/**
 显示颜色的圆
 */
@property (nonatomic, strong) UIView * cololrView;

/**
 背景view
 */
@property (nonatomic, strong) UIView * backView;

@end


@implementation BottomToolCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        [self.backView addSubview:self.iconImageView];
        [self.backView addSubview:self.cololrView];
        [self.backView addSubview:self.descLabel];
        [self.contentView addSubview:self.backView];
    }
    
    
    return self;
        
}




- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_top).with.offset(4);
    }];
     
     [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.backView.mas_centerX);
         make.top.equalTo(self.iconImageView.mas_bottom).with.offset(2);
    }];
    
    [self.cololrView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.backView.mas_top).with.offset(4);
        make.left.equalTo(self.iconImageView.mas_right).with.offset(-4);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    
}

- (void)setModel:(BottomToolModel *)model{
    
    _model = model;
    self.descLabel.text = model.descStr;
    
    if (model.isSelect) {
        
        self.cololrView.hidden = NO;
        
        self.cololrView.backgroundColor = model.selectColor;
        
        self.iconImageView.tintColor = [UIColor whiteColor];
        
        self.iconImageView.image = [[UIImage imageNamed:model.iconImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        
        self.descLabel.textColor = [UIColor whiteColor];
        
    }else{
        
        self.cololrView.hidden = YES;
        
        self.descLabel.textColor = canNotPressColor;
        
        self.iconImageView.tintColor = kUIColorFromRGB(0x5e5e5e);
        
        self.iconImageView.image = [[UIImage imageNamed:model.iconImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.descLabel.textColor = kUIColorFromRGB(0x5e5e5e);
    }
    
}


#pragma mark - get/set

- (UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}


- (UILabel *)descLabel{
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = APPFont9;
    }
    return _descLabel;
}

- (UIView *)cololrView{
    
    if (!_cololrView) {
        _cololrView = [[UIView alloc] init];
        _cololrView.layer.cornerRadius = 4.0;
        _cololrView.layer.masksToBounds = YES;
        _cololrView.layer.borderWidth = 1.5;
        _cololrView.layer.borderColor = [UIColor whiteColor].CGColor;
        _cololrView.hidden = YES;
    }
    return _cololrView;
}


- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    
    return _iconImageView;
}







@end
