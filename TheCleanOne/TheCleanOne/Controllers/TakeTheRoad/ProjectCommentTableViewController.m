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
#import "CWStarRateView.h"

@interface ProjectCommentTableViewController ()
{
    CGFloat g_height;
    CGFloat ratingStarNum;
    CWStarRateView *rateV ;
}
@property (nonatomic, strong) ProjectComment *projectComment;
@property (nonatomic, strong) NSArray *projectCommentList;
@end

@implementation ProjectCommentTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"comment viewwillappear %lf",ratingStarNum);
    rateV.scorePercent = ratingStarNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 //   [self.tableView registerClass:[ProjectCommentCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectCommentCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.rowHeight = 80;
    self.tableView.tableHeaderView = [self headerView];
    self.projectComment = [[ProjectComment alloc] init];
    g_height = 100;
    
}



- (UIView *)headerView
{
    UIView *bgHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    rateV = [[CWStarRateView alloc] initWithFrame:CGRectMake(20, 10, self.view.bounds.size.width/2, 60) numberOfStars:5];
    rateV.clipsToBounds = YES;
    rateV.scorePercent = ratingStarNum;
    rateV.hasAnimation = YES;
    rateV.allowIncompleteStar = YES;
    [bgHeaderView addSubview:rateV];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, bgHeaderView.bounds.size.height, bgHeaderView.bounds.size.width, 0.5)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [bgHeaderView addSubview:lineV];
    
    return bgHeaderView;
}




- (NSString *)segmentTitle
{
    return @"评论";
}

//-(UIScrollView *)streachScrollView
//{
//    return self.tableView;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.projectCommentList.count;
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
        
        
        CGSize textMaxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, MAXFLOAT);
        CGSize textRealSize = [cell.projectComment.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
        g_height = textRealSize.height + 70;
    }

    NSLog(@"cell:%@\t%lu",cell.projectComment,indexPath.row);
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    return g_height;
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

- (void)projectCommentDetailInfo:(NSInteger )projectId
{
    HttpConnectToServer *hcts = [[HttpConnectToServer alloc] init];
    [hcts getEvaluationList:projectId andFrom:0 andTo:9];
    [hcts setCompletionBlock2:^(NSDictionary *dict) {
        if ([dict[@"flag"] intValue] == 1) {
            NSData *data = [dict[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //字典转模型
            ProjectCommentList *pcl = [[ProjectCommentList alloc] init];
            pcl.avgGrade = [tempDict[@"avgGrade"] doubleValue];
            ratingStarNum = pcl.avgGrade/5;
            pcl.count = [tempDict[@"count"] intValue];
            pcl.projectCommentList = [ProjectComment projectCommentWithArray:tempDict[@"list"]];
            self.projectCommentList = pcl.projectCommentList;
            
            NSLog(@"before comment %lf",pcl.avgGrade);

            [self.tableView reloadData];
         }
    }];
    
}

@end
