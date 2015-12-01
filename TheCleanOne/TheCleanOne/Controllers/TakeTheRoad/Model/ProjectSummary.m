//
//  ProjectSummary.m
//  TheCleanOne
//
//  Created by lihp on 15/9/1.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectSummary.h"

@implementation ProjectSummary

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)initProjectSummaryWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)projectSummaries:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self initProjectSummaryWithDict:dict]];
    }
    return arrayM;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.projectId = value;
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@\t%@\t%@\t%@\t%@>", self.projectId,self.statement,self.uri,self.name,self.type];
}


@end
