#import "NSColor+Hex.h"

@implementation NSColor(Hex)

+ (NSColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [NSColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (NSColor *)colorWithHex:(NSInteger)hexValue
{
    return [NSColor colorWithHex:hexValue alpha:1.0];
}

+ (NSColor *)whiteColorWithAlpha:(CGFloat)alphaValue
{
    return [NSColor colorWithHex:0xffffff alpha:alphaValue];
}

+ (NSColor *)blackColorWithAlpha:(CGFloat)alphaValue
{
    return [NSColor colorWithHex:0x000000 alpha:alphaValue];
}

+ (NSColor*)colorWithHexColorString:(NSString *)inColorString
{
    NSColor* result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:1.0];
    return result;
}

-(NSString *)hexColorString{
    
    NSUInteger red = [self redComponent] * 255;
    NSUInteger green = [self greenComponent] * 255;
    NSUInteger blue = [self blueComponent] * 255;
    
    NSString *result = [NSString stringWithFormat:@"%lx%lx%lx", (unsigned long)red, (unsigned long)green, (unsigned long)blue];
    
    return result;
}

- (NSString *)argbString{
    
    NSUInteger red = [self redComponent] * 255;
    NSUInteger green = [self greenComponent] * 255;
    NSUInteger blue = [self blueComponent] * 255;
    NSUInteger alpha = self.alphaComponent * 255;
    
    NSString *result = [NSString stringWithFormat:@"%lx%lx%lx%lx", (unsigned long)alpha, (unsigned long)red, (unsigned long)green, (unsigned long)blue];
    
    return [result uppercaseString];
}

@end
