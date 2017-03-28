//
//  NSObject+runTime.m
//  AllInOne
//
//  Created by Apple on 16/9/5.
//  Copyright © 2016年 AppleYJ. All rights reserved.
//

#import "NSObject+runTime.h"
#import <objc/runtime.h>



@implementation NSObject (MethodSwizzling)

+ (void)gyj_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector {
    
    // 获取原有方法
    Method origMethod = class_getInstanceMethod(self,
                                                origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getInstanceMethod(self,
                                                   swizzleSelector);
    
    
    method_exchangeImplementations(origMethod, swizzleMethod);
    
    
    /*
    // 注意：不能直接交换方法实现，需要判断原有方法是否存在,存在才能交换
    // 如何判断？添加原有方法，如果成功，表示原有方法不存在，失败，表示原有方法存在
    // 原有方法可能没有实现，所以这里添加方法实现，用自己方法实现
    // 这样做的好处：方法不存在，直接把自己方法的实现作为原有方法的实现，调用原有方法，就会来到当前方法的实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    //此处是添加成功的。因为原来的类里面没有这个方法。
    if (!isAdd) { // 添加方法失败，表示原有方法存在，直接替换
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
     */
}

+ (void)gyj_swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    // 获取原有方法
    Method origMethod = class_getClassMethod(self,
                                             origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getClassMethod(self,
                                                swizzleSelector);
    
    
    method_exchangeImplementations(origMethod, swizzleMethod);
    
    /*
    // 添加原有方法实现为当前方法实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) { // 添加方法失败，原有方法存在，直接替换
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
    */
}

@end


@implementation NSObject (runTime)

+ (void)getIvarList:(Class)cls{
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    Ivar *var = class_copyIvarList(cls, &count);
    for (int i; i<count; i++) {
        Ivar _var = *(var + i);
        NSLog(@"%s",ivar_getTypeEncoding(_var));
        NSLog(@"%s",ivar_getName(_var));
    }
}

+ (void)getProperties:(Class)cls{
    
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"name = %@",name);
    }
}

@end
