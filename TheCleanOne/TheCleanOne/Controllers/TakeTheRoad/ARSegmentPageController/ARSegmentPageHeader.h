//
//  ARSegmentPageHeader.h
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentPageControllerHeaderProtocol.h"

@interface ARSegmentPageHeader : UIView<ARSegmentPageControllerHeaderProtocol>
//页首图片
@property (nonatomic, strong) UIImageView *imageView;


@end