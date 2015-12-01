//
//  SettingViewController.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/17.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "SettingViewController.h"
#import "UITools.h"
#import "Masonry.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *myTableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"设置";
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [UITools setNavigationState:@"返回" leftAction:@selector(backAction) rightBtnStr:nil rightAction:nil rightBtnStateSelected:nil titleStr:@"设置" forViewController:self];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    switch (section) {
        case 0:
            row = 3;
            break;
        default:
            row = 2;
            break;
    }
    return row;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"密码修改";
                    break;
                case 1:
                    cell.textLabel.text = @"消息设置";
                    break;
                default:
                    cell.textLabel.text = @"清空缓存";
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"意见反馈";
                    break;
                default:
                    cell.textLabel.text = @"去评分";
                    break;
            }
            break;
        default:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"关于";
                    break;
                default:
                    cell.textLabel.text = @"版本号";
                    break;
            }
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
