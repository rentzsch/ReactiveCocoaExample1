//
//  WordMaker.m
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import "WordMaker.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

/*
 Demonstrates a class-based processor that requires state between sent values.
 
 The first implementation stores its state in explicit properties while the second version
 stores it in the closure.
 */

#if 1

@interface WordMaker ()
@property(assign)  char       firstConsonant;
@property(assign)  char       secondVowel;
@property(assign)  char       thirdConsonant;
@property(strong)  RACSignal  *outputSignal;
@end

@implementation WordMaker

+ (RACSignal*)makerWithInputSignal:(RACSignal*)inputSignal {
    return ((WordMaker*)[[self alloc] initWithInputSignal:inputSignal]).outputSignal;
}

- (id)initWithInputSignal:(RACSignal*)inputSignal {
    self = [super init];
    if (self) {
        self.outputSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [inputSignal subscribeNext:^(NSNumber *charObj) {
                char c = [charObj charValue];
                switch (c) {
                    case 'a':
                    case 'e':
                    case 'i':
                    case 'o':
                    case 'u':
                        self.secondVowel = c;
                        break;
                    default:
                        self.firstConsonant = self.thirdConsonant;
                        self.thirdConsonant = c;
                        break;
                }
                if (self.firstConsonant && self.secondVowel) {
                    [subscriber sendNext:[NSString stringWithFormat:@"%c%c%c",
                                          self.firstConsonant,
                                          self.secondVowel,
                                          self.thirdConsonant]];
                }
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
    return self;
}

#else

@implementation WordMaker

+ (RACSignal*)makerWithInputSignal:(RACSignal*)inputSignal {
    __block char firstConsonant, secondVowel, thirdConsonant;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [inputSignal subscribeNext:^(NSNumber *charObj) {
            char c = [charObj charValue];
            switch (tolower(c)) {
                case 'a':
                case 'e':
                case 'i':
                case 'o':
                case 'u':
                    secondVowel = c;
                    break;
                default:
                    firstConsonant = thirdConsonant;
                    thirdConsonant = c;
                    break;
            }
            if (firstConsonant && secondVowel) {
                [subscriber sendNext:[NSString stringWithFormat:@"%c%c%c",
                                      firstConsonant,
                                      secondVowel,
                                      thirdConsonant]];
            }
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

#endif

@end