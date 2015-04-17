//
//  GViewController.m
//  GCountableUILabel
//
//  Created by Daniel KIM on 04/17/2015.
//  Copyright (c) 2014 Daniel KIM. All rights reserved.
//

#import "GViewController.h"

@interface GViewController ()

@property (nonatomic, assign) NSUInteger count;

@end

@implementation GViewController

- (void)viewDidLoad
{
    // super
    [super viewDidLoad];
    
    // set default count
    self.count = 1234;
    
    // configure label
    [self.label setTextColor:[UIColor orangeColor]];
    
    // perform update count
    [self performSelector:@selector(performUpdateCount) withObject:nil afterDelay:1.0f];
}

- (void)performUpdateCount
{
    // increase count
    self.count += (arc4random() % 50) + 1;
    
    // set text
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_label setText:[formatter stringFromNumber:[NSNumber numberWithInteger:_count]]];
    
    // perform
    [self performSelector:@selector(performUpdateCount) withObject:nil afterDelay:1.0f];
}

#pragma mark - IBActions

- (IBAction)animationTypeChange:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {
        [_label setAnimationType:GCountableUILabelAnimationTypePushUp];
    }
    else if (control.selectedSegmentIndex == 1) {
        [_label setAnimationType:GCountableUILabelAnimationTypePushDown];
    }
    else if (control.selectedSegmentIndex == 2) {
        [_label setAnimationType:GCountableUILabelAnimationTypeFade];
    }
    else if (control.selectedSegmentIndex == 3) {
        [_label setAnimationType:GCountableUILabelAnimationTypeNone];
    }
}

- (IBAction)textAlignChange:(id)sender
{
    // TODO : Support it changable on the go
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 0) {
        [_label setTextAlignment:NSTextAlignmentLeft];
    }
    else if (control.selectedSegmentIndex == 1) {
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    else if (control.selectedSegmentIndex == 2) {
        [_label setTextAlignment:NSTextAlignmentRight];
    }
}

@end
