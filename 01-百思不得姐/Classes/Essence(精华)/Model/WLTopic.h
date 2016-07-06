//
//  WLTopic.h
//  01-百思不得姐
//
//  Created by wanglong on 16/6/26.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLTopic : NSObject
/** topicId */
@property(nonatomic,strong)NSString *topicId;
/** name */
@property(nonatomic,strong)NSString *name;
/** profile_image */
@property(nonatomic,strong)NSString *profile_image;
/** create_time */
@property(nonatomic,strong)NSString *create_time;
/** text */
@property(nonatomic,strong)NSString *text;
/**ding*/
@property(nonatomic,assign)NSInteger ding;
/**cai*/
@property(nonatomic,assign)NSInteger cai;
/**repost*/
@property(nonatomic,assign)NSInteger repost;
/**comment*/
@property(nonatomic,assign)NSInteger comment;
/**sina_v*/
@property(nonatomic,assign)NSInteger sina_v;
/**image_width*/
@property(nonatomic,assign)CGFloat width;
/**image_height*/
@property(nonatomic,assign)CGFloat height;
/**image*/
@property(nonatomic,copy)NSString *smallImage;
/**image1*/
@property(nonatomic,copy)NSString *largeImage;
/**image2*/
@property(nonatomic,copy)NSString *middleImage;
/**voicetime*/
@property(nonatomic,assign)NSInteger voicetime;
/**voicetime*/
@property(nonatomic,assign)NSInteger videotime;
/**playfcount*/
@property(nonatomic,assign)NSInteger playfcount;

/** top_cmt */
@property(nonatomic,strong)NSArray *top_cmt;
/**type*/
@property(nonatomic,assign)WLTopicType type;
/**
 *  其他额外的辅助属性
 */

/**cellHeight*/
@property(nonatomic,assign,readonly)CGFloat cellHeight;

/**pictureSize*/
@property(nonatomic,assign)CGRect pictureRect;

/**bigPicture*/
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

/**pictureProgess*/
@property(nonatomic,assign)CGFloat pictureProgess;

/**voiceRect*/
@property(nonatomic,assign)CGRect voiceRect;

/**videoRect*/
@property(nonatomic,assign)CGRect videoRect;
/**topcmtRect*/
@property(nonatomic,assign)CGRect topcmtRect;
/**topCmt*/
@property(nonatomic,assign,getter=istopCmt)BOOL topCmt;
@end
