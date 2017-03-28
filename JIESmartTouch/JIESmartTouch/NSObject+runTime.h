//
//  NSObject+runTime.h
//  AllInOne
//
//  Created by Apple on 16/9/5.
//  Copyright © 2016年 AppleYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runTime)

+ (void)getIvarList:(Class)cls;
+ (void)getProperties:(Class)cls;
@end


/**
 *  分类的目的：实现两个方法实现的交换，调用原有方法，有现有方法(自己实现方法)的实现。
 */
@interface NSObject (MethodSwizzling)

/**
 *  交换对象方法
 *
 *  @param origSelector    原有方法
 *  @param swizzleSelector 现有方法(自己实现方法)
 */
+ (void)gyj_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector;

/**
 *  交换类方法
 *
 *  @param origSelector    原有方法
 *  @param swizzleSelector 现有方法(自己实现方法)
 */
+ (void)gyj_swizzleClassSelector:(SEL)origSelector
                swizzleSelector:(SEL)swizzleSelector;





@end
