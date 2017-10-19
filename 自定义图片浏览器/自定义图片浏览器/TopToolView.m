//
//  TopToolView.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/17.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TopToolView.h"

@interface TopToolView()


/**
 退出按钮
 */
@property (nonatomic, strong) UIButton * cancleBtn;

/**
 左侧按钮
 */
@property (nonatomic, strong) UIButton * leftBtn;

/**
 右侧按钮
 */
@property (nonatomic, strong) UIButton * rightBtn;

/**
 更多按钮
 */
@property (nonatomic, strong) UIButton * moreBtn;

/**
 页码label
 */
@property (nonatomic, strong) UILabel * pageLabel;

@end

@implementation TopToolView

- (instancetype)init{
    
    
    if (self = [super init]) {
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.cancleBtn];
        [self addSubview:self.moreBtn];
        
    }
    
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).with.offset(12);
        make.centerY.equalTo(self.mas_centerY).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(adaptWidth(122));
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
        make.centerY.equalTo(self.mas_centerY).with.offset(10);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).with.offset(- adaptWidth(122));
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
        make.centerY.equalTo(self.mas_centerY).with.offset(10);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-12);
        make.size.mas_equalTo(CGSizeMake(adaptWidth(24), adaptWidth(24)));
        make.centerY.equalTo(self.mas_centerY).with.offset(10);
    }];
    
}


#pragma mark - Clicks

- (void)cancleClick{
    
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    
}

- (void)leftClick{
    
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightClick{
    
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)moreClick{
    
    if (self.moreBlock) {
        self.moreBlock();
    }
    
}

#pragma mark - get/set

- (UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setImage:[UIImage imageNamed:@"Cooperation_Quit_btn"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)leftBtn{
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setImage:[UIImage imageNamed:@"Cooperation_DownP_btn"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setImage:[UIImage imageNamed:@"Cooperation_UpP_btn"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIButton *)moreBtn{
    
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"Cooperation_Scale_btn"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (UILabel *)pageLabel{
    
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.font = [UIFont boldSystemFontOfSize:16];
        _pageLabel.textColor = [UIColor whiteColor];
    }
    return _pageLabel;
}

@end
