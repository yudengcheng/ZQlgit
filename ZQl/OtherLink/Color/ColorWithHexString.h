//
//  ColorWithHexString.h
//  ColorWithHexString
//
//  Created by yier on 15/7/3.
//  Copyright (c) 2015年 newdoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorWithHexString : NSObject

//16进制字符串转成颜色
+ (UIColor *)colorWithHexString: (NSString *)color;

 //颜色转16进制字符串
+ (NSString *)getHexStringWithColor:(UIColor *)color;
@end
