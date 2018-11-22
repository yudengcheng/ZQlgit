//
//  HomeViewController.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeCTableViewCell.h"
#import "UserViewController.h"
#import "MJRefresh.h"
#import "LocalData.h"
#import "UserI.h"
#import "LoginViewController.h"
#import "NewsViewController.h"
#import "SDCycleScrollView.h"
#import "TypeViewController.h"
#import "CreateViewController.h"
#import <LYWV/NetWork.h>
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SDCycleScrollViewDelegate>
{
    NSMutableArray *listArr;
    NSArray *listBtnArr;
    int page;
}
@property (strong, nonatomic) UITableView *homeTableview;
@end

static NSString * ideHomeCTableViewCell = @"HomeCTableViewCell";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arrlist = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"http://pglib.oss-cn-hangzhou.aliyuncs.com/100/otherL.plist"]];
    
    [LocalData defaultPlatform].osslist = arrlist;
    [[LocalData defaultPlatform] initData];
    [self initData];
    [Helper goYC:^{
        [self layout];
        
    } isdismiss:YES];

    
    page = 1;
    
    self.title = @"首页";
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addData];
    
    static int Refreshnum = 0;
    
    if (Refreshnum != 0) {
        
        [self.homeTableview reloadData];
        
    } else
    {
        Refreshnum = Refreshnum+1;
    }

}

- (void)addData
{
    [listArr removeAllObjects];
    
    int count = page *8;
    
    if (count > [LocalData defaultPlatform].Homelist.count) {
        
        count = [LocalData defaultPlatform].Homelist.count;
        
    }
    
    for (int i = 0; i < count; i++) {
        
        if (![[UserI defaultPlatform].userblacklist containsObject:[LocalData defaultPlatform].Homelist[i][@"name"]]) {
            
            [listArr addObject:[LocalData defaultPlatform].Homelist[i]];
        } else
        {
           NSLog(@"%@",[LocalData defaultPlatform].Homelist[i][@"name"]);
        }
    }
}

-(void)initData
{
    listArr = [[NSMutableArray alloc] init];
    listBtnArr = [LocalData defaultPlatform].typelist;
    
    self.homeTableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:self.homeTableview];
    
//    [self.homeTableview registerNib:[UINib nibWithNibName:ideHomeCTableViewCell bundle:nil] forCellReuseIdentifier:ideHomeCTableViewCell];
    [self.homeTableview registerClass:[HomeCTableViewCell class] forCellReuseIdentifier:ideHomeCTableViewCell];
    
    self.homeTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"请稍等..." Interaction:NO];
        });
        
        double delayInSeconds = (float)(1+arc4random()%99)/100  + 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            // code to be executed on the main queue after delay
            [ProgressHUD dismiss];
            [self.homeTableview.mj_header endRefreshing];
        });
        
    }];
    
    self.homeTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [Helper goYC:^{
            page++;
            
            [self addData];
            
            [self.homeTableview.mj_footer endRefreshing];
            
            [self.homeTableview reloadData];
            
        } isdismiss:YES];
        
    }];
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen.width, Screen.width * 3/8)];
    
    NSMutableArray *listImageArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        
        [listImageArr addObject:[NSString stringWithFormat:@"home_jpg_%d.jpg",i]];
    }
     
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen.width, Screen.width * 3/8) shouldInfiniteLoop:YES imageNamesGroup:listImageArr];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headerview addSubview:cycleScrollView];
    
    int w = 5;
    int h = 0;
    int iw = 0;
    int btnw = (Screen.width-120) / 5;
    int height = 0;
    
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    for (int i = 0; i < listBtnArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + (btnw +20) * iw,Screen.width * 3/8+ 10 + (btnw + 20)* h , btnw, btnw)];
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
        btn.backgroundColor  =[UIColor whiteColor];
        
        LRViewBorderRadius(btn, btnw/2, 1, MainQianColor);
        
        btn.tag = i+1;
        [btn setTitle:listBtnArr[i] forState:UIControlStateNormal];
        [headerview addSubview:btn];
        if (iw == w-1) {
            iw = 0;
            h = h +1;
        }else
        {
            iw = iw +1;
        }
        [btn addTarget:self action:@selector(TypeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        height = CGRectGetMaxY(btn.frame);
    }
    
    headerview.frame = CGRectMake(0, 0, Screen.width, height+ 20);

    
    self.homeTableview.tableHeaderView = headerview;
}

