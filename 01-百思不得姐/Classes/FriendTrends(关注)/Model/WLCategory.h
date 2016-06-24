//
//  WLCategory.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/20.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLRecommedUser;
@interface WLCategory : NSObject
/** ID */
@property(nonatomic,assign)NSInteger ID;
/** name */
@property(nonatomic,strong)NSString *name;
/** count */
@property(nonatomic,assign)NSInteger count;
/** users */
@property(nonatomic,strong)NSMutableArray *users;
/**currentPage*/
@property(nonatomic,assign)NSInteger currentPage;
/**total*/
@property(nonatomic,assign)NSInteger total;

@end
