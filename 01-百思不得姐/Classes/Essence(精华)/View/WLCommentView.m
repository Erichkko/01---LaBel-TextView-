
//
//  WLComment.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/5.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLCommentView.h"
#import "WLComment.h"
#import "WLUser.h"
#import <UIImageView+WebCache.h>

@interface WLCommentView()
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *senderView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *playVoice;

@end

@implementation WLCommentView

+ (instancetype)commentView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    self.backgroundView = bgView;
}
- (void)setComment:(WLComment *)comment
{
    _comment = comment;
    WLUser *user = comment.user;
    [self.userHeaderView sd_setImageWithURL:[NSURL URLWithString:user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    if ([user.sex isEqualToString:WLUserSexMale]) {
        self.senderView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
         self.senderView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    self.userNameLabel.text = user.username;

    self.dingLabel.text = [NSString stringWithFormat:@"(%zd)",comment.like_count];

    if (comment.voiceuri.length) {
         self.playVoice.hidden = NO;
        [self.playVoice setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];

    }else{
          self.playVoice.hidden = YES;
    }
    
        self.contentLabel.text = comment.content;
}

- (void)setFrame:(CGRect)frame
{   frame.origin.x = margin;
    frame.size.width = WLWindow.width - 2 * frame.origin.x;
    
    [super setFrame:frame];
}
@end
