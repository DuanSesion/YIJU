//
//  RMTabBar.m
//  BigRedMan
//
//  Created by xiong on 16/6/11.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import "RMTabBar.h"

@interface RMTabBar()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *frontBgView;
@property (nonatomic, strong) UIView *pointView;

@end

@implementation RMTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *img = [[UIImage alloc] init];
        self.shadowImage = img;
        self.backgroundImage = img;
        
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"767676"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        [self layoutBgView];
        
        [self layoutBtn];
        
    }
    return self;
}

- (void)layoutBgView
{
//    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RM_SCREEN_WIDTH, 49)];
//    _bgView.backgroundColor = [UIColor whiteColor];
//    _bgView.contentMode = UIViewContentModeScaleAspectFill;
//
//    _frontBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -4, RM_SCREEN_WIDTH,4)];
////    [_frontBgView setImage:[UIImage imageNamed:@"淡出图层"]];
//    _frontBgView.contentMode = UIViewContentModeScaleToFill;
//    
//    [self addSubview:_bgView];
//    [self addSubview:_frontBgView];
    
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = RGBA(50,50,50,0.9f);
}


- (void)layoutBtn
{
 
    
 
}



- (void)setSelectedIndex:(NSUInteger)index
{
    

}




@end
