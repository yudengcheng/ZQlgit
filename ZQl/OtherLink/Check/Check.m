//
//  Check.m
//  OAO
//
//  Created by yier on 15/8/4.
//  Copyright (c) 2015年 newdoone. All rights reserved.
//

#import "Check.h"

@implementation Check

#pragma mark - 验证身份证

/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger )value1 Value2:(NSInteger )value2;

{
    
    return [str substringWithRange:NSMakeRange(value1,value2)];
    
}

/**
 
 * 功能:判断是否在地区码内
 
 * 参数:地区码
 
 */

+ (BOOL)areaCode:(NSString *)code

{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
        
    }
    
    return YES;
    
}
/**
 
 * 功能:验证身份证是否合法
 
 * 参数:输入的身份证号
 
 */

+(BOOL)isNotIDCard:(NSString *)sPaperId

{
    
    //判断位数
    
    
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return YES;
    }
    NSString *carid = sPaperId;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![Check areaCode:sProvince]) {
        
        return YES;
        
    }
    
    //判断年月日是否有效
    
    
    
    //年份
    
    int strYear = [[Check getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    
    int strMonth = [[Check getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    
    int strDay = [[Check getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return YES;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId))
    {
        return -1;
    }
    
    
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            
            return YES;
        }
    }
    
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 判断电话号码
+ (BOOL)isNotMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0-9])|(1[4,7][0-9]))\\d{8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - 检查字符串是否为空
+(BOOL)isStringOfNull:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    return NO;
}

#pragma  mark - 检查邮箱是否错误
//通过区分字符串

+(BOOL)isNotValidateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy] ;
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return YES;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return YES;
        }
        
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - 判断姓名
+ (BOOL)isNotName:(NSString *)name
{
#define IS_CHINA_SYMBOL(chr)  (((int)(chr)>127)&&chr<0x9fff)
    for (int i = 0; i<name.length; i++) {
        unichar ch = [name characterAtIndex:i];
        if (!IS_CHINA_SYMBOL(ch)) {
            return YES;
        }
    }
    //    VVDLog(@"11111");
    return NO;
}

#pragma mark - 验证emoji
//缺陷：2⃣#⃣7⃣7⃣6⃣5⃣4⃣3⃣2⃣2⃣2⃣2⃣2⃣®〰
+(NSString *)isBackNotContainsEmoji:(NSString *)string {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:string
                                                               options:0
                                                                 range:NSMakeRange(0, [string length])
                                                          withTemplate:@""];
    
    return modifiedString;
    
}

#pragma mark - 判断密码
+(BOOL)isNotPWD:(NSString *)pwd
{
    NSString * password = @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~\\(\\)\\-\\_\\=\\+\\|\\{\\}\\\\\\;\\'\\:\\""\\,\\.\\/\\<\\>\\?\\`]{6,20}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    
    if ([regextestmobile evaluateWithObject:pwd] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isNotPWDIncludeAlphanumeric:(NSString *)pwd
{
    NSString * password = @"^[A-Za-z0-9]+$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    
    if ([regextestmobile evaluateWithObject:pwd] == YES)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+(BOOL)isNotPowerPassword:(NSString *)pwd
{
    NSString * password = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    
    if ([regextestmobile evaluateWithObject:pwd] == YES)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+(BOOL)isNotOnlyNumber:(NSString *)numStr
{
    
    
    NSString * checkPredicate = @"^[0-9]*$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", checkPredicate];
    
    if ([regextestmobile evaluateWithObject:numStr] == YES)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark -  查找字符串在整个字符串的位置
+(NSInteger)findStringBeginNumberInTotalStringByKey:(NSString *)key TotalString:(NSString *)totalString
{
    NSString * body = totalString;
    
    NSString * keyString = key;
    
    NSScanner * scanner = [NSScanner scannerWithString:body];
    
    [scanner setCaseSensitive:YES];//区分大小写
    
    BOOL isfind;
    
    while (![scanner isAtEnd])   //是否到末尾
    {
        isfind=[scanner scanString:keyString intoString:NULL];
        
        if(isfind)
        {
            return ([scanner scanLocation]-keyString.length);
        }
        else
        {
            scanner.scanLocation++;
        }
    }
    
    return 0;
    
}

#pragma mark -  利用正则表达式验证邮箱
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 截屏
+ (UIImage *)imageFromView:(UIView *)theView Name:(NSString *)name
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    NSData *imageData = UIImageJPEGRepresentation(theImage, 0.5);
    //    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:name];
    //    [imageData writeToFile:fullPath atomically:NO];
    
    //    VVDLog(@"%@",fullPath);
    
    return theImage;
}

//设置高斯模糊
+(UIImage *)setGaussianBlurWithURL:(NSString *)url ImageView:(UIImageView *)imageView LocalImage:(UIImage *)localImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image;
    
    if (IsImageStr(url)) {
        
        NSData * data = UIImagePNGRepresentation(localImage);
        image = [CIImage imageWithData:data];
    }
    else
    {
        image = [CIImage imageWithContentsOfURL:[NSURL URLWithString:url]];
        
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@50.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:imageView.bounds];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    
    return blurImage;
}


@end
