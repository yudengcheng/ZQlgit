//
//  UIRGBColor.h
//  xkb
//
//  Created by 金色大地 on 15/7/15.
//  Copyright (c) 2015年 金色大地. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIRGBColor : NSObject


+(UIColor *)colorWithRGB:(int)color alpha:(float)alpha;

//通过颜色来生成一个纯色图片
+(UIImage *)buttonImageFromColor:(UIColor *)color;
@end
