//
//  UIColor+HexString.h
//  DT
//
//  Created by Ryan Nystrom on 2/5/13.
//
//

#import <UIKit/UIKit.h>

#define colorWithAlpha(a) [UIColor colorWithWhite:0 alpha:a]
#define colorWithXYMethod(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
