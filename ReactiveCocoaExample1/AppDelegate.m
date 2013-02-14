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

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    RACSignal *lowercaseSignal = [LowercaseEmitter lowercaseEmitter];
    [CharacterSignalLogger loggerWithSignal:lowercaseSignal label:@"lowercase"];
}

@end
