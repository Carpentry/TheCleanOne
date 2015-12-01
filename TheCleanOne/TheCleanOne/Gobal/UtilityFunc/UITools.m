//
//  UITools.m
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "UITools.h"

@implementation UITools

+ (void)setNavigationTitleViewString:(NSString *)title andTitleColor:(UIColor *)color
                   forViewController:(UIViewController *)controller
{
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 168, 44)];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    titleTextLabel.textColor = color;
    titleTextLabel.font = [UIFont fontWithName:@"黑体" size:80];
    titleTextLabel.textAlignment = NSTextAlignmentCenter;
    titleTextLabel.text = title;
    controller.navigationItem.titleView = titleTextLabel;
}

+ (void)setNavigationState:(NSString *)leftBtnStr leftAction:(SEL)action rightBtnStr:(NSString *)rightBtnStr rightAction:(SEL)rightAction rightBtnStateSelected:(NSString *)rightBtnStateName titleStr:(NSString *)title forViewController:(UIViewController *)controller
{
    if ( IOS7_OR_LATER )
    {
        controller.edgesForExtendedLayout = UIRectEdgeNone;
        controller.extendedLayoutIncludesOpaqueBars = NO;
        controller.modalPresentationCapturesStatusBarAppearance = NO;
        [controller.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    else{
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 168, 44)];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    titleTextLabel.textColor = [UIColor lightGrayColor];
    titleTextLabel.font = [UIFont fontWithName:@"黑体" size:80];
    titleTextLabel.textAlignment = NSTextAlignmentCenter;
    titleTextLabel.text = title;
    controller.navigationItem.titleView = titleTextLabel;
    
    if (leftBtnStr != nil) {
        UIView *navigationLeftItem_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        navigationLeftItem_view.backgroundColor = [UIColor clearColor];
        UIButton * navigationLeftItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        [navigationLeftItemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [navigationLeftItemBtn setTitle:leftBtnStr forState:UIControlStateNormal];
        if ([controller respondsToSelector:action]) {
            [navigationLeftItemBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
        }
        [navigationLeftItem_view addSubview:navigationLeftItemBtn];
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:navigationLeftItem_view];
        controller.navigationItem.leftBarButtonItem = leftBarButton;
    } else {
        controller.navigationItem.leftBarButtonItem = nil;
    }
    
    if (rightBtnStr != nil) {
        UIView *navigationRightItem_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        navigationRightItem_view.backgroundColor = [UIColor clearColor];
        UIButton * navigationRightItemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        [navigationRightItemBtn setTitle:rightBtnStr forState:UIControlStateNormal];
        [navigationRightItemBtn setTitle:rightBtnStateName forState:UIControlStateSelected];
        [navigationRightItemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([controller respondsToSelector:rightAction]) {
            [navigationRightItemBtn addTarget:controller action:rightAction forControlEvents:UIControlEventTouchUpInside];
        }
        [navigationRightItem_view addSubview:navigationRightItemBtn];
        UIBarButtonItem *_rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:navigationRightItemBtn];
        _rightBarButton.enabled = YES;
        controller.navigationItem.rightBarButtonItem = _rightBarButton;
    } else {
        controller.navigationItem.rightBarButtonItem = nil;
    }
}
@end
