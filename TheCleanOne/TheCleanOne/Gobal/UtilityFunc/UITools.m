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
@end
