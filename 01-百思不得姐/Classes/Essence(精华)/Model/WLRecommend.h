//
//  WLRecommend.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/23.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRecommend : NSObject
/** is_sub */
@property(nonatomic,assign)NSInteger is_sub;
/** theme_id */
@property(nonatomic,strong)NSString *theme_id;
/** theme_name */
@property(nonatomic,strong)NSString *theme_name;
/** sub_number */
@property(nonatomic,strong)NSString *sub_number;
/**is_default*/
@property(nonatomic,assign)NSInteger is_default;
/** image_list */
@property(nonatomic,strong)NSString *image_list;
@end
