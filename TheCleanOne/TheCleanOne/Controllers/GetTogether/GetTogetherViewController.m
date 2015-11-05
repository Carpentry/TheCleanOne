//
//  GetTogetherViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "GetTogetherViewController.h"
#import "ShowCell.h"
#import "ShowModel.h"

@interface GetTogetherViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *showModels;


@end





@implementation GetTogetherViewController

- (NSArray *)showModels
{
    if (_showModels == nil) {
        _showModels = [ShowModel models];
    }
    return _showModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToList:) name:popToListNotification object:NULL];
//
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}




#pragma mark --UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"reuseCellIdentifier";
//     ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[ShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }

    ShowCell *cell = [ShowCell cellWithTableView:tableView];
    return cell;
}

#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
