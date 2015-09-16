//
//  ProjectInfoCell.h
//  TheCleanOne
//
//  Created by lihp on 15/8/15.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectInfo.h"


@interface ProjectInfoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) ProjectInfo *projectInfo;
@end
