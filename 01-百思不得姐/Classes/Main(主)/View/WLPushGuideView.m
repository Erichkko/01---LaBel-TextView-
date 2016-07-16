//
//  WLPushGuideView.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/25.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLPushGuideView.h"

@implementation WLPushGuideView

+ (instancetype)guideView
{
 
    return [self viewFromXib];
}

+ (void)show
{
    
    NSString *kVersion = @"CFBundleShortVersionString";
    NSString *sanboxVersion = [WLUSerDefault stringForKey:kVersion];
    
    NSDictionary *infoDict =  [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDict[kVersion];
    
    
    if (![sanboxVersion isEqualToString:currentVersion]) {
        WLPushGuideView *guideView = [WLPushGuideView guideView];
        guideView.frame = WLWindow.bounds;
        [WLWindow addSubview:guideView];
        [WLUSerDefault setObject:currentVersion forKey:kVersion];
        [WLUSerDefault synchronize];
    }

}
- (IBAction)ikownClick:(UIButton *)sender {
    [self removeFromSuperview];
}
@end
