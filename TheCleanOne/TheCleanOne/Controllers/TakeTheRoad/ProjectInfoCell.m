//
//  ProjectInfoCell.m
//  TheCleanOne
//
//  Created by lihp on 15/8/15.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectInfoCell.h"

@interface ProjectInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ProjectInfoCell



- (void)setProjectInfo:(ProjectInfo *)projectInfo
{
    
    _projectInfo = projectInfo;
    NSLog(@"projectInfo:%@",_projectInfo);
    self.introLabel.text = projectInfo.title;
    self.contentLabel.text = projectInfo.introduction;
    
 
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *cellIdentifier = @"reuseIdentifier";
    ProjectInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectInfoCell" owner:nil options:nil] lastObject];
//    }
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
