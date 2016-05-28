//
//  MEStringBuilder.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/27/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEStringBuilder.h"
#import "NSString+MEString.h"

NSString* const kMEHashTagPattern = @"\\B#\\w+";
NSString* const kMEMentionPattern = @"\\B@\\w+";

@implementation MEStringBuilder

+ (NSAttributedString *)buildCommentsString:(NSString *)source
{
    NSMutableAttributedString* attrSource = [[NSMutableAttributedString alloc]
                                             initWithString:source
                                             attributes:[NSString me_feedCommentsAttributes]];
    [self highlightHashTagsInString:attrSource];
    [self highlightMentionsInString:attrSource];
    
    return attrSource;
}

#pragma mark - Adding Attributes

+ (void)highlightHashTagsInString:(NSMutableAttributedString *)source
{
    NSRegularExpression* expression = [self hashTagsExpression];
    NSDictionary* attr = [NSString me_hashTagsAttributes];
    [self addAttributes:attr toString:source withExpression:expression];
}

+ (void)highlightMentionsInString:(NSMutableAttributedString *)source
{
    NSRegularExpression* expression = [self mentionsExpression];
    NSDictionary* attr = [NSString me_userLinksAttributes];
    [self addAttributes:attr toString:source withExpression:expression];
}

+ (void)addAttributes:(NSDictionary *)attributes
             toString:(NSMutableAttributedString *)source
       withExpression:(NSRegularExpression *)expression
{
    NSRange searchRange = NSMakeRange(0, source.string.length);

    [expression
     enumerateMatchesInString:source.string
     options:0
     range:searchRange
     usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop)
     {
         [source addAttributes:[NSString me_hashTagsAttributes] range:match.range];
     }];
}

#pragma mark - Regular Expession

+ (NSRegularExpression *)hashTagsExpression
{
    return [NSRegularExpression regularExpressionWithPattern:kMEHashTagPattern options:0 error:nil];
}

+ (NSRegularExpression *)mentionsExpression
{
    return [NSRegularExpression regularExpressionWithPattern:kMEMentionPattern options:0 error:nil];
}

@end
