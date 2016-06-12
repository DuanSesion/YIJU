//
//  XYTextField.m
//  XiuYu
//
//  Created by Aaron Yu on 14-9-15.
//  Copyright (c) 2014年 XY. All rights reserved.
//

#import "RMTextField.h"


@implementation RMTextField

- (id)initWithFrame:(CGRect) frame iconName:(NSString *)name
{
    self = [super initWithFrame:frame];
    
    if (!self)
    {
        return nil;
    }
    CGRect imageViewFrame = [self iconImageViewRect];
    
    UIImage *icon = [UIImage imageNamed:name];
    
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    iconImage.backgroundColor = [UIColor redColor];
    [iconImage setImage:icon];
    [iconImage setContentMode:UIViewContentModeCenter];
    
    self.leftView = iconImage;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    CALayer *rightView = [CALayer layer];
    rightView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-54, 112/2.0);
    rightView.backgroundColor =  [UIColor colorWithHexString:@"#f3f4f9"].CGColor;
    rightView.cornerRadius = 3.f;
    
    [self.layer addSublayer:rightView];
 
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 50,bounds.origin.y + 10,bounds.size.width - 45, bounds.size.height - 20);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    
    leftViewRect.origin.x += 15;
    
    return leftViewRect;
}

- (CGRect)iconImageViewRect
{
    return CGRectMake(0, 5, 5, self.frame.size.height);
}


@end
