//
//  GViewController.h
//  GCountableUILabel
//
//  Created by Daniel KIM on 04/17/2015.
//  Copyright (c) 2014 Daniel KIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GCountableUILabel/GCountableUILabel.h>

@interface GViewController : UIViewController

@property (nonatomic, strong) IBOutlet GCountableUILabel *label;

- (IBAction)animationTypeChange:(id)sender;
- (IBAction)textAlignChange:(id)sender;

@end
