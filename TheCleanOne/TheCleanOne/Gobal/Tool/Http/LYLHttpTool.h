//
//  LYLHttpTool.h
//  TheCleanOneComeCrossTest
//
//  Created by lihp on 15/8/29.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//  处理网络请求

#import <Foundation/Foundation.h>
@interface LYLHttpTool : NSObject
//get请求
/**
 * get请求不需要返回值：1.网络的数据会延迟，并不会马上返回
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

//post请求
+ (void)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

@end
