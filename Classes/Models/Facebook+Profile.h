//
//  Facebook+Profile.h
//  Sechat
//
//  Created by Albert Moky on 2019/6/27.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "Facebook.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kNotificationName_AvatarUpdated;

@interface Facebook (Avatar)

- (BOOL)saveAvatar:(NSData *)data
              name:(nullable NSString *)filename
             forID:(DIMID *)ID;

- (nullable NSImage *)loadAvatarWithURL:(NSString *)urlString
                                  forID:(DIMID *)ID;

@end

NS_ASSUME_NONNULL_END
