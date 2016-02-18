//
//  UIViewController+Tracking.m
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import "MethodSwizzlingWithClassAndSel.h"

@implementation UIViewController (Tracking)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
        
        [MethodSwizzlingWithClassAndSel  methodSwizzleWithClass:class
                                                    originalSEL:originalSelector
                                                   swizzlingSEL:swizzledSelector];
    });
}

- (void)xxx_viewWillAppear:(BOOL)animated
{
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear:%@",NSStringFromClass([self class]));
}

@end
