//
//  ProjectIntroHeaderView.h
//  TheCleanOne
//
//  Created by lihp on 15/9/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectInfo;

typedef void (^headerViewBlock)(BOOL open);

@interface ProjectIntroHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) ProjectInfo *projectInfo;
@property (nonatomic, copy) headerViewBlock  block;
@property (nonatomic, assign) NSInteger section;
//@property (nonatomic, assign) BOOL open;

- (void)setHeaderViewTitle:(NSString *)title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView andTitle:(NSString *)title andSection:(NSInteger)section;
@end
