//
//  Helper.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "Helper.h"
#import "ProgressHUD.h"
#import "UserI.h"
#import "LoginViewController.h"
@interface Helper()<UIAlertViewDelegate>
{
    
}
@end

@implementation Helper

+ (BOOL)refresh_go
{
    [ProgressHUD show:@"请稍等..." Interaction:NO];
    
    [NSThread sleepForTimeInterval:(float)(1+arc4random()%99)/100 +0.3];
    
    [ProgressHUD dismiss];
    return YES;
}

+ (void)login_go:(UIViewController *)controller
{
    if (![UserI defaultPlatform].isLogin) {
        
        LoginViewController *login  =[[LoginViewController alloc] init];
        
//        [controller presentViewController:login animated:YES completion:nil];
        [controller.navigationController pushViewController:login animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认举报该信息含有非法内容？" delegate:controller cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
}


+ (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

+ (void)goYC:(dispatch_block_t)block isdismiss:(BOOL)bo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD show:@"请稍等..." Interaction:NO];
    });
    
    double delayInSeconds = (float)(1+arc4random()%99)/200  + 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if (bo) {
            [ProgressHUD dismiss];
        }
        
    });
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
