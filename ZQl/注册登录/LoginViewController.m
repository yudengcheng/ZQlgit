//
//  LoginViewController.m
//  StockingSellingStoring
//
//  Created by yudengcheng on 16/7/15.
//  Copyright © 2016年 doone. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"

#import "UIImage+Color.h"

#import "Check.h"

#import "UserI.h"
@interface LoginViewController ()
@property (strong, nonatomic) UITextField *text_phone;
@property (strong, nonatomic) UITextField *text_password;
@property (strong, nonatomic) UIButton *registerBtb;

@property (strong, nonatomic) UIButton *btn_login;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layout
{
    self.title = @"登录";
    
    
    [self.view addSubview:[self userView]];
    [self.view addSubview:[self passView]];
    
    [self.view addSubview:self.btn_login];
    [self.view addSubview:self.registerBtb];
    
}

/**
 *  登录
 *
 *  @param sender <#sender description#>
 */
- (void)login_action:(id)sender {
    if (![self isRightStr]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD show:@"登录中..." Interaction:NO];
    });
    
    double delayInSeconds = (float)(1+arc4random()%99)/100  + 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        // code to be executed on the main queue after delay
        [UserI defaultPlatform].loginName = self.text_phone.text;
        [UserI defaultPlatform].loginPwd = self.text_password.text;
        [UserI defaultPlatform].isLogin = YES;
        [[UserI defaultPlatform] saveLogin];
        [ProgressHUD showSuccess:@"登录成功!"];
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    
}


/**
 *  注册
 *
 */
- (void)register_action:(id)sender {
    RegisterViewController * regis = [[RegisterViewController alloc] init];
    regis.Vtype = 1;
//    [self presentViewController:regis animated:YES completion:nil];
    [self.navigationController pushViewController:regis animated:YES];
}


-(BOOL)isRightStr
{
    BOOL isright = NO;
    
    if (self.text_phone.text.length == 0 ) {
        [ProgressHUD showError:@"请输入账号！"];
        return NO;
    } else if (self.text_password.text.length == 0)
    {
        [ProgressHUD showError:@"请输入密码！"];
        return NO;
    }
    
    
    
    for (NSMutableDictionary *userdic in [UserI defaultPlatform].listUser) {
        if ([userdic[@"username"] isEqualToString:self.text_phone.text] && [userdic[@"password"] isEqualToString:self.text_password.text]) {
            isright = YES;
            break;
        }
        
    }
    
    if (!isright) {
        [Helper goYC:^{
            [ProgressHUD showError:@"账号或密码错误！"];
        } isdismiss:NO];
    }
    
    return isright;
}


- (UIView *)userView
{
    UIView *userview = [[UIView alloc] initWithFrame:CGRectMake(20, 30, Screen.width - 40, 40)];
    LRViewBorderRadius(userview, 2, 0, [UIColor whiteColor]);
    userview.backgroundColor = SetHexColor(0xF2F4F9);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"login_phone.png"];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, Screen.width - 100, 40)];
    userField.placeholder = @"请输入您的账号";
    userField.font = [UIFont systemFontOfSize:17.0f];
    
    [userview addSubview:imageView];
    [userview addSubview:userField];
    
    self.text_phone = userField;
    
    return userview;
}

- (UIView *)passView
{
    UIView *userview = [[UIView alloc] initWithFrame:CGRectMake(20, 80, Screen.width - 40, 40)];
    LRViewBorderRadius(userview, 2, 0, [UIColor whiteColor]);
    userview.backgroundColor = SetHexColor(0xF2F4F9);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"login_password.png"];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, Screen.width - 100, 40)];
    userField.placeholder = @"请输入密码";
    userField.secureTextEntry = YES;
    userField.font = [UIFont systemFontOfSize:17.0f];
    
    [userview addSubview:imageView];
    [userview addSubview:userField];
    
    self.text_password = userField;
    
    return userview;
}

- (UIButton *)btn_login
{
    if (!_btn_login) {
        _btn_login = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, Screen.width - 40, 40)];
        [_btn_login setTitleColor:MainColor forState:UIControlStateNormal];
        LRViewBorderRadius(_btn_login, 1.5f, 1, MainColor);
        
        _btn_login.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_btn_login setTitle:@"立即登录" forState:UIControlStateNormal];
        [_btn_login setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_btn_login setBackgroundImage:[UIImage imageWithColor:MainQianColor] forState:UIControlStateHighlighted];
        [_btn_login addTarget:self action:@selector(login_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_login;
}

- (UIButton *)registerBtb
{
    if (!_registerBtb) {
        _registerBtb = [[UIButton alloc] initWithFrame:CGRectMake(Screen.width - 95, 200, 75, 25)];
        [_registerBtb setTitleColor:MainQianColor forState:UIControlStateNormal];
        _registerBtb.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _registerBtb.titleLabel.textAlignment = 2;
        [_registerBtb setTitle:@"立即注册" forState:UIControlStateNormal];
         [_registerBtb addTarget:self action:@selector(register_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtb;
}

@end
