//
//  TableViewController.h
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentPageController.h"
@class ProjectInfo;

@interface TableViewController : UITableViewController<ARSegmentControllerDelegate>
@property (nonatomic, strong) ProjectInfo *projectInfo;
@end