-(void)layout
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:self action:@selector(FTAction)];
    
    
    self.homeTableview.delegate =self;
    self.homeTableview.dataSource = self;
    self.homeTableview.tableFooterView = [[UIView alloc] init];
    self.homeTableview.backgroundColor =BackGroundColor;
}

#pragma mark UITableviewD
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 80;
    }else
    {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    HomeCTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ideHomeCTableViewCell forIndexPath:indexPath];
    HomeCTableViewCell * cell = [[HomeCTableViewCell alloc] init];
    
    NSDictionary *dic = listArr[indexPath.row];
    
    cell.name.text = dic[@"title"];
    cell.content.text = dic[@"content"];
    [cell.jbbutton addTarget:self action:@selector(check_jb:) forControlEvents:UIControlEventTouchUpInside];
    [cell.blackButton addTarget:self action:@selector(check_black:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UserI defaultPlatform].isLogin) {
        
        if ([dic[@"name"] isEqualToString:[UserI defaultPlatform].loginName] ) {
            cell.jbbutton.hidden = YES;
            cell.blackButton.hidden = YES;
        }else
        {
            cell.jbbutton.hidden = NO;
            cell.blackButton.hidden = NO;
        }
        
    }else
    {
        cell.jbbutton.hidden = NO;
        cell.blackButton.hidden = NO;
    }
    
    cell.blackButton.tag = indexPath.row;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;//选中无效果]
    return cell;
    //    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Helper goYC:^{
        NSDictionary *dic = listArr[indexPath.row];
        
        NewsViewController *news = [[NewsViewController alloc] init];
        news.datadic = dic;
        news.Row = indexPath.row;
        [self.navigationController pushViewController:news animated:YES];
    } isdismiss:YES];
    
}

- (void)loginOrOut
{
    if (![UserI defaultPlatform].isLogin) {
        [Helper login_go:self];
    } else
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        alert.tag = 1000;
//        [alert show];
        UserViewController *user = [[UserViewController alloc] init];
        [self.navigationController pushViewController:user animated:YES];
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

- (void)TypeAction:(UIButton *)button
{
    TypeViewController *type = [[TypeViewController alloc] init];
    type.typeStr = [NSString stringWithFormat:@"%ld",(long)button.tag];
    type.title = listBtnArr[button.tag-1];
    [self.navigationController pushViewController:type animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 1000) {
        [[UserI defaultPlatform] loginOut];
        [self addData];
        [self.homeTableview reloadData];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"去登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginOrOut)];
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
        
        [[UserI defaultPlatform].userblacklist addObject:listArr[row][@"name"]];
        
        [[UserI defaultPlatform] saveList];
        
        NSLog(@"%@",[UserI defaultPlatform].userblacklist);
        
        [self addData];
        
        [Helper goYC:^{
        
            [self.homeTableview reloadData];
            
            [ProgressHUD showSuccess:@"拉入黑名单成功！"];
            
        } isdismiss:NO];
    }
}

- (void)FTAction
{
    if (![UserI defaultPlatform].isLogin) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    } else
    {
        CreateViewController *create = [CreateViewController new];
        [self.navigationController pushViewController:create animated:YES];
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [Helper goYC:^{
        
        NSDictionary *dic = [LocalData defaultPlatform].Homelist[index];
        
        BOOL isHMD = NO;
        
        for (int i = 0; i < [UserI defaultPlatform].userblacklist.count; i++) {
            
            if ([dic[@"name"] isEqualToString:[UserI defaultPlatform].userblacklist[i]]) {
                isHMD = YES;
                break;
            }
            
        }
        if (isHMD) {
            
            [ProgressHUD showError:@"已加入黑名单!"];
            
        } else
        {
            [ProgressHUD dismiss];
            NewsViewController *news = [[NewsViewController alloc] init];
            news.datadic = dic;
            news.Row = index;
            [self.navigationController pushViewController:news animated:YES];
        }

    } isdismiss:NO];
    
    
}



@end

