//
//  RegisterViewController.m
//  StockingSellingStoring
//
//  Created by yudengcheng on 16/7/15.
//  Copyright © 2016年 doone. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIImage+Color.h"
#import "UViewController.h"
#import "Check.h"
#import "UserI.h"
#define TIME 60
@interface RegisterViewController ()
{
    NSTimer * timer;
    NSInteger sum;
    BOOL isAgrss;
}
@property (strong, nonatomic) UILabel *label_gou;

@property (strong, nonatomic) UITextField *text_passwordagain;
@property (strong, nonatomic) UITextField *text_realname;

@property (strong, nonatomic) UIButton *btn_register;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}

-(void)layout
{
    isAgrss = NO;
    
    self.title = @"注册";
    
    [self.view addSubview:[self userView]];
    [self.view addSubview:[self passView]];
    
    [self.view addSubview:[self agreesView]];
    [self.view addSubview:self.btn_register];
    

}

#pragma mark 获取验证码



- (IBAction)Register_action:(id)sender {
    if (![self isRightStr]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD show:@"注册中..." Interaction:NO];
    });
    
    double delayInSeconds = (float)(1+arc4random()%99)/100  + 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        [dic setObject:self.text_realname.text forKey:@"username"];
        [dic setObject:self.text_passwordagain.text forKey:@"password"];
        
        [[UserI defaultPlatform].listUser addObject:dic];
        
        [[UserI defaultPlatform] saveList];
        
        // code to be executed on the main queue after delay
        [UserI defaultPlatform].loginName = self.text_realname.text;
        [UserI defaultPlatform].loginPwd = self.text_passwordagain.text;
        [UserI defaultPlatform].isLogin = YES;
        [[UserI defaultPlatform] saveLogin];
        [ProgressHUD showSuccess:@"登录成功!"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
    
}

-(BOOL)isRightStr
{
    BOOL isright = YES;
    
    
    if (self.text_realname.text.length == 0) {
        [ProgressHUD showError:@"请输入账号！！！"];
        return NO;
    }
    
    if (self.text_passwordagain.text.length == 0) {
        [ProgressHUD showError:@"请输入密码！！！"];
        return NO;
    }
    
    if (!isAgrss) {
        [ProgressHUD showError:@"请阅读并同意用户协议！！！"];
        return NO;
    }
    
    
    for (NSMutableDictionary *userdic in [UserI defaultPlatform].listUser) {
        
        if ([userdic[@"username"] isEqualToString:self.text_realname.text]) {
            isright = NO;
            [Helper goYC:^{
                [ProgressHUD showError:@"账号已存在！！！"];
            } isdismiss:NO];
            break;
        }
        
    }
    
    return isright;
}

- (IBAction)user_Action:(id)sender {
    UViewController *uview = [[UViewController alloc] init];
    
    [self.navigationController pushViewController:uview animated:YES];
}
- (IBAction)agress_Action:(id)sender {
    
    isAgrss = !isAgrss;
    
    if (isAgrss) {
        
        self.label_gou.text = @"✓";
        
    } else
    {
        
        self.label_gou.text = @"";
    }
    
}

- (IBAction)backACTION:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    self.text_realname = userField;
    
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
    
    self.text_passwordagain = userField;
    
    return userview;
}

- (UIView *)agreesView
{
    UIView *userview = [[UIView alloc] initWithFrame:CGRectMake(20, 135, 150, 35)];
    userview.backgroundColor = [UIColor clearColor];
    
    UILabel *lagou = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 15, 15)];
    LRViewBorderRadius(lagou, 7.5, 1, MainQianColor);
    lagou.textColor = MainQianColor;
    lagou.font = [UIFont systemFontOfSize:15.0];
    
    UILabel *agress = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 30, 35)];
    agress.textColor = MainQianColor;
    agress.font = [UIFont systemFontOfSize:14.0f];
    agress.text = @"同意";
    
    UIButton *btn_gou = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 47, 35)];
    btn_gou.backgroundColor =[UIColor clearColor];
    [btn_gou addTarget:self action:@selector(agress_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *userxy = [[UIButton alloc] initWithFrame:CGRectMake(47, 0, 88, 35)];
    [userxy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    userxy.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [userxy setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [userxy addTarget:self action:@selector(user_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [userview addSubview:lagou];
    [userview addSubview:agress];
    [userview addSubview:btn_gou];
    [userview addSubview:userxy];
    
    self.label_gou = lagou;
    
    return userview;
}

- (UIButton *)btn_register
{
    if (!_btn_register) {
        _btn_register = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, Screen.width - 40, 40)];
        [_btn_register setTitleColor:MainColor forState:UIControlStateNormal];
        LRViewBorderRadius(_btn_register, 1.5f, 1, MainColor);
        
        _btn_register.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_btn_register setTitle:@"立即注册" forState:UIControlStateNormal];
        [_btn_register setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_btn_register setBackgroundImage:[UIImage imageWithColor:MainQianColor] forState:UIControlStateHighlighted];
        [_btn_register addTarget:self action:@selector(Register_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_register;
}

@end
