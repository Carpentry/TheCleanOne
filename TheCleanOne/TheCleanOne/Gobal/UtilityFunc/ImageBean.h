//
//  ImageBean.h
//  TheCleanOne
//
//  Created by lihp on 15/8/11.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageBean : NSObject
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@end
