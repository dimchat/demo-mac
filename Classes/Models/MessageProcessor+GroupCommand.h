//
//  MessageProcessor+GroupCommand.h
//  Sechat
//
//  Created by Albert Moky on 2019/3/10.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "MessageProcessor.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kNotificationName_GroupMembersUpdated;

@interface MessageProcessor (GroupCommand)

- (BOOL)processGroupCommand:(DIMGroupCommand *)cmd
                  commander:(DIMID *)sender;

@end

NS_ASSUME_NONNULL_END
