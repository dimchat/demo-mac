//
//  ChatMessageCell.m
//  Sechat
//
//  Created by John Chen on 2019/3/26.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "ChatMessageCell.h"

@implementation ChatMessageCell

-(id)initWithFrame:(NSRect)frameRect{
    
    if(self = [super initWithFrame:frameRect]){
        
        CGFloat width = frameRect.size.width - 60.0 - 10.0;
        
        self.avatarView = [[NSImageView alloc] initWithFrame:NSMakeRect(10.0, 10.0, 40.0, 40.0)];
        self.avatarView.image = [NSImage imageNamed:NSImageNameUser];
        [self addSubview:self.avatarView];
        
        self.messageLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(60.0, 10.0, width, 20.0)];
        self.messageLabel.editable = NO;
        [self addSubview:self.messageLabel];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
