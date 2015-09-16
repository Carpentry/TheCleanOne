//
//  ProjectComment.h
//  TheCleanOne
//
//  Created by lihp on 15/8/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectComment : NSObject
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL anonymous;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)projectCommentWithDict:(NSDictionary *)dict;
+ (NSArray *)projectCommentWithArray:(NSArray *)array;
@end
