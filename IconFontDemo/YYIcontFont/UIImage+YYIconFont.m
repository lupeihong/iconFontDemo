//
//  UIImage+YYIconFont.m
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//

#import "UIImage+YYIconFont.h"
#import "YYIconFont.h"
#import "YYIconFontImageCache.h"

@implementation UIImage (YYIconFont)

+ (UIImage *)yy_iconWithText:(NSString*)text fontSize:(CGFloat)size color:(UIColor*)color
{
    NSString *key = [self getKeyForCache:text fontSize:size color:color];
    UIImage *cacheImage = [YYIconFontImageCache imageFromMemoryCacheForKey:key];
    if (cacheImage) {
        return cacheImage;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageSize = size * scale;
    UIFont *font = [YYIconFont fontWithSize:imageSize];
    NSString *unicodeText = [YYIconFont getUniCodeFrom:text];
    
    UIImage *image;
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(imageSize, imageSize)];
        image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull context) {
            UIColor *backgroundColor = [UIColor clearColor];
            [backgroundColor set];
            UIRectFill(CGRectMake(0.0, 0.0, imageSize, imageSize)); //fill the background
            [unicodeText drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
        }];
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(imageSize, imageSize));
        
        UIColor *backgroundColor = [UIColor clearColor];
        [backgroundColor set];
        UIRectFill(CGRectMake(0.0, 0.0, imageSize, imageSize)); //fill the background
        
        [unicodeText drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
        
        image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
        UIGraphicsEndImageContext();
    }
    
    if (image) {
        [YYIconFontImageCache storeImage:image forKey:key];
    }
    
    return image;
}

+ (NSString*)getKeyForCache:(NSString*)unicodeText fontSize:(CGFloat)size color:(UIColor*)color{
    return [NSString stringWithFormat:@"%@_%@_%@",unicodeText,@(size),@(color.hash)];
}

@end
