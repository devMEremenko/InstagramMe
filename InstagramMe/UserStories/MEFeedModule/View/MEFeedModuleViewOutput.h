//
//  MEFeedModuleViewOutput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MEFeedModuleViewOutput <NSObject>

/**
 @author devMEremenko

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;

@end