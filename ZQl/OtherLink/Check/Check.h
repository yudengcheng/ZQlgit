//
//  Check.h
//  OAO
//
//  Created by yier on 15/8/4.
//  Copyright (c) 2015年 newdoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Check : NSObject

//检查IDCard
+(BOOL)isNotIDCard:(NSString *)sPaperId;

//检查手机号码
+(BOOL)isNotMobileNumber:(NSString *)mobileNum;

//检查字符串是否为空
+(BOOL)isStringOfNull:(NSString *)string;

//检查邮箱
-(BOOL)isValidateEmail:(NSString *)email;

//检查邮箱是否错误
+(BOOL)isNotValidateEmail:(NSString*)email;

//检查姓名中是否含有数字或标点符号
+ (BOOL)isNotName:(NSString *)name;

//检查字符串中是否包含emoji表情
+(NSString *)isBackNotContainsEmoji:(NSString *)string;

//检查密码中是否只含有数字 字符 字母
+(BOOL)isNotPWD:(NSString *)pwd;

//弱密码校验，必须且只能包含数字和字母6~20位 (ww1111)
+(BOOL)isNotPowerPassword:(NSString *)pwd;

//检查是否只含有数字 字母
+(BOOL)isNotPWDIncludeAlphanumeric:(NSString *)pwd;

//检查是否只含有数字
+(BOOL)isNotOnlyNumber:(NSString *)numStr;

//查找字符串在整个字符串的位置
+(NSInteger)findStringBeginNumberInTotalStringByKey:(NSString *)key TotalString:(NSString *)totalString;

//截屏
+ (UIImage *)imageFromView:(UIView *)theView Name:(NSString *)name;
//高斯模糊
+(UIImage *)setGaussianBlurWithURL:(NSString *)url ImageView:(UIImageView *)imageView LocalImage:(UIImage *)localImage;
@end
