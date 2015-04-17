//
//  GCountableUILabel.m
//  GCountableUILabel
//
//  Created by Daniel KIM on 27/03/2015.
//  Copyright (c) 2015 GwangpaDotCom. All rights reserved.
//

#import "GCountableUILabel.h"

@interface GCountableUILabel ()

@property (nonatomic, strong) UIColor *originalTextColor;
@property (nonatomic, strong) NSMutableDictionary *map;

@end

@implementation GCountableUILabel

#pragma mark - Initialise

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialise];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialise];
    }
    return self;
}

- (void)initialise
{
    self.originalTextColor = self.textColor;
    self.map = [NSMutableDictionary dictionary];
    self.clipsToBounds = YES;
    self.animationType = GCountableUILabelAnimationTypePushUp;
}

#pragma mark - OverrideExistsMethods

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:[UIColor clearColor]];
    self.originalTextColor = textColor;
}

- (void)setText:(NSString *)text
{
    // super
    [super setText:text];
    
    // start point x
    CGFloat startX = 0.0f;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    if (self.textAlignment == NSTextAlignmentCenter) {
        startX = CGRectGetWidth(self.bounds) / 2.0f - size.width / 2.0f;
    } else if (self.textAlignment == NSTextAlignmentRight) {
        startX = CGRectGetWidth(self.bounds) - size.width;
    }

    // check changes
    for (NSUInteger i = 0; i < text.length; i++) {
        // key
        NSNumber *key = [NSNumber numberWithInteger:i];
        
        // define change to string
        NSString *toString = [text substringWithRange:NSMakeRange(i, 1)];
        
        // previous string
        UILabel *currentLabel = [_map objectForKey:key];
        NSString *fromString = currentLabel.text;
        
        if ([toString isEqualToString:fromString] == NO) {
            // define size of string
            CGSize size = [toString sizeWithAttributes:@{NSFontAttributeName:self.font}];
            
            // alpha for animation
            CGFloat alpha = 1.0f;
            
            // frame for newLabel
            CGRect frame = CGRectZero;
            frame.size.width = size.width;
            frame.size.height = CGRectGetHeight(self.bounds);
            frame.origin.y = 0.0f;
            frame.origin.x = startX;
            
            // define origin.x
            if (i > 0) {
                UILabel *prevLabel = [_map objectForKey:[NSNumber numberWithInteger:i - 1]];
                frame.origin.x = CGRectGetMaxX(prevLabel.frame);
            }
            
            // define origin.y for animation type
            switch (_animationType) {
                case GCountableUILabelAnimationTypePushUp:
                    frame.origin.y = CGRectGetHeight(self.bounds);
                    break;
                    
                case GCountableUILabelAnimationTypePushDown:
                    frame.origin.y = -CGRectGetHeight(self.bounds);
                    break;
                    
                case GCountableUILabelAnimationTypeFade:
                    frame.origin.y = 0.0f;
                    alpha = 0.0f;
                    break;

                case GCountableUILabelAnimationTypeNone:
                    frame.origin.y = 0.0f;
                    break;
            }
            
            // create label
            UILabel *newLabel = [[UILabel alloc] init];
            [newLabel setTextColor:_originalTextColor];
            [newLabel setFont:self.font];
            [newLabel setBackgroundColor:[UIColor clearColor]];
            [newLabel setText:toString];
            [newLabel setFrame:frame];
            [newLabel setAlpha:alpha];
            [self addSubview:newLabel];
            
            // animation value
            double delay = 0.0f;
            double duration = 0.0f;
            if (_animationType == GCountableUILabelAnimationTypeFade) {
                duration = 0.25f;
            } else if (_animationType != GCountableUILabelAnimationTypeNone) {
                delay = (arc4random() % 11) / 100.0f;
                duration = 0.25f + ((arc4random() % 6) / 100.0f) * (arc4random() % 2 ? 1 : -1);
            }
            
            // animation
            [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect frame = newLabel.frame;
                frame.origin.y = 0.0f;
                switch (_animationType) {
                    case GCountableUILabelAnimationTypePushUp:
                        [newLabel setFrame:frame];
                        frame = currentLabel.frame;
                        frame.origin.y -= CGRectGetHeight(currentLabel.bounds);
                        [currentLabel setFrame:frame];
                        break;
                        
                    case GCountableUILabelAnimationTypePushDown:
                        [newLabel setFrame:frame];
                        frame = currentLabel.frame;
                        frame.origin.y = CGRectGetHeight(currentLabel.bounds);
                        [currentLabel setFrame:frame];
                        break;
                        
                    case GCountableUILabelAnimationTypeFade:
                        [newLabel setAlpha:1.0f];
                        [currentLabel setAlpha:0.0f];
                        break;

                    default:
                        break;
                }
            } completion:^(BOOL finished) {
                [currentLabel removeFromSuperview];
            }];
            
            // add to map
            [_map setObject:newLabel forKeyedSubscript:key];
        }
    }
}

@end
