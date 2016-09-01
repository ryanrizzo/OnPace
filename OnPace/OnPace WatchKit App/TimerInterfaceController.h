//
//  TimerInterfaceController.h
//  OnPace
//
//  Created by Ryan Rizzo on 8/17/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface TimerInterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *BPMLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTimer *timer;
@property (unsafe_unretained, nonatomic) IBOutlet NSTimer *t;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *startButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *registerPaceButton;
- (IBAction)registerPace;

@end
