//
//  HomeController.m
//  BigRedMan
//
//  Created by xiong on 16/6/11.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import "HomeController.h"
#import "RMRNavigationBarView.h"
#import "RMTabBarViewController.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *_tableView;
    
    RMRNavigationBarView *nanBarView;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor groupTableViewBackgroundColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    

    
    
    
    /*
    NSMutableDictionary  *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"81c59a3f50414acca3c705a6b735e9c3" forKey:@"api_key"];
    [postDic setObject:@"aaa88611a" forKey:@"username"];
    [postDic setObject:@"abcdefg" forKey:@"password"];
    [postDic setObject:@"12345672a8a@qq.com" forKey:@"email"];
    
    NSString *str= [@"省份" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [postDic setObject:str forKey:@"province"];
    [postDic setObject:@"城市" forKey:@"city"];
    [postDic setObject:@"学校" forKey:@"school"];
    
    
    [[RMServer shareInstance]createUser:postDic success:^(id JSON) {
        
        NSLog(@"%@---%@---%@",JSON,JSON[@"error_description"],JSON[@"user"][@"province"]);
        
    } error:^(NSError *error) {
        
    }];
     */
      
    [self setLayout];
}

- (void)setLayout{

    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RM_SCREEN_WIDTH, RM_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 50;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:_tableView];
    
    RMTabBarViewController *tabbarVc  = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabbarVc followRollingScrollView:_tableView currentNan:self.navigationController];
    
//    UIImageView *background = [[UIImageView alloc]initWithFrame:_tableView.bounds];
//    background.image = [UIImage imageNamed:@"background"];
//    _tableView.backgroundView = background;
    
    
    nanBarView = [[RMRNavigationBarView alloc]initWithFrame:CGRectMake(0, 20, RM_SCREEN_WIDTH, 44) withWidth:RM_SCREEN_WIDTH withArray:@[@"关注",@"热门",@"最新"]];
    self.navigationItem.titleView = nanBarView;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellId =  @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

@end
