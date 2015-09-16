//
//  ProjectCommentList.h
//  TheCleanOne
//
//  Created by lihp on 15/8/17.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectComment.h"

@interface ProjectCommentList : NSObject
@property (nonatomic, assign) double avgGrade;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSArray *projectCommentList;

@end
