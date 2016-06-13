//
//  UILabel+Ext.m
//  Thin
//
//  Created by Crystal on 15/11/20.
//  Copyright © 2015年 Crystal. All rights reserved.
//

#import "UILabel+Ext.h"

@implementation UILabel(Ext)

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize
{
    if (nil == color) {
        color = [UIColor blackColor];
    }
    if (nil == text) {
        text = @"";
    }
    if (fontSize < 0.000001) {
        fontSize = 14.0;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;

    fontSize *= SCREEN_SCALE;
    
    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
}

+ (UILabel *)labelWithFontSize : (CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc] init];
    fontSize *= SCREEN_SCALE;
    
    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
}

@end
