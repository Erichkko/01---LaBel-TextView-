//
//  WLLoginTool.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/16.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLLoginTool.h"
#import "WLLoginAndRegisterController.h"

@implementation WLLoginTool
+ (NSString *)getUid
{
    NSString *uid = [WLUSerDefault valueForKey:WLUserUid];
    
    return uid;
}

+ (void)setUid:(NSString *)uid
{
    [WLUSerDefault setObject:uid forKey:WLUserSexMale];
    [WLUSerDefault synchronize];
}

+ (void)checkIsLogin
{
    if ([self getUid] == nil) {
        WLLoginAndRegisterController *loginAndRegisterVc = [[WLLoginAndRegisterController alloc] init];
        UIViewController *rootVc = WLWindow.rootViewController;
        [rootVc presentViewController:loginAndRegisterVc animated:YES completion:nil];
    }
    
}
@end
