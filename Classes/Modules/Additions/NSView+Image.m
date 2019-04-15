#import "NSView+Image.h"

@implementation NSView (ImageRepresentation)

- (NSImage *)imageRepresentation
{
    BOOL wasHidden = self.isHidden;
    CGFloat wantedLayer = self.wantsLayer;
    
    self.hidden = NO;
    self.wantsLayer = YES;
    
    NSImage *image = [[NSImage alloc] initWithSize:self.bounds.size];
    [image lockFocus];
    CGContextRef ctx = [NSGraphicsContext currentContext].graphicsPort;
    [self.layer renderInContext:ctx];
    [image unlockFocus];
    
    self.wantsLayer = wantedLayer;
    self.hidden = wasHidden;
    
    return image;
}

@end
