//
//  NetOperation.m
//  TheCleanOne
//
//  Created by lihp on 15/7/14.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "NetOperation.h"
#import "HttpConnectToServer.h"
#import "ComeAcrossViewController.h"


@implementation NetOperation

- (void)downLoad:(NSDictionary *)srcDict
{
    
    ComeAcrossViewController *cavc = [[ComeAcrossViewController alloc] init];
    
    NSString *l_imgName = [NSString stringWithFormat:@"%@.%@",srcDict[@"name"],srcDict[@"type"]];
    NSString *l_str = srcDict[@"uri"];
    NSArray *l_arr = [l_str componentsSeparatedByString:@"//"];
    NSRange range = [l_arr[1] rangeOfString:@"/"];//匹配得到的下标
    NSLog(@"rang:%@",NSStringFromRange(range));
    NSString *l_hostname = [l_arr[1] substringToIndex:range.location];//截取下标之后的字符串
    NSString *l_addr = [l_arr[1] substringFromIndex:range.location];
    NSLog(@"截取的值为：%@\n%@",l_hostname,l_addr);

    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = paths[0];
    NSString *downloadPath = [cacheDirectory stringByAppendingPathComponent:l_imgName];
    NSString *path = l_addr;
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:l_hostname customHeaderFields:nil];
    MKNetworkOperation * downloadOperation = [engine operationWithPath:path params:nil httpMethod:@"POST"];
    [downloadOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:YES]];
    [downloadOperation onDownloadProgressChanged:^(double progress) {
       // NSLog(@"download progress: %.2f", progress*100.0);
    }];
    [downloadOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"download file finished!");
        NSData *data = [completedOperation responseData];
        if (data) {
            NSError *error;
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (!resDict) {
                NSLog(@"error:%@",error);
                
            }
        } else {
            NSLog(@"Success!");
            
            UIImage *img = [UIImage imageWithContentsOfFile:downloadPath];
           // cavc.imageView.image = img;
            NSLog(@"%@",downloadPath);
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:downloadOperation];
        
}

- (void)upLoad:(id)sender
{
    
}
@end
