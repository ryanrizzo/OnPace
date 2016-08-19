//
//  TimerInterfaceController.m
//  OnPace
//
//  Created by Ryan Rizzo on 8/17/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "TimerInterfaceController.h"

@interface TimerInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *BPMLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startButton;
@property (assign, nonatomic) int *count;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *registerPaceButton;

@property (strong, nonatomic) NSDate *time;

@end

@implementation TimerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    NSString *labelString = [NSString stringWithFormat:@"%@ BPM",((NSArray*)context).firstObject];
    
    
    
    [self.BPMLabel setText:labelString];

    // Configure interface objects here.
}

-(IBAction)startButtonPressed:(float)bpm {
    
    int currentCount = (int) self.count;
    NSLog(@"%d",currentCount);
    if(currentCount == 0){
        [self.timer start];
        
        [self.startButton setTitle:@"Stop"];
        self.count++;
    }else{
        [self.timer stop];
        [self.startButton setTitle:@"Start"];
        self.count--;
    }
}

-(IBAction)registerMilePacePressed:(float)bpm {
    
    int currentCount = (int) self.count;
    NSLog(@"%d",currentCount);
    if(currentCount == 0){
        
        [self.timer start];
        [self.startButton setTitle:@"Stop"];
        self.count++;
    }else{
        [self.timer stop];
        [self.startButton setTitle:@"Start"];
        self.count--;
    }
}

//- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
//    if ([segueIdentifier isEqualToString:@"StartTimer"]) {
//        return @[self.sliderValue];
//    }
//    return nil;
//}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



