//
//  NewsViewController.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "HomeCTableViewCell.h"
#import "MJRefresh.h"
#import "Helper.h"
#import "UserI.h"
#import "UUInputFunctionView.h"
#import "LocalData.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UUInputFunctionViewDelegate>
{
    UUInputFunctionView *IFView;
}
@property (strong, nonatomic) UITableView *tableviewnews;
@property (strong, nonatomic) UIView *footer_view;
@property (nonatomic, strong) NSMutableArray *listPL;
@end
static NSString * ideHomeCTableViewCell = @"HomeCTableViewCell";
static NSString * ideNewsTableViewCell = @"NewsTableViewCell";
@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [IFView removedealloc];
}

- (void)addData
{
    if (self.listPL == nil) {
        self.listPL = [[NSMutableArray alloc] init];
    } else
    {
        [self.listPL removeAllObjects];
    }
    for (NSDictionary *pldic in self.datadic[@"homepl"]) {
        
        if (![[UserI defaultPlatform].userblacklist containsObject:pldic[@"name"]]) {
            
            [self.listPL  addObject:pldic];
            
        }
        
    }
    
}

-(void)initData
{
    [self addData];
    
    self.title = self.datadic[@"title"];
    
    self.tableviewnews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen.width, Screen.height-60)];
    
    [self.view addSubview:self.tableviewnews];
    
    [self.tableviewnews registerClass:[HomeCTableViewCell class] forCellReuseIdentifier:ideHomeCTableViewCell];
//    [self.tableviewnews registerNib:[UINib nibWithNibName:ideHomeCTableViewCell bundle:nil] forCellReuseIdentifier:ideHomeCTableViewCell];
    [self.tableviewnews registerNib:[UINib nibWithNibName:ideNewsTableViewCell bundle:nil] forCellReuseIdentifier:ideNewsTableViewCell];
    
    self.tableviewnews.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"请稍等..." Interaction:NO];
        });
        
        double delayInSeconds = (float)(1+arc4random()%99)/100  + 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            // code to be executed on the main queue after delay
            [ProgressHUD dismiss];
            [self.tableviewnews.mj_header endRefreshing];
        });
        
    }];
    
}

-(void)layout
{
    self.footer_view = [[UIView alloc] initWithFrame:CGRectMake(0, Screen.height-100, Screen.width, 40)];
    
    [self.view addSubview:self.footer_view];
    
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    
    IFView.delegate = self;
    
    [self.footer_view addSubview:IFView];
    
    
    self.tableviewnews.delegate =self;
    self.tableviewnews.dataSource = self;
    self.tableviewnews.tableFooterView = [[UIView alloc] init];
    self.tableviewnews.backgroundColor =BackGroundColor;
    
}

#pragma mark UITableviewD
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.listPL.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return [Helper calculateRowHeight:self.datadic[@"content"] fontSize:15.0f] + 70;
    }else
    {
        NSDictionary *dic = self.listPL[indexPath.row];
        return [Helper calculateRowHeight:dic[@"content"] fontSize:15.0f] + 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ideNewsTableViewCell forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;//选中无效果]
        
        cell.title.text = self.datadic[@"title"];
        cell.content.text = self.datadic[@"content"];
        cell.name.text = [NSString stringWithFormat:@"作者:%@",self.datadic[@"name"]];
        
        return cell;
    } else
    {
        HomeCTableViewCell * cell = [[HomeCTableViewCell alloc] init];
        cell.content.numberOfLines = 0;
        NSDictionary *dic = self.listPL[indexPath.row];
        
        cell.name.text = dic[@"name"];
        cell.content.text = dic[@"content"];
        [cell.jbbutton addTarget:self action:@selector(check_jb:) forControlEvents:UIControlEventTouchUpInside];
        [cell.blackButton addTarget:self action:@selector(check_black:) forControlEvents:UIControlEventTouchUpInside];
        cell.blackButton.tag = indexPath.row;
        
        if ([dic[@"name"] isEqualToString:[UserI defaultPlatform].loginName]) {
            cell.jbbutton.hidden = YES;
            cell.blackButton.hidden = YES;
        } else
        {
            cell.jbbutton.hidden = NO;
            cell.blackButton.hidden = NO;
        }
        
        return cell;
    }
    
}

- (void)check_jb:(UIButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认举报该信息含有非法内容？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 1001;
    [alert show];
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
    if (buttonIndex == 1 && alertView.tag == 1001) {
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
        [Helper goYC:^{
            
            int row = alertView.tag - 1002;
            
            [[UserI defaultPlatform].userblacklist addObject:self.listPL[row][@"name"]];
            
            [[UserI defaultPlatform] saveList];
            
            if ([self.listPL[row][@"name"] isEqualToString:self.datadic[@"name"]]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            } else
            {
                [self addData];
                
                [self.tableviewnews reloadData];
            }
            
            [ProgressHUD showSuccess:@"拉入黑名单成功！"];
        } isdismiss:NO];
    }
}

- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    if (![UserI defaultPlatform].isLogin) {
        [ProgressHUD showError:@"请先登录！"];
        return;
    }
    
    if (message.length == 0) {
        return [ProgressHUD showError:@"请输入评论"];
    }
    
    for (int i = 0; i < [LocalData defaultPlatform].Homelist.count; i++) {
        NSMutableDictionary *dic = [LocalData defaultPlatform].Homelist[i];
        if ([dic[@"name"] isEqualToString:self.datadic[@"name"]] && [dic[@"title"] isEqualToString:self.datadic[@"title"]]) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"homepl"]];
            
            [arr addObject:@{@"name":[UserI defaultPlatform].loginName,
                             @"content":message
                             }];
            
            [self.listPL addObject:@{@"name":[UserI defaultPlatform].loginName,
                                     @"content":message
                                     }];
            
            [dic setObject:arr forKey:@"homepl"];
            
            [[LocalData defaultPlatform].Homelist removeObjectAtIndex:i];
            [[LocalData defaultPlatform].Homelist insertObject:dic atIndex:i];
            
            [[LocalData defaultPlatform] saveList];
            
            break;
        }
        
    }
    
    [Helper goYC:^{
        [self.tableviewnews reloadData];
    } isdismiss:YES];
    
    
    
}


@end
