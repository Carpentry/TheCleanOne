//
//  UITools.h
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITools : NSObject

+ (void)setNavigationTitleViewString:(NSString *)title andTitleColor:(UIColor *)color
                   forViewController:(UIViewController *)controller;

+ (void)setNavigationState:(NSString *)leftBtnStr leftAction:(SEL)action rightBtnStr:(NSString *)rightBtnStr rightAction:(SEL)rightAction rightBtnStateSelected:(NSString *)rightBtnStateName titleStr:(NSString *)title forViewController:(UIViewController *)controller;
@end
