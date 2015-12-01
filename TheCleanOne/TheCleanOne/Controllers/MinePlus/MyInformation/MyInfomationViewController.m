//
//  MyInfomationViewController.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/21.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "MyInfomationViewController.h"
#import "TitleValueTableViewCell.h"
#import "Masonry.h"
#import "ModelUserDetails.h"

@interface MyInfomationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *myTableView;

@end

@implementation MyInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [backBtnItem setTintColor:[UIColor lightGrayColor]];
    self.title = @"详细信息";
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_myTableView registerNib:[UINib nibWithNibName:@"TitleValueTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    TitleValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[TitleValueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
   ;
    switch (indexPath.row) {
        case 0:
            [cell setTitle:@"头像" andValue:SHARE.userInfo.portrait_url];
            break;
        case 1:
            [cell setTitle:@"昵称" andValue:SHARE.userInfo.nickname];
            break;
        case 2:
        {
            NSString *str = SHARE.userInfo.gender?@"男":@"女";
            [cell setTitle:@"性别" andValue:str];
            break;}
        case 3:
            [cell setTitle:@"生日" andValue:SHARE.userInfo.birthday];
            break;
        case 4:
            [cell setTitle:@"电话" andValue:SHARE.userInfo.phone];
            break;
        case 5:
            [cell setTitle:@"所在地" andValue:SHARE.userInfo.location];
            break;
        case 6:
            [cell setTitle:@"座右铭" andValue:SHARE.userInfo.motto];
            break;
        default:
            break;
    }

    
    return cell;
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
