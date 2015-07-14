//
//  ComeAcrossViewController.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ComeAcrossViewController.h"
#import "HttpConnectToServer.h"

@interface ComeAcrossViewController ()

@end

@implementation ComeAcrossViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = [UIImage imageNamed:@"icon"];
    self.textView.editable = NO;
    [HttpConnectToServer comeAcrossRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
