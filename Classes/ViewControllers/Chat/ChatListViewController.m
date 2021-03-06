#import "ChatListViewController.h"
#import "Log.h"
#import "ChatListViewCell.h"

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

#pragma mark NSTableView datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return 4;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSRect r = NSMakeRect(0.0, 0.0, self.view.bounds.size.width, 40.0);
    ChatListViewCell *cell = [[ChatListViewCell alloc] initWithFrame:r];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
//    DIMID *selectedID = [_users objectAtIndex:self.tableView.selectedRow];
//    DIMUser *selectedAccount = DIMUserWithID(selectedID);
//
//    if(self.delegate != nil){
//        [self.delegate listViewController:self didSelectObject:cell];
//    }
}

@end
