//
//  ShowCell.m
//  TheCleanOne
//
//  Created by lihp on 15/8/13.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ShowCell.h"
#import "ShowModel.h"

@interface ShowCell()
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end


@implementation ShowCell

- (void)setShowModel:(ShowModel *)showModel
{
    _showModel = showModel;
    self.nameView.text = showModel.userName;
    self.textView.text = showModel.title;
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"reuseCellIdentifier";
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSLog(@"加载xib");

        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShowCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
