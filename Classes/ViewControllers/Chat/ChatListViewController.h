#import <Cocoa/Cocoa.h>
#import "ChatListViewCell.h"

@protocol ChatListViewControllerDelegate <NSObject>

-(void)didSelectCell:(ChatListViewCell *)cell;

@end

@interface ChatListViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

@property(nonatomic, assign) id<NSObject, ChatListViewControllerDelegate>delegate;
@property (strong) IBOutlet NSTableView *tableView;

@end
