//
//  userTokenTool.h
//  WiFiKeepers
//
//  Created by JOY on 16/4/11.
//  Copyright © 2016年 JOY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userTokenTool : NSObject
+ (BOOL)isLogin;
+ (NSString *)getToken;
+ (NSString *)getAccont;
+ (NSString *)getSecret;
+ (NSData *)getIcon;

+(void)removeUserKey;

@end
