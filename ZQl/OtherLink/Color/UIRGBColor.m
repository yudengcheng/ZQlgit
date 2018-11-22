//
//  UIRGBColor.m
//  xkb
//
//  Created by 金色大地 on 15/7/15.
//  Copyright (c) 2015年 金色大地. All rights reserved.
//

#import "UIRGBColor.h"

@implementation UIRGBColor

+(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}


+(UIImage *)buttonImageFromColor:(UIColor *)color{
	CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,100);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end
