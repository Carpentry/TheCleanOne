//
//  HttpConnectToServer.m
//  TheCleanOne
//
//  Created by lihp on 15/7/10.
//  Copyright (c) 2015年 liyuelong. All rights reserved.
//

#import "HttpConnectToServer.h"
#import "MKNetworkKit.h"

@implementation HttpConnectToServer
+ (void)comeAcrossRequest
{
    NSLog(@"%@",SERVER_IP);
    NSString *path = [[NSString alloc] initWithFormat:@"/FamilyTrip/servlet/GetHomeList"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1.0.0",@"version", nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"192.168.1.112:8080" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *str = [completedOperation responseString];
        NSLog(@"responseData : %@", str);
        NSData *data = [completedOperation responseData];
        NSArray *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        
        NSLog(@"%@",resDict[0]);
        NSDictionary *dictt = resDict[0];
        NSDictionary *dicttt = [dictt objectForKey:@"content"];
        //        NSArray *arr1 = [NSArray arrayWithObject:dicttt];
        str = [NSString stringWithFormat:@"%@",dicttt];
        
        NSLog(@"~~~~%@",str);
        NSLog(@"~~~~%@",[dictt objectForKey:@"flag"]);
        
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *arr2 = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
        NSLog(@"~~~~%@",arr2[0]);
        dictt = arr2[0];
        NSLog(@"name:%@\nstatement:%@\nuri:%@",dictt[@"name"],dictt[@"statement"],dictt[@"uri"]);
        NSLog(@"~~~~%@",arr2[1]);
        dictt = arr2[1];
        NSLog(@"name:%@\nstatement:%@\nuri:%@",dictt[@"name"],dictt[@"statement"],dictt[@"uri"]);
  
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"MKNetwork请求错误 : %@", [error localizedDescription]);
    }];
    [engine enqueueOperation:op];
}
@end
