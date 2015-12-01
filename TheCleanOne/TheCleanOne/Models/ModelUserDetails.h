//
//  ModelUserDetails.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/21.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelUserDetails : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *portrait_url;
@property (nonatomic, assign) NSInteger *gender;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *location;
@property (strong, nonatomic) NSString *motto;
+ (instancetype)initUserWithDict:(NSDictionary *)dict;
@end
