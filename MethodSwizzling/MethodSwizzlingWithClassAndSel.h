//
//  MethodSwizzlingWithClassAndSel.h
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodSwizzlingWithClassAndSel : NSObject

+ (void)methodSwizzleWithClass:(Class)class originalSEL:(SEL)originalSEL swizzlingSEL:(SEL)swizzlingSEL;

@end
