//
//  EaseUserHeaderView.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/14.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"


@interface EaseUserHeaderView : UIImageView
@property (strong, nonatomic) User *curUser;
@property (strong, nonatomic) UIImage *bgImage;

@property (nonatomic, copy) void (^userIconClicked)();
@property (nonatomic, copy) void (^fansCountBtnClicked)();
@property (nonatomic, copy) void (^followsCountBtnClicked)();
@property (nonatomic, copy) void (^followBtnClicked)();

+ (id)userHeaderViewWithUser:(User *)user image:(UIImage *)image;
- (void)updateData;
@end
