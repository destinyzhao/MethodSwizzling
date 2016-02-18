//
//  NSMutableArray+AddNullObject.m
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "NSMutableArray+AddNullObject.h"
#import "MethodSwizzlingWithClassAndSel.h"
#import <objc/runtime.h>

@implementation NSMutableArray (AddNullObject)


+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = objc_getClass("__NSArrayM");
        
        SEL originalSelector = @selector(addObject:);
        SEL swizzledSelector = @selector(addNullObject:);
        
        [MethodSwizzlingWithClassAndSel methodSwizzleWithClass:class
                                                   originalSEL:originalSelector
                                                  swizzlingSEL:swizzledSelector];
    });
}

- (void)addNullObject:(id)anObject {
    if (anObject) {
        [self addNullObject:anObject];
    }
}


@end
