#import "ChatListViewCell.h"

@implementation ChatListViewCell

-(id)initWithFrame:(NSRect)frameRect{
    
    if(self = [super initWithFrame:frameRect]){
        
        CGFloat width = frameRect.size.width - 60.0 - 10.0;
        
        self.avatarView = [[NSImageView alloc] initWithFrame:NSMakeRect(10.0, 10.0, 40.0, 40.0)];
        self.avatarView.image = [NSImage imageNamed:NSImageNameUser];
        [self addSubview:self.avatarView];
        
        self.nameLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(60.0, 10.0, width, 20.0)];
        self.nameLabel.editable = NO;
        self.nameLabel.autoresizingMask = NSViewWidthSizable;
        [self addSubview:self.nameLabel];
        
        self.lastMessageLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(60.0, 30.0, width, 20.0)];
        self.lastMessageLabel.editable = NO;
        self.lastMessageLabel.autoresizingMask = NSViewWidthSizable;
        [self addSubview:self.lastMessageLabel];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
