//
//  YYIconFont.h
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYIconFont : NSObject
+ (void)registerFontName:(NSString *)fontName;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (NSString*)getUniCodeFrom:(NSString*)text;

@end
