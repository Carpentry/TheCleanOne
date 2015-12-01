//
//  UITabImageView.h
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/14.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabImageView : UIImageView
- (void)addTapBlock:(void(^)(id obj))tapAction; //添加了一个点击事件块
- (void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tabBlock:(void(^)(id obj))tapAction;//通过url 设置图片，入参有：图片url，占位图片，点击块（我认为就是 回调函数，要执行的代码先写下来， 等待调用）
@end
