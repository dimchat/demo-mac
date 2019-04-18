#import <Cocoa/Cocoa.h>
#import "ChatListViewCell.h"
#import "Protocols.h"

@interface ChatListViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

@property(nonatomic, assign) id<NSObject, ListViewControllerDelegate>delegate;
@property (strong) IBOutlet NSTableView *tableView;

@end
