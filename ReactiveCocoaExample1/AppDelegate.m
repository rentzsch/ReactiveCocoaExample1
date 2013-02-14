//
//  AppDelegate.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "AppDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LowercaseEmitter.h"
#import "SignalLogger.h"
#import "LowercaseToUppercaseCharacterSignalTransformer.h"
#import "WordMaker.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    RACSignal *lowercaseSignal = [LowercaseEmitter lowercaseEmitter];
    [SignalLogger loggerWithSignal:lowercaseSignal label:@"lowercase"];
    
    // Define transformer inline:
    RACSignal *inlineUppercaseTransformer = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [lowercaseSignal subscribeNext:^(NSNumber *charObj) {
            char c = [charObj charValue];
            c = toupper(c);
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
    [SignalLogger loggerWithSignal:inlineUppercaseTransformer label:@"inline uppercase"];
    
    // Or use a reusable transformer class:
    RACSignal *classBasedUppercaseTransformer = [LowercaseToUppercaseCharacterSignalTransformer transformerWithInputSignal:lowercaseSignal];
    [SignalLogger loggerWithSignal:classBasedUppercaseTransformer label:@"class-based uppercase"];
    
    RACSignal *wordsSignal = [WordMaker makerWithInputSignal:lowercaseSignal];
    [SignalLogger loggerWithSignal:wordsSignal label:@"words"];
}

@end
