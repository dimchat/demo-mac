#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSColor(Hex)

+ (NSColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (NSColor *)colorWithHex:(NSInteger)hexValue;
+ (NSColor *)whiteColorWithAlpha:(CGFloat)alphaValue;
+ (NSColor *)blackColorWithAlpha:(CGFloat)alphaValue;

+ (NSColor *)colorWithHexColorString:(NSString *)inColorString;
- (NSString *)hexColorString;
- (NSString *)argbString;

@end
