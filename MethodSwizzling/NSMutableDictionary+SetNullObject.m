//
//  NSMutableDictionary+SetNullObject.m
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "NSMutableDictionary+SetNullObject.h"
#import "MethodSwizzlingWithClassAndSel.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (SetNullObject)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = objc_getClass("__NSDictionaryM");
        
        SEL originalSelector = @selector(setObject:forKey:);
        SEL swizzledSelector = @selector(setNullObject:forKey:);
        
        [MethodSwizzlingWithClassAndSel methodSwizzleWithClass:class
                                                   originalSEL:originalSelector
                                                  swizzlingSEL:swizzledSelector];
    });
}

- (void)setNullObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject && aKey) {
        [self setNullObject:anObject forKey:aKey];
    }
}

@end
