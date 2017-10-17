//
//  TBYImageViewController.m
//  自定义图片浏览器
//
//  Created by 佟博研 on 2017/10/12.
//  Copyright © 2017年 tby. All rights reserved.
//

#import "TBYImageViewController.h"
#import "TBYimageCollectionViewCell.h"
#import "TBYImageViewModel.h"
#import "TopToolView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface TBYImageViewController ()

@property (nonatomic, strong) UICollectionView * imageCollectionView;

@property (nonatomic, strong) TBYImageViewModel * viewModel;

@property (nonatomic, strong) TopToolView * topToolView;

@property (nonatomic, assign) BOOL isShowTool;

@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation TBYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentRow = 0;
    self.isShowTool = YES;
    [self initView];
    [self getData];
    
    [self preferredStatusBarStyle];
}

- (void)initView{
    
    self.view.backgroundColor = textblackColor;
    
    [self.view addSubview:self.imageCollectionView];
    
    [self.view addSubview:self.topToolView];
    
    [self.viewModel handelCollection:self.imageCollectionView];
    
}

- (void)getData{
    
    WS(weakSelf)
    [self.viewModel initDataWithArr:self.imageArr complete:^{
        
        [weakSelf.imageCollectionView reloadData];
    }];
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.topToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(adaptWidth(62));
        
    }];
    
        
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.right.top.bottom.equalTo(self.view);
            
    }];
}



#pragma mark - get/set

- (UICollectionView *)imageCollectionView{
    
    if (!_imageCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight);
      
        
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _imageCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _imageCollectionView.pagingEnabled = YES;
      
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        _imageCollectionView.scrollEnabled = NO;
    }
    
    return _imageCollectionView;
}

- (NSArray *)imageArr{
    
    if (!_imageArr) {
        
        _imageArr = @[@"MWPhotoBrowser1",@"MWPhotoBrowser2",@"MWPhotoBrowser3",@"1233",@"1234",@"1235",@"qwer"];
    }
    return _imageArr;
}

- (TBYImageViewModel *)viewModel{
    
    if (!_viewModel) {
        
        _viewModel = [[TBYImageViewModel alloc] init];
        WS(weakSelf)
        _viewModel.tapBlock = ^{
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!weakSelf.topToolView.hidden) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        [weakSelf.topToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                             make.left.right.top.equalTo(weakSelf.view);
                            make.height.mas_equalTo(0);
                            
                        }];
                        weakSelf.topToolView.alpha = 0;
                        [weakSelf.topToolView.superview layoutSubviews];
                    } completion:^(BOOL finished) {
                        
                        weakSelf.topToolView.hidden = YES;
                    }];

                }else{
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        [weakSelf.topToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.top.equalTo(weakSelf.view);
                            make.height.mas_equalTo(adaptWidth(62));
                            
                        }];
                        weakSelf.topToolView.alpha = 0.8;
                        [weakSelf.topToolView.superview layoutSubviews];
                        
                    } completion:^(BOOL finished) {
                        
                        weakSelf.topToolView.hidden = NO;
                    }];
  
                }
                
            });
            
        };
    }
    
    return _viewModel;
}

- (TopToolView *)topToolView{
    
    if (!_topToolView) {
        _topToolView = [[TopToolView alloc] init];
        _topToolView.backgroundColor = textblackColor;
        _topToolView.alpha = 0.8;
        WS(weakSelf)
        _topToolView.rightBlock = ^{
            
            weakSelf.currentRow++;
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:weakSelf.currentRow inSection:0];
            
            [weakSelf.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        };
        
        _topToolView.leftBlock = ^{
            
            weakSelf.currentRow--;
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:weakSelf.currentRow inSection:0];
            
            [weakSelf.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
        };
        
    }
    return _topToolView;
}

@end
