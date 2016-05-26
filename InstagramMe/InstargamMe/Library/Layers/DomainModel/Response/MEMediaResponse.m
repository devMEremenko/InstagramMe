//
//  MEMediaResponse.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEMediaResponse.h"

@implementation MEMediaResponse

- (NSArray<InstagramMedia *> *)recentMedia
{
    if (!_recentMedia)
    {
        _recentMedia = @[];
    }
    return _recentMedia;
}

@end
