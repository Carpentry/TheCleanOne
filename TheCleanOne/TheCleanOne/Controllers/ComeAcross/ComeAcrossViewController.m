//
//  ComeAcrossViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ComeAcrossViewController.h"
#import "LYLHttpTool.h"
#import "MJExtension.h"
#import "LYLContent.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface ComeAcrossViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger beforeOperPage;
    NSInteger afterOperPage;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@end

@implementation ComeAcrossViewController



- (NSMutableArray *)contents
{
    if (_contents == nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/GetHomeList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", nil];
    [LYLHttpTool GET:path parameters:param success:^(id responseObject) {
        //   NSDictionary *dict = responseObject[@"content"];
        //获取字典数组
        NSString *str = responseObject[@"content"];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        //把字典数组转成模型数组
        for (NSDictionary *dictLemp in dictArr) {
            LYLContent *content = [LYLContent objectWithKeyValues:dictLemp];
            [self.contents addObject:content];
            
        }
        
        NSLog(@"%@,%lu",self.contents,self.contents.count);
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height * self.contents.count) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPull)];
        self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPull)];
        [self.view addSubview:self.tableView];
        
    } failure:^(NSError *error) {
        NSLog(@"get:%@",error);
        
    }];
    
    
    
}


- (void)downPull
{
    afterOperPage = beforeOperPage - 1;
    if (afterOperPage < 0) {
        afterOperPage = self.contents.count - 1;
    }
    afterOperPage = afterOperPage % self.contents.count;
    beforeOperPage = afterOperPage;
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    NSLog(@"下拉 总计%lu,%lu",self.contents.count,afterOperPage);
}

- (void)upPull
{
    afterOperPage = beforeOperPage + 1;
    if (afterOperPage < 0) {
        afterOperPage = self.contents.count - 1;
    }
    afterOperPage = afterOperPage % self.contents.count;
    beforeOperPage = afterOperPage;
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
    NSLog(@"上拉 总计%lu,%lu",self.contents.count,afterOperPage);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, self.view.bounds.size.width - 40, 220)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 101;
        [cell.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0 ,0)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 102;
        [cell.contentView addSubview:label];
    }
    
    LYLContent *content = [[LYLContent alloc] init];
    content = self.contents[afterOperPage];
    UIImageView * imageView = (UIImageView *)[cell.contentView viewWithTag:101];
    
    NSLog(@"%@",content.uri);
    [imageView sd_setImageWithURL:(NSURL *)content.uri placeholderImage:[UIImage imageNamed:@"icon"]];
    
    UILabel * label = (UILabel *)[cell.contentView viewWithTag:102];
    label.text = content.statement;
    CGSize size = [self sizeWithString:label.text font:label.font];
    label.frame =  CGRectMake(20, 354, size.width, size.height);
    
    return cell;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 8000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
}


@end

