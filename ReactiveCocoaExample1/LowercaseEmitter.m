//
//  LowercaseEmitter.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "LowercaseEmitter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LowercaseEmitter ()
@property(assign)  char        currentChar;
@property(strong)  NSTimer     *timer;
@property(strong)  RACSubject  *outputSignal;
@end

@implementation LowercaseEmitter

+ (RACSignal*)lowercaseEmitter {
    return ((LowercaseEmitter*)[[self alloc] init]).outputSignal;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentChar = 'a';
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.10
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
        self.outputSignal = [RACSubject subject];
    }
    return self;
}

- (void)timerFired:(NSTimer*)timer {
    [self.outputSignal sendNext:[NSNumber numberWithChar:self.currentChar]];
    
    if (self.currentChar == 'z') {
        [self.outputSignal sendCompleted];
        [self.timer invalidate];
    } else {
        self.currentChar++;
    }
}

@end
