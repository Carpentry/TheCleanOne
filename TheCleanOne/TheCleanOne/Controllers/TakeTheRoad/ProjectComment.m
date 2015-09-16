//
//  ProjectComment.m
//  TheCleanOne
//
//  Created by lihp on 15/8/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectComment.h"
#import "MJExtension.h"

@implementation ProjectComment
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)projectCommentWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)projectCommentWithArray:(NSArray *)array
{

    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        [arrayM addObject:[self objectWithKeyValues:dict]];
    }
    return arrayM;
}
@end
