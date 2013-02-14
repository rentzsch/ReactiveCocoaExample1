//
//  AppDelegate.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "AppDelegate.h"
#import "LowercaseEmitter.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)notification {
    [LowercaseEmitter lowercaseEmitter];
    
}

@end
