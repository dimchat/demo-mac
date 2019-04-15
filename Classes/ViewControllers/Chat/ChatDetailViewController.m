//
//  ChatDetailViewController.m
//  Sechat
//
//  Created by 陈均卓 on 2019/3/24.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "ChatMessageCell.h"

@interface ChatDetailViewController ()<NSSplitViewDelegate, NSTableViewDelegate, NSTableViewDataSource>

@end

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex{
    
    if(dividerIndex == 1){
        return 200.0;
    }
    
    return proposedMinimumPosition;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex{
    
    if(dividerIndex == 1){
        return 300.0;
    }
    
    return proposedMaximumPosition;
}

#pragma mark NSTableView datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return 4;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSRect r = NSMakeRect(0.0, 0.0, self.view.bounds.size.width, 40.0);
    ChatMessageCell *cell = [[ChatMessageCell alloc] initWithFrame:r];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60.0;
}

- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes{
    return 0;
}

@end
