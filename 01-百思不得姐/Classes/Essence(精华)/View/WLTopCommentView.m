//
//  WLTopCommentView.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/3.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTopCommentView.h"
#import "WLTopComment.h"
#import "WLUser.h"
@interface WLTopCommentView()
@property (weak, nonatomic) IBOutlet UILabel *topcmtLabel;

@end
@implementation WLTopCommentView


+ (instancetype)commentView
{
    return [self viewFromXib];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.topcmtLabel.font = WLCellFont;
}


- (void)setTopComment:(WLTopComment *)topComment
{
    _topComment = topComment;
    WLUser *user = (WLUser *)topComment.user;
    self.topcmtLabel.text =[NSString stringWithFormat:@"%@:%@",user.username,topComment.content];
    
    
}

@end
