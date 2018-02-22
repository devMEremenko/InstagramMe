//
//  MELogoImageView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELogoView.h"

@interface MELogoView ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation MELogoView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self imageView];
    }
    return self;
}

- (CGSize)intrinsicContentSize
{
    return UILayoutFittingCompressedSize;
}


#pragma mark - Lazy Load

- (UIImageView*)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage me_logoImage];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@120);
            make.height.equalTo(@90);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return _imageView;
}

@end
