//
//  ModelRegister.m
//  TheCleanOne
//
//  Created by 李岳龙 on 15/11/19.
//  Copyright © 2015年 liyuelong. All rights reserved.
//

#import "ModelRegister.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ModelRegister
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.version = @"";
        self.username = @"";
        self.password = @"";
    }
    return self;
}

- (NSDictionary *)toParams
{
    return @{@"version":VERSIONNUM,
             @"username":self.username,
             @"password":[self md5:self.password]
             };
}

- (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
