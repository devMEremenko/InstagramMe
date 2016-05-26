//
//  MECommentsContentView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MECommentsContentView.h"
#import "InstagramKit.h"
#import "NSString+MEStringSize.h"

CGFloat const kMECommentContentViewOffset = 12.f;
CGFloat const kMEViewAllCommentsHeight = 22.f;
CGFloat const kMEMaxCommentHeight = 80.f;
CGFloat const kMaxCommentHeight = 90.f;

NSInteger const kMEMaxCommentLenght = 150;
NSInteger const kMEMaxViewingComment = 2;

@interface MECommentsContentView ()
@property (weak, nonatomic) InstagramMedia* media;
@end

@implementation MECommentsContentView

+ (CGFloat)heightWithMedia:(InstagramMedia *)media inSize:(CGSize)inSize
{
    NSArray* comments = [self viewingCommentsFromArray:media.mComments];
    CGFloat result = [self commentsHeight:comments inSize:inSize];
    result += [self heightViewAllButton];
    return result + kMECommentContentViewOffset;
}

+ (CGFloat)heightViewAllButton
{
    return kMECommentContentViewOffset * 2.f + kMEViewAllCommentsHeight;
}

+ (CGFloat)commentsHeight:(NSArray *)comments inSize:(CGSize)inSize
{
    CGFloat result = 0.f;
    CGFloat width = inSize.width - 2 * kMECommentContentViewOffset;
    CGSize surfaceSize = CGSizeMake(width, CGFLOAT_MAX);
    
    for (NSString* message in comments)
    {
        CGRect rect = [message me_commentsBoundingWithSize:surfaceSize];
        result += rect.size.height < kMaxCommentHeight ? : kMaxCommentHeight;
    }
    return result + [self offsetBetweenComments:comments];
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

- (void)updateConstraints
{
    BOOL showViewAllButton = [self isShowViewAllButton];
    
    [self.viewAllCommentsButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(!showViewAllButton ? @0 : @(kMEViewAllCommentsHeight));
    }];
    
    [self.firstCommentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.viewAllCommentsButton.mas_bottom).with.offset(kMECommentContentViewOffset);
        make.left.equalTo(self.mas_left).with.offset(kMECommentContentViewOffset);
        make.right.equalTo(self.mas_right).with.offset(-kMECommentContentViewOffset);
        
        CGFloat heigt = [self heightCommentAtIndex:0];
        make.height.equalTo(@(heigt));
    }];
    
    [self.secondCommentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        CGFloat height = [self heightCommentAtIndex:1];
        make.height.equalTo(@(height));
    }];
    
    [super updateConstraints];
}

- (CGFloat)heightCommentAtIndex:(NSInteger)index
{
    CGFloat result = 0.f;
    CGSize inSize = self.bounds.size;
    NSArray* comments = self.media.mComments;

    if (comments.count >= index + 1)
    {
        result = [[self class] commentsHeight:@[comments[index]] inSize:inSize];
    }
    return result;
}

#pragma mark -

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.media = media;

    NSInteger commentsCount = media.mComments.count;
    if (commentsCount >= 1)
    {
        self.firstCommentLabel.text = media.mComments[0];
        if (commentsCount >= 2)
        {
            self.secondCommentLabel.text = media.mComments[1];
        }
    }
    [self updateConstraints];
}

#pragma mark - Helpers

+ (CGFloat)offsetBetweenComments:(NSArray *)comments
{
    if (comments.count == 0)
    {
        return 0.f;
    }
    return (1 + comments.count) * kMECommentContentViewOffset;
}

#pragma mark -

- (BOOL)isShowViewAllButton
{
    return [[self class] isShowViewAllButtonForMedia:self.media];
}

+ (BOOL)isShowViewAllButtonForMedia:(InstagramMedia *)media
{
    return media.commentCount < kMEMaxViewingComment;
}

#pragma mark - Lazy Load

- (MEViewAllButton *)viewAllCommentsButton
{
    if (!_viewAllCommentsButton)
    {
        _viewAllCommentsButton = [MEViewAllButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_viewAllCommentsButton];

        [_viewAllCommentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(kMECommentContentViewOffset);
            make.left.equalTo(self.mas_left).with.offset(kMECommentContentViewOffset);
            make.right.equalTo(self.mas_right).with.offset(-kMECommentContentViewOffset);
        }];
    }
    return _viewAllCommentsButton;
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
            make.top.equalTo(self.firstCommentLabel.mas_bottom);
            make.left.equalTo(self.mas_left).with.offset(kMECommentContentViewOffset);
            make.right.equalTo(self.mas_right).with.offset(-kMECommentContentViewOffset);
        }];
    }
    return _secondCommentLabel;
}

@end
