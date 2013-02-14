//
//  CharacterSignalLogger.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "SignalLogger.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation SignalLogger

+ (instancetype)loggerWithSignal:(RACSignal*)signal label:(NSString*)label {
    return [[self alloc] initWithSignal:signal label:label];
}

- (id)initWithSignal:(RACSignal*)signal label:(NSString*)label {
    self = [super init];
    if (self) {
        [signal
         subscribeNext:^(id x) {
             NSLog(@"%@ next: %c", label, [x charValue]);
         }
         error:^(NSError *error) {
             NSLog(@"%@ error: %@", label, error);
         }
         completed:^{
             NSLog(@"%@ completed", label);
         }];
    }
    return self;
}

@end
