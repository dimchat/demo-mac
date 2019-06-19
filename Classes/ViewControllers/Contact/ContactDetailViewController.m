//
//  ContactDetailViewController.m
//  Sechat
//
//  Created by John Chen on 2019/4/18.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "DimProfile+Extension.h"
#import "User.h"
#import "Client.h"

@interface ContactDetailViewController ()

@property (weak) IBOutlet NSImageView *avatarImageView;
@property (weak) IBOutlet NSTextField *nicknameLabel;
@property (weak) IBOutlet NSTextField *numberLabel;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self updateUI];
}

-(void)setAccount:(DIMAccount *)account{
    
    _account = account;
    [self updateUI];
}

-(void)updateUI{
    
    if(_account == nil){
        return;
    }
    
    DIMProfile *profile = DIMProfileForID(_account.ID);
    
    // avatar
    CGRect frame = self.avatarImageView.frame;
    NSImage *image = [profile avatarImageWithSize:frame.size];
    if (!image) {
        image = [NSImage imageNamed:@"AppIcon"];
    }
    [self.avatarImageView setImage:image];
    
    // name
    self.nicknameLabel.stringValue = account_title(_account);
    
    // desc
    self.numberLabel.stringValue = [NSString stringWithFormat:@"%@", _account.ID];
}

- (IBAction)didPressAddFriendButton:(id)sender {
    
    Client *client = [Client sharedInstance];
    DIMUser *user = client.currentUser;
    
    // send meta & profile first as handshake
    DIMMeta *meta = DIMMetaForID(user.ID);
    DIMProfile *profile = DIMProfileForID(user.ID);
    DIMCommand *cmd;
    if (profile) {
        cmd = [[DIMProfileCommand alloc] initWithID:user.ID
                                               meta:meta
                                            profile:profile];
    } else {
        cmd = [[DIMMetaCommand alloc] initWithID:user.ID
                                            meta:meta];
    }
    [client sendContent:cmd to:_account.ID];
    
    // add to contacts
    Facebook *facebook = [Facebook sharedInstance];
//    [facebook user:user addContact:_account.ID];
    NSLog(@"contact %@ added to user %@", _account, user);
}


@end
