//
//  MERecentMedia.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MERecentMedia.h"

@implementation MERecentMedia

- (NSArray<InstagramMedia *> *)media
{
    if (!_media)
    {
        _media = @[];
    }
    return _media;
}

@end
