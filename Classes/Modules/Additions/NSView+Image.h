#import <AppKit/AppKit.h>

@interface NSView (ImageRepresentation)

/// Renders subtree without ignoring children opacity.
- (NSImage *)imageRepresentation;

@end
