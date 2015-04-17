//
//  GCountableUILabel.h
//  GCountableUILabel
//
//  Created by Daniel KIM on 27/03/2015.
//  Copyright (c) 2015 GwangpaDotCom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GCountableUILabelAnimationTypeNone      = 0,
    GCountableUILabelAnimationTypePushUp    = 1,
    GCountableUILabelAnimationTypePushDown  = 2,
    GCountableUILabelAnimationTypeFade      = 3,
} GCountableUILabelAnimationType;

@interface GCountableUILabel : UILabel

// animation type. Default value : GCountableUILabelAnimationTypePushDown
@property (nonatomic, assign) GCountableUILabelAnimationType animationType;

@end
