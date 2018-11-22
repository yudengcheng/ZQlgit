//
//  InitTabbarController.m
//  MicroMall
//
//  Created by yier on 15/11/8.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import "InitTabbarController.h"
#import "HomeViewController.h"
#import "UserViewController.h"
#import "RootNavigationController.h"
#import "UserI.h"
#import "LoginViewController.h"
#import "UIImage+Color.h"
@implementation InitTabbarController

static  InitTabbarController * _initTabbarController = nil;
+(InitTabbarController *)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _initTabbarController  = [[super allocWithZone:NULL] init] ;
//        _initTabbarController.tbc = [self initTabbarController];
        
    }) ;
    
    return _initTabbarController ;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [InitTabbarController shareInstance] ;
}

-(id)copyWithZone:(struct _NSZone *)zone
{
    return [InitTabbarController shareInstance] ;
}

- (void)updateV:(NSNotification *)notifition
{

}


- (UITabBarController *)InitializationTabbarController
{
    [self removeCacle];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateV:) name:@"UPDATEVIEW" object:nil];
    
    
    UIImage *theImage = [UIImage imageWithColor:MainColor];
    self.homeVC = [[HomeViewController alloc]init];
    RootNavigationController * homeNagc = [[RootNavigationController alloc]initWithRootViewController:self.homeVC];
    [homeNagc.navigationBar setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
    homeNagc.tabBarItem.title = @"首页";
    homeNagc.tabBarItem.image = [UIImage imageNamed:@"tab_home.png"];


    
    self.personalVC = [[UserViewController alloc]init];
    RootNavigationController * personalNagc = [[RootNavigationController alloc]initWithRootViewController:self.personalVC];
    [personalNagc.navigationBar setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
    personalNagc.tabBarItem.title = @"个人中心";
    personalNagc.tabBarItem.image = [UIImage imageNamed:@"tab_personal.png"];

    
    self.tbc = [[UITabBarController alloc]init];
    self.tbc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    self.tbc.tabBar.backgroundColor=[UIColor whiteColor];
    self.tbc.tabBar.tintColor=MainColor;
    self.tbc.viewControllers = @[homeNagc,personalNagc];

    
    [self getred];
    self.tbc.delegate  =self;
    self.selectIndex = 0;
    return self.tbc;
}

- (void)setSelectedAsTabbar:(NSInteger )selectedIndex
{
    self.tbc.selectedIndex = selectedIndex;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex ==1) {
        if ([UserI defaultPlatform].isLogin == false) {
            [InitTabbarController shareInstance].tbc.selectedIndex  = 0;;
            
            LoginViewController *login = [[LoginViewController alloc] init];
            
            [[InitTabbarController shareInstance].homeVC.navigationController pushViewController:login animated:YES];
        }
    }
    
}

- (void)removeCacle
{
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}



-(void)registerUserPhoneMI
{

}

-(void)getred
{

}

@end
