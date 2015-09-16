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

@interface ProjectIntroTableViewController ()
@property (nonatomic, strong) ProjectInfo *projectInfo;

@end

@implementation ProjectIntroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectInfoCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    TakeTheRoadViewController *ttrvc = [[TakeTheRoadViewController alloc] init];
//    ttrvc.delegate = self;
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"reuseIdentifier";
//    ProjectInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ProjectInfoCell *cell = [ProjectInfoCell cellWithTableView:tableView];
//        cell.projectInfo.title = self.projectInfo.title;
//        cell.projectInfo.introduction = self.projectInfo.introduction;
        
        cell.projectInfo = self.projectInfo;
    

    return cell;
}


#pragma mark - ProjectIntroDelegate
- (void)projectDetailInfo:(ProjectInfo *)projectInfo andImages:(NSArray *)imgArr
{
    
    NSLog(@"projectDetailInfo:%s",__func__);
 //   self.projectInfo = [[ProjectInfo alloc] init];
    self.projectInfo = projectInfo;
    [self.tableView reloadData];

}

//- (void)projectDetailInfo:(NSIndexPath *)indexPath
//{
//    __block ProjectInfo *tempProjectInfo = [[ProjectInfo alloc] init];
//
//    NSLog(@"****recv indexPath:%lu",indexPath.row);
//        HttpConnectToServer *hcts = [[HttpConnectToServer alloc] init];
//        [hcts getProjectInfo:(indexPath.row + 1) andUserId:0];
//        [hcts setCompletionBlock2:^(NSDictionary *dict) {
//
//            
//            if ([dict[@"flag"] intValue] == 1) {
//                
//                NSData *data = [dict[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
//                NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                tempProjectInfo.title = tempDict[@"title"];
//                tempProjectInfo.introduction = tempDict[@"introduction"];
//                tempProjectInfo.feature = tempDict[@"feature"];
//                tempProjectInfo.schedule = tempDict[@"schedule"];
//                tempProjectInfo.expenses = tempDict[@"expenses"];
//                tempProjectInfo.notice = tempDict[@"notice"];
//                tempProjectInfo.contact = tempDict[@"contact"];
//                self.projectInfo = tempProjectInfo;
//                [self.tableView reloadData];
//            }
//
//        }];
//    
//    
//         
//}
@end
