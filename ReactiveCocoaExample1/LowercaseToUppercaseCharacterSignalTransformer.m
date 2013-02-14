//
//  LowercaseToUppercaseCharacterSignalTransformer.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "LowercaseToUppercaseCharacterSignalTransformer.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

/*
 Demonstrates a stateless class-based transformer.
 */

@implementation LowercaseToUppercaseCharacterSignalTransformer

+ (RACSignal*)transformerWithInputSignal:(RACSignal*)inputSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [inputSignal subscribeNext:^(NSNumber *charObj) {
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
}

@end
