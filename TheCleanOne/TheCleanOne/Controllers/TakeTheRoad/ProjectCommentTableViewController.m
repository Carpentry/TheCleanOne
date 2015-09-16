//
//  ProjectCommentTableViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/8/14.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectCommentTableViewController.h"
#import "ProjectCommentList.h"
#import "ProjectCommentCell.h"
#import "ProjectComment.h"
#import "HttpConnectToServer.h"

@interface ProjectCommentTableViewController ()
@property (nonatomic, strong) ProjectComment *projectComment;
@property (nonatomic, strong) NSArray *projectCommentList;
@end

@implementation ProjectCommentTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
 //   [self.tableView registerClass:[ProjectCommentCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectCommentCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.rowHeight = 80;
    
    self.projectComment = [[ProjectComment alloc] init];
}



-(NSString *)segmentTitle
{
    return @"评论";
}

//-(UIScrollView *)streachScrollView
//{
//    return self.tableView;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ProjectCommentCell *cell = [ProjectCommentCell cellWithTableView:tableView];
    
    static NSString *cellIdentifier = @"reuseIdentifier";
    ProjectCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    

    
    if (cell == nil) {
        //     ProjectCommentCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectCommentCell" owner:nil options:nil] lastObject];
        [tableView registerNib:[UINib nibWithNibName:@"ProjectCommentCell"  bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    
    
    
    if (self.projectCommentList.count > indexPath.row) {
        NSLog(@"%@\t%lu",self.projectCommentList[indexPath.row],indexPath.row);
        cell.projectComment = self.projectCommentList[indexPath.row];
    }

    NSLog(@"cell:%@\t%lu",cell.projectComment,indexPath.row);
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(ProjectCommentCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.projectCommentList.count > indexPath.row) {
//        NSLog(@"%@\t%lu",self.projectCommentList[indexPath.row],indexPath.row);
//        cell.projectComment = self.projectCommentList[indexPath.row];
//    }
//    
//    NSLog(@"cell:%@\t%lu",cell.projectComment,indexPath.row);
//
//}

#pragma mark -ProjectCommentDelegate

- (void)projectCommentDetailInfo:(NSIndexPath *)indexPath
{
    HttpConnectToServer *hcts = [[HttpConnectToServer alloc] init];
    [hcts getEvaluationList:(indexPath.row+1) andFrom:0 andTo:9];
    [hcts setCompletionBlock2:^(NSDictionary *dict) {
        
        if ([dict[@"flag"] intValue] == 1) {
            NSData *data = [dict[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //字典转模型
            ProjectCommentList *pcl = [[ProjectCommentList alloc] init];
            pcl.avgGrade = [tempDict[@"avgGrade"] doubleValue];
            pcl.count = [tempDict[@"count"] intValue];
            pcl.projectCommentList = [ProjectComment projectCommentWithArray:tempDict[@"list"]];
            self.projectCommentList = pcl.projectCommentList;

            [self.tableView reloadData];
         }
    }];
    
}

@end
