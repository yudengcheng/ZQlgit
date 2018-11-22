//
//  BlackTableViewCell.m
//  ZQl
//
//  Created by yudc on 2018/8/16.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "BlackTableViewCell.h"

@implementation BlackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)init
{
    if (self = [super init]) {
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.btn_outblack];
    }
    return self;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
        _name.font = [UIFont systemFontOfSize:20];
        _name.textColor = MainColor;
        
    }
    return _name;
}


- (UIButton *)btn_outblack
{
    if (!_btn_outblack) {
        _btn_outblack = [[UIButton alloc] initWithFrame:CGRectMake(Screen.width - 115, 10, 100, 30)];
        _btn_outblack.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_btn_outblack setTitleColor:MainColor forState:UIControlStateNormal];
        [_btn_outblack setTitle:@"举报" forState:UIControlStateNormal];
    }
    return _btn_outblack;
}
@end
