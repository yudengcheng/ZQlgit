//
//  InitTabbarController.h
//  MicroMall
//
//  Created by yier on 15/11/8.
//  Copyright © 2015年 newdoone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeViewController;
@class UserViewController;
@interface InitTabbarController : NSObject<UITabBarControllerDelegate>

@property (nonatomic,strong) UITabBarController * tbc;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) HomeViewController * homeVC;
@property (nonatomic,strong) UserViewController * personalVC;

+(InitTabbarController *)shareInstance;

- (UITabBarController *)InitializationTabbarController;

- (void)setSelectedAsTabbar:(NSInteger )selectedIndex;


@end
