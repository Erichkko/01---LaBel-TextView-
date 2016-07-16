//
//  WLAddTagToolBar.h
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLAddTagToolBar;

@protocol WLAddTagToolBarDelegate <NSObject>

@optional
- (void)addTagClickBtnPlus:(WLAddTagToolBar *)toolBar;

@end
@interface WLAddTagToolBar : UIView
+ (instancetype)toolBarView;
/** deleagte */
@property(nonatomic,weak)id <WLAddTagToolBarDelegate> deleagte;
@end
