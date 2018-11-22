//
//  RegisterViewController.h
//  StockingSellingStoring
//
//  Created by yudengcheng on 16/7/15.
//  Copyright © 2016年 doone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

/**
 *  1、注册 2、忘记密码
 */
@property (nonatomic ,assign) int Vtype;

- (IBAction)backACTION:(id)sender;
@end
