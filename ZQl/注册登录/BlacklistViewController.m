//
//  BlacklistViewController.m
//  ZQl
//
//  Created by yudc on 2018/8/10.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "BlacklistViewController.h"
#import "BlackTableViewCell.h"
#import "UserI.h"
@interface BlacklistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView_blacklist;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString *idBlackTableViewCell = @"BlackTableViewCell";

@implementation BlacklistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"黑名单";
    
    [self initData];
    
    [self.view addSubview:self.tableView_blacklist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData
{
    self.dataArr = [UserI defaultPlatform].userblacklist;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UITableView *)tableView_blacklist
{
    if (!_tableView_blacklist) {
        _tableView_blacklist = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
//        [_tableView_blacklist registerNib:[UINib nibWithNibName:idBlackTableViewCell bundle:nil] forCellReuseIdentifier:idBlackTableViewCell];
        [_tableView_blacklist registerClass:[BlackTableViewCell class] forCellReuseIdentifier:idBlackTableViewCell];
        
        _tableView_blacklist.delegate = self;
        _tableView_blacklist.dataSource = self;
        
        _tableView_blacklist.tableFooterView = [UIView new];
        
    }
    return _tableView_blacklist;
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
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BlackTableViewCell * cell = [[BlackTableViewCell alloc] init];;

    
    cell.name.text = self.dataArr[indexPath.row];
    cell.btn_outblack.tag = indexPath.row;
    [cell.btn_outblack addTarget:self action:@selector(out_Black:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;//选中无效果]
    return cell;

}

- (void)out_Black:(UIButton *)btn
{
    [Helper goYC:^{
        [self.dataArr removeObjectAtIndex:btn.tag];
        [[UserI defaultPlatform] saveList];
        [self.tableView_blacklist reloadData];
        [ProgressHUD dismiss];
    } isdismiss:NO];
    
}

@end
