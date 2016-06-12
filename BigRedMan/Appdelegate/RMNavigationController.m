//
//  SLNavigationController.m
//  Thin
//
//  Created by Crystal on 15/11/18.
//  Copyright © 2015年 Crystal. All rights reserved.
//

#import "RMNavigationController.h"

@implementation RMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = RGBA(50,50,50,0.9f);
    self.navigationBar.tintColor    = [UIColor whiteColor];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    
    [self.navigationBar setTitleTextAttributes:attributes];
    
    
    
}


+ (void)initialize
{
    
    [self setupNavigationBarTheme];
    
    [self setupBarButtonItemTheme];
}


+ (void)setupNavigationBarTheme
{
    
}

+ (void)setupBarButtonItemTheme
{
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
