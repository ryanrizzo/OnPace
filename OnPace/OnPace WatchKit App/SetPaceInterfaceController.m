//
//  SetPaceInterfaceController.m
//  OnPace
//
//  Created by Ryan Rizzo on 8/17/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "SetPaceInterfaceController.h"

@interface SetPaceInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *sliderValueLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSlider *slider;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startButton;

@property (strong, nonatomic) NSNumber *sliderValue;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *milePaceLabel;

@property (strong, nonatomic) NSDictionary *milePaceDict;
//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *bpmPicker;

@end

@implementation SetPaceInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    [self.sliderValueLabel setText:@"Set Your Pace"];
    
    [self.milePaceLabel setText:@""];
    
//    WKPickerItem *minimum;
//    WKPickerItem *middle;
//    WKPickerItem *maximum;
//    minimum.title = @"60";
//    middle.title = @"180";
//    maximum.title = @"300";
//    
//    NSArray *bpmArray = [NSArray arrayWithObjects:minimum, middle, maximum, nil];
//    
//    [self.bpmPicker setItems:bpmArray];
    
    
}

- (IBAction)sliderChangedValue:(float)bpm {
    
    self.sliderValue = [NSNumber numberWithFloat:roundf(bpm)];
    
    NSString *text = [NSString stringWithFormat:@"%@ BPM", self.sliderValue];
    
    NSString *paceText = [NSString stringWithFormat:@"%@ Mile Pace", self.sliderValue];
    
    [self.sliderValueLabel setText:text];
    [self.milePaceLabel setText:paceText];
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    if ([segueIdentifier isEqualToString:@"StartTimer"]) {
        return @[self.sliderValue];
    }
    return nil;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}





@end



