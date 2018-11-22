//
//  UserI.h
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserI : NSObject

@property (nonatomic, strong) NSString *loginName;

@property (nonatomic, strong) NSString *loginPwd;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSMutableArray *listUser;

@property (nonatomic, strong) NSMutableArray *userblacklist;

+ (UserI *)defaultPlatform;

- (void)loginOut;

- (void)saveLogin;

- (void)saveList;
@end
