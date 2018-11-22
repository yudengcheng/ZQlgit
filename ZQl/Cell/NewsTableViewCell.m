//
//  NewsTableViewCell.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.title.textColor = MainColor;
    self.name.textColor = MainQianColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (UILabel *)title
//{
//    if (!_title) {
//        _title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Screen.width - 30, 25)];
//        _title.font = [UIFont systemFontOfSize:25];
//        _title.textColor = MainColor;
//    }
//    return _title;
//}
//
//- (UILabel *)name
//{
//    if (!_name) {
//        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 38, Screen.width - 30, 15)];
//        _name.textAlignment = 2;
//        _name.font = [UIFont systemFontOfSize:12];
//        _name.textColor = MainColor;
//        
//    }
//    return _name;
//}
//
//- (UILabel *)content
//{
//    if (!_content) {
//        _content = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, Screen.width - 30, 25)];
//        _content.font = [UIFont systemFontOfSize:15];
//        _content.textColor = MainColor;
//    }
//    return _content;
//}


@end
