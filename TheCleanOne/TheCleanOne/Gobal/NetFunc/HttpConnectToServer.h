//
//  HttpConnectToServer.h
//  TheCleanOne
//
//  Created by lihp on 15/7/10.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishBlock)(NSURL *url,NSString *str);

typedef void(^FinishBlock2)(NSDictionary *dict);
//@class NetOperation;
@interface HttpConnectToServer : NSObject

@property (nonatomic, strong) NSArray *firstPageArray; //首页数组
@property (copy, nonatomic) FinishBlock finishBlock;
@property (copy, nonatomic) FinishBlock2 finishBlock2;
- (void)setCompletionBlock:(FinishBlock)aCompletionBlock;
- (void)setCompletionBlock2:(FinishBlock2)aCompletionBlock;
- (BOOL)parse:(NSURL *)url andStatement:(NSString *)statement;

#pragma mark -- 遇见
// 1、获取首页列表
- (void)comeAcrossRequest;
#pragma mark -- 启程
// 2、获取项目列表
- (void)getProjectList:(int)fromNum andTo:(int)toNum;
// 3、获取项目详细信息
- (void)getProjectInfo:(NSInteger)proId andUserId:(int)userId;
// 4、获取项目评价列表
- (void)getEvaluationList:(NSInteger)proId andFrom:(int)fromNum andTo:(int)toNum;
// 5、发表项目评价
- (void)saveEvaluation:(int)proId andUserId:(int)userId andGrade:(int)grade andContent:(NSString *)content andIsAnonymous:(int)anonymous;
// 6、添加收藏
- (void)addFavorite:(int)proId andUserId:(int)userId;
// 7、取消收藏
- (void)removeFavorite:(int)proId andUserId:(int)userId;
#pragma mark -- 聚汇
// 8、获取话题清单
- (void)getTopicList:(int)fromNum andTo:(int)toNum;
// 9、获取话题详细信息接口
- (void)getTopicById:(int)topicId;
// 10、获取项目评价列表
- (void)getCommentList:(int)topicId andFrom:(int)fromNum andTo:(int)toNum;
// 11、发表话题评论接口
- (void)addComment:(int)topicId andUserId:(int)userId andContent:(NSString *)content;
// 12、更新话题评论
- (void)updateComment:(int)commentId andContent:(NSString *)content;
// 13、删除话题评论
- (void)deleteComment:(int)commentId;
// 14、上传图片
- (void)uploadImage;
// 15、发表话题
- (void)publicTopic:(int)userId andTitle:(NSString *)title andContent:(NSString *)content andImageIds:(NSString *)imageIds;
// 16、点赞话题
- (void)praiseTopic:(int)topicId;
// 17、删除话题
- (void)deleteTopic:(int)topicId;
// 18、编辑话题
- (void)editTopic:(int)topicId andTitle:(NSString *)title andContent:(NSString *)content andImageIds:(NSString *)imageIds;
#pragma mark -- 我+
@end
