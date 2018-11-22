//
//  HomeCTableViewCell.m
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import "HomeCTableViewCell.h"

@implementation HomeCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //    self.content.textColor = MainColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)init
{
    if (self = [super init]) {
        [self.contentView addSubview:self.jbbutton];
        [self.contentView addSubview:self.blackButton];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.content];
    }
    return self;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Screen.width - 150, 25)];
        _name.font = [UIFont systemFontOfSize:20];
        _name.textColor = MainColor;
        
    }
    return _name;
}

- (UIButton *)jbbutton
{
    if (!_jbbutton) {
        _jbbutton = [[UIButton alloc] initWithFrame:CGRectMake(Screen.width - 65, 8, 50, 30)];
        _jbbutton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_jbbutton setTitleColor:MainColor forState:UIControlStateNormal];
        [_jbbutton setTitle:@"举报" forState:UIControlStateNormal];
    }
    return _jbbutton;
}

- (UIButton *)blackButton
{
    if (!_blackButton) {
        _blackButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen.width - 123, 8, 50, 30)];
        _blackButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_blackButton setTitleColor:MainQianColor forState:UIControlStateNormal];
        [_blackButton setTitle:@"黑名单" forState:UIControlStateNormal];
    }
    return _blackButton;
}

- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, Screen.width - 30, 25)];
        _content.font = [UIFont systemFontOfSize:15];        
    }
    return _content;
}

@end
