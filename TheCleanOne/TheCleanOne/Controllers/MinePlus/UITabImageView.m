//
//  UITabImageView.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/14.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "UITabImageView.h"
#import "UIImageView+WebCache.h"

@interface UITabImageView ()

@property (nonatomic, copy) void(^tapAction)(id);

@end

@implementation UITabImageView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
    }
    return self;
}
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (void)tap
{
    if (self.tapAction) {
        self.tapAction(self);
    }
}
- (void)addTapBlock:(void (^)(id))tapAction
{
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];//手势识别
        [self addGestureRecognizer:tap];
    }
}

- (void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tabBlock:(void (^)(id))tapAction
{
    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
    [self addTapBlock:tapAction];
}

@end
