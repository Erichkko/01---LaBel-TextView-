//
//  WLRightCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/20.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLRightCell.h"
#import "WLRecommedUser.h"
#import <UIImageView+WebCache.h>
@interface WLRightCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@end
@implementation WLRightCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(WLRecommedUser *)user
{
    _user = user;
    self.nameLabel.text = user.screen_name;
    self.infoLabel.text = [NSString stringWithFormat:@"已有%@关注",user.fans_count];
    
//    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
//
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.header]placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.iconView.image  = image?[image circleImage]:placeholderImage;
//    }];
    
        [self.iconView setCircleHeaderWithURL:user.header];
}

@end
