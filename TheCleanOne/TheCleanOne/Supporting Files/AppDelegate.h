//
//  AppDelegate.h
//  TheCleanOne
//
//  Created by lihp on 15/6/23.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelUserDetails.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL flag_login; //是否已登陆
@property (strong, nonatomic) ModelUserDetails *userInfo;




@end

