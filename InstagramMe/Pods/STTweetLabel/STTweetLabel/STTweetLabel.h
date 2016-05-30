//
//  STTweetLabel.h
//  STTweetLabel
//
//  Created by Sebastien Thiebaud on 09/29/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

typedef NS_ENUM(NSInteger, STTweetHotWord) {
    STTweetHandle = 0,
    STTweetHashtag,
    STTweetLink
};

typedef void (^MEDetectionBlock)(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range);

@interface STTweetLabel : UILabel

@property (nonatomic, strong) NSArray *validProtocols;
@property (nonatomic, assign) BOOL leftToRight;
@property (nonatomic, assign) BOOL textSelectable;
@property (nonatomic, strong) UIColor *selectionColor;
@property (nonatomic, copy) MEDetectionBlock detectionBlock;

- (void)setAttributes:(NSDictionary *)attributes;
- (void)setAttributes:(NSDictionary *)attributes hotWord:(STTweetHotWord)hotWord;

- (NSDictionary *)attributes;
- (NSDictionary *)attributesForHotWord:(STTweetHotWord)hotWord;

- (CGSize)suggestedFrameSizeToFitEntireStringConstrainedToWidth:(CGFloat)width;

@end
