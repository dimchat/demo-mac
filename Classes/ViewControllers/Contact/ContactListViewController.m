//
//  ContactListViewController.m
//  Sechat
//
//  Created by John Chen on 2019/4/15.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "ContactListViewController.h"
#import "Client.h"
#import "ContactListViewCell.h"
#import "Facebook.h"

@interface ContactListViewController ()<NSSearchFieldDelegate, NSTableViewDataSource, NSTableViewDelegate>{
    
    NSMutableArray *_users;
}

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _users = [[NSMutableArray alloc] init];
    
    Client *client = [Client sharedInstance];
    
    // 2. waiting for update
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:kNotificationName_OnlineUsersUpdated object:client];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:kNotificationName_SearchUsersUpdated object:client];
    
    // 3. query from the station
    [client queryOnlineUsers];
}

- (void)searchFieldDidStartSearching:(NSSearchField *)sender{
    
    NSString *keywords = self.searchField.stringValue;
    
    Client *client = [Client sharedInstance];
    [client searchUsersWithKeywords:keywords];
}

//- (void)searchFieldDidEndSearching:(NSSearchField *)sender{
//    
//    NSString *keywords = self.searchField.stringValue;
//    
//    Client *client = [Client sharedInstance];
//    [client searchUsersWithKeywords:keywords];
//}

- (void)reloadData:(NSNotification *)notification {
    
    NSArray *users = [notification.userInfo objectForKey:@"users"];
    
    DIMBarrack *barrack = [DIMBarrack sharedInstance];
    Client *client = [Client sharedInstance];
    
    DIMID *ID;
    DIMMeta *meta;
    DIMPublicKey *PK;
    
//    if ([notification.name isEqual:kNotificationName_OnlineUsersUpdated]) {
//        // online users
//        NSLog(@"online users: %@", users);
//
//        if (_onlineUsers) {
//            [_onlineUsers removeAllObjects];
//        } else {
//            _onlineUsers = [[NSMutableArray alloc] initWithCapacity:users.count];
//        }
//
//        for (NSString *item in users) {
//            ID = [DIMID IDWithID:item];
//            PK = DIMPublicKeyForID(ID);
//            if (PK) {
//                [_onlineUsers addObject:ID];
//            } else {
//                [client queryMetaForID:ID];
//            }
//        }
//
//    } else if ([notification.name isEqual:kNotificationName_SearchUsersUpdated]) {
    if ([notification.name isEqual:kNotificationName_SearchUsersUpdated]) {
        // search users
        
        if (_users) {
            [_users removeAllObjects];
        } else {
            _users = [[NSMutableArray alloc] initWithCapacity:users.count];
        }
        
        for (NSString *item in users) {
            ID = [DIMID IDWithID:item];
            if (!MKMNetwork_IsPerson(ID.type) &&
                !MKMNetwork_IsGroup(ID.type)) {
                // ignore
                continue;
            }
            [_users addObject:ID];
        }
        
        NSDictionary *results = [notification.userInfo objectForKey:@"results"];
        id value;
        for (NSString *key in results) {
            ID = [DIMID IDWithID:key];
            value = [results objectForKey:key];
            if ([value isKindOfClass:[NSDictionary class]]) {
                meta = [DIMMeta metaWithMeta:value];
                [barrack saveMeta:meta forID:ID];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark NSTableView datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [_users count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSRect r = NSMakeRect(0.0, 0.0, self.view.bounds.size.width, 40.0);
    ContactListViewCell *cell = [[ContactListViewCell alloc] initWithFrame:r];
    DIMID *ID = [_users objectAtIndex:row];
    cell.account = DIMAccountWithID(ID);
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60.0;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSLog(@"Select row %@", notification);
//    if(self.delegate != nil){
//        
//        ContactListViewCell *cell = (ContactListViewCell *)[self.tableView selectedCell];
//        [self.delegate listViewController:self didSelectCell:cell];
//    }
}

@end
