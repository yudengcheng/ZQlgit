//
//  TypeViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/17.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "TypeViewController.h"
#import "HomeCTableViewCell.h"
#import "UserI.h"
#import "LocalData.h"
#import "NewsViewController.h"
@interface TypeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView_type;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
static NSString * ideHomeCTableViewCell = @"HomeCTableViewCell";
@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addData];
    
    [self.view addSubview:self.tableView_type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addData
{
    [self.dataArr removeAllObjects];
    
    if ([self.typeStr isEqualToString:@"我的帖子"]) {
        for (int i = 0; i <  [LocalData defaultPlatform].Homelist.count ; i++) {
            
            if ([[LocalData defaultPlatform].Homelist[i][@"name"] isEqualToString:[UserI defaultPlatform].loginName]) {
                [self.dataArr addObject:[LocalData defaultPlatform].Homelist[i]];
            }
        }
    } else
    {
        for (int i = 0; i <  [LocalData defaultPlatform].Homelist.count ; i++) {
            
            if (![[UserI defaultPlatform].userblacklist containsObject:[LocalData defaultPlatform].Homelist[i][@"name"]]) {
                if ([LocalData defaultPlatform].Homelist[i][@"type"] != nil && [[LocalData defaultPlatform].Homelist[i][@"type"] isEqualToString:self.typeStr]) {
                    [self.dataArr addObject:[LocalData defaultPlatform].Homelist[i]];
                }
                
            }
        }
    }
    
}

- (UITableView *)tableView_type
{
    if (!_tableView_type) {
        _tableView_type = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
//        [_tableView_type registerNib:[UINib nibWithNibName:ideHomeCTableViewCell bundle:nil] forCellReuseIdentifier:ideHomeCTableViewCell];
        [_tableView_type registerClass:[HomeCTableViewCell class] forCellReuseIdentifier:ideHomeCTableViewCell];
        _tableView_type.delegate = self;
        _tableView_type.dataSource = self;
        
        _tableView_type.tableFooterView = [UIView new];
        
    }
    return _tableView_type;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Helper goYC:^{
        NSDictionary *dic = self.dataArr[indexPath.row];
        
        NewsViewController *news = [[NewsViewController alloc] init];
        news.datadic = dic;
        news.Row = indexPath.row;
        [self.navigationController pushViewController:news animated:YES];
    } isdismiss:YES];
    
}

#pragma mark UITableviewD
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCTableViewCell * cell = [[HomeCTableViewCell alloc] init];;
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    cell.name.text = dic[@"title"];
    cell.content.text = dic[@"content"];
    [cell.jbbutton addTarget:self action:@selector(check_jb:) forControlEvents:UIControlEventTouchUpInside];
    [cell.blackButton addTarget:self action:@selector(check_black:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.typeStr isEqualToString:@"我的帖子"]) {
//        [cell.jbbutton setTitle:@"删除" forState:UIControlStateNormal];
        cell.jbbutton.hidden = YES;
        cell.blackButton.hidden = YES;
    }
    
    cell.blackButton.tag = indexPath.row;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;//选中无效果]
    return cell;
    
}

- (void)check_jb:(UIButton *)button
{
    if ([self.typeStr isEqualToString:@"我的帖子"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除该贴子吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 10001;
        [alert show];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认举报该信息含有非法内容？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 1001;
        [alert show];
    }
    
}

- (void)check_black:(UIButton *)button
{
    if (![UserI defaultPlatform].isLogin) {
        [ProgressHUD showError:@"请先登录！！"];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"拉入黑名单后后将不显示该用户发表的所有帖子以及其评论信息，确认将该用户拉入黑名单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 1002+button.tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 10001) {
        [Helper goYC:^{
            
            
            
        } isdismiss:YES];
    } else if (buttonIndex == 1 && alertView.tag == 1001) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"请稍等..." Interaction:NO];
        });
        
        double delayInSeconds = (float)(1+arc4random()%99)/100  + 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            // code to be executed on the main queue after delay
            [ProgressHUD showSuccess:@"感谢您的举报，我们将进一步审查，如举报属实，将立即删除该信息！！"];
        });
    } else if (buttonIndex == 1)
    {
        int row = alertView.tag - 1002;
        
        [[UserI defaultPlatform].userblacklist addObject:self.dataArr[row][@"name"]];
        
        [[UserI defaultPlatform] saveList];
        
        NSLog(@"%@",[UserI defaultPlatform].userblacklist);
        
        [self addData];
        
        [Helper goYC:^{
            
            [self.tableView_type reloadData];
            
            [ProgressHUD showSuccess:@"拉入黑名单成功！"];
            
        } isdismiss:NO];
    }
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
