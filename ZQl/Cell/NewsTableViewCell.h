//
//  NewsTableViewCell.h
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *name;
@end
