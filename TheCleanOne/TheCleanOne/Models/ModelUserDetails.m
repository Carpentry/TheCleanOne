//
//  ModelUserDetails.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/21.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "ModelUserDetails.h"

@implementation ModelUserDetails
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)initUserWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
}
@end
