//
//  ProjectSummary.h
//  TheCleanOne
//
//  Created by lihp on 15/9/1.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectSummary : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *statement;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@end
