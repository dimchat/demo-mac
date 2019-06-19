//
//  UIImage+Extension.m
//  DIMClient
//
//  Created by Albert Moky on 2019/2/1.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "NSString+Extension.h"

#import "UIImage+Extension.h"

@implementation NSImage (Data)

- (NSData *)jpegDataWithQuality:(CGFloat)compressionQuality {
    // TODO: convert to JPEG data
    //return NSImageJPEGRepresentation(self, compressionQuality);
    return nil;
}

- (NSData *)pngData {
    // TODO: convert to PNG data
    //return NSImagePNGRepresentation(self);
    return nil;
}

@end

@implementation NSImage (Resize)

- (NSImage *)thumbnail {
    
    CGSize maxSize = CGSizeMake(96, 128);
    CGSize size = self.size;
    if (size.width <= maxSize.width && size.height <= maxSize.height) {
        // too small, no need to thumbnail
        return self;
    }
    return [self aspectFit:maxSize];
}

- (NSImage *)aspectFit:(CGSize)maxSize {
    CGSize size = self.size;
    CGFloat ratio = MIN(maxSize.width / size.width, maxSize.height / size.height);
    CGSize newSize = CGSizeMake(size.width * ratio, size.height * ratio);
    return [self resize:newSize];
}

- (NSImage *)aspectFill:(CGSize)maxSize {
    CGSize size = self.size;
    CGFloat ratio = MAX(maxSize.width / size.width, maxSize.height / size.height);
    CGSize newSize = CGSizeMake(size.width * ratio, size.height * ratio);
    return [self resize:newSize];
}

- (NSImage *)resize:(CGSize)newSize {
    
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    NSRect rect;
    CGImageRef imageRef = [self CGImageForProposedRect:&rect context:nil hints:nil];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, kCGInterpolationLow);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    NSImage *newImage = [[NSImage alloc] initWithCGImage:newImageRef size:newRect.size];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

@end

@implementation NSImage (Text)

+ (nullable NSImage *)imageWithText:(NSString *)text size:(const CGSize)size {
    return [self imageWithText:text size:size color:nil backgroundColor:nil];
}

