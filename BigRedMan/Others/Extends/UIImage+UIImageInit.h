//
//  UIImage+UIImage_Init.h
//  duzhehui
//
//  Created by Jun on 14-6-13.
//  Copyright (c) 2014年 Jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageInit)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)toSize:(CGSize)size;
- (UIImage *)scaleCompressForSize:(CGSize)size;
- (UIImage *)scaleCompressForWidth:(CGFloat)defineWidth;
- (UIImage *)gaussBlur:(CGFloat)blurLevel andImage:(UIImage*)originImage;

@end
