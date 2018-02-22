//
//  MEHelperFunctions.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/31/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEHelperFunctions.h"

CGRect me_ceilRect(CGRect rect)
{
    rect.size.width = ceilf(CGRectGetWidth(rect));
    rect.size.height = ceilf(CGRectGetHeight(rect));
    return rect;
}