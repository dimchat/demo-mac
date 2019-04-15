//
//  ChatMessageCell.h
//  Sechat
//
//  Created by John Chen on 2019/3/26.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatMessageCell : NSView

@property(nonatomic, strong) NSImageView *avatarView;
@property(nonatomic, strong) NSTextField *messageLabel;

@end

NS_ASSUME_NONNULL_END
