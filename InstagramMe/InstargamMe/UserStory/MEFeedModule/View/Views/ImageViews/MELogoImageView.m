//
//  MELogoImageView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELogoImageView.h"

@implementation MELogoImageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 40, 30);
        self.image = [UIImage me_logoImage];
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
