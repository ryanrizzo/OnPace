//
//  TimerInterfaceController.m
//  OnPace
//
//  Created by Ryan Rizzo on 8/17/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "TimerInterfaceController.h"

@interface TimerInterfaceController ()
@property (assign, nonatomic) int *count;

@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *lastStartTime;
@property (assign, nonatomic) NSTimeInterval totalIntervals;

@property (assign, nonatomic) NSNumber *bpm;

@property (assign, nonatomic) double buzzInterval;

@end

@implementation TimerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    NSString *labelString = [NSString stringWithFormat:@"%@ SPM",((NSArray*)context).firstObject];
    
    self.bpm = ((NSArray*)context).firstObject;
    
    double bps = self.bpm.doubleValue /60;
    
    self.buzzInterval = 1/ bps;
    
    NSLog(@"%f", self.buzzInterval);
    
    [self.BPMLabel setText:labelString];
    
    [self.registerPaceButton setEnabled:NO];

    // Configure interface objects here.
}

-(IBAction)startButtonPressed:(float)bpm {
    
    //for keeping track of whether we are paused or not
    int currentCount = (int) self.count;
    NSLog(@"%d",currentCount);
    
    
    //initial start
    if(currentCount == 0){
        
        [self.registerPaceButton setEnabled:NO];
        
        NSDate *now = [[NSDate alloc] init];
        
        //creates checkpoint start
        self.lastStartTime = now;
        self.totalIntervals = 0.0;
        
        self.startTime = now;
        
        [self.timer setDate:self.startTime];
        
        [self.timer start];
        
        if ([self.t isKindOfClass:[NSTimer class]]) {
            [self.t invalidate];
        }

        self.t = [NSTimer scheduledTimerWithTimeInterval:self.buzzInterval target:self selector:@selector(buzz) userInfo:nil repeats:YES];
        
        //change button text
        [self.startButton setTitle:@"Stop"];
        self.count= self.count+2;
        
        //resume
    }else if(currentCount ==4){
        
        [self.registerPaceButton setEnabled:NO];
        
        //register starting point for next interval
        NSDate *now = [[NSDate alloc] init];
        self.lastStartTime = now;
        
        NSDate *displayTime = [NSDate dateWithTimeInterval:self.totalIntervals sinceDate:now];
        
        //set timer to the elapsed time at the most recent pause
        [self.timer setDate:displayTime];
        
        [self.timer start];
        
        //change button text
        [self.startButton setTitle:@"Stop"];
        self.count++;
        
        if ([self.t isKindOfClass:[NSTimer class]]) {
            [self.t invalidate];
        }
        self.t = [NSTimer scheduledTimerWithTimeInterval:self.buzzInterval target:self selector:@selector(buzz) userInfo:nil repeats:YES];
        
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"buzz");
        });
        */
        
        //stop
    }else{
        
        [self.registerPaceButton setEnabled:YES];
        
        [self.timer stop];
        [self.t invalidate];
        
        
        NSTimeInterval newInterval = [self.lastStartTime timeIntervalSinceNow];
        
        //add new interval to total
        self.totalIntervals = self.totalIntervals + newInterval;
        
        //change button text
        [self.startButton setTitle:@"Start"];
        self.count--;
    }
}

- (void)buzz {
    NSLog(@"buzz");
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStart];
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    if ([segueIdentifier isEqualToString:@"RegisterPace"]) {
        NSNumber *mileTime = [NSNumber numberWithDouble:self.totalIntervals];
        return @[mileTime, self.bpm];
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
    if ([self.t isKindOfClass:[NSTimer class]]) {
        [self.t invalidate];
    }

}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

- (IBAction)registerPace {
    
    NSDictionary *mpd = [[[NSUserDefaults standardUserDefaults] objectForKey:@"milePaceDict"] mutableCopy];

    
    if(mpd){
        NSNumber *mileTime = [NSNumber numberWithDouble:self.totalIntervals];
        double milePace = mileTime.doubleValue *-1;
        NSString *milePaceString = [self stringFromTimeInterval:milePace];
        
        
        [mpd setValue:milePaceString forKey:self.bpm.stringValue];
        [[NSUserDefaults standardUserDefaults] setObject:mpd forKey:@"milePaceDict"];

    }
    
    [self popController];
}
@end



