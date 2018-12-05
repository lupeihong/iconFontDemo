//
//  YYIconFontImageCache.m
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//

#import "YYIconFontImageCache.h"
#import <UIKit/UIKit.h>

@interface YYIconFontImageCache()
@property (nonatomic, strong, getter = getMemoryCache) NSCache *memoryCache;
@end


@implementation YYIconFontImageCache

+ (NSCache *)sharedMemoryCache
{
    static NSCache *sharedMemoryCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMemoryCache = [[NSCache alloc] init];
        sharedMemoryCache.name = @"YYIconFontImageCache";
    });
    return sharedMemoryCache;
}


+ (void)storeImage:(UIImage *)image forKey:(NSString *)key
{
    @synchronized([self sharedMemoryCache]) {
        [[self sharedMemoryCache] setObject:image forKey:key];
    }
}

+ (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    __block UIImage *image;
    @synchronized([self sharedMemoryCache]) {
        image = [[self sharedMemoryCache] objectForKey:key];
    }
    return image;
}

+ (void)clearSharedMemoryCache
{
    @synchronized([self sharedMemoryCache]) {
        [[self sharedMemoryCache] removeAllObjects];
    }
}

@end
