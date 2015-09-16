//
//  ShowModel.h
//  TheCleanOne
//
//  Created by lihp on 15/8/13.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject
@property (nonatomic, assign) int topicId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) int readCount;
@property (nonatomic, assign) int praiseCount;
@property (nonatomic, assign) int commentCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)showModelWithDict:(NSDictionary *)dict;
+ (NSArray *)models;
@end
