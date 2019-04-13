//
//  Facebook+Register.h
//  DIMClient
//
//  Created by Albert Moky on 2019/1/28.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "Facebook.h"

NS_ASSUME_NONNULL_BEGIN

@interface Facebook (Register)

- (BOOL)saveMeta:(const DIMMeta *)meta privateKey:(const DIMPrivateKey *)SK forID:(const DIMID *)ID;

- (NSArray<const DIMID *> *)scanUserIDList;

- (BOOL)saveUserIDList:(const NSArray<const DIMID *> *)users withCurrentID:(nullable const DIMID *)curr;
- (BOOL)saveUserList:(const NSArray<const DIMUser *> *)users withCurrentUser:(nullable const DIMUser *)curr;

- (BOOL)removeUser:(const DIMUser *)user;

- (BOOL)saveProfile:(const DIMProfile *)profile forID:(const DIMID *)ID;
- (nullable DIMProfile *)loadProfileForID:(const DIMID *)ID;

- (BOOL)saveMembers:(const NSArray<const DIMID *> *)list withGroupID:(const DIMID *)grp;
- (NSArray<const DIMID *> *)loadMembersWithGroupID:(const DIMID *)grp;

@end

#pragma mark - Avatar

extern const NSString *kNotificationName_AvatarUpdated;

@interface Facebook (Avatar)

- (BOOL)saveAvatar:(const NSData *)data
              name:(nullable NSString *)filename
             forID:(const DIMID *)ID;

- (nullable NSImage *)loadAvatarWithURL:(NSString *)urlString
                                  forID:(const DIMID *)ID;

@end

NS_ASSUME_NONNULL_END
