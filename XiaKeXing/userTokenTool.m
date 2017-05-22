//
//  userTokenTool.m
//  WiFiKeepers
//
//  Created by JOY on 16/4/11.
//  Copyright © 2016年 JOY. All rights reserved.
//

#import "userTokenTool.h"

@implementation userTokenTool

+ (BOOL)isLogin {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] != nil) {
       return YES;
    }else return NO;
}
+ (NSString *)getToken { return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];}
+ (NSData *)getIcon { return [[NSUserDefaults standardUserDefaults] objectForKey:@"icon"];}

+ (NSString *)getAccont {return [[NSUserDefaults standardUserDefaults] objectForKey:@"accont"];}
+ (NSString *)getSecret {return [[NSUserDefaults standardUserDefaults] objectForKey:@"secret"];}


+ (void)removeUserKey {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
}





@end
