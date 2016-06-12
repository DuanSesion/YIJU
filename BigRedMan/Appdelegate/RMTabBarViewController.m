//
//  RMTabBViewController.m
//  BigRedMan
//
//  Created by xiong on 16/6/11.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import "RMTabBarViewController.h"
#import "RMNavigationController.h"
#import "RMTabBar.h"
#import "HomeController.h"

#define NavBarFrame currentNan.navigationBar.frame
#define TaBBarFrame self.tabBar.frame

@interface RMTabBarViewController ()<UITabBarControllerDelegate,UIGestureRecognizerDelegate>{

  UIButton * _appoint_button;
    
  UIView *scrollView;
  UIPanGestureRecognizer *panGesture;
  UINavigationController *currentNan;
  UIView *overLay;
  BOOL isHidden;
}

@end

@implementation RMTabBarViewController

static RMTabBarViewController *sharedTabBarController;

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTabBarController=[[RMTabBarViewController alloc]init];
    });
    
    return sharedTabBarController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
   
    [self changeTabBar];
    [self setupView];
    
    

    
    
}

- (void)changeTabBar
{
    RMTabBar *tabBar = [[RMTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
}

- (void)setupView
{
    HomeController *vc1 = [HomeController new];
    vc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"tab_live_i"] selectedImage:[UIImage imageNamed:@"tab_live_p"]];
    
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tab_me"] selectedImage:[UIImage imageNamed:@"tab_me_p"]];
    
    
    RMNavigationController *homeNan =  [[RMNavigationController alloc]initWithRootViewController:vc1];
 
    RMNavigationController *meNan   = [[RMNavigationController alloc]initWithRootViewController:vc3];
 
    
    _appoint_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _appoint_button.userInteractionEnabled = YES;
    _appoint_button.backgroundColor = RGBA(71,71,71,1.f);
    _appoint_button.layer.cornerRadius = 30;
    _appoint_button.layer.edgeAntialiasingMask = kCALayerLeftEdge|kCALayerRightEdge;
    [_appoint_button.layer addSublayer:[self drawBow]];
    
    [_appoint_button setFrame:CGRectMake(0, -5, 60, 60)];
    _appoint_button.center =CGPointMake(RM_SCREEN_WIDTH/2.0, 15) ;
    [_appoint_button setImage:[UIImage imageNamed:@"tab_room"] forState:UIControlStateNormal];
    [_appoint_button setImage:[UIImage imageNamed:@"tab_room_p"] forState:UIControlStateSelected];
    [_appoint_button setContentMode:UIViewContentModeScaleAspectFill];
    [_appoint_button setTag:103];
    [_appoint_button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    
   
    
    self.viewControllers = @[homeNan,meNan];
    [self.tabBar addSubview:_appoint_button];
   
}

- (void)btnClicked:(id)sender{

    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    RMNavigationController *starNan =  [[RMNavigationController alloc]initWithRootViewController:vc2];

    [self presentViewController:starNan animated:YES completion:^{
        
    }];
}

- (CALayer*)drawBow{
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor redColor];
    line.frame = CGRectMake(0, 0, RM_SCREEN_WIDTH, 1.5);
    [self.tabBar addSubview:line];
    
    [_appoint_button setImageEdgeInsets:UIEdgeInsetsMake(0, 0., 0, -1)];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:30 startAngle:60-6.09 endAngle:-0.5 clockwise:YES];
    
    //    create shape layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]initWithLayer:_appoint_button.layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1.5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}

//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)view currentNan:(UINavigationController*)nan
{
    scrollView = view;
    currentNan = nan;
    
    panGesture = [[UIPanGestureRecognizer alloc] init];
    panGesture.cancelsTouchesInView = NO;
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    [panGesture addTarget:self action:@selector(handlePanGesture:)];
    [scrollView addGestureRecognizer:panGesture];
    
//    overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
//    overLay.alpha=0;
//    overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
//    [navigationController.navigationBar addSubview:overLay];
//    [navigationController.navigationBar bringSubviewToFront:overLay];
}

#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)pan{


    CGPoint translation = [panGesture translationInView:[scrollView superview]];
    
    //显示
    if (translation.y >= 0) {
        if (isHidden) {
            
             overLay.alpha=0;
            CGRect navBarFrame = NavBarFrame;
            CGRect scrollViewFrame = scrollView.frame;
            CGRect tabBarFrame = TaBBarFrame;
            
            navBarFrame.origin.y = 20;
            scrollViewFrame.origin.y += 64;
            scrollViewFrame.size.height -= 64;
            tabBarFrame.origin.y -= 65;
            
            [UIView animateWithDuration:0.2 animations:^{
                //NavBarFrame = navBarFrame;
                scrollView.frame=scrollViewFrame;
                TaBBarFrame = tabBarFrame;
                [currentNan setNavigationBarHidden:NO animated:YES];
            }];
            isHidden= NO;
        }
    }
    
    //隐藏
    if (translation.y < 0) {
        if (!isHidden) {
            CGRect frame = NavBarFrame;
            CGRect scrollViewFrame = scrollView.frame;
            CGRect tabBarFrame = TaBBarFrame;
            
            frame.origin.y = -24;
            scrollViewFrame.origin.y -= 64;
            scrollViewFrame.size.height += 64;
            tabBarFrame.origin.y += 65;
            
            
            [UIView animateWithDuration:0.2 animations:^{
                //NavBarFrame = frame;
                scrollView.frame=scrollViewFrame;
                TaBBarFrame = tabBarFrame;
                [currentNan setNavigationBarHidden:YES animated:YES];
                
            }];
             isHidden = YES;
        }
    }


}

#pragma mark -- tabBarViewController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    RMTabBar *tabBar = (RMTabBar *)tabBarController.tabBar;
    
    [tabBar setSelectedIndex:tabBarController.selectedIndex];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    UINavigationController *temp = (UINavigationController *)viewController;
//    
//    if ([[temp.viewControllers objectAtIndex:0] isKindOfClass:[UIViewController class]]) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        
//        UINavigationController *nav = (UINavigationController *)self.selectedViewController;
//        [nav pushViewController:vc animated:YES];
//        
//        return NO;
//    }
    return YES;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    RMTabBar *tabBar = (RMTabBar *)self.tabBar;
    [tabBar setSelectedIndex:selectedIndex];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
