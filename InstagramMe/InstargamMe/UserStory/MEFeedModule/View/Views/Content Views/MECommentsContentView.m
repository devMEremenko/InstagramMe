//
//  MECommentsContentView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MECommentsContentView.h"
#import "MEInstagramKit.h"
#import "NSString+MEString.h"
#import "STTweetLabel.h"

typedef NS_ENUM(NSUInteger, MECommentIndex) {
    MECommentIndexFirst,
    MECommentIndexSecond
};

@interface MECommentsContentView ()

@property (weak, nonatomic) InstagramMedia* media;

@end

CGFloat const kMECommentViewDefaultOffset = 16.f;
CGFloat const kMECommentViewButtonTopOffset = 10.f;
CGFloat const kMECommentViewButtonBottomOffset = 10.f;

CGFloat const kMEAllButtonHeight = 22.f;
CGFloat const kMEMaxCommentHeight = 76.f;

NSInteger const kMEMaxCommentLenght = 150;
NSInteger const kMEMaxViewingComment = 2;

@implementation MECommentsContentView


+ (CGFloat)heightWithMedia:(InstagramMedia *)media inSize:(CGSize)inSize
{
    NSArray* comments = [self viewingCommentsFromArray:media.comments];
    CGFloat result = [self commentsHeight:comments inSize:inSize];
    
    if ([self isShowViewAllButtonForMedia:media])
    {
        result += [self heightAllCommentsButtonForMedia:media];
    }
    else
    {
        result += kMECommentViewDefaultOffset; // top offset insted button
    }
    return result + kMECommentViewDefaultOffset; // + bottom offset
}

+ (CGFloat)heightAllCommentsButtonForMedia:(InstagramMedia *)media
{
    return kMEAllButtonHeight + kMECommentViewButtonTopOffset + kMECommentViewButtonBottomOffset;
}

+ (CGFloat)commentsHeight:(NSArray *)commentsArr inSize:(CGSize)inSize
{
    CGFloat result = 0.f;
    CGSize surfaceSize = [self commentsSizeWithViewSize:inSize];
    
    for (InstagramComment* comment in commentsArr)
    {
        CGFloat height = [comment.text me_commentsBoundingWithSize:surfaceSize].size.height;
        
        if (comment.isExtended)
        {
            result += height;
        }
        else
        {
            result += height < kMEMaxCommentHeight ? height : kMEMaxCommentHeight;
        }
    }
    return ceilf(result + [self offsetBetweenComments:commentsArr]);
}

+ (NSArray *)viewingCommentsFromArray:(NSArray *)comments
{
    if (comments.count > kMEMaxViewingComment)
    {
        NSRange commentsRange = NSMakeRange(0, kMEMaxViewingComment);
        comments = [comments subarrayWithRange:commentsRange];
    }
    return comments;
}

#pragma mark - Layouts & Constraints

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateConstraints];
}

- (void)updateConstraints
{
    BOOL isShowViewAllButton = [self isShowViewAllButton];
    
    [self.allCommentsButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (isShowViewAllButton)
        {
            make.height.equalTo(@(kMEAllButtonHeight));
            [self.allCommentsButton setTitle];
        }
        else
        {
            make.height.equalTo(@0);
            [self.allCommentsButton clearTitle];
        }
    }];
    
    [self.firstCommentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (isShowViewAllButton)
        {
            make.top.equalTo(self.allCommentsButton.mas_bottom).with.offset(kMECommentViewButtonTopOffset);
        }
        else
        {
            make.top.equalTo(self.mas_top).with.offset(kMECommentViewDefaultOffset);
        }
        make.left.equalTo(self.mas_left).with.offset(kMECommentViewDefaultOffset);
        make.right.equalTo(self.mas_right).with.offset(-kMECommentViewDefaultOffset);
        make.height.equalTo(@([self heightCommentAtIndex:MECommentIndexFirst]));
    }];
    
    [self.secondCommentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@([self heightCommentAtIndex:MECommentIndexSecond]));
    }];
    
    [super updateConstraints];
}

#pragma mark -

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.media = media;

    NSInteger commentsCount = media.comments.count;
    
    InstagramComment* comment1 = commentsCount >= 1 ? media.comments[MECommentIndexFirst] : nil;
    InstagramComment* comment2 = commentsCount >= 2 ? media.comments[MECommentIndexSecond] : nil;
    
    [self.firstCommentLabel setupWithComment:comment1];
    [self.secondCommentLabel setupWithComment:comment2];
        
    [self updateConstraints];
}

#pragma mark - Helpers

+ (CGFloat)offsetBetweenComments:(NSArray *)comments
{
    if (comments.count == 0)
    {
        return 0.f;
    }
    CGFloat offset = (comments.count - 1) * kMECommentViewDefaultOffset;
    return offset < 0 ? 0 : offset;
}

+ (CGSize)commentsSizeWithViewSize:(CGSize)viewSize
{
    CGFloat width = viewSize.width - 2 * kMECommentViewDefaultOffset;
    return CGSizeMake(width, CGFLOAT_MAX);
}

- (CGFloat)heightCommentAtIndex:(NSInteger)index
{
    CGFloat result = 0.f;
    CGSize inSize = self.bounds.size;
    NSArray* comments = self.media.comments;
    
    if (comments.count >= index + 1)
    {
        result = [[self class] commentsHeight:@[comments[index]] inSize:inSize];
    }
    return result;
}

#pragma mark -

- (BOOL)isShowViewAllButton
{
    return [[self class] isShowViewAllButtonForMedia:self.media];
}

+ (BOOL)isShowViewAllButtonForMedia:(InstagramMedia *)media
{
    return media.commentCount > kMEMaxViewingComment;
}

#pragma mark - Lazy Load

- (MEViewAllButton *)allCommentsButton
{
    if (!_allCommentsButton)
    {
        _allCommentsButton = [MEViewAllButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_allCommentsButton];
        
        [_allCommentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(kMECommentViewButtonTopOffset);
            make.left.equalTo(self.mas_left).with.offset(kMECommentViewDefaultOffset);
            make.right.equalTo(self.mas_right).with.offset(-kMECommentViewDefaultOffset);
        }];
    }
    return _allCommentsButton;
}

- (MECommentLabel *)firstCommentLabel
{
    if (!_firstCommentLabel)
    {
        _firstCommentLabel = [MECommentLabel new];
        [self addSubview:_firstCommentLabel];
    }
    return _firstCommentLabel;
}

- (MECommentLabel *)secondCommentLabel
{
    if (!_secondCommentLabel)
    {
        _secondCommentLabel = [MECommentLabel new];
        [self addSubview:_secondCommentLabel];
        
        [_secondCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstCommentLabel.mas_bottom).with.offset(kMECommentViewDefaultOffset);
            make.left.equalTo(self.mas_left).with.offset(kMECommentViewDefaultOffset);
            make.right.equalTo(self.mas_right).with.offset(-kMECommentViewDefaultOffset);
        }];
    }
    return _secondCommentLabel;
}

@end
