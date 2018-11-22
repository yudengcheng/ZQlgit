//
//  Config.h
//  CDOTO
//
//  Created by yier on 15/8/3.
//  Copyright (c) 2015年 newdoone. All rights reserved.
//

#ifndef CDOTO_Config_h
#define CDOTO_Config_h



/**
 *
 *配置Tabbar上的ViewController为加载网页还是原生,有web的为网页，没有为原生
 */
#define TabbarVCArray @[@"Home",@"Life",@"User"]
//#define TabbarVCArray @[@"HomeWeb",@"CommunityWeb",@"ServerWeb",@"ShopCartWeb",@"MyselfWeb"]

/**
 *  App Info
 */

#define App_VersionKey (NSString *)kCFBundleVersionKey

#define App_ID        @"961330940"
#define App_Store_URL @"https://itunes.apple.com/cn/app/id"App_ID"?mt=8"

#define App_Name    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define APP_Identifier (NSString *)kCFBundleIdentifierKey
//取出上次使用的版本号
#define App_LastVersionCode [[NSUserDefaults standardUserDefaults] objectForKey:App_VersionKey]
//加载程序中的info.plist
#define App_CurrentVersionCode [NSBundle mainBundle].infoDictionary[App_VersionKey]
//这是真实的版本号，AppStore使用
#define App_BuildleVersion   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
//这是用户看到的版本号
#define APP_ShortBuildleVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

/**
 *  Persistence Directory
 *
 *  @return 系统的Directory路径
 */

#define Document_Directoty NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

/**
 *  FMDB
 *
 *  FMDB_PATH 数据库存储路径
 *
 *  FMDBLogLastError 数据库打印错误
 */

#define FMDB_Path [NSString stringWithFormat:@"%@/%@.db", Document_Directoty, App_Name]
//#define FMDB_Path [NSString stringWithFormat:@"%@/%@.db", @"/Users/yier/Documents/新东网项目/FMDB测试", App_Name]
#define FMDBLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

/**
 *  SSKeychain
 */

#define SSServer_Name @"com.doone.PontexlifeOwner"
#define SSLogin    @"SSLogin"
#define SSPassword     @"SSPassword"
#define SSAccess_Token @"SSAccess_Token"


/**
 *  圆弧设置
 *
 *  @param View   调整的view
 *  @param Radius 角度
 *  @param Width  边框
 *  @param Color  颜色
 */
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//
#define IMAGEURL(name) [NSString stringWithFormat:@"%@%@",[Tool getUsermodel].fileAskPath,name] //图片拼接

#endif
