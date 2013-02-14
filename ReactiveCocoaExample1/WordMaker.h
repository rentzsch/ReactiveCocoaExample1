//
//  WordMaker.h
//  ReactiveCocoaExample1
//
//  Created by Wolf Rentzsch on 2/14/13.
//  Copyright (c) 2013 Jonathan 'Wolf' Rentzsch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

/*
 Dumb little class that generate "words" given at least one vowel and two consonants as it
 gets them.
 
 For example: ['a','b','c','d','e','f'] would output ['bac','cad','ced','def'].
 */

@interface WordMaker : NSObject

+ (RACSignal*)makerWithInputSignal:(RACSignal*)inputSignal;

@end
