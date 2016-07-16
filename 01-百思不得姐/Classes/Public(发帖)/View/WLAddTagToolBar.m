//
//  WLAddTagToolBar.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/10.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLAddTagToolBar.h"
#import "WLAddTagViewController.h"

@interface WLAddTagToolBar ()
/** labels */
@property(nonatomic,strong)NSMutableArray *labels;
@property (weak, nonatomic) IBOutlet UIView *topView;
/** plusBtn */
@property(nonatomic,weak)UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;
@end
@implementation WLAddTagToolBar
- (NSMutableArray *)labels
{
    if (_labels == nil) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}
+ (instancetype)toolBarView
{
    return [self viewFromXib];
    
}

- (void)awakeFromNib
{
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [plusBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    plusBtn.size = [plusBtn currentImage].size;
    plusBtn.height = tagHeight;
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusBtn];
    self.plusBtn = plusBtn;
    [self createTag:@[@"糗事fdsaaaafdsdsfds",@"操你妈逼操你妈逼操你妈逼操你妈逼操你妈逼",@"ffffffff"]];
}

- (void)plusBtnClick
{
//    if ([self.deleagte respondsToSelector:@selector(addTagClickBtnPlus:)]) {
//        [self.deleagte addTagClickBtnPlus:self];
//    }
    
    WLAddTagViewController *addTagVc = [[WLAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    addTagVc.returnBlock = ^(NSArray *array){
        WLLog(@"top == %@",array);
        [weakSelf createTag:array];
        
    };
   
       addTagVc.tags = [self.labels valueForKeyPath:@"text"];
    UIViewController *rootVc = WLWindow.rootViewController;
    UINavigationController *navVc = (UINavigationController *)rootVc.presentedViewController;
    [navVc pushViewController:addTagVc animated:YES];
  
    /**
     UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
     UINavigationController *nav = (UINavigationController *)root.presentedViewController;
     [nav pushViewController:vc animated:YES];
     */
}

- (void)createTag:(NSArray *)tags
{
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = WLTagFont;
        tagLabel.backgroundColor = WLTAGColor;
        tagLabel.textColor = [UIColor blackColor];
        [tagLabel sizeToFit];
        tagLabel.width += 2*tagMargin;

        tagLabel.height = tagHeight;
        [self.labels addObject:tagLabel];
        [self.topView addSubview:tagLabel];
        
    }
  [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        if (i == 0) {
            label.x = 0;
            label.y = 0;
        }else{
            UILabel *lastLabel = self.labels[i - 1];
            CGFloat lastLabelX =  CGRectGetMaxX(lastLabel.frame) + tagMargin;
            CGFloat lastLabelW = lastLabel.width;
            if (lastLabelW < self.topView.width -lastLabelX) {
                label.x = lastLabelX;
                label.y = lastLabel.y;
            }else{
                label.x = 0;
                label.y = CGRectGetMaxY(lastLabel.frame)+tagMargin;
            }
        }
    }
    
    
    UILabel *lastLabel  = self.labels.lastObject;
    
    CGFloat leftWidth = self.topView.width - CGRectGetMaxX(lastLabel.frame);
    if (leftWidth >= self.plusBtn.width) {
        self.plusBtn.x = CGRectGetMaxX(lastLabel.frame) + tagMargin;
        self.plusBtn.y = lastLabel.y;
    }else{
        self.plusBtn.x = 0;
        self.plusBtn.y = CGRectGetMaxY(lastLabel.frame);
    }
    CGFloat olderH = self.height;
    self.height = CGRectGetMaxY(self.plusBtn.frame) + 44;
    self.y  +=  -self.height + olderH;
}
@end
