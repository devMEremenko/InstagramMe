//
//  LMHelperFunction.m
//  LightMe
//
//  Created by Maxim Eremenko on 2/16/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "LMHelperFunction.h"

void LMDispatchAfter(CGFloat time, CodeBlock block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void LMDispatchToMainQueue(CodeBlock block)
{
    if ([NSThread isMainThread])
    {
        if (block) { block(); };
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block();
        });
    }
}

void LMDispatchToBackgroundQueue(CodeBlock block)
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^
    {
        if (block) block();
    });
}

#pragma mark -

