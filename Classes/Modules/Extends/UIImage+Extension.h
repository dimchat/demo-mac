//
//  UIImage+Extension.h
//  DIMClient
//
//  Created by Albert Moky on 2019/2/1.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIImage_JPEGCompressionQuality_Photo     0.5
#define UIImage_JPEGCompressionQuality_Thumbnail 0

@interface NSImage (Data)

- (NSData *)jpegDataWithQuality:(CGFloat)compressionQuality;
- (NSData *)pngData;

@end

@interface NSImage (Resize)

- (NSImage *)resize:(CGSize)newSize;
- (NSImage *)aspectFill:(CGSize)maxSize;
- (NSImage *)aspectFit:(CGSize)maxSize;
- (NSImage *)thumbnail;

@end

@interface NSImage (Text)

+ (nullable NSImage *)imageWithText:(const NSString *)text size:(const CGSize)size;
+ (nullable NSImage *)imageWithText:(const NSString *)text
                               size:(const CGSize)size
                              color:(nullable NSColor *)textColor
                    backgroundColor:(nullable NSColor *)bgColor;
+ (nullable NSImage *)imageWithText:(const NSString *)text
                               size:(const CGSize)size
                              color:(nullable NSColor *)textColor
                    backgroundImage:(nullable NSImage *)bgImage;

@end

@interface NSImage (Tiled)

+ (NSImage *)tiledImages:(NSArray<NSImage *> *)images size:(const CGSize)size;
+ (NSImage *)tiledImages:(NSArray<NSImage *> *)images
                    size:(const CGSize)size
         backgroundColor:(nullable NSColor *)bgColor;

@end

NS_ASSUME_NONNULL_END
