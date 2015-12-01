//
//  TakeTheRoadViewController.h
//  TheCleanOne
//
//  Created by lihp on 15/6/28.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectInfo.h"

@protocol ProjectIntroDelegate <NSObject>

//- (void)projectDetailInfo:(NSIndexPath *)indexPath;

- (void)projectDetailInfo:(ProjectInfo *)projectInfo andImages:(NSArray *)imgArr;

@end


@protocol ProjectCommentDelegate <NSObject>

- (void)projectCommentDetailInfo:(NSInteger )projectId;

@end



@interface TakeTheRoadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *localDict;
@property (strong, nonatomic) NSArray *localArray;

@property (nonatomic, assign) id<ProjectIntroDelegate> delegate;

@property (nonatomic, weak) id<ProjectCommentDelegate> commentDelegate;
@property (nonatomic, weak) id<ProjectIntroDelegate> proIntroDelegate;

@end
