
#import <Cocoa/Cocoa.h>
#import "Facebook.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactListViewCell : NSView

@property(nonatomic, strong) NSImageView *avatarView;
@property(nonatomic, strong) NSTextField *nameLabel;
@property(nonatomic, strong) NSTextField *lastMessageLabel;
@property(nonatomic, strong) DIMUser *contact;

@end

NS_ASSUME_NONNULL_END
