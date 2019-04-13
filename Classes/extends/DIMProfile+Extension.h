//
//  DIMProfile+Extension.h
//  DIMClient
//
//  Created by Albert Moky on 2019/3/2.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <AppKit/AppKit.h>

#import <DIMCore/DIMCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface DIMProfile (Extension)

// account.avatar
- (NSImage *)avatarImageWithSize:(const CGSize)size;

// group.logo
- (NSImage *)logoImageWithSize:(const CGSize)size;

@end

NS_ASSUME_NONNULL_END
