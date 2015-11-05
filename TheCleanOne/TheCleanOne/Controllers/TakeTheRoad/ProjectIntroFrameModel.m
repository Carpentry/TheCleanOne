//
//  ProjectIntroFrameModel.m
//  TheCleanOne
//
//  Created by lihp on 15/9/16.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "ProjectIntroFrameModel.h"
@implementation ProjectIntroFrameModel
- (void)adaptProjectIntroFrameModel:(NSString *)inputStr
{
//    if (self = [super init]) {
        CGFloat textFieldX = 0;
        CGFloat textFieldY = 0;
        CGSize textMaxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, MAXFLOAT);
        CGSize textRealSize = [inputStr boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
        CGSize textFinishSize = CGSizeMake(textRealSize.width, textRealSize.height);
        self.textFieldF = (CGRect){{textFieldX,textFieldY},textFinishSize};
//    }

//    return self;
    
}


@end
