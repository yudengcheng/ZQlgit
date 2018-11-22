//
//  LocalData.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "LocalData.h"

#define SAVELIST [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@"main"]


@implementation LocalData

+ (LocalData *)defaultPlatform
{
    static LocalData *yyj = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        yyj = [[LocalData alloc] init];
    });
    return  yyj;
}

- (void)initData
{
    self.Homelist = [[NSMutableArray alloc] init];
    
    
    NSArray *arrlist;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SAVELIST] != nil) {

        arrlist = [[NSUserDefaults standardUserDefaults] objectForKey:SAVELIST];

    } else
    {
        arrlist = [LocalData defaultPlatform].osslist;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    for (NSDictionary *thinkDic in arrlist) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:thinkDic];
        
        NSMutableArray *plarr = [NSMutableArray arrayWithArray:dic[@"homepl"]];
        
        [dic removeObjectForKey:@"homepl"];
        
        [dic setObject:plarr forKey:@"homepl"];
        
        [self.Homelist addObject:dic];
    }

}

- (void)saveList
{
    [[NSUserDefaults standardUserDefaults]setObject:self.Homelist forKey:SAVELIST];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)typelist
{
    if (!_typelist) {
        _typelist = [NSArray arrayWithObjects:@"学习",@"教学",@"教程",@"大神",@"其他", nil];
    }
    return _typelist;
}

@end
