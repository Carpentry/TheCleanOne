//
//  ProjectCommentCell.m
//  TheCleanOne
//
//  Created by lihp on 15/8/15.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectCommentCell.h"
#import "ProjectComment.h"
@interface ProjectCommentCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ProjectCommentCell


- (void)setProjectComment:(ProjectComment *)projectComment
{
    _projectComment = projectComment;
    _nameLabel.text = projectComment.userName;
    _contentLabel.text = projectComment.content;
    _dateLabel.text = projectComment.date;
    
    if ([projectComment.userName isEqualToString:SHARE.userInfo.nickname]) {
        _deleteBtn.hidden = NO;
    }else{
        _deleteBtn.hidden = YES;
    }
}



- (IBAction)deleteBtnAction:(id)sender {
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView 
{
    

    static NSString *cellIdentifier = @"reuseIdentifier";
    ProjectCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
//     ProjectCommentCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCommentCell" owner:nil options:nil] lastObject];
        [tableView registerNib:[UINib nibWithNibName:@"ProjectCommentCell"  bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
