//
//  MERecentMedia.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import <ANBaseDomainModel/ANBaseDomainModel.h>
#import "InstagramKit.h"

@interface MERecentMedia : ANBaseDomainModel

@property (strong, nonatomic) NSArray<InstagramMedia*>* media;

@end
