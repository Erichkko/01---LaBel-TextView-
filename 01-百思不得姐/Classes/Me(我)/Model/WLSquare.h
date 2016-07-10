//
//  WLSquare.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/9.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSquare : NSObject
/**
 *   url: mod: //BDJ_To_Check,
 android: ,
 iphone: ,
 id: 28,
 market: ,
 ipad: ,
 name: 审贴,
 icon: http: //img.spriteapp.cn/ugc/2015/05/20/150532_5078.png
 */

/** icon */
@property(nonatomic,strong)NSString *icon;
/** name */
@property(nonatomic,strong)NSString *name;
/** url */
@property(nonatomic,strong)NSString *url;
/** squareID */
@property(nonatomic,strong)NSString *squareID;
@end
