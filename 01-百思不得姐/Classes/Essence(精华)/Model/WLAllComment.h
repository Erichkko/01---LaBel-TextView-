//
//  WLAllComment.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/4.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLComment;
@class WLTopComment;
@interface WLAllComment : NSObject
/** data */
@property(nonatomic,strong)NSMutableArray *data;
/** hot */
@property(nonatomic,strong)NSMutableArray *hot;
@end
