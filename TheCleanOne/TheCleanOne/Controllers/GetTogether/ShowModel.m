//
//  ShowModel.m
//  TheCleanOne
//
//  Created by lihp on 15/8/13.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ShowModel.h"
#import "HttpConnectToServer.h"

@implementation ShowModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)showModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)models
{
    
    //获取话题列表入口
    HttpConnectToServer *hcts = [[HttpConnectToServer alloc] init];
    [hcts getTopicList:0 andTo:9];
    [hcts setCompletionBlock2:^(NSDictionary *dict) {
        if ([dict[@"flag"] intValue] == 1) {
            NSLog(@"获取话题列表%@",dict[@"content"]);
        }
    }];
    
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self showModelWithDict:dict]];
    }
    return arrayM;
}
@end
