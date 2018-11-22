//
//  UViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/6.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "UViewController.h"

@interface UViewController ()

@end

@implementation UViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.title = @"用户协议";
    
    UITextView *view = [[UITextView alloc] initWithFrame:self.view.bounds];
    
    NSString *fullname = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"user.txt"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:fullname];
    
    NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    view.text = str;
    
    view.font = [UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
