//
//  MEAdditionallyButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAdditionallyButton.h"

@implementation MEAdditionallyButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setImage:[UIImage me_additionallyImage] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
