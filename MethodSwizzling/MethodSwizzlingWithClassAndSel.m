//
//  MethodSwizzlingWithClassAndSel.m
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MethodSwizzlingWithClassAndSel.h"
#import <objc/runtime.h>

@implementation MethodSwizzlingWithClassAndSel

+ (void)methodSwizzleWithClass:(Class)class originalSEL:(SEL)originalSEL swizzlingSEL:(SEL)swizzlingSEL{
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSEL);
    
    /*
     我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，
     如果self没有实现被交换的方法，会导致失败。而且self没有交换的方法实现，但是父类有这个方法，
     这样就会调用父类的方法，结果就不是我们想要的结果了。
     所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，
     我们就可以对其进行交换了。
     */
    BOOL didAddMethod = class_addMethod(class,
                                     originalSEL,
                                     method_getImplementation(swizzlingMethod),
                                     method_getTypeEncoding(swizzlingMethod));
    
    if(didAddMethod){
        class_replaceMethod(class,
                            swizzlingSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}


@end
