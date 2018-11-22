//
//  Helper.h
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (BOOL)refresh_go;

+ (void)login_go:(UIViewController *)controller;

+ (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize;

+ (void)goYC:(dispatch_block_t)block isdismiss:(BOOL)bo;
@end