+ (nullable NSImage *)imageWithText:(NSString *)text
                               size:(const CGSize)size
                              color:(nullable NSColor *)textColor
                    backgroundColor:(nullable NSColor *)bgColor {
    // TODO:
    return nil;
//    // prepare image contact
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (bgColor) {
//        CGContextSetFillColorWithColor(context, bgColor.CGColor);
//        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
//    }
//
//    // calculate font size
//    CGFloat fontSize = [NSFont systemFontSize];
//    NSFont *font = [NSFont systemFontOfSize:fontSize];
//    CGSize textSize = [text sizeWithFont:font maxSize:size];
//    CGFloat scale = MIN(size.width / textSize.width,
//                        size.height / textSize.height);
//    // adjust text font size
//    fontSize *= scale;
//    font = [NSFont systemFontOfSize:fontSize];
//    textSize = [text sizeWithFont:font maxSize:size];
//
//    // draw the text in center
//    NSDictionary *attr;
//    if (textColor) {
//        attr = @{NSFontAttributeName:font,
//                 NSForegroundColorAttributeName:textColor,
//                 };
//    } else {
//        attr = @{NSFontAttributeName:font,
//                 };
//    }
//    CGRect rect = CGRectMake((size.width - textSize.width) * 0.5,
//                             (size.height - textSize.height) * 0.5,
//                             size.width, size.height);
//    [text drawInRect:rect withAttributes:attr];
//
//    // get image
//    NSImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
}

+ (nullable NSImage *)imageWithText:(NSString *)text
                               size:(const CGSize)size
                              color:(nullable NSColor *)textColor
                    backgroundImage:(nullable NSImage *)bgImage {
    // TODO:
    return nil;
//    // prepare image contact
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (bgImage) {
//        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), bgImage.CGImage);
//    }
//
//    // calculate font size
//    CGFloat fontSize = [NSFont systemFontSize];
//    NSFont *font = [NSFont systemFontOfSize:fontSize];
//    CGSize textSize = [text sizeWithFont:font maxSize:size];
//    CGFloat scale = MIN(size.width / textSize.width,
//                        size.height / textSize.height);
//    // adjust text font size
//    fontSize *= scale;
//    font = [NSFont systemFontOfSize:fontSize];
//    textSize = [text sizeWithFont:font maxSize:size];
//
//    // draw the text in center
//    NSDictionary *attr;
//    if (textColor) {
//        attr = @{NSFontAttributeName:font,
//                 NSForegroundColorAttributeName:textColor,
//                 };
//    } else {
//        attr = @{NSFontAttributeName:font,
//                 };
//    }
//    CGRect rect = CGRectMake((size.width - textSize.width) * 0.5,
//                             (size.height - textSize.height) * 0.5,
//                             size.width, size.height);
//    [text drawInRect:rect withAttributes:attr];
//
//    // get image
//    NSImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
}

@end

@implementation NSImage (Tiled)

+ (NSImage *)tiledImages:(NSArray<NSImage *> *)images size:(const CGSize)size {
    return [self tiledImages:images size:size backgroundColor:nil];
}

#define UIImageTiledDraw(i, kX, kY, dX, dY)                                    \
        do {                                                                   \
            tileImage = [images objectAtIndex:(i)];                            \
            tileRect = CGRectMake(center.x + tileCenter.x * (kX-1) + dX,       \
                                  center.y + tileCenter.y * (kY-1) + dY,       \
                                  tileSize.width, tileSize.height);            \
            [tileImage drawInRect:tileRect];                                   \
        } while (0)                      /* EOF 'UIImageTiledDraw(i, dx, dy)' */

+ (NSImage *)tiledImages:(NSArray<NSImage *> *)images
                    size:(const CGSize)size
         backgroundColor:(nullable NSColor *)bgColor {
    // TODO:
    return nil;
//    // prepare image contact
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (bgColor) {
//        CGContextSetFillColorWithColor(context, bgColor.CGColor);
//        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
//    }
//    
//    NSUInteger count = images.count;
//    CGSize tileSize;
//    if (count > 4) {
//        tileSize = CGSizeMake(size.width / 3 - 2, size.height / 3 - 2);
//    } else {
//        tileSize = CGSizeMake(size.width / 2 - 2, size.height / 2 - 2);
//    }
//    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
//    CGPoint tileCenter = CGPointMake(tileSize.width * 0.5, tileSize.height * 0.5);
//    
//    NSImage *tileImage;
//    CGRect tileRect;
//    switch (count) {
//        case 0:
//            //NSAssert(false, @"tiled images cannot be empty");
//            break;
//            
//        case 1:
//            UIImageTiledDraw(0,  0,  0,  0,  0); // center
//            break;
//            
//        case 2:
//            UIImageTiledDraw(0, -1,  0, -1,  0); // left
//            UIImageTiledDraw(1,  1,  0,  1,  0); // right
//            break;
//            
//        case 3:
//            UIImageTiledDraw(0,  0, -1,  0, -1); // top center
//            UIImageTiledDraw(1, -1,  1, -1,  1); // bottom left
//            UIImageTiledDraw(2,  1,  1,  1,  1); // bottom right
//            break;
//            
//        case 4:
//            UIImageTiledDraw(0, -1, -1, -1, -1); // top left
//            UIImageTiledDraw(1,  1, -1,  1, -1); // top right
//            UIImageTiledDraw(2, -1,  1, -1,  1); // bottom left
//            UIImageTiledDraw(3,  1,  1,  1,  1); // bottom right
//            break;
//            
//        case 5:
//            UIImageTiledDraw(0, -1, -1, -1, -1); // top left
//            UIImageTiledDraw(1,  1, -1,  1, -1); // top right
//            UIImageTiledDraw(2, -2,  1, -3,  1); // bottom left
//            UIImageTiledDraw(3,  0,  1,  0,  1); // bottom center
//            UIImageTiledDraw(4,  2,  1,  3,  1); // bottom right
//            break;
//            
//        case 6:
//            UIImageTiledDraw(0, -2, -1, -3, -1); // top left
//            UIImageTiledDraw(1,  0, -1,  0, -1); // top center
//            UIImageTiledDraw(2,  2, -1,  3, -1); // top right
//            UIImageTiledDraw(3, -2,  1, -3,  1); // bottom left
//            UIImageTiledDraw(4,  0,  1,  0,  1); // bottom center
//            UIImageTiledDraw(5,  2,  1,  3,  1); // bottom right
//            break;
//            
//        case 7:
//            UIImageTiledDraw(0,  0, -2,  0, -3); // top center
//            UIImageTiledDraw(1, -2,  0, -3,  0); // middle left
//            UIImageTiledDraw(2,  0,  0,  0,  0); // middle center
//            UIImageTiledDraw(3,  2,  0,  3,  0); // middle right
//            UIImageTiledDraw(4, -2,  2, -3,  3); // bottom left
//            UIImageTiledDraw(5,  0,  2,  0,  3); // bottom center
//            UIImageTiledDraw(6,  2,  2,  3,  3); // bottom right
//            break;
//            
//        case 8:
//            UIImageTiledDraw(0, -1, -2, -1, -3); // top left
//            UIImageTiledDraw(1,  1, -2,  1, -3); // top right
//            UIImageTiledDraw(2, -2,  0, -3,  0); // middle left
//            UIImageTiledDraw(3,  0,  0,  0,  0); // middle center
//            UIImageTiledDraw(4,  2,  0,  3,  0); // middle right
//            UIImageTiledDraw(5, -2,  2, -3,  3); // bottom left
//            UIImageTiledDraw(6,  0,  2,  0,  3); // bottom center
//            UIImageTiledDraw(7,  2,  2,  3,  3); // bottom right
//            break;
//            
//        default: // >= 9
//            UIImageTiledDraw(0, -2, -2, -3, -3); // top left
//            UIImageTiledDraw(1,  0, -2,  0, -3); // top center
//            UIImageTiledDraw(2,  2, -2,  3, -3); // top right
//            UIImageTiledDraw(3, -2,  0, -3,  0); // middle left
//            UIImageTiledDraw(4,  0,  0,  0,  0); // middle center
//            UIImageTiledDraw(5,  2,  0,  3,  0); // middle right
//            UIImageTiledDraw(6, -2,  2, -3,  3); // bottom left
//            UIImageTiledDraw(7,  0,  2,  0,  3); // bottom center
//            UIImageTiledDraw(8,  2,  2,  3,  3); // bottom right
//            break;
//    }
//    
//    // get image
//    NSImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
}

@end
