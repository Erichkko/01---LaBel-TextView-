//
//  WLPIcture.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/29.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTopic;
@class WLPIcture;

@protocol WLPIctureDelegate <NSObject>

@optional
-(void)picture:(WLPIcture *)picture showBigPictureWithTopic:(WLTopic *)topic;


@end
@interface WLPIcture : UIView

/** topic */
@property(nonatomic,strong)WLTopic *topic;

/** delegate */
@property(nonatomic,weak)id<WLPIctureDelegate> delegate;
+(instancetype) picture;
@end
