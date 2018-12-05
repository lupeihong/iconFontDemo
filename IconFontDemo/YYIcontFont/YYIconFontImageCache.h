//
//  YYIconFontImageCache.h
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YYIconFontImageCache : NSObject

+ (void)storeImage:(UIImage *)image forKey:(NSString *)key;
+ (UIImage *)imageFromMemoryCacheForKey:(NSString *)key;
+ (void)clearSharedMemoryCache;

@end
