//
//  FirstPageViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "FirstPageViewController.h"
#import "ComeAcrossViewController.h"
#import "UITools.h"

@interface FirstPageViewController () <UITabBarControllerDelegate>

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITools setNavigationTitleViewString:@"CleanOne" andTitleColor:[UIColor lightGrayColor] forViewController:self];
//    self.delegate = self;
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//     ComeAcrossViewController *ComeAcrossVC = (ComeAcrossViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ComeAcrossViewController"];
//    [self.navigationController pushViewController:ComeAcrossVC animated:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
