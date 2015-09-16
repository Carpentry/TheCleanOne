//
//  GlobalVar.h
//  TheCleanOne
//
//  Created by lihp on 15/7/10.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#ifndef TheCleanOne_GlobalVar_h
#define TheCleanOne_GlobalVar_h


/************************************设备相关宏***********************************/
//iPhone 5
#define ISIPHONE5 ([NSString getDeviceTypeInfo] == 5) ? 1 : 0
//iPhone 4
#define ISIPHONE4 ([NSString getDeviceTypeInfo] == 4) ? 1 : 0
//iPhone 5s
#define ISIPHONE5S ([[NSString deviceString] isEqualToString:@"iPhone 5s"]) ? 1 : 0
//iPhone 6
#define ISIPHOEN6  ([NSString getDeviceTypeInfo] == 6) ? 1 : 0
//iPhone 6P
#define ISIPHONE6P ([[NSString deviceString] isEqualToString:@"iPhone 6 Plus"]) ? 1 : 0
//iOS 7 之后的版本
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
//终端类型
#define TERMINALTYPE @"iPhone"
//获取屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//获取屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

/************************************设备相关宏***********************************/
//服务器IP地址
//#define SERVER_IP   @"192.168.1.107" //buckstar  xianglong-002
//#define SERVER_IP   @"192.168.6.100" //infinite-005
#define SERVER_IP   @"101.200.82.231" //公网


//端口号
#define PORT    @"8080"
//版本号
#define VERSIONNUM [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//超时
#define TIME_OUT   10


#define COLOR_WITHRGBA [UIColor colorWithRed:19.0f/255.0f green:123.0f/255.0f blue:204.0f/255.0f alpha:1.0]

#endif
