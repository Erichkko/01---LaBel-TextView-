//
//  WLRecommendCell.m
//  01-百思不得姐
//
//  Created by wanglong on 16/6/23.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLRecommendCell.h"
#import "WLRecommend.h"
#import <UIImageView+WebCache.h>
@interface WLRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;

@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@end

@implementation WLRecommendCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   }


- (void)setRecommend:(WLRecommend *)recommend
{
    _recommend = recommend;
    
    self.titleLabel.text = recommend.theme_name;
    int followNumber = [recommend.sub_number intValue];
    NSString *followStr ;

    if (followNumber > 10000 ) {
        followStr = [NSString stringWithFormat:@"%.1f万个人订阅",followNumber / 10000.0];
    }else{
        followStr = [NSString stringWithFormat:@"%zd个人订阅",followNumber];
    }
    self.followLabel.text = followStr;
//    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];

//    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:recommend.image_list] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.iconImage.image =image?[image circleImage]:placeholderImage;
//    }];
       [self.iconImage setCircleHeaderWithURL:recommend.image_list];
}

- (void)setFrame:(CGRect)frame
{
    
    WLLog(@"frame = %@",NSStringFromCGRect(frame));
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height  -=  2;
    
    [super setFrame:frame];
}
@end
