//
//  ModelRegister.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/19.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelRegister : NSObject
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

- (NSDictionary *)toParams;
@end
