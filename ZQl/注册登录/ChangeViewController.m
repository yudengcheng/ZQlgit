//
//  ChangeViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/16.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "ChangeViewController.h"
#import "UIImage+Color.h"
#import "Helper.h"
#import "UserI.h"
@interface ChangeViewController ()
@property (strong, nonatomic) UITextField *text_old;
@property (strong, nonatomic) UITextField *text_new;
@property (strong, nonatomic) UITextField *text_newagain;

@property (strong, nonatomic) UIButton *btn_change;
@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)change_Action:(id)sender {
    if (![self isChange]) {
        return;
    }
    
    
    [Helper goYC:^{
        if (![self.text_old.text isEqualToString:[UserI defaultPlatform].loginPwd]) {
            [ProgressHUD showError:@"旧密码输错！！！"];
            return;
        }
        
        for (int i = 0; i< [UserI defaultPlatform].listUser.count ; i++) {
            
            NSDictionary *dic = [UserI defaultPlatform].listUser[i];
            
            if ([dic[@"username"] isEqualToString:[UserI defaultPlatform].loginName]) {
                
                [[UserI defaultPlatform].listUser removeObject:dic];
                
                NSDictionary *userdic = @{@"username":[UserI defaultPlatform].loginName,
                                          @"password":self.text_new.text
                                          };
                
                [[UserI defaultPlatform].listUser insertObject:userdic atIndex:i];
                
                [[UserI defaultPlatform] saveList];
                
                [ProgressHUD showError:@"修改密码成功！！！"];
                
        
                break;
            }
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } isdismiss:NO];
    
}

- (BOOL)isChange
{
    if (self.text_old.text.length == 0) {
        [ProgressHUD showError:@"请输入旧密码！"];
        return false;
    } else if (self.text_new.text.length == 0)
    {
        [ProgressHUD showError:@"请输入新密码！"];
        return false;
    } else if (self.text_newagain.text.length == 0)
    {
        [ProgressHUD showError:@"请再次输入新密码！"];
        return false;
    } else if (![self.text_newagain.text isEqualToString:self.text_new.text])
    {
        [ProgressHUD showError:@"输入两次的密码不同！"];
        return false;
    }
    
    return YES;
}

- (void)createView
{
    NSArray *titleArr = @[@"请输入旧密码",@"请输入新密码",@"请再次输入新密码"];
    
    for (int i = 0; i< titleArr.count; i++) {
        
        UITextField *textf = [[UITextField alloc] initWithFrame:CGRectMake(20, 30 + 55 * i, Screen.width - 40, 40)];
        
        LRViewBorderRadius(textf, 3, 1, MainQianColor);
        textf.placeholder = titleArr[i];
        textf.font = [UIFont systemFontOfSize:15.0f];
        textf.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.view addSubview:textf];
        
        if (i == 0) {
            self.text_old = textf;
        } else if (i == 1)
        {
            self.text_new = textf;
        } else if (i == 2)
        {
            self.text_newagain = textf;
        }
        
    }
    
    [self.view addSubview:self.btn_change];
}

- (UIButton *)btn_change
{
    if (!_btn_change) {
        _btn_change = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, Screen.width - 40, 40)];
        [_btn_change setTitleColor:MainColor forState:UIControlStateNormal];
        LRViewBorderRadius(_btn_change, 1.5f, 1, MainColor);
        
        _btn_change.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_btn_change setTitle:@"确认修改" forState:UIControlStateNormal];
        [_btn_change setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_btn_change setBackgroundImage:[UIImage imageWithColor:MainQianColor] forState:UIControlStateHighlighted];
        [_btn_change addTarget:self action:@selector(change_Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_change;
}

@end
