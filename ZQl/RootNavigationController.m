//
//  RootNavigationController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "RootNavigationController.h"
#import "ColorWithHexString.h"
#import "UIRGBColor.h"
@interface RootNavigationController ()<UINavigationControllerDelegate>

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

}

-(void)initView{

//    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;

	self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};

	self.title_la = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, [[UIScreen mainScreen]bounds].size.width-160, 50)];
	self.title_la.textAlignment =1;
	self.title_la.textColor = [UIRGBColor colorWithRGB:0x333333 alpha:1];
	self.title_la.font = [UIFont fontWithName:@"Helvetica" size:20];
	[self.view addSubview:self.title_la];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	if (self.viewControllers.count >0) {
		viewController.hidesBottomBarWhenPushed =YES;
	}

	[super pushViewController:viewController animated:animated];
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    viewController.navigationItem.backBarButtonItem = barButtonItem;
}

@end
