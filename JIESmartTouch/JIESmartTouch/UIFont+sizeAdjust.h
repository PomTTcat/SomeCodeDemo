//
//  UIFont+sizeAdjust.h
//  Libratone iOS
//
//  Created by 管宇杰 on 17/3/20.
//  Copyright © 2017年 Libratone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (sizeAdjust)


#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kwRatio (kScreenWidth / 375.0)
#define khRatio (kScreenHeight / 667.0)
#define kAWidth(width) (ceilf((width) * kwRatio))
#define kAHeight(height) (ceilf((height) * khRatio))


+ (nullable UIFont *)BLfontWithName:(NSString *)fontName size:(CGFloat)fontSize;

@end
