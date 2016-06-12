//
//  NSArray+AtIndexCrash.m
//  MethodSwizzling
//
//  Created by Alex on 16/6/12.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "NSArray+AtIndexCrash.h"
#import "MethodSwizzlingWithClassAndSel.h"
#import <objc/runtime.h>


@implementation NSArray (AtIndexCrash)

+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = objc_getClass("__NSArrayI");
        
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(swizzledObjectAtIndex:);
        
        [MethodSwizzlingWithClassAndSel methodSwizzleWithClass:class
                                                   originalSEL:originalSelector
                                                  swizzlingSEL:swizzledSelector];
    });
}

- (id)swizzledObjectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self swizzledObjectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self swizzledObjectAtIndex:index];
    }
}


@end
