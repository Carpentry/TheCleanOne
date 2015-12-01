//
//  RegisterViewController.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/17.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "RegisterViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "Masonry.h"
#import "InputOnlyTextTableViewCell.h"
#import "UITools.h"
#import "LYLHttpTool.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIAlertView *remindView;
    NSString *repeatPassword;
}
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIImageView *iconUserView, *bgBlurredView;
@property (strong, nonatomic) UIButton *loginBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myRegister = [[ModelRegister alloc] init];
    [UITools setNavigationState:@"返回" leftAction:@selector(back) rightBtnStr:nil rightAction:nil rightBtnStateSelected:nil titleStr:@"注册" forViewController:self];

    _myTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_myTableView registerNib:[UINib nibWithNibName:@"InputOnlyTextTableViewCell"  bundle:[NSBundle mainBundle] ]forCellReuseIdentifier:@"cell"];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.backgroundColor = [UIColor grayColor];

    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView = [self customFooterView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    InputOnlyTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[InputOnlyTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            [cell configWithPlaceholder:@"输入用户名" andValue:self.myRegister.username];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.username = valueStr;

            };
            break;}
        case 1:{
            [cell configWithPlaceholder:@"输入密码" andValue:self.myRegister.password];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.password = valueStr;

            };
            break;}
        default:{
            [cell configWithPlaceholder:@"确认密码" andValue:repeatPassword];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                repeatPassword = valueStr;

            };
            break;}
    }
    
    return cell;
}

- (UIView *)customHeaderView
{
    CGFloat iconUserViewWidth = 90;
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3)];
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
#define kLoginPaddingLeftWidth 18
- (UIView *)customFooterView
{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLoginPaddingLeftWidth, 20, ScreenWidth-kLoginPaddingLeftWidth*2, 45)];
    [_loginBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:_loginBtn];
    
    
    return footerV;
}

- (void)loginAction
{
    if (self.myRegister.username.length < 4 || self.myRegister.username.length > 20) {
        [self showAlert:@"输入用户名长度错误"];
        return;
    }else if (self.myRegister.password.length < 4 || self.myRegister.password.length > 20 ){
        [self showAlert:@"输入密码长度错误"];
        return;
    }else if (![repeatPassword isEqualToString:self.myRegister.password]) {
        [self showAlert:@"输入密码不一致"];
        return;
    }
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
        [_activityIndicator setCenter:CGPointMake(_loginBtn.center.x, _loginBtn.center.y)];
        [_loginBtn addSubview:_activityIndicator];
    }
    [_activityIndicator startAnimating];
    self.loginBtn.enabled = NO;
    
    NSLog(@"%@  %@  %@",self.myRegister.username,self.myRegister.password,repeatPassword);
    __weak typeof(self) weakSelf = self;
    NSString *path = [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,PORT,@"/FamilyTrip/servlet/UserRegister"];
    [LYLHttpTool GET:path parameters:[self.myRegister toParams] success:^(id responseObject) {
        weakSelf.loginBtn.enabled = YES;
        [weakSelf.activityIndicator stopAnimating];
        NSLog(@"recv:%@",responseObject);
        //获取字典数组
        if ([responseObject[@"flag"] isEqualToNumber:@1]) { //通信正常
            if ([responseObject[@"content"] isEqualToString:@"1"]) { //成功
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([responseObject[@"content"] isEqualToString:@"-1"]){//用户名格式错误
                [self showAlert:@"输入用户名格式错误"];
            }else if ([responseObject[@"content"] isEqualToString:@"0"]){//用户名已被注册
                [self showAlert:@"用户已被注册"];
            }else if ([responseObject[@"content"] isEqualToString:@"失败"]){//缺少必要信息
                [self showAlert:@"缺少必要信息"];
            }else{//服务器异常
                [self showAlert:@"服务器异常"];

            }
        }else if ([responseObject[@"flag"] isEqualToNumber:@-1]){ //异常
            [self showAlert:@"服务异常，请重试"];
        }else{ //失败
            [self showAlert:@"网络异常，请重试"];
        }
       
        
    } failure:^(NSError *error) {
        NSLog(@"get:%@",error);
        
    }];
}


- (void)back
{
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
