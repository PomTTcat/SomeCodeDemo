//
//  UIFont+sizeAdjust.m
//  Libratone iOS
//
//  Created by 管宇杰 on 17/3/20.
//  Copyright © 2017年 Libratone. All rights reserved.
//

#import "UIFont+sizeAdjust.h"
#import "NSObject+runTime.h"

@implementation UIFont (sizeAdjust)

+(void)load{
    [self gyj_swizzleClassSelector:@selector(fontWithName:size:) swizzleSelector:@selector(BLfontWithName:size:)];
}

+ (nullable UIFont *)BLfontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    NSLog(@"font %f %@",fontSize,fontName);
    UIFont *font = [self BLfontWithName:fontName size:kAWidth(fontSize)];
    NSLog(@"font %f %@",kAWidth(fontSize),fontName);
    return font;
}

@end
