//
//  Define.h
//  CDOTO
//
//  Created by tangdizhu on 14-7-28.
//  Copyright (c) 2014年 tangdizhu. All rights reserved.
//

#ifndef CDOTO_Define_h
#define CDOTO_Define_h




#define ScreenProportion Screen.width/320.0
#define Screen  [UIScreen mainScreen].bounds.size

/***********尺寸宏***********/
#define CGRM(_X,_Y,_W,_H) CGRectMake(_X, _Y, _W * ([UIScreen mainScreen].bounds.size.width / 320.0), _H * ([UIScreen mainScreen].bounds.size.height / 568.0))

/**
 判断系统
 *
 **/
#define currentVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define isIOS7 currentVersion>=7.0 && currentVersion <8.0
#define isIOS8 currentVersion>=8.0 && currentVersion <9.0
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/**
 判断手机
 *
 **/
#define isIphone_5 Screen.height == 568
#define isIphone_4 Screen.height == 480
#define isIphone_6 Screen.height == 667
#define isIphone_6plus Screen.height == 736
#define isIphone [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define isIpad   [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad

/***********根据路径加载图片***********/
#define IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]]
/***********颜色宏***********/
#define   SetColor(R,G,B,P) [UIColor colorWithRed:(CGFloat)(R/255.0) green:(CGFloat)(G/255.0) blue:(CGFloat)(B/255.0) alpha:P]
#define SetHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//主题色
//#define ThemeColor SetHexColor(0x38B7EA)
#define ThemeColor SetHexColor(0x9473B7)
//背景色
//#define BackGroundColor SetHexColor(0xE1E4EE)
#define BackGroundColor [UIColor whiteColor]
//蓝色按钮
#define BlueButton SetColor(56, 183, 234, 1)

//屏幕长宽
#define VIEW_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define VIEW_HEIGHT [[UIScreen mainScreen] bounds].size.height

/***********int转string***********/
#define IntToString(_int) _int = [NSString stringWithFormat:@"%d",[_int intValue]]
/***********NULL转nil***********/
#define NULL_NIL(_str)  [_str isEqual:[NSNull null]] ? @"":_str

/***********imageUrl是否为空l***********/
#define IsImageStr(imageStr) [imageStr isEqualToString:@""] || [imageStr isEqualToString:@"<null>"] || imageStr == nil
/***********默认的没有图片***********/
#define DefaultImage [UIImage imageNamed:@"noPicture"]

/***********CGRectGetHeight***********/
#define CGGetH(Frame)  CGRectGetHeight(Frame)
/***********CGRectGetWidth***********/
#define CGGetW(Frame) CGRectGetWidth(Frame)


/**************显示对话框*****************/
#define ShowAlert(message)  DXAlertView * alertView = [[DXAlertView alloc]initWithTitle:@"温馨提示！" contentText:message leftButtonTitle:nil    rightButtonTitle:@"知道了"];[alertView show];
#define ShowDescription  NSString * showStr = [NSString stringWithFormat:@"%@",finishedTure[@"description"]];ShowAlert(showStr);
#define ShowNetError    ShowAlert(@"网络错误");


// 日志输出
#ifdef DEBUG
#define VVDLog(format, ...) NSLog((@"\n[函数名:%s]" "[行号:%d]  \n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define VVDLog(format, ...);
#endif


/** 6.GCD */
// GCD -一次性执行
#define ZB_DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
// GCD -在Main线程上运行
#define ZB_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// GCD -开启异步线程
#define ZB_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), globalQueueBlock);


//返回信息
typedef void(^BackSuccessBlock)(id backSuccessBlock);
typedef void(^BackErrorBlock)(id backErrorBlock);

#define MainColor SetHexColor(0xBC3322)
#define MainQianColor SetHexColor(0xBC640C)

#define FirstName @"qa5526"
#define FirstPwd @"123456"

//检测是否包含中文
#define IS_CH_SYMBOL(chr) ((int)(chr)>127)

#import "ProgressHUD.h"
#import "Helper.h"
//#import "Request.h"
#endif
