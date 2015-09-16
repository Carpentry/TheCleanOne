//
//  ShowCell.h
//  TheCleanOne
//
//  Created by lihp on 15/8/13.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowModel;

@interface ShowCell : UITableViewCell

@property (nonatomic, strong) ShowModel *showModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
