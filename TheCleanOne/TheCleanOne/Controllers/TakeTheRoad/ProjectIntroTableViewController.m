//
//  ProjectIntroTableViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/8/14.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectIntroTableViewController.h"
#import "ProjectInfoCell.h"
#import "ProjectInfo.h"
#import "HttpConnectToServer.h"
#import "ProjectIntroFrameModel.h"
#import "ProjectIntroHeaderView.h"

@interface ProjectIntroTableViewController ()
{
    ProjectIntroFrameModel *model;
    ProjectIntroFrameModel *title;
    ProjectIntroFrameModel *introduction;
    ProjectIntroFrameModel *feature;
    ProjectIntroFrameModel *schedule;
    ProjectIntroFrameModel *expenses;
    ProjectIntroFrameModel *notice;
    ProjectIntroFrameModel *contact;
    NSArray *array;
    BOOL open;
}
@property (nonatomic, strong) ProjectInfo *projectInfo;

@end

@implementation ProjectIntroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"项目标题",@"项目简介",@"项目特色",@"行程安排",@"费用说明",@"项目须知",@"联系方式"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectInfoCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.rowHeight = 100;
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    TakeTheRoadViewController *ttrvc = [[TakeTheRoadViewController alloc] init];
//    ttrvc.delegate = self;
    
    title = [[ProjectIntroFrameModel alloc] init];
    introduction = [[ProjectIntroFrameModel alloc] init];
    feature = [[ProjectIntroFrameModel alloc] init];
    schedule = [[ProjectIntroFrameModel alloc] init];
    expenses = [[ProjectIntroFrameModel alloc] init];
    notice = [[ProjectIntroFrameModel alloc] init];
    contact = [[ProjectIntroFrameModel alloc] init];


    
}

- (void)viewWillAppear:(BOOL)animated
{
    title.open = 1;
    introduction.open = 1;
    feature.open = 1;
    schedule.open = 1;
    expenses.open = 1;
    notice.open = 1;
    contact.open = 1;
    [self.tableView reloadData];
}


- (NSString *)segmentTitle
{
    return @"介绍";
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return title.open ? 1 :0;
    } else if (section == 1){
        return introduction.open ? 1 :0;
    } else if (section == 2){
        return feature.open ? 1 :0;
    } else if (section == 3){
        return schedule.open ? 1 :0;
    } else if (section == 4){
        return expenses.open ? 1 :0;
    } else if (section == 5){
        return notice.open ? 1 :0;
    } else if (section == 6){
        return contact.open ? 1 :0;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *cellIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.lineBreakMode= NSLineBreakByCharWrapping;
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    
    if (indexPath.section == 0) {//项目标题
        cell.textLabel.text = self.projectInfo.title;
        [title adaptProjectIntroFrameModel:self.projectInfo.title];
    }else if (indexPath.section == 1){//项目简介
        cell.textLabel.text = self.projectInfo.introduction;
        [introduction adaptProjectIntroFrameModel:self.projectInfo.introduction];
    }else if (indexPath.section == 2){//项目特色
        cell.textLabel.text = self.projectInfo.feature;
        [feature adaptProjectIntroFrameModel:self.projectInfo.feature];
    }else if (indexPath.section == 3){//行程安排
        cell.textLabel.text = self.projectInfo.schedule;
        [schedule adaptProjectIntroFrameModel:self.projectInfo.schedule];
    }else if (indexPath.section == 4){//费用说明
        cell.textLabel.text = self.projectInfo.expenses;
        [expenses adaptProjectIntroFrameModel:self.projectInfo.expenses];
    }else if (indexPath.section == 5){//项目须知
        cell.textLabel.text = self.projectInfo.notice;
        [notice adaptProjectIntroFrameModel:self.projectInfo.notice];
    }else if (indexPath.section == 6){//联系方式
        cell.textLabel.text = self.projectInfo.contact;
        [contact adaptProjectIntroFrameModel:self.projectInfo.contact];
    }else{
        NSLog(@"%s failed",__func__);
    }

    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return title.textFieldF.size.height;
    } else if (indexPath.section == 1){
        return introduction.textFieldF.size.height;
    } else if (indexPath.section == 2){
        return feature.textFieldF.size.height;
    } else if (indexPath.section == 3){
        return schedule.textFieldF.size.height;
    } else if (indexPath.section == 4){
        return expenses.textFieldF.size.height;
    } else if (indexPath.section == 5){
        return notice.textFieldF.size.height;
    } else if (indexPath.section == 6){
        return contact.textFieldF.size.height;
    }
    return model.textFieldF.size.height;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProjectIntroHeaderView* header = [ProjectIntroHeaderView headerViewWithTableView:tableView andTitle:array[section] andSection:section];
    [header setHeaderViewTitle:array[section]];
    header.projectInfo = self.projectInfo;
//    header.block = ^(BOOL isOpen){
//        open = isOpen;
//        [self.tableView reloadData];
//    };
    if (section == 0) {
        header.block = ^(BOOL isOpen){
            title.open = isOpen;
            NSLog(@"title:%d",title.open);
            [self.tableView reloadData];
        };
    }else if (section == 1){
        header.block = ^(BOOL isOpen){
            introduction.open = isOpen;
            [self.tableView reloadData];
        };
    }else if (section == 2){
        header.block = ^(BOOL isOpen){
            feature.open = isOpen;
            [self.tableView reloadData];
        };
    }else if (section == 3){
        header.block = ^(BOOL isOpen){
            schedule.open = isOpen;
            [self.tableView reloadData];
        };
    }else if (section == 4){
        header.block = ^(BOOL isOpen){
            expenses.open = isOpen;
            [self.tableView reloadData];
        };
    }else if (section == 5){
        header.block = ^(BOOL isOpen){
            notice.open = isOpen;
            [self.tableView reloadData];
        };
    }else if (section == 6){
        header.block = ^(BOOL isOpen){
            contact.open = isOpen;
            [self.tableView reloadData];
        };
    }

    return header;
}

#pragma mark - ProjectIntroDelegate
- (void)projectDetailInfo:(ProjectInfo *)projectInfo andImages:(NSArray *)imgArr
{
    
    NSLog(@"projectDetailInfo:%s",__func__);
 //   self.projectInfo = [[ProjectInfo alloc] init];
    self.projectInfo = projectInfo;
    [self.tableView reloadData];

}




@end
