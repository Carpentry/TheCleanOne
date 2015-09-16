//
//  NetOperation.h
//  TheCleanOne
//
//  Created by lihp on 15/7/14.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  HttpConnectToServer;
@interface NetOperation : NSObject
- (void)downLoad:(NSDictionary *)srcDict;
@end
