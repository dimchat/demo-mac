//
//  ChatListViewCell.h
//  Sechat
//
//  Created by 陈均卓 on 2019/3/24.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatListViewCell : NSView

@property(nonatomic, strong) NSImageView *avatarView;
@property(nonatomic, strong) NSTextField *nameLabel;
@property(nonatomic, strong) NSTextField *lastMessageLabel;

@end

NS_ASSUME_NONNULL_END
