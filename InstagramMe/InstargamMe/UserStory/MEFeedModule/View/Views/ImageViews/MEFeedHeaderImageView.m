//
//  MEFeedHeaderImageView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedHeaderImageView.h"

@implementation MEFeedHeaderImageView

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self setProfileImageWithURL:media.user.profilePictureURL];
}

- (void)setProfileImageWithURL:(NSURL *)url
{
    [self yy_setImageWithURL:url
     placeholder:nil
     options:0
     completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
         
         UIImage* roundedImage = [image yy_imageByRoundCornerRadius:image.size.height
                                                        borderWidth:0.5
                                                        borderColor:[UIColor me_feedImageCornerColor]];
         self.image = roundedImage;
    }];
}

@end
