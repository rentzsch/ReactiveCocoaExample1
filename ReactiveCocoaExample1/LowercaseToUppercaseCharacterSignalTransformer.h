//
//  LowercaseToUppercaseCharacterSignalTransformer.h
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface LowercaseToUppercaseCharacterSignalTransformer : NSObject

+ (RACSignal*)transformerWithInputSignal:(RACSignal*)inputSignal;

@end
