//
//  ProjectIntroFrameModel.h
//  TheCleanOne
//
//  Created by lihp on 15/9/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProjectIntroFrameModel : NSObject
@property (nonatomic, assign) CGRect textFieldF;
@property (nonatomic, assign) BOOL open;
- (void)adaptProjectIntroFrameModel:(NSString *)inputStr;
@end
