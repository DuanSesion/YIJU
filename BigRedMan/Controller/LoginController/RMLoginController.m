//
//  HRLoginController.m
//  BigRedMan
//
//  Created by Duanshaoxiong on 16/6/8.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import "RMLoginController.h"
#import "RMTextField.h"
#import "RMServer.h"
#import "Masonry.h"

@interface RMLoginController()<UITextFieldDelegate>
{
  
    UIButton    *logBtn;
    UIButton    *btnGetCode;

    UIImageView *userHeadView;
    RMTextField *textFieldPhone;
    RMTextField *textFieldPassword;
    BOOL        bShowPassWord;
    NSTimer     *timer;
    NSInteger   nCount;
}
@end

@implementation RMLoginController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title  = @"注册";
    self.view.backgroundColor  = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    

    
    [self initLayout];
}

- (void)initLayout{

    textFieldPhone = [[RMTextField alloc] initWithFrame:CGRectZero iconName:@"iconfont-shouji.png"];
    textFieldPhone.textColor = [UIColor colorWithHexString:@"#666666"];
    textFieldPhone.placeholder = @"请输入手机号";
    textFieldPhone.returnKeyType = UIReturnKeyDone;
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    textFieldPhone.textAlignment = NSTextAlignmentNatural;
    [textFieldPhone.layer setCornerRadius:2];
    textFieldPhone.delegate = self;
    [self.view addSubview:textFieldPhone];
    [textFieldPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(27);
        make.top.equalTo(self.view.mas_topMargin).with.offset(114);
        make.height.mas_equalTo(112/2.f);
        make.right.mas_equalTo(self.view.mas_right).offset(-27);
    }];
    
    
    
    textFieldPassword = [[RMTextField alloc] initWithFrame:CGRectZero iconName:@"iconfont-yanzhengmaicon.png"];
    textFieldPassword.textColor = [UIColor colorWithHexString:@"#666666"];
    textFieldPassword.placeholder = @"短信验证码";
    textFieldPassword.returnKeyType = UIReturnKeyDone;
    [textFieldPassword.layer setCornerRadius:2];
    textFieldPassword.delegate = self;
    [self.view addSubview:textFieldPassword];
    [textFieldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(27);
        make.right.equalTo(self.view.mas_right).with.offset(-27);
        make.top.equalTo(textFieldPhone.mas_bottom).with.offset(1);
        make.height.mas_equalTo(112/2.f);
    }];
    
    
    
    btnGetCode = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:btnGetCode];
    [btnGetCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(textFieldPassword).offset(-5);
        //make.top.equalTo(textFieldPassword.mas_topMargin).with.offset(20/2);
        make.centerY.equalTo(textFieldPassword);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    [btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnGetCode setTitleColor:[UIColor colorWithHexString:@"fff"] forState:UIControlStateNormal];
    [btnGetCode setBackgroundColor:[UIColor colorWithHexString:@"55c7fc"]];
    btnGetCode.layer.borderColor = [UIColor whiteColor].CGColor;
    btnGetCode.layer.cornerRadius = 5;
    btnGetCode.layer.borderWidth = 1;
    btnGetCode.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnGetCode addTarget:self action:@selector(sendingCode) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sendingCode
{
 
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"];
    
    if ([regextestmobile evaluateWithObject:textFieldPhone.text]){
    
         return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:textFieldPhone.text forKey:@"phone"];
    
    btnGetCode.enabled = NO;
    nCount = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerValid) userInfo:nil repeats:YES];
    
    [timer fire];
}

-(void)timerValid
{
    nCount -= 1;
    [btnGetCode setTitle:[NSString stringWithFormat:@"重新获取%ldS",(long)nCount] forState:UIControlStateNormal];
    if (nCount == 0) {
        [timer invalidate];
        nCount = 60;
        [btnGetCode setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        btnGetCode.enabled = YES;
    }
}


@end
