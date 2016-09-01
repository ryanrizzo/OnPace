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
    NSLog(@"awakeWithContext");
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    self.milePaceDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"milePaceDict"] mutableCopy];
    if (!self.milePaceDict) {
        self.milePaceDict = [@{} mutableCopy];
    }
    
    if(context){
        
        NSNumber *registeredMilePace = ((NSArray*)context).firstObject;
        
        double milePace = registeredMilePace.doubleValue *-1;
        
        NSString *milePaceString = [self stringFromTimeInterval:milePace];
        
        
        NSNumber *bpm = ((NSArray*)context)[1];
        
        
        [self.milePaceDict setValue:milePaceString forKey:bpm.stringValue];
        
    }
    
    // Configure interface objects here.
    if(!context){
    [self.sliderValueLabel setText:@"Set Your Pace"];
    
    [self.milePaceLabel setText:@"Steps Per Minute"];
    }else{
        NSNumber *stepsPM = ((NSArray*)context)[1];
        [self.slider setValue:stepsPM.floatValue];
        [self sliderChangedValue:stepsPM.floatValue];
    }
    
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

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

- (IBAction)sliderChangedValue:(float)bpm {
    
    self.sliderValue = [NSNumber numberWithFloat:roundf(bpm)];
    
    NSString *text = [NSString stringWithFormat:@"%@ Steps Per Minute", self.sliderValue];
    
    NSString *paceText;
    
    if(![self.milePaceDict objectForKey:self.sliderValue.stringValue]){
    paceText = [NSString stringWithFormat:@"No time registered yet"];
    }else{
        paceText = [NSString stringWithFormat:@"%@ Mile Pace", [self.milePaceDict objectForKey:self.sliderValue.stringValue]];
        
    }
    
    
    [self.sliderValueLabel setText:text];
    [self.milePaceLabel setText:paceText];
}



- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    if ([segueIdentifier isEqualToString:@"StartTimer"]) {
        if(self.sliderValue){
        return @[self.sliderValue];
        }else{
            self.sliderValue = [NSNumber numberWithFloat:roundf(160)];
            return@[self.sliderValue];
        }
    }
    return nil;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"activating");
    self.milePaceDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"milePaceDict"] mutableCopy];
    if (!self.milePaceDict) {
        self.milePaceDict = [@{} mutableCopy];
    }
    
    if (self.sliderValue.floatValue == 0.0f) {
        self.sliderValue = @160;
    }
    [self sliderChangedValue:self.sliderValue.floatValue];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
//    [[NSUserDefaults standardUserDefaults] setObject:self.milePaceDict forKey:@"milePaceDict"];
}





@end



