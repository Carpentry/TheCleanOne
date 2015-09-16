//
//  ProjectInfo.m
//  TheCleanOne
//
//  Created by lihp on 15/8/11.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectInfo.h"


@implementation ProjectInfo
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    self = [super init];
//    if (self) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//
//+ (instancetype)projectInfoWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//+ (NSArray *)projectInfo
//{
//    
//
//    
//  
//    
////    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"<#fileName#>.plist" ofType:nil]];
//    NSMutableArray *arrayM = [NSMutableArray array];
////    for (NSDictionary *dict in array) {
////        [arrayM addObject:[self projectInfoWithDict:dict]];
////    }
//    return arrayM;
//}

- (NSString *)description
{
    return  [NSString stringWithFormat:@"<%@: %p> {title:%@, introduction:%@}",self.class,self,self.title,self.introduction];
}
@end
