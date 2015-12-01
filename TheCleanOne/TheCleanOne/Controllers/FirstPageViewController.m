//
//  FirstPageViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "FirstPageViewController.h"
#import "SettingViewController.h"
#import "UITools.h"
#import "LoginViewController.h"

@interface FirstPageViewController () <UITabBarControllerDelegate>
{
    UIButton *leftButtion;
    UIImageView *arrowImage;
    UIView *leftView;
    
    UIButton *rightButtion;
    
    UIView *titleView;
    UIButton *buttonTitle;
    UIImageView *titleImage;
    
}

@end

@implementation FirstPageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    SHARE.flag_login = NO;
   [UITools setNavigationTitleViewString:@"遇见" andTitleColor:[UIColor lightGrayColor] forViewController:self];

    self.delegate = self;
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//     ComeAcrossViewController *ComeAcrossVC = (ComeAcrossViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ComeAcrossViewController"];
//    [self.navigationController pushViewController:ComeAcrossVC animated:YES];
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //self.navigationItem.titleView = titleView;
    if (tabBarController.selectedIndex == 0) {
       [UITools setNavigationTitleViewString:@"遇见" andTitleColor:[UIColor lightGrayColor] forViewController:self];
        [self.navigationItem setRightBarButtonItem:nil];
    } else if (tabBarController.selectedIndex == 1){
       [UITools setNavigationTitleViewString:@"启程" andTitleColor:[UIColor lightGrayColor] forViewController:self];
        [self.navigationItem setRightBarButtonItem:nil];
    } else if (tabBarController.selectedIndex == 2){
       [UITools setNavigationTitleViewString:@"聚汇" andTitleColor:[UIColor lightGrayColor] forViewController:self];
        [self.navigationItem setRightBarButtonItem:nil];
    } else if (tabBarController.selectedIndex == 3){
        if (SHARE.flag_login) {
            [UITools setNavigationTitleViewString:@"我+" andTitleColor:[UIColor lightGrayColor] forViewController:self];
            self.navigationItem.backBarButtonItem.title = @"返回";
            UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClicked:)];
            [rightItem setTintColor:[UIColor lightGrayColor]];
            [self.navigationItem setRightBarButtonItem:rightItem animated:NO];
        } else {
            LoginViewController *loginViewVC = [[LoginViewController alloc] init];
            loginViewVC.firstPageVC = self;
            [self.navigationController pushViewController:loginViewVC animated:NO];
        }

        
    }
}

- (void)settingBtnClicked:(id)sender
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)createMinePlusNavigationBar
{
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClicked:)];
    [rightItem setTintColor:[UIColor lightGrayColor]];
    [self.navigationItem setRightBarButtonItem:rightItem animated:NO];
}



@end
