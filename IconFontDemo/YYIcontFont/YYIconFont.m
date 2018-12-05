//
//  YYIconFont.m
//  IconFontDemo
//
//  Created by luph on 2018/11/26.
//  Copyright © 2018年 yy. All rights reserved.
//

#import "YYIconFont.h"
#import <CoreText/CoreText.h>

static NSString *yyIconFontName;
static NSDictionary *codeMap;

@implementation YYIconFont

+ (void)registerFontName:(NSString *)fontName {
    yyIconFontName = fontName;
}

+ (void)registerFontWithURL:(NSURL *)url {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(newFont, nil);
    CGFontRelease(newFont);
}

+ (UIFont *)fontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:yyIconFontName size:size];
    if (font == nil) {
        NSURL *fontFileUrl = [[NSBundle mainBundle] URLForResource:yyIconFontName withExtension:@"ttf"];
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:yyIconFontName size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}


+ (NSString *)glyphsPath {
    return [yyIconFontName stringByAppendingString:@".strings"];
}

+ (NSString *)pathForResource:(NSString *)aPath {
    return [[NSBundle mainBundle] pathForResource:aPath.stringByDeletingPathExtension.lastPathComponent
                                           ofType:aPath.pathExtension];
}

+ (NSDictionary *)codeMap {
    @synchronized(self) {
        if (!codeMap) {
            NSString *path = [[NSBundle mainBundle] pathForResource:[self glyphsPath].stringByDeletingPathExtension.lastPathComponent
                                                             ofType:[self glyphsPath].pathExtension];
            codeMap = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        }
    }
    return codeMap;
}

+ (NSString*)getUniCodeFrom:(NSString*)text{
    return [[self codeMap] objectForKey:text];
}

@end
