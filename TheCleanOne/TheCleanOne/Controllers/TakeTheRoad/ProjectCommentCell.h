//
//  ProjectCommentCell.h
//  TheCleanOne
//
//  Created by lihp on 15/8/15.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectComment;

@interface ProjectCommentCell : UITableViewCell
@property (nonatomic, strong) ProjectComment *projectComment;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteBtnAction:(id)sender;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
