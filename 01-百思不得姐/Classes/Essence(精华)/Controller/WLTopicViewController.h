//
//  WLTopicViewController.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/27.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WLTopicTypeAll = 1,
    WLTopicTypePicture = 10,
    WLTopicTypeWord = 29,
    WLTopicTypeVoice = 31,
    WLTopicTypeAudio = 41
    
}WLTopicType;
@interface WLTopicViewController : UITableViewController
/**type*/
@property(nonatomic,assign)WLTopicType type;
@end
