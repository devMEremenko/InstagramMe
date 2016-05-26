//
//  MEMediaResponse.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import <ANBaseDomainModel/ANBaseDomainModel.h>
@class InstagramMedia;

@interface MEMediaResponse : NSObject

@property (strong, nonatomic) NSArray<InstagramMedia*>* recentMedia;

@end
