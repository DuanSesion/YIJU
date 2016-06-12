//
//  GDRTabBarView.h
//  封装tabBar
//
//  Created by dllo on 16/1/6.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMRNavigationBarView : UIView

- (void) deliver:(UIScrollView *)scrollView;

- (instancetype)initWithFrame:(CGRect)frame withWidth:(CGFloat)width withArray:(NSArray *)arr;

@end
