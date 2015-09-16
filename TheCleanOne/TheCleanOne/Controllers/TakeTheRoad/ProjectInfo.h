//
//  ProjectInfo.h
//  TheCleanOne
//
//  Created by lihp on 15/8/11.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageBean.h"

@interface ProjectInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *feature;
@property (nonatomic, copy) NSString *schedule;
@property (nonatomic, copy) NSString *expenses;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, assign) NSInteger favorite;
@property (nonatomic, strong) ImageBean *images;

//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)projectInfoWithDict:(NSDictionary *)dict;
//+ (NSArray *)projectInfo;
@end
