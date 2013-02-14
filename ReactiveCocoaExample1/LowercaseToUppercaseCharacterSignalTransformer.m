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
 
 The first version creates an explicit signal with the three callbacks.
 
 The second leverages -[RACStream map:], which handles the common case of
 wanting to transform one value into another for all values in a stream.
 */

@implementation LowercaseToUppercaseCharacterSignalTransformer

#if 1

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

#else

+ (RACSignal*)transformerWithInputSignal:(RACSignal*)inputSignal {
    return [inputSignal map:^id(id value) {
        char c = [value charValue];
        c = toupper(c);
        return [NSNumber numberWithChar:c];
    }];
}

#endif

@end
