//
//  LoginViewController.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/17.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "LoginViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterViewController.h"
#import "Masonry.h"
#import "UITools.h"
#import "InputOnlyTextTableViewCell.h"
#import "User.h"
#import "LYLHttpTool.h"
#import "ModelUserDetails.h"


@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIAlertView *remindView;
}
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIImageView *iconUserView, *bgBlurredView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _user = [[User alloc] init];
    [UITools setNavigationState:@"返回" leftAction:@selector(back) rightBtnStr:@"注册" rightAction:@selector(gotoRegisterVC) rightBtnStateSelected:nil titleStr:@"登录" forViewController:self];
    _myTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"InputOnlyTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView = [self customFooterView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    InputOnlyTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[InputOnlyTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    }
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            [cell configWithPlaceholder:@"输入用户名" andValue:self.user.name];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.user.name = valueStr;
            };
            break;}
        default:{
            [cell configWithPlaceholder:@"输入密码" andValue:self.user.global_key];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.user.global_key = valueStr;
            };
            break;}
    }
    return cell;
}

- (UIView *)customHeaderView
{
    CGFloat iconUserViewWidth = 90;
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2)];
    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    _iconUserView.layer.masksToBounds = YES;
    _iconUserView.layer.cornerRadius = _iconUserView.frame.size.width/2;
    _iconUserView.layer.borderWidth = 2;
    _iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerV addSubview:_iconUserView];
    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.centerX.equalTo(headerV);
        make.centerY.equalTo(headerV).offset(30);
    }];
    [_iconUserView setImage:[UIImage imageNamed:@"icon"]];
    return headerV;
}
- (UIView *)customFooterView
{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLoginPaddingLeftWidth, 20, ScreenWidth-kLoginPaddingLeftWidth*2, 45)];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:_loginBtn];
    
    UIButton *forgetPasswdBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [forgetPasswdBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [forgetPasswdBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    [forgetPasswdBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
    [forgetPasswdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [footerV addSubview:forgetPasswdBtn];
    [forgetPasswdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.equalTo(footerV);
        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
    }];
    [forgetPasswdBtn addTarget:self action:@selector(forgetPasswdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footerV;
}

- (void)forgetPasswdBtnAction
{
    
}

- (void)loginAction
{
    if (self.user.name.length < 4 || self.user.name.length > 20) {
        [self showAlert:@"输入用户名长度错误"];
        return;
    }else if (self.user.global_key.length < 4 || self.user.global_key.length > 20 ){
        [self showAlert:@"输入密码长度错误"];
        return;
    }
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
        [_activityIndicator setCenter:CGPointMake(_loginBtn.center.x, _loginBtn.center.y)];
        [_loginBtn addSubview:_activityIndicator];
    }
    [_activityIndicator startAnimating];
    
    NSLog(@"%@  %@",self.user.name,self.user.global_key);
    __weak typeof(self) weakSelf = self;
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/Login"];
    [LYLHttpTool GET:path parameters:[self.user toParams] success:^(id responseObject) {
        weakSelf.loginBtn.enabled = YES;
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"recv:%@",responseObject);
        NSString *str = responseObject[@"content"];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        //获取字典数组
        if ([responseObject[@"flag"] isEqualToNumber:@1]) { //通信正常
            SHARE.flag_login = YES;
            ModelUserDetails *userDetails = [ModelUserDetails initUserWithDict:dict];
            SHARE.userInfo = userDetails;
            [self.firstPageVC createMinePlusNavigationBar];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([responseObject[@"flag"] isEqualToNumber:@0]){ //失败
            [self showAlert:@"获取失败，请重试"];
        }else if ([responseObject[@"flag"] isEqualToNumber:@-1]){ //服务器异常
            [self showAlert:@"服务异常，请重试"];
        }else{ //错误
            [self showAlert:@"输入有误，请重试"];
        }
    } failure:^(NSError *error) {
        NSLog(@"get:%@",error);
        
    }];
    
}

- (void)gotoRegisterVC
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)back
{
    [self.firstPageVC setSelectedIndex:0];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIAlertViewDelegate methods
- (void)performDismiss{
    [remindView dismissWithClickedButtonIndex:0 animated:NO];
    [remindView removeFromSuperview];
}
- (void)willPresentAlertView:(UIAlertView *)alertView{
    CGRect frame = alertView.frame;
    frame.size.height = 60;
    alertView.frame = frame;
}
- (void)showAlert:(NSString *)context{
    remindView = [[UIAlertView alloc] initWithTitle:nil message:context delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [remindView show];
    [self performSelector:@selector(performDismiss) withObject:nil afterDelay:1.5f];
}

@end
