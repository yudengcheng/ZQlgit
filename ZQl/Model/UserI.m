//
//  UserI.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "UserI.h"
#import "Helper.h"

#define SAVELISTT [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@"2"]

#define SAVEMAIN [[NSBundle mainBundle] bundleIdentifier]

@implementation UserI

+ (UserI *)defaultPlatform
{
    static UserI *yyj = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        yyj = [[UserI alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginname"] != nil) {
            yyj.loginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginname"];
            yyj.loginPwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginPwd"];
            yyj.isLogin = YES;
        }
    });
    return  yyj;
}

- (NSMutableArray *)listUser
{
    if (!_listUser) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:SAVELISTT] != nil) {
            _listUser = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:SAVELISTT]];
        } else
        {
            _listUser = [[NSMutableArray alloc] init];
            NSDictionary *firty = @{@"username":FirstName,@"password":FirstPwd};
            [_listUser addObject:firty];
        }
        
    }
    return _listUser;
}

- (NSMutableArray *)userblacklist
{
    if (!_userblacklist) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SAVEMAIN,self.loginName]] != nil) {
            _userblacklist = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SAVEMAIN,self.loginName]]];
        } else
            _userblacklist = [[NSMutableArray alloc] init];
        
    }
    return _userblacklist;
}

- (void)saveList
{
    [[NSUserDefaults standardUserDefaults] setObject:self.listUser forKey:SAVELISTT];
    [[NSUserDefaults standardUserDefaults] setObject:self.userblacklist forKey:[NSString stringWithFormat:@"%@%@",SAVEMAIN,self.loginName]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveLogin
{
    if (self.isLogin) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SAVEMAIN,self.loginName]] != nil) {
            self.userblacklist = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SAVEMAIN,self.loginName]]];
        } else
            self.userblacklist = [[NSMutableArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:self.loginName forKey:@"loginname"];
        [[NSUserDefaults standardUserDefaults] setObject:self.loginPwd forKey:@"loginPwd"];
    }
}

- (void)loginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginname"];
    self.userblacklist = [[NSMutableArray alloc] init];
    [UserI defaultPlatform].isLogin = NO;
    self.loginName = @"";
    
}

@end
