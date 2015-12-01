//
//  TitleValueTableViewCell.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/21.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "TitleValueTableViewCell.h"

@interface TitleValueTableViewCell ()
@property (copy, nonatomic) NSString *title,*value;
@end

@implementation TitleValueTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    _titleLabel.text = _title;
    _valueLabel.text = _value;
}

- (void)setTitle:(NSString *)title andValue:(NSString *)value
{
    self.title = title;
    self.value = value;
}

@end
