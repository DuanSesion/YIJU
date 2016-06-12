//
//  RMTabBar.h
//  BigRedMan
//
//  Created by xiong on 16/6/11.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMTabBarDelegate <NSObject>

- (void)touchBtnAtIndex:(NSUInteger)index;

@end

@interface RMTabBar : UITabBar

@property (nonatomic, strong) UIButton *home_button;
@property (nonatomic, strong) UIButton *account_button;
@property (nonatomic, strong) UIButton *appoint_button;
@property (nonatomic, strong) UIButton *showyu_button;
@property (nonatomic, strong) UIButton *me_button;



@property (nonatomic, weak) id<RMTabBarDelegate> tabBarDelegate;

- (void)setSelectedIndex:(NSUInteger)index;


@end
