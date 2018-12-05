//
//  UIImage+YYIconFont.h
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYIconFont)
+ (UIImage *)yy_iconWithText:(NSString*)unicodeText fontSize:(CGFloat)size color:(UIColor*)color;
@end
