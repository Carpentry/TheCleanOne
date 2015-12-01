//
//  TakeTheRoadViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "TakeTheRoadViewController.h"
#import "HttpConnectToServer.h"
#import "UIImageView+WebCache.h"
#import "ARSegmentPageController.h"
//#import "TableViewController.h"
//#import "CollectionViewController.h"
//#import "CustomHeaderViewController.h"
#import "ProjectIntroTableViewController.h"
#import "ProjectCommentTableViewController.h"
#import "ProjectSummary.h"
#import "LYLHttpTool.h"
#import "UIImage+ImageEffects.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ProjectInfo.h"
#import "ImageBean.h"
#import "UITools.h"
#define CELLHEIGHT 120

@interface TakeTheRoadViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    HttpConnectToServer *hcts;
}
@property (nonatomic, strong) ARSegmentPageController *paper;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIImage *blurImage;
@property (nonatomic, strong) NSMutableArray *summaries;
@end

@implementation TakeTheRoadViewController


- (NSArray *)summaries
{
    if (_summaries == nil) {
        _summaries = [NSMutableArray array];
    }
    return _summaries;
}



- (void)upAction
{
    [self loadProjectSummary:self.summaries.count andTo:self.summaries.count+9];
}

- (void)downAction
{
    [self.tableView.header endRefreshing];
}



- (void)viewDidLoad {
    [super viewDidLoad];
  

    
//tableView设置
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    //self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downAction)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upAction)];
    //tableview返回后，顶部有空白，一直没有解决，加进子视图后，空白消失，真特么神奇
    [self.view addSubview:self.tableView];

//下载项目列表
    [self loadProjectSummary:0 andTo:9];

    
    hcts = [[HttpConnectToServer alloc] init];
    
//    self.defaultImage = [UIImage imageNamed:@"listdownload.jpg"];
//    self.blurImage = [[UIImage imageNamed:@"listdownload.jpg"] applyDarkEffect];
    
    
    

    ProjectIntroTableViewController *table = [[ProjectIntroTableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    
    ProjectCommentTableViewController *table1 = [[ProjectCommentTableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    
    
    self.delegate = table;
    self.commentDelegate  = table1;
    
    
    ARSegmentPageController *pager = [[ARSegmentPageController alloc] init];
    [pager setViewControllers:@[table,table1]];
//    [pager setViewControllers:@[intro,comment]];
    pager.freezenHeaderWhenReachMaxHeaderHeight = YES;
    //    pager.segmentMiniTopInset = 64;
    self.paper = pager;
    
    
    self.proIntroDelegate = pager;
    
  //  [self.paper addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)loadProjectSummary:(NSInteger)fromNum andTo:(NSInteger)toNum
{
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/GetProjectList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInteger:fromNum],@"from",[NSNumber numberWithInteger:toNum],@"to",nil];
    [LYLHttpTool GET:path parameters:param success:^(id responseObject) {
        if ([responseObject[@"flag"] intValue] == 1) {
            
            [self.tableView.footer endRefreshing];
            //获取字典数组
            NSString *str = responseObject[@"content"];
            NSData  *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
//            NSArray *contents = (NSMutableArray *)[ProjectSummary objectArrayWithKeyValuesArray:dictArr];
            NSArray *contents = [ProjectSummary projectSummaries:dictArr];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.summaries.count, contents.count)];
            [self.summaries insertObjects:contents atIndexes:indexSet];
            [self.tableView reloadData];
            NSLog(@"~~%@",self.summaries);
        }else{
            NSLog(@"recv failed");
        }

        
    } failure:^(NSError *error) {
        NSLog(@"%s:%@",__func__,error);
    }];
    
}


- (void)loadProjectInfo:(NSInteger)getProjectId andUserId:(NSInteger)userId
{
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/GetProjectInfo"];

    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInteger:getProjectId],@"id",[NSNumber numberWithInteger:userId],@"userId",nil];
    [LYLHttpTool GET:path parameters:param success:^(id responseObject) {
        if ([responseObject[@"flag"] intValue] == 1) {
            NSString *str = responseObject[@"content"];
            NSData  *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            ProjectInfo *proInfo = [ProjectInfo objectWithKeyValues:dict];
            NSArray *imgArr = (NSMutableArray *)[ImageBean objectArrayWithKeyValuesArray:dict[@"images"]];
            if ([self.delegate respondsToSelector:@selector(projectDetailInfo: andImages:)]){
                NSLog(@"tableDelegate is called");
                [self.delegate projectDetailInfo:proInfo andImages:imgArr];
            }
            
            if ([self.proIntroDelegate respondsToSelector:@selector(projectDetailInfo:andImages:)]) {
                NSLog(@"proIntroDelegate is called");
                [self.proIntroDelegate projectDetailInfo:proInfo andImages:imgArr];
            }
            
            
            //防止多次push same viewController
            if (![self.navigationController.topViewController isKindOfClass:[ARSegmentPageController class]]) {

                //是否已收藏此项目
                if (proInfo.favorite == 1) {
                    self.paper.isCollect = YES;
                } else {
                    self.paper.isCollect = NO;
                }
                self.paper.userId = userId;
                self.paper.projectId = getProjectId;
                
                
                [self.navigationController pushViewController:self.paper animated:YES];
            }

        }else{
            NSLog(@"recv failed");
        }
    } failure:^(NSError *error) {
        NSLog(@"%s:%@",__func__,error);
    }];
    
}


- (void)loadComment:(NSInteger)getProjectId
{
    if ([self.commentDelegate respondsToSelector:@selector(projectCommentDetailInfo:)]) {
        [self.commentDelegate projectCommentDetailInfo:getProjectId];
    }
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.summaries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"reuseCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIImageView *cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,CELLHEIGHT)];

        
        cellImageView.tag = 101;
        [cell.contentView addSubview:cellImageView];
    }
    

    ProjectSummary *ps = [[ProjectSummary alloc] init];
    ps = self.summaries[indexPath.row];
    UIImageView *cellImageView = (UIImageView *)[cell.contentView viewWithTag:101];
    [cellImageView sd_setImageWithURL:(NSURL *)ps.uri placeholderImage:[UIImage imageNamed:@"icon"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"didSelectRowAtIndexPath is called");

    //开始调用获取相信信息接口，对项目详细内容进行展示
//    if ([self.delegate respondsToSelector:@selector(projectDetailInfo:)]){
//        [self.delegate projectDetailInfo:indexPath];
//    }

    

    ProjectSummary *ps = [[ProjectSummary alloc] init];
    ps = self.summaries[indexPath.row];
    
    [self loadProjectInfo:[ps.projectId integerValue] andUserId:[SHARE.userInfo.userId integerValue]];
    
    [self loadComment:[ps.projectId integerValue]];

//获取项目评价列表
//    if ([self.commentDelegate respondsToSelector:@selector(projectCommentDetailInfo:)]) {
//        [self.commentDelegate projectCommentDetailInfo:indexPath];
//    }


    //0916临时测试
//    [self.navigationController pushViewController:self.paper animated:YES];

}



@end
