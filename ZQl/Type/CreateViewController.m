//
//  CreateViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/27.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "CreateViewController.h"
#import "LocalData.h"
#import "UserI.h"
#import "Helper.h"
@interface CreateViewController ()

@property (strong, nonatomic) UITextField *title_label;
@property (strong, nonatomic) UITextView *content_field;

@property (strong, nonatomic) NSArray *typeArr;
@property (strong, nonatomic) NSMutableArray *btnArr;

@property (strong, nonatomic) NSString *choaseType;
@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发帖";
    self.choaseType = @"";
    
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layout
{
    NSArray *labeltitleArr = @[@"标题:",@"内容:",@"类型:"];
    
    for (int i = 0; i< 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 25)];
        
        if (i == 1) {
            label.frame = CGRectMake(20, 65, 50, 25);
        } else if (i == 2)
        {
            label.frame = CGRectMake(20, 205, 50, 25);
        }
        
        label.textColor = MainColor;
        label.font = [UIFont systemFontOfSize:17.0f];
        label.text = labeltitleArr[i];
        
        [self.view addSubview:label];
        
    }
    
    LRViewBorderRadius(self.title_label, 2, 1, MainQianColor);
    LRViewBorderRadius(self.content_field, 2, 1, MainQianColor);
    
    self.title_label = [[UITextField alloc] initWithFrame:CGRectMake(90, 20, Screen.width - 110, 25)];
    self.title_label.textColor = MainColor;
    self.title_label.font = [UIFont systemFontOfSize:15];
    LRViewBorderRadius(self.title_label, 2, 1, MainColor);
    
    [self.view addSubview:self.title_label];
    
    self.content_field = [[UITextView alloc] initWithFrame:CGRectMake(90, CGRectGetMaxY(self.title_label.frame)+20, Screen.width - 110, 120)];
    self.content_field.font = [UIFont systemFontOfSize:15];
    self.content_field.textColor = MainColor;
    LRViewBorderRadius(self.content_field, 2, 1, MainColor);
    
    [self.view addSubview:self.content_field];
    
    int heightNum = 0;
    int typeNum = 0;
    int btnWitdth = 50;
    int btnheight = 25;
    
    for (int i = 0; i < [LocalData defaultPlatform].typelist.count ; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(90 + (btnWitdth + 15)* typeNum, CGRectGetMaxY(self.content_field.frame)+20 + (btnheight + 15) *heightNum, btnWitdth, btnheight)];
        
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        LRViewBorderRadius(btn, 2, 1, [UIColor grayColor]);
        
        [btn setTitleColor:MainColor forState:UIControlStateSelected];
        
        btn.tag = i + 1;
        
        [btn addTarget:self action:@selector(ChoseType:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:[LocalData defaultPlatform].typelist[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        
        [self.btnArr addObject:btn];
        
        typeNum = typeNum + 1;
        
        if (90 + (btnWitdth + 15)* typeNum + btnWitdth > Screen.width) {
            
            typeNum = 0;
            
            heightNum = heightNum+1;
            
        }
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(FBAction)];
}

- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc] init];
    }
    return _btnArr;
}

- (void)ChoseType:(UIButton *)btn
{
    for (UIButton *button in self.btnArr) {
        if (btn == button) {
            
            button.selected = YES;
        
            LRViewBorderRadius(button, 2, 1, MainColor);
            
            self.choaseType =  [NSString stringWithFormat:@"%d",btn.tag];
        } else
        {
            button.selected = NO;
            
            LRViewBorderRadius(button, 2, 1, [UIColor grayColor]);
        }
    }
    

}

- (void)FBAction
{
    if (self.title_label.text.length == 0) {
        [ProgressHUD showError:@"请输入标题！"];
        return;
    } else if (self.content_field.text.length < 60)
    {
        [ProgressHUD showError:@"内容不能少于30个字！"];
        return;
    } else if (self.choaseType.length == 0)
    {
        [ProgressHUD showError:@"请选择帖子类型！"];
        return;
    }
    NSMutableDictionary *typedic = [[NSMutableDictionary alloc] init];
    
    [typedic setObject:self.title_label.text forKey:@"title"];
    [typedic setObject:self.content_field.text forKey:@"content"];
    [typedic setObject:[UserI defaultPlatform].loginName forKey:@"name"];
    [typedic setObject:self.choaseType forKey:@"type"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [typedic setObject:arr forKey:@"homepl"];
    
    [[LocalData defaultPlatform].Homelist insertObject:typedic atIndex:0];
    
    [[LocalData defaultPlatform] saveList];
    
    [Helper goYC:^{
        
        [ProgressHUD showSuccess:@"发帖成功！"];
        
        [self.navigationController popViewControllerAnimated:YES];
    } isdismiss:NO];
    
    
    
}



@end
