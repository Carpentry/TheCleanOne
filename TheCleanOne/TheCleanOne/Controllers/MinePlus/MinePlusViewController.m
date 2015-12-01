//
//  MinePlusViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "MinePlusViewController.h"
#import "EaseUserHeaderView.h"
#import "UIScrollView+APParallaxHeader.h"
#import "FirstPageViewController.h"
#import "MyInfomationViewController.h"
#import "Masonry.h"


@interface MinePlusViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EaseUserHeaderView *headerView;
@property (strong, nonatomic) FirstPageViewController *mainVC;
@end

@implementation MinePlusViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.headerView updateData];
//    [self.mainVC createMinePlusNavigationBar:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [[User alloc] init];
    user.name = @"李岳龙";
    _curUser = user;
    _headerView = [EaseUserHeaderView userHeaderViewWithUser:_curUser image:[UIImage imageNamed:@"icon"]];
    [_tableView addParallaxWithView:_headerView andHeight:CGRectGetHeight(_headerView.frame)];
    
    titleArr = [NSArray arrayWithObjects:@"详细信息",@"我的消息",@"我的项目",@"我的话题", nil];

}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            MyInfomationViewController *myInfoVC = [[MyInfomationViewController alloc] init];
            [self.navigationController pushViewController:myInfoVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
