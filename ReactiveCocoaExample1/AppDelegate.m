//
//  AppDelegate.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "AppDelegate.h"
#import "LowercaseEmitter.h"
#import "CharacterSignalLogger.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    RACSignal *lowercaseSignal = [LowercaseEmitter lowercaseEmitter];
    [CharacterSignalLogger loggerWithSignal:lowercaseSignal label:@"lowercase"];
    
    // Define transformer inline:
    RACSignal *uppercaseSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [lowercaseSignal subscribeNext:^(NSNumber *charObj) {
            char c = [charObj charValue];
            c -= 'a' - 'A';
            [subscriber sendNext:[NSNumber numberWithChar:c]];
        }
        error:^(NSError *error) {
            [subscriber sendError:error];
        }
        completed:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    [CharacterSignalLogger loggerWithSignal:uppercaseSignal label:@"inline uppercase"];
}

@end
