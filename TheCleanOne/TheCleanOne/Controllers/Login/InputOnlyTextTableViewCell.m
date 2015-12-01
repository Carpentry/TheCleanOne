//
//  InputOnlyTextTableViewCell.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/18.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "InputOnlyTextTableViewCell.h"

@implementation InputOnlyTextTableViewCell 

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr
{
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr ? phStr :@"" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    self.textField.text = valueStr;
}

#pragma mark - UIView
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews is called!");
    self.backgroundColor = [UIColor clearColor];
    self.textField.font = [UIFont systemFontOfSize:17];
    self.textField.textColor = [UIColor whiteColor];
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(kLoginPaddingLeftWidth, 43.5, ScreenWidth-2*kLoginPaddingLeftWidth, 0.5)];
    _lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.contentView addSubview:_lineView];


    
}

- (IBAction)editDidBegin:(id)sender {
}

- (IBAction)editDidEnd:(id)sender {
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (IBAction)textValueChange:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (IBAction)btnClicked:(id)sender {
    self.textField.text = @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end
