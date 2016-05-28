//
//  MELabel.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

typedef NS_ENUM(NSUInteger, MEContentAlignment) {
    ContentAlignmentNone,
    ContentAlignmentCenter,
    ContentAlignmentTop,
    ContentAlignmentBottom,
    ContentAlignmentLeft,
    ContentAlignmentRight,
    ContentAlignmentTopLeft,
    ContentAlignmentTopRight,
    ContentAlignmentBottomLeft,
    ContentAlignmentBottomRight
};

@interface MELabel : UIView

@property (assign, nonatomic) MEContentAlignment contentAlignment;

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSAttributedString* attributedText;
@property (assign, nonatomic) NSInteger numberOfLines;
@property (assign, nonatomic) CGFloat padding;
@property (strong, nonatomic) UIFont* font;
@property (strong, nonatomic) UIColor* textColor;
@property (assign, nonatomic) NSLineBreakMode lineBreakMode;
@property (strong, nonatomic) NSParagraphStyle* paragraphStyle;
@property (strong, nonatomic) NSShadow* shadow;
@end
