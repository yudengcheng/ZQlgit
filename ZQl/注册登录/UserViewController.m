//
//  UserViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/16.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "UserViewController.h"
#import "UIImage+Color.h"
#import "ChangeViewController.h"
#import "UserI.h"
#import "BlacklistViewController.h"
#import "InitTabbarController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "TypeViewController.h"
@interface UserViewController ()


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.title = [UserI defaultPlatform].loginName;
    
    
    [self createBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)change_Action:(id)sender {
    UIButton * button = (UIButton *) sender;
    if (button.tag == 0) {
        ChangeViewController *change = [[ChangeViewController alloc] init];
        
        [self.navigationController pushViewController:change animated:YES];
    } else if (button.tag == 1)
    {
        [Helper goYC:^{
            if ([UserI defaultPlatform].userblacklist.count == 0 ) {
                [ProgressHUD showError:@"你黑名单没有人，不用管理！"];
            } else
            {
                [ProgressHUD dismiss];
                BlacklistViewController *black = [[BlacklistViewController alloc] init];
                [self.navigationController pushViewController:black animated:YES];
            }
        } isdismiss:NO];
    } else if (button.tag == 2)
    {
        TypeViewController *type = [[TypeViewController alloc] init];
        
        type.typeStr = @"我的帖子";
        type.title = @"我的帖子";
        
        [self.navigationController pushViewController:type animated:YES];
    } else if (button.tag == 3)
    {
        [[UserI defaultPlatform] loginOut];
        
        [Helper goYC:^{
            self.title = @"个人中心";
            
            [InitTabbarController shareInstance].tbc.selectedIndex = 0;
            
            LoginViewController *login  = [[LoginViewController alloc] init];
            
            [[InitTabbarController shareInstance].homeVC.navigationController pushViewController:login animated:YES];
            
            [ProgressHUD showSuccess:@"退出成功"];
        } isdismiss:YES];
    }
    
}


- (void) createBtn
{
    NSArray *titleArr = @[@"修改密码",@"黑名单",@"我的帖子",@"退出登录"];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 30 + 60 * i, Screen.width - 40, 40)];
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:MainQianColor] forState:UIControlStateHighlighted];
        LRViewBorderRadius(button, 3.0f, 1, MainColor);
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.tag = i;
        
        [button addTarget:self action:@selector(change_Action:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == titleArr.count - 1) {
            button.center = CGPointMake(Screen.width/2, Screen.height - 150);
        }
        
        [self.view addSubview:button];
    }
}

@end
