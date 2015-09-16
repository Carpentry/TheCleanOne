//
//  HttpConnectToServer.m
//  TheCleanOne
//
//  Created by lihp on 15/7/10.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "HttpConnectToServer.h"
#import "ComeAcrossViewController.h"
#import "MKNetworkKit.h"
#import "NetOperation.h"
#import "UIImageView+WebCache.h"


@implementation HttpConnectToServer



#pragma mark -- 遇见
// 1、获取首页列表
- (void)comeAcrossRequest
{

    NSLog(@"%@,%@",SERVER_IP,VERSIONNUM);
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetHomeList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSData *data = [completedOperation responseData];
        NSDictionary *dictt = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];


        NSDictionary *dicttt = [dictt objectForKey:@"content"];
        str = [NSString stringWithFormat:@"%@",dicttt];
        
        
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        self.firstPageArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
        NSLog(@"~~~~%@~~~~~~~count:%lu",self.firstPageArray[0],self.firstPageArray.count);
        dictt = self.firstPageArray[0];
        NSLog(@"name:%@\nstatement:%@\nuri:%@",dictt[@"name"],dictt[@"statement"],dictt[@"uri"]);

        NSURL *l_URL = [NSURL URLWithString:dictt[@"uri"]];
        
//        if (self.finishBlock) {
//            self.finishBlock(l_URL,dictt[@"statement"]);
//        }
        [self parse:l_URL andStatement:dictt[@"statement"]];
        
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}

#pragma mark -- 启程
// 2、获取项目列表
- (void)getProjectList:(int)fromNum andTo:(int)toNum
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetProjectList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInt:fromNum],@"from",[NSNumber numberWithInt:toNum],@"to",nil];

    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSDictionary *l_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",l_dict);
//        NSDictionary *l_dict = resDict[0];
        if (self.finishBlock2) {
            self.finishBlock2(l_dict);
        }

        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
// 3、获取项目详细信息
- (void)getProjectInfo:(NSInteger)proId andUserId:(int)userId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetProjectInfo"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInteger:proId],@"id",[NSNumber numberWithInt:userId],@"userId",nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"getProjectInfo responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSDictionary *l_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",l_dict);
//        NSDictionary *l_dict = resDict[0];
        if (self.finishBlock2) {
            self.finishBlock2(l_dict);
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
// 4、获取项目评价列表
- (void)getEvaluationList:(NSInteger)proId andFrom:(int)fromNum andTo:(int)toNum
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetEvaluationList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version", [NSNumber numberWithInteger:proId],@"id",[NSNumber numberWithInt:fromNum],@"from",[NSNumber numberWithInt:toNum],@"to",nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSDictionary *l_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",l_dict);
        //        NSDictionary *l_dict = resDict[0];
        if (self.finishBlock2) {
            self.finishBlock2(l_dict);
        }
        
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
// 5、发表项目评价
- (void)saveEvaluation:(int)proId andUserId:(int)userId andGrade:(int)grade andContent:(NSString *)content andIsAnonymous:(int)anonymous
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/SaveEvaluation"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:proId],@"projectId",[NSNumber numberWithInt:userId],@"userId",[NSNumber numberWithInt:grade],@"grade",content,@"content",[NSNumber numberWithInt:anonymous],@"anonymous", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//6、添加收藏
- (void)addFavorite:(int)proId andUserId:(int)userId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/AddFavorite"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:proId],@"projectId",[NSNumber numberWithInt:userId],@"userId", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//7、取消收藏
- (void)removeFavorite:(int)proId andUserId:(int)userId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/RemoveFavorite"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:proId],@"projectId",[NSNumber numberWithInt:userId],@"userId", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
#pragma mark -- 聚汇
//8、获取话题清单
- (void)getTopicList:(int)fromNum andTo:(int)toNum
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/TopicList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:fromNum],@"from",[NSNumber numberWithInt:toNum],@"to", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSDictionary *l_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",l_dict);
        //        NSDictionary *l_dict = resDict[0];
        if (self.finishBlock2) {
            self.finishBlock2(l_dict);
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//9、获取话题详细信息接口
- (void)getTopicById:(int)topicId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetTopicById"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"id",nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//10、获取项目评价列表
- (void)getCommentList:(int)topicId andFrom:(int)fromNum andTo:(int)toNum
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"id",[NSNumber numberWithInt:fromNum],@"from",[NSNumber numberWithInt:toNum],@"to", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//11、发表话题评论接口
- (void)addComment:(int)topicId andUserId:(int)userId andContent:(NSString *)content
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"topicId",[NSNumber numberWithInt:userId],@"userId",content,@"content", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}


//12、更新话题评论
- (void)updateComment:(int)commentId andContent:(NSString *)content
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:commentId],@"commentId",content,@"content", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//13、删除话题评论
- (void)deleteComment:(int)commentId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:commentId],@"commentId", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//14、上传图片
- (void)uploadImage
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}

//15、发表话题
- (void)publicTopic:(int)userId andTitle:(NSString *)title andContent:(NSString *)content andImageIds:(NSString *)imageIds
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:userId],@"userId",title,@"title",content,@"content",imageIds,@"imageIds", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//16、点赞话题
- (void)praiseTopic:(int)topicId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"topicId", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//17、删除话题
- (void)deleteTopic:(int)topicId
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"topicId", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}
//18、编辑话题
- (void)editTopic:(int)topicId andTitle:(NSString *)title andContent:(NSString *)content andImageIds:(NSString *)imageIds
{
    NSString *serverAddr = [NSString stringWithFormat:@"%@:%@",SERVER_IP,PORT];
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetCommentList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:VERSIONNUM,@"version",[NSNumber numberWithInt:topicId],@"topicId",title,@"title",content,@"content",imageIds,@"imageIds", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serverAddr customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",resDict[0]);
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
    
}


#pragma mark -- 我+





#pragma mark -- 工具函数

- (BOOL)parse:(NSURL *)url andStatement:(NSString *)statement
{
    if (self.finishBlock) {
        self.finishBlock(url,statement);
        return YES;
    }
    return  NO;
}



- (void)setCompletionBlock:(FinishBlock)aCompletionBlock
{
    self.finishBlock = aCompletionBlock;
}

- (void)setCompletionBlock2:(FinishBlock2)aCompletionBlock
{
    self.finishBlock2 = aCompletionBlock;
}
@end
