//
//  UILabel+Ext.h
//  Thin
//
//  Created by Crystal on 15/11/20.
//  Copyright © 2015年 Crystal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Ext)


+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)font;

+ (UILabel *)labelWithFontSize : (CGFloat)fontSize;

@end
