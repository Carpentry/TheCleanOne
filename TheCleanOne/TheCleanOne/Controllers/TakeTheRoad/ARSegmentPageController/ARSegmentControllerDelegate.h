//
//  ARSegmentControllerDelegate.h
//  ARSegmentPager
//
//  Created by August on 15/3/29.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ARSegmentControllerDelegate <NSObject>

//分页的标题
-(NSString *)segmentTitle;

@optional

//伸展滚动视图
-(UIScrollView *)streachScrollView;

@end
